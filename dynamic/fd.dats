%{^
#include "include/common.h"
#include <unistd.h>
%}

#define ATS_DYNLOADFLAG 0

staload "static/fd.sats"

dataview filedes_impl (int) = {n: nat} filedes_impl(n) of (int n)

assume filedes (fd: int) = filedes_impl (fd)

primplement lemma_filedes_natural {n: int} (pf): [n >= 0] void = let
  prval filedes_impl n = pf
  prval () = pf := filedes_impl n
in () end

implement close (prf | fd) : void = let
  extern fun unsafe_close (int): int = "ext#close"
  val _ = unsafe_close(fd)
  prval filedes_impl fd = prf
in () end
