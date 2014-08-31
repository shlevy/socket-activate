%{^
#include "include/common.h"
#include <unistd.h>
%}

#include "share/atspre_staload.hats"

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
  extern fun unsafe_close (int): Int = "ext#close"
  val res = unsafe_close(fd)
  prval filedes_impl fd = prf
in if res = ~1 then let
  prval e_obl = require_errno_check ()
in (Some_v e_obl | res) end
else (None_v () | res) end
