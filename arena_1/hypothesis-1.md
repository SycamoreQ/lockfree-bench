# Benchmark Info and Hypothesis

* Document that specifies specs and benchmark information like no. of threads for hardware, cores and compute capability in general.

# Hypothesis

At high contention, a lock beats a CAS loop.
At low contention, a single RMW beats an uncontended spinlock.
The crossover point moves between chips.

Source of the claims: Fedor Pikus's lock-free programming talk. Only the abstract was checked, not the video itself, so re-verify against the talk before quoting it in the post.

---

# Hardware

## ARM (Mac M4 Air)

* Cores - 10 CPU cores, 8 GPU cores. 4 P cores and 6 E cores.

* SMT (Simultaneous Multi Threading) - Apple M4 Air does not use multi-threading and instead has Asymmetric Multiprocessing, which means that it has two types of cores, i.e. P-cores and E-cores, and so does not need to split a core into two logical threads to improve performance.

* Cache topology - ultra wide L1 cache and a deep L2 cache. L1 cache line is 128 bytes, which is more than the x86 64 bytes. L1 cache is massive with a 192 KB L1 I-cache and a 128 KB L1 D-cache for P cores; E cores have 128 KB and 64 KB respectively. L2 cache is shared amongst P cores and is 16 MB, whereas a 4 MB L2 cache is shared amongst E cores. L3 cache is not present.

* LSE atomics - Large System Extension exists in ARM since ARMv8.1-A to improve performance and scalability of multicore sync on AArch64 systems. Now there is a single non-interruptible read-modify-write instruction without a retry loop. Instructions that exist in this are CAS, CASP, LD<op>, ST<op>, SWP.

> Notes to verify / consider (added):
> * "No L3" is true in the conventional sense, but Apple chips have a shared system-level cache (SLC) behind L2. Mention it in the post, since it affects cross-cluster traffic.
> * The M4 Air is fanless, so sustained runs will throttle. Record die temperature or run a fixed cool-down between configs, and keep run lengths short.
> * macOS has no hard thread pinning. Thread affinity tags are not honored on Apple Silicon, so you can only influence placement with QoS classes. With 4 P cores, runs of more than 4 domains will spill onto E cores. Plot the P-only region (1-4 domains) separately from the mixed region.
> * `perf` does not exist on macOS. Counters would come from Instruments (CPU Counters), so expect fewer counters than on x86.
> * Padding: 128-byte lines mean 64-byte padding is not enough on this machine. Check what `Atomic.make_contended` pads to on your OCaml version.

## x86 (Dell Inspiron 15 5510, CachyOS)

Values below are from Intel's published spec for this part (Tiger Lake-H35 / Willow Cove cores) and general knowledge, not measured on your machine. Confirm each one with the commands at the end of this section, and fix anything that differs.

* CPU - 11th gen Intel Core 11300H, max turbo 4.40 GHz. The "8 cores" you listed is 8 hardware threads: it should be **4 physical cores x 2 threads (SMT)**. Confirm with `lscpu` (look at "Core(s) per socket" and "Thread(s) per core"). The "15" in the name is most likely an "i5".

