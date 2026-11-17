#!/usr/bin/env fish
# Usage (from the repo root):
#   scripts/run_bench.fish <machine-id> [note]
# e.g.
#   scripts/run_bench.fish m4air "plugged in"
#   scripts/run_bench.fish i5-11300h "governor=performance"

set expected_ocaml 5.3.0
set expected_flambda false
set linux_cpus 0,1,2,3   # one logical CPU per physical core (from lscpu -e)

if test (count $argv) -lt 1
    echo "usage: scripts/run_bench.fish <machine-id> [note]"
    exit 1
end
set machine $argv[1]
set note (string join ' ' $argv[2..-1])

# 1. Toolchain check: refuse to run on the wrong compiler.
set ver (ocamlfind ocamlopt -version)
set fl (ocamlfind ocamlopt -config | string replace -rf '^flambda\s*:\s*' '')
if test "$ver" != "$expected_ocaml"
    echo "wrong compiler: $ver (expected $expected_ocaml)"
    echo "hint: run 'eval (opam env)' in this shell"
    exit 1
end
if test "$fl" != "$expected_flambda"
    echo "flambda is $fl (expected $expected_flambda)"
    exit 1
end

# 2. Git state: warn if the tree is dirty.
set desc (git describe --always --dirty)
if string match -q '*-dirty' -- $desc
    echo "warning: working tree is dirty ($desc); commit before a real run"
end

# 3. Build.
dune build --profile release ./bin/bench_counter.exe; or exit 1
set exe ./_build/default/bin/bench_counter.exe

# 4. Run, with platform-specific wrapping.
set -x BENCH_MACHINE $machine
set -x GIT_DESC $desc
set -x BENCH_DATE (date +%F)

switch (uname)
    case Darwin
        set -x BENCH_FLAGS "release, ocaml $ver, flambda $fl, no pinning, $note"
        caffeinate -i $exe
    case Linux
        set -x BENCH_FLAGS "release, ocaml $ver, flambda $fl, taskset $linux_cpus, $note"
        taskset -c $linux_cpus $exe
    case '*'
        echo "unsupported OS"
        exit 1
end
