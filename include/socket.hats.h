(*
#include <sys/socket.h>
*)

#define HASHDEFINE #define
#define DEFINE(x) HASHDEFINE ATS_ ## x x

DEFINE(AF_UNIX)

(* SOCK_* constants are enums, not macros, ugh *)
HASHDEFINE ATS_SOCK_STREAM 1
