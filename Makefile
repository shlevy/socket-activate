PATSHOME=$(wildcard /run/current-system/sw/lib/ats2-postiats-*)

PATSOPT=patsopt

%_dats.c: %.dats
	$(PATSOPT) --output $@ --dynamic $<

%_dats.o: %_dats.c
	$(CC) -std=c99 -D_XOPEN_SOURCE -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -c $(CFLAGS) -o $@ $<

.PHONY: all
all: socket-activate

socket-activate: socket-activate_dats.o
	$(CC) -L$(PATSHOME)/ccomp/atslib/lib -L$(PATSHOME)/ccomp/atslib/lib64 $(LDFLAGS) $< -o $@

clean:
	rm -f *_dats.*
	rm socket-activate
