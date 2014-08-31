%{^
#include "include/common.h"
%}

#define ATS_DYNLOADFLAG 0

staload "static/fd.sats"

implement main () = let
  prval pf = __assert () where {
    extern praxi __assert (): filedes 2
  }
  val _ = close(pf | 2)
in 0 end
