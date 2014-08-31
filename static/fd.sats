staload "static/errno.sats"

absview filedes (fd: int)

prfn lemma_filedes_natural {n: int} (pf: !filedes n):
  [n >= 0] void

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
  [res: int] (option_v(errno_obligation, res == ~1) | int res)
