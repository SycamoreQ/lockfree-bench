(** Returns the minimum of two Int64 values. *)
val min64 : int64 -> int64 -> int64

(** Returns the maximum of two Int64 values. *)
val max64 : int64 -> int64 -> int64

(** [run ~domains worker] spawns [domains] domains, synchronizes their start using
    a spin barrier, and executes [worker i] on each domain [i] (where [i] is a
    0-based index).

    @return A tuple [(seconds, results)] where [seconds] is the wall-clock execution
    time measured from the earliest worker start to the latest worker end (excluding
    domain spawn/join overhead). [results] is a list of the values returned by each
    worker, sorted by domain ID.
    @raise Invalid_argument if [domains] < 1. *)
val run : domains:int -> (int -> 'a) -> float * 'a list

(** [repeat ~warmup ~reps f] executes the thunk [f] [warmup] times (discarding the
    results to warm up CPU caches and trigger page faults), and then executes [f]
    [reps] times, collecting and returning the results.

    @return A list of length [reps] containing the return values of [f]. *)
val repeat : warmup:int -> reps:int -> (unit -> float) -> float list

(** [median_of_sorted arr] calculates the median value of a sorted array of floats.
    @raise Invalid_argument if [arr] is empty. *)
val median_of_sorted : float array -> float

(** [median_and_iqr xs] computes the median and Interquartile Range (IQR) of a list
    of floats using Tukey's hinges.

    @return A tuple [(median, iqr)]. If [xs] contains fewer than two elements, the
    IQR will be returned as [Float.nan].
    @raise Invalid_argument if [xs] is empty. *)
val median_and_iqr : float list -> float * float

(** [env name ~default] fetches the value of the environment variable [name].
    @return The string value of the environment variable if it exists and is not
    empty, otherwise returns [default]. *)
val env : string -> default:string -> string

(** Returns the value of the [BENCH_MACHINE] environment variable, or "unknown". *)
val machine : unit -> string

(** Returns the value of the [GIT_DESC] environment variable, or "unknown". *)
val git_desc : unit -> string

(** Returns the value of the [BENCH_DATE] environment variable, or "undated". *)
val bench_date : unit -> string

(** Generates a list of metadata key-value pairs representing the current execution
    environment (machine, git commit, date, OCaml version, OS type, word size,
    recommended domains, and custom flags). *)
val meta_lines : unit -> (string * string) list

(** Formats a float to a string with 9 significant digits. *)
val fmt_float : float -> string

(** Escapes and formats a string for safe inclusion in a CSV file (handling quotes,
    commas, and newlines). *)
val csv_field : string -> string

(** Joins a list of string fields into a comma-separated CSV row. *)
val csv_row : string list -> string

(** [ensure_dir d] creates directory [d] with permissions [0o755] if it does not
    already exist. *)
val ensure_dir : string -> unit

(** [results_path ~bench] constructs a standardized file path for saving benchmark
    results in the format [results/<machine>/<date>_<git>_<bench>.csv]. Creates
    the necessary parent directories if they do not exist. *)
val results_path : bench:string -> string

(** [write_csv ~path ~columns rows] writes benchmark data to a CSV file at [path].
    It automatically prepends environment metadata as commented lines (`#`), followed
    by the [columns] headers, and then the data [rows]. *)
val write_csv : path:string -> columns:string list -> string list list -> unit
