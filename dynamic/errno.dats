%{^
#include "include/common.h"
#include <errno.h>
%}

#define ATS_DYNLOADFLAG 0

staload "static/errno.sats"

assume errno_obligation = unit_v

primplement require_errno_check () = unit_v ()

implement get_errno (prf | (*none*)) = let
  prval unit_v () = prf
in $extval(int, "errno") end
