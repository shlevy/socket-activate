#define ATS_PACKNAME "socket_activate.fd"

absview filedes (fd: int)

prfn lemma_filedes_natural {n: int} (pf: !filedes n):<prf> [n >= 0] void

fn close {fd: nat} (filedes fd | int fd): void
