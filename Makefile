maindir = $(shell pwd)
sbcl = /usr/bin/sbcl --noinform --noprint --disable-debugger --eval
lisp = /usr/bin/lisp -batch -quiet -eval
lisp-files = $(wildcard src/*.lisp src/lib/*.lisp tools/*.lisp)
corais-lyi = $(wildcard literatura/bach-corais/*.lyi)
corais-png = $(patsubst %.lyi,%.png,$(corais-lyi))
corais-ly = $(patsubst %.lyi,%.ly,$(corais-lyi))
corais-dir = $(maindir)/corais

lilypond = lilypond -I $(maindir)/literatura/bach-corais -I $(maindir)/lily

vpath %.lyi literatura/bach-corais
vpath %.ly $(corais-dir)
vpath %.png $(corais-dir)

.PHONY: update clean

rameau: $(lisp-files)
	${sbcl} "(load \"tools/make-image.lisp\")"

cmurameau: $(lisp-files)
	${lisp} "(load \"tools/make-image.lisp\")" 

eclrameau: $(lisp-files)
	ecl -eval  "(load \"tools/make-image.lisp\")"

clisprameau: $(lisp-files)
	clisp -ansi -K full -x  "(load \"tools/make-image.lisp\")"

all: rameau cmurameau clisprameau

doc:
	cd docs ;\
	make pdf

update: 
	git fetch && git rebase origin/master
	make rameau

corais-ly: $(corais-ly)

$(corais-dir):
	if [ ! -d $(corais-dir) ]; then mkdir -p $(corais-dir); fi; \

## BUG: regera os png toda vez que chama corais
corais: $(corais-png)

## BUG: regera os lyc toda vez que chama corais
corais-fast: $(corais-ly)
	cd $(corais-dir); \
	$(lilypond) --png $(notdir $(corais-ly))

%.ly: %.lyi $(corais-dir)
	cat $< lily/score.lyi > $(corais-dir)/$(basename $(notdir $<)).ly
	@if [ -f $(patsubst %.lyi,%.pop,$<) ]; then cp $(patsubst %.lyi,%.pop,$<) $(corais-dir); fi ;\

%.png: %.ly
	cd $(corais-dir); \
	$(lilypond) --png $(notdir $<)

clean:
	rm -f rameau

cleanall:
	rm -rf rameau cmurameau eclrameau clisprameau $(corais-dir)
