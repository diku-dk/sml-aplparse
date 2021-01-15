MLCOMP ?= mlkit
SMLPKG ?= smlpkg

MLLIB=lib/github.com/diku-dk/sml-aplparse
FILENAMES=test/test.mlb test/test.sml aplparse.mlb REGION.sig Region.sml AplLex.sml AplParse.sml ParseComb.sml PARSE_COMB.sig
FILES=$(FILENAMES:%=$(MLLIB)/%)

all: $(MLLIB)/test/test.exe

$(MLLIB)/test/test.exe: $(FILES) Makefile lib/github.com/diku-dk/sml-unicode
	$(MLCOMP) -output $@ $<

TESTFILES=test.apl test1.apl test2.apl test3.apl test4.apl test5.apl \
          sierpinski.apl mult.apl primes.apl prelude.apl quadassign.apl \
          boolean.apl math.apl vec.apl chars.apl circ.apl quadids.apl \
          idx.apl underscore.apl thorn.apl train.apl trainatop.apl idx2.apl float.apl complex.apl

.PHONY: test
test: $(MLLIB)/test/test.exe Makefile
	@$(foreach tf,$(TESTFILES), echo "\n[Processing $(tf)]"; ./$< $(MLLIB)/test/tests/$(tf);)

.PHONY: clean
clean:
	rm -rf *~ MLB run
	rm -rf $(MLLIB)/test/*~ $(MLLIB)/test/MLB $(MLLIB)/test/test.exe
	rm -rf $(MLLIB)/*~ $(MLLIB)/MLB

lib/github.com/diku-dk/sml-unicode:
	$(SMLPKG) sync