* Hybrid cores - none. All four cores are identical (unlike the M4's P/E split).

* SMT - on. Logical CPUs that share a core are siblings, so with 4 domains you must pin one per physical core to get a clean comparison. Domains 5-8 land on SMT siblings and will share the core's L1/L2 and execution units. Plot 1-4 and 5-8 as separate regions. This lines up with the M4 Air's 4 P cores, so 1-4 domains is the apples-to-apples region for ARM vs x86.

* Cache topology - L1D 48 KB and L1I 32 KB per core, L2 1.25 MB per core (private), L3 8 MB shared across all cores. Cache line is 64 bytes. Note that Intel's adjacent-line prefetcher can pair lines, so false sharing can show up at 128-byte granularity even though the line is 64 bytes. Pad to 128 bytes on both machines to be safe.

* Atomics - LOCK-prefixed `cmpxchg`, `xadd`, `xchg` (an `xchg` with a memory operand is implicitly locked). Strong TSO memory model: an SC load is a plain `mov`, and an SC store is `xchg` (or `mov` + `mfence`). So every `Atomic.set` is a full barrier here, which is the main reason OCaml's SC-only atomics penalize the spinlock unlock on this machine.

* `pause` - used by `Domain.cpu_relax`. Its latency changed a lot across microarchitectures (very long on Skylake-derived cores). I have not verified the value for Tiger Lake/Willow Cove, so measure it with a small loop and report it, since it changes how backoff behaves.

* Frequency / power - laptop with a power-limited H35 part (roughly 28-35 W configurable). Expect turbo to fall under sustained load, so record frequency during runs and keep runs short with cool-downs. Set the governor and EPP for the benchmark session and note them.

* Scheduler - CachyOS ships a custom kernel with its own scheduler tuning (BORE or EEVDF, depending on the kernel you run). With more runnable domains than cores, the scheduler affects spinlock behavior a lot (a preempted lock holder). Record `uname -r` and keep domain count at or below logical CPUs, ideally pinned.

* GPUs - NVIDIA GeForce MX450 and Intel Iris Xe are not used by these benchmarks. Mention only to say the CPU is the only compute path involved.

* Counters - real hardware, not a VM, so `perf` counters should work; check `perf_event_paranoid` and install `perf` if it is missing.

* OS - CachyOS (Arch-based).

Commands to confirm the values above:

```
lscpu                                    # model, cores, threads per core, caches, flags
lscpu -e                                 # which logical CPUs are siblings
lscpu -C                                 # cache sizes
lstopo                                   # topology (hwloc)
cat /sys/devices/system/cpu/cpu0/cache/index*/{level,type,size,coherency_line_size,shared_cpu_list}
grep -m1 flags /proc/cpuinfo
cpupower frequency-info                  # governor, turbo, range
cat /sys/devices/system/cpu/intel_pstate/status
uname -r
cat /proc/sys/kernel/perf_event_paranoid
```

### Side-by-side summary

| | M4 Air | Dell Inspiron 15 5510 (11300H) |
|---|---|---|
| CPU cores | 4 P + 6 E | 4 identical cores |
| Hardware threads | 10 (no SMT) | 8 (SMT, 2 per core) |
| "Clean" scaling region | 1-4 domains (P cores) | 1-4 domains (one per physical core) |
| Cache line | 128 B | 64 B (pad to 128 B) |
| L1D (per core) | 128 KB (P), 64 KB (E) | 48 KB |
| L2 | 16 MB shared (P), 4 MB shared (E) | 1.25 MB private per core |
| L3 / SLC | no L3, has SLC | 8 MB shared L3 |
| Atomic RMW | LSE (CAS, SWP, LD<op>), LL/SC fallback | LOCK cmpxchg / xadd / xchg |
| Memory model | weak (ARM) | TSO |
| SC store | check asm | `xchg` (full barrier) |
| Pinning | QoS classes only | taskset / numactl |
| Counters | Instruments | perf |
| Cooling | fanless | laptop fan, power-limited |

## Toolchain (both machines) - TO FILL IN

* OS: CachyOS on x86 (kernel: TODO), macOS on the M4 Air (version: TODO)
* OCaml version / switch, flambda on or off, `ocamlopt` flags, dune profile
* OxCaml version (if used)
* C compiler and flags for control experiments (LSE on or off on arm64)
* Record the exact commit of the benchmark code for each run

---

# Plan

Framing for the post: **does the Pikus claim hold up in OCaml 5 on my ARM and x86 machines, and what does the generated code say about why?**

## Phase 0: Setup and hypotheses

- [ ] Finish the hardware survey above for both machines
- [ ] Pin the OCaml version and flags
- [ ] Hypotheses are the three at the top of this file; do not change them after seeing results (record any new ideas as follow-ups)

## Phase 1: Primitives on a single shared counter

Isolates the atomic operation from hashtable noise.

- [ ] CAS loop
- [ ] FAA (`Atomic.fetch_and_add`)
- [ ] TAS spinlock
- [ ] TTAS spinlock
- [ ] TTAS with backoff
- [ ] stdlib `Mutex`
- [ ] Optional: ticket lock

Sweep **domain count** against **private work between operations**. Contention is controlled by that ratio, and the crossover only shows up if both vary.

Done when: both regimes are visible on at least one machine.

## Phase 2: Assembly and counters, per primitive per architecture

- [ ] Dump asm for each primitive on both machines (`ocamlfind ocamlopt -S`, or `perf annotate` on x86). Annotate the key instructions: `lock cmpxchg`, `xchg`, `lock xadd`, `ldaxr`/`stlxr`, `casal`, `ldadd`.
- [ ] On arm64, record whether `compare_and_set` and `fetch_and_add` compile to LL/SC loops or LSE instructions. Do not assume.
- [ ] x86: `perf stat` with cycles, instructions, IPC, backend stalls, one process per config.
- [ ] ARM (macOS): Instruments CPU Counters, accepting a smaller counter set.
- [ ] Optional control: write the same loops in C and compile once with LSE and once without on arm64. This separates "OCaml's codegen" from "the hardware".

## Phase 3: Hashtable

Keep the scope tight: fixed size, no resizing (resizing is a project of its own).

Variants:
- [ ] One global mutex
- [ ] One global spinlock
- [ ] Striped locks
- [ ] CAS-based lock-free table (per-bucket atomic head pointers, or open addressing with atomic slots)
- [ ] Baselines from existing libraries (e.g. Saturn) if a comparable table exists; check their current offerings

Design choices worth discussing in the post:
- Immutable buckets with a CAS on the head allocate on every write, which pollutes the benchmark with GC effects.
- An array of boxed atomics adds pointer chasing and layout problems, and `make_contended` on every slot costs memory.
- The GC gives ABA safety and removes the need for hazard pointers or epochs. This is a real OCaml-specific point.

Workloads:
- Read-heavy (95/5), mixed (50/50), write-heavy
- Uniform keys vs Zipf (hot keys are the contention knob)
- Table sizes that fit in L1, in L2, and in neither

## Phase 4: Correctness before speed

- [ ] dscheck for model-checking the CAS logic on small scenarios
- [ ] A linearizability test (qcheck-lin or similar) on the table
- [ ] TSan on a debug build, if the compiler supports it

Done when: each variant passes before it gets benchmarked.

## Phase 5: Benchmarking method

- [ ] Spawn domains and release them from a barrier
- [ ] Fixed op count per domain; time from barrier release to last finisher (avoids a shared stop flag adding traffic)
- [ ] Monotonic clock, warm-up runs, many repetitions
- [ ] Report median and IQR or bootstrap CIs; raw data to CSV
- [ ] Pin with `taskset`/`numactl` on x86; QoS only on macOS (see notes above)
- [ ] Fix the frequency governor on x86; watch thermals on the fanless Air
- [ ] Check `Gc.minor_words` stays flat in the hot loop
- [ ] Same suite, same flags, on both machines where possible

## Phase 6: OxCaml (stretch)

- [ ] Port the harness or the lock-free table
- [ ] Do modes (`portable`/`contended`) help with data-race safety on the shared state?
- [ ] Do unboxed or stack-allocated types remove allocation from the hot path?
- [ ] Does it expose any finer-grained atomic orderings than SC? Verify against current docs. If yes, this is a strong follow-up post, since SC-only atomics are the biggest confound in the whole comparison.

## Phase 7: The post

Figures:
1. Scaling curves (throughput vs domains) for each primitive, per machine
2. Crossover heatmap: domains x private work
3. Side-by-side asm for the key instruction sequences
4. Counters table (cycles/op, IPC, stalls)
5. Hashtable scaling under each workload mix

Threats to validity (state them openly):
- OCaml atomics are sequentially consistent only. The unlock store is an `xchg` on x86, unlike C++'s release store, which biases spinlock-vs-lock-free.
- OCaml GC and runtime effects.
- Only two machines, so Pikus's "target market" claim cannot be tested. Report observations, not conclusions.
- SMT on x86, heterogeneous P/E cores on the M4.
- Throttling on the fanless Air.
- Different cache line sizes (128 B vs 64 B) change false-sharing behavior.

## Suggested order and post split

1. Phases 0 -> 1 -> 2 on one machine, then repeat on the other. This is a publishable "primitives" post on its own.
2. Phases 3-5 are the second post (hashtable).
3. Phase 6 is a bonus or follow-up.

## Open items / things I could not verify

- Exact padding size of `Atomic.make_contended` on each machine
- Whether `ocamlopt` on arm64 emits LSE instructions for `compare_and_set` / `fetch_and_add`
- Current state of dscheck, qcheck-lin, TSan support, and Saturn's table in your OCaml version
- What OxCaml currently exposes for atomics and parallelism
