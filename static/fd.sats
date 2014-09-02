#include "include/socket.hats"

staload "static/error.sats"

absview filedes (fd: int)

prfn lemma_filedes_natural {n: int} (pf: !filedes n):
  [n >= 0] void

dataprop domain(int) = AF_UNIX (ATS_AF_UNIX)

(* Needs bitwise constraints (https://groups.google.com/forum/?fromgroups=#!topic/ats-lang-users/2WIHuLsWQAs)
dataprop type_base(int) = SOCK_STREAM (ATS_SOCK_STREAM)

dataprop type_modifier(int) = SOCK_NONBLOCK (ATS_SOCK_NONBLOCK) | SOCK_CLOEXEC (ATS_SOCK_CLOEXEC)

dataprop type(int) =
  | {t: int} base (t) of (type_base(t))
  | {t, m: int} or ((t lor m)) of (type(t), type_modifier(m))
*)

dataprop type(int) = SOCK_STREAM (ATS_SOCK_STREAM)

(* TODO: protocol *)

sortdef nat_or_error = {a: int | a >= ~1}
typedef NatOrError = [a: nat_or_error] int a

fn socket {d, t: int} (domain d, type t | int d, int t):
  [fd: nat_or_error] (option_v(filedes fd, fd != ~1) | int fd)

(* Even if close fails, we shouldn't consider the fd still open.
 From close(2) on my system:
 > Not checking the return value of close() is a common but nevertheless serious
 > programming error. It is quite possible that errors on a previous write(2)
 > operation are first reported at the final close(). Not checking the return
 > value when closing the file may lead to silent loss of data. This can espe‐
 > cially be observed with NFS and with disk quota. Note that the return value
 > should only be used for diagnostics. In particular close() should not be
 > retried after an EINTR since this may cause a reused descriptor from another
 > thread to be closed
*)
fn close {fd: nat} (filedes fd | int fd):
  [res: int] (option_v(error_obligation, res == ~1) | int res)
