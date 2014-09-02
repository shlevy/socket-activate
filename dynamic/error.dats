%{^
#include "include/common.h"
%}

#define ATS_DYNLOADFLAG 0

staload "static/error.sats"

assume error_obligation = unit_v

primplement impose_error_obligation () = unit_v ()

primplement discharge_error_obligation (prf) = let
  prval unit_v () = prf
in () end
