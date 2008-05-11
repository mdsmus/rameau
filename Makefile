RAMEAUDEPS = t
hostname = $(shell hostname)
maindir = $(shell pwd)

ifeq ($(RAMEAUDEPS),t)
	sbcl = /usr/bin/sbcl --no-userinit
	lisp = /usr/bin/lisp -noinit 
	clisp = clisp -ansi -K full -norc
else
	sbcl = /usr/bin/sbcl --disable-debugger
	lisp = /usr/bin/lisp -batch -quiet
	clisp = clisp -ansi -K full
endif

lisp-files = $(wildcard src/*asd src/*.lisp src/lib/*.lisp tools/*.lisp src/algorithms/*.lisp)
corais-lyi = $(wildcard literatura/bach-corais/*.lyi)
corais-png = $(notdir $(patsubst %.lyi,%.png,$(corais-lyi)))
corais-png-partitura = $(addprefix coral-,$(notdir $(patsubst %.lyi,%.png,$(corais-lyi))))
corais-ly-partitura = $(addprefix coral,$(notdir $(patsubst %.lyi,%.ly,$(corais-lyi))))
corais-ly = $(notdir $(patsubst %.lyi,%.ly,$(corais-lyi)))
corais-dir = $(maindir)/corais

neural-path = $(maindir)/neural-nets/

lilypond = lilypond -I $(maindir)/literatura/bach-corais -I $(maindir)/lily

vpath %.lyi literatura/bach-corais
vpath %.pop gabaritos/bach-corais
vpath %.ly $(corais-dir)
vpath %.log $(corais-dir)
vpath %.png $(corais-dir)
vpath %.fann neural-nets/
vpath %.data neural-nets/

.PHONY: update clean all doc update corais-ly corais corais-partitura resultados erros

default: corais-ly rameau train-neural

all-rameau: rameau cmurameau clisprameau

resultados: rameau clean-resultados
	./rameau resultados c -f 7..400 > resultados/rameau
	python tools/formata-tipos.py resultados/rameau resultados/

clean-erros:
	rm -f erros/*

check: rameau
	./rameau check all

unit: rameau
	./rameau teste unidade -v

test: rameau unit
	./rameau a c -f 001

erros: rameau clean-erros
	./rameau erros c > erros/rameau
	python tools/formata-tipos.py erros/rameau erros/

clean-acertos:
	rm -f acertos/*

acertos: rameau clean-acertos
	./rameau acertos c > acertos/rameau
	python tools/formata-tipos.py acertos/rameau acertos/

cl-fann: deps
	@if [ ! -d rameau-deps/cl-fann ]; then \
	cd rameau-deps ; git clone git://genos.mus.br/cl-fann ;\
	else \
	cd rameau-deps/cl-fann ; git pull ;\
	fi
deps:
	@if [ ! -d rameau-deps ]; then \
	git clone git://genos.mus.br/rameau-deps ;\
	else \
	cd rameau-deps ; git pull ;\
	fi

train-neural: context.fann e-chord.fann

e-chord-train.data:
	./rameau train --e-chord-data-set --e-chord-data $(neural-path)/$@

context-train.data:
	./rameau train --context-data-set --context-data $(neural-path)/$@

context.fann: context-train.data
	./rameau train --context-fann-file --context-data $(neural-path)/$< --context-fann $(neural-path)/$@

e-chord.fann: e-chord-train.data
	./rameau train --e-chord-fann-file --e-chord-data $(neural-path)/$< --e-chord-fann $(neural-path)/$@

rameau: $(lisp-files)
	${sbcl} --eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" --load "tools/make-image.lisp"

checa-notas: tools/read-notes.lisp
	${sbcl} --eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" --load "tools/make-image-read-notes.lisp"

cmurameau: $(lisp-files)
	${lisp} -eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" -load "tools/make-image.lisp"

eclrameau: $(lisp-files)
	ecl -eval  "(load \"tools/make-image.lisp\")"

clisprameau: $(lisp-files)
	${clisp} -x "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" -x "(load \"tools/make-image.lisp\")"

doc:
	cd docs ;\
	make pdf

update: cl-fann
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

coral-%.png: %.ly %.pop rameau
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

clean:
	rm -f rameau
	rm -f *.data *.fann
	find -name *.fasl -exec rm {} \;
	find -name *.fas -exec rm {} \;
	find -name *.lib -exec rm {} \;
	find -name *.x86f -exec rm {} \;

clean-lisp-cache:
	rm -rf /var/cache/common-lisp-controller/$$UID/sbcl/local

cleanall: clean clean-nets clean-resultados
	rm -rf rameau cmurameau eclrameau clisprameau $(corais-dir)

lispclean: clean
	@if [ $(hostname) == "phoenix" ]; then \
	rm -rf ~/lisp/fasl/* ;\
	find ~/lisp -name *.fas -exec rm {} \; ;\
	else \
	rm -rf /var/cache/common-lisp-controller/$$UID/* ;\
	fi 
