%{^
#include "include/common.h"
%}

#include "share/atspre_staload.hats"

#define ATS_DYNLOADFLAG 0

staload "static/fd.sats"
staload "static/errno.sats"

implement main () = let
  val (pf | fd) = socket(AF_UNIX, SOCK_STREAM | ATS_AF_UNIX, ATS_SOCK_STREAM)
in (if fd >= 0 then let
  prval Some_v pf = pf

  val (pf | res) = close(pf | fd)
in (if res = ~1 then let
  prval Some_v e_obl = pf
in get_errno (e_obl | (*none*)) end
else let
  prval None_v () = pf
in 0 end): int end
else let
  prval None_v () = pf
in ~1 end): int end
