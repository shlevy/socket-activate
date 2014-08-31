%{^
#include "include/common.h"
%}

#include "share/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

staload "static/fd.sats"
staload "static/errno.sats"

implement main () = let
  prval pf = __assert () where {
    extern praxi __assert (): filedes 2
  }

  val (pf | res) = close(pf | 2)

  val ret = (if res = ~1 then let
    prval Some_v e_obl = pf
  in get_errno (e_obl | (*none*)) end
  else let
    prval None_v () = pf
  in 0 end) : int
in ret end
