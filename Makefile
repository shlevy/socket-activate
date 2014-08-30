PATSHOME=$(wildcard /run/current-system/sw/lib/ats2-postiats-*)

PATSOPT=patsopt

FIND=find

%_dats.c: %.dats
	$(PATSOPT) --output $@ --dynamic $<

%_dats.o: %_dats.c include/common.h
	$(CC) -std=c99 -D_XOPEN_SOURCE -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -I. -c $(CFLAGS) -o $@ $<

.PHONY: all
all: socket-activate

socket-activate: dynamic/socket-activate_dats.o
	$(CC) -L$(PATSHOME)/ccomp/atslib/lib -L$(PATSHOME)/ccomp/atslib/lib64 $(LDFLAGS) $< -o $@

clean:
	$(FIND) . -name '*_dats.*' -print0 | xargs -0 $(RM) -f
	$(RM) socket-activate
