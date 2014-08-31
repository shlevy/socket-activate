%{^
#include "include/common.h"
#include <unistd.h>
%}

#define ATS_DYNLOADFLAG 0

staload "static/fd.sats"
staload "static/errno.sats"

dataview filedes_impl (int) = {n: nat} filedes_impl(n) of (int n)

assume filedes (fd: int) = filedes_impl (fd)

primplement lemma_filedes_natural (pf) = let
  prval filedes_impl n = pf
  prval () = pf := filedes_impl n
in () end

implement close (prf | fd) = let
  extern fun unsafe_close (int): int = "ext#close"
  val res = unsafe_close(fd)
  prval filedes_impl fd = prf
  prval prf = (if res = ~1 then let
    prval e_obl = require_errno_check ()
  in Some_v e_obl end
  else None_v ()): [res: int] (option_v(errno_obligation, res == ~1))
in (prf | res) end
