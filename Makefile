PATSHOME=$(wildcard /run/current-system/sw/lib/ats2-postiats-*)

PATSOPT=patsopt

FIND=find

%.hats: %.hats.h
	$(CPP) -P $< -o $@

%_dats.c: %.dats static/fd.sats static/error.sats include/socket.hats
	$(PATSOPT) --output $@ --dynamic $< || ($(RM) -f $@ && exit 1)

%_dats.o: %_dats.c include/common.h
	$(CC) -std=c99 -D_XOPEN_SOURCE -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -I. -c $(CFLAGS) -o $@ $<

.PHONY: all
all: socket-activate

OBJS=dynamic/socket-activate_dats.o dynamic/fd_dats.o dynamic/error_dats.o

socket-activate: $(OBJS)
	$(CC) -L$(PATSHOME)/ccomp/atslib/lib -L$(PATSHOME)/ccomp/atslib/lib64 $(LDFLAGS) $(OBJS) -o $@

clean:
	$(FIND) . -name '*_dats.*' -print0 | xargs -0 $(RM) -f
	$(RM) -f socket-activate
	$(RM) -f include/socket.hats
