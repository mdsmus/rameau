RAMEAUDEPS = t
hostname = $(shell hostname)
maindir = $(shell pwd)

ifeq ($(RAMEAUDEPS),t)
	sbcl = /usr/bin/sbcl --no-userinit --disable-debugger
else
	sbcl = /usr/bin/sbcl --disable-debugger
endif

lisp = /usr/bin/lisp -batch -quiet -eval
lisp-files = $(wildcard src/*.lisp src/lib/*.lisp tools/*.lisp src/algoritmos/*.lisp)
corais-lyi = $(wildcard literatura/bach-corais/*.lyi)
corais-png = $(notdir $(patsubst %.lyi,%.png,$(corais-lyi)))
corais-png-partitura = $(addprefix coral-,$(notdir $(patsubst %.lyi,%.png,$(corais-lyi))))
corais-ly-partitura = $(addprefix coral,$(notdir $(patsubst %.lyi,%.ly,$(corais-lyi))))
corais-ly = $(notdir $(patsubst %.lyi,%.ly,$(corais-lyi)))
corais-dir = $(maindir)/corais

lilypond = lilypond -I $(maindir)/literatura/bach-corais -I $(maindir)/lily

vpath %.lyi literatura/bach-corais
vpath %.pop gabaritos/bach-corais
vpath %.ly $(corais-dir)
vpath %.log $(corais-dir)
vpath %.png $(corais-dir)

.PHONY: update clean all doc update corais-ly corais corais-partitura resultados erros

default: corais-ly rameau

all-rameau: rameau cmurameau clisprameau

resultados: rameau clean-resultados
	./rameau resultados c -f 7..300 > resultados/rameau
	python tools/formata-tipos.py resultados/rameau resultados/

clean-erros:
	rm -f erros/*

erros: rameau clean-erros
	./rameau erros c > erros/rameau
	python tools/formata-tipos.py erros/rameau erros/

clean-acertos:
	rm -f acertos/*

acertos: rameau clean-acertos
	./rameau acertos c > acertos/rameau
	python tools/formata-tipos.py acertos/rameau acertos/

rameau-deps:
	git clone git://genos.mus.br/rameau-deps

rameau: $(lisp-files) rameau-deps
	echo ${RAMEAUDEPS}
	${sbcl} --eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" --eval "(load \"tools/make-image.lisp\")"

cmurameau: $(lisp-files)
	${lisp} "(load \"tools/make-image.lisp\")" 

eclrameau: $(lisp-files)
	ecl -eval  "(load \"tools/make-image.lisp\")"

clisprameau: $(lisp-files)
	clisp -ansi -K full -x  "(load \"tools/make-image.lisp\")"

doc:
	cd docs ;\
	make pdf

update: 
	git fetch && git rebase origin/master

corais-ly: $(corais-ly)

## BUG: regera os png quando não precisa (mas não faz isso sempre)
corais: $(corais-png)

corais-partitura: rameau $(corais-png-partitura)

## BUG: regera os lyc quando não precisa (mas não faz isso sempre)
corais-fast: $(corais-ly)
	cd $(corais-dir); \
	$(lilypond) --png $(notdir $(corais-ly))

## BUG: gera dos os ly que tem no diretorio, inclusive coral-*.ly
corais-partitura-fast: $(corais-ly)
	./rameau partitura corais -vt
	cd $(corais-dir); \
	$(lilypond) --png $(notdir $(corais-ly-partitura))

%.ly: %.lyi
	@if [ ! -d $(corais-dir) ]; then mkdir -p $(corais-dir); fi;
	@cat $< lily/score.lyi > $(corais-dir)/$(basename $(notdir $<)).ly

coral-%.png: %.ly %.pop
	./rameau partitura corais -f $(notdir $(basename $<))
	cd $(corais-dir); \
	$(lilypond) --png coral-$(notdir $<) 2> $(corais-dir)/coral-$(notdir $(basename $<)).log

book: book-stuff
	sh gera-tex.sh
	latex book-corais.tex
	dvips book-corais.dvi

book-stuff: docs/corais.lytex corais-ly
	lilypond-book -o out --psfonts -I corais/ docs/corais.lytex

%.png: %.ly
	cd $(corais-dir); \
	$(lilypond) --png $< 2> $(corais-dir)/$(notdir $(basename $<)).log

clean-nets:
	rm -f neural-nets/*

clean-resultados:
	rm -f resultados/*

clean: clean-nets
	rm -f rameau
	rm -f *.data *.fann
	find -name *.fasl -exec rm {} \;
	find -name *.x86f -exec rm {} \;

clean-lisp-cache:
	rm -rf /var/cache/common-lisp-controller/$$UID/sbcl/local

cleanall: clean clean-nets clean-resultados
	rm -rf rameau cmurameau eclrameau clisprameau $(corais-dir)

lispclean: cleanall
	@if [ $(hostname) == "phoenix" ]; then \
	rm -rf ~/lisp/fasl/* ;\
	find ~/lisp -name *.fas -exec rm {} \; ;\
	else \
	rm -rf /var/cache/common-lisp-controller/$(id -u)/* ;\
	fi 
