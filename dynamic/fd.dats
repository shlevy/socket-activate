%{^
#include "include/common.h"
#include <unistd.h>
#include <sys/socket.h>
%}

#include "share/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

staload "static/fd.sats"
staload "static/error.sats"

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
  prval e_obl = impose_error_obligation ()
in (Some_v e_obl | res) end
else (None_v () | res) end

implement socket (domain, type) = let
  extern fun unsafe_socket (int, int, int): NatOrError = "ext#socket"
  val res = unsafe_socket(domain, type, 0)
in if res = ~1 then (None_v () | res)
else let
  prval pf = filedes_impl res
in (Some_v pf | res) end end
