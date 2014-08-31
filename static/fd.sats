staload "static/errno.sats"

absview filedes (fd: int)

prfn lemma_filedes_natural {n: int} (pf: !filedes n):<prf>
  [n >= 0] void

fn close {fd: nat} (filedes fd | int fd):
  [res: int] (option_v(errno_obligation, res == ~1) | int res)
