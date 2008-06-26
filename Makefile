SYSTEM = $(shell uname -s)

ifeq ("$(SYSTEM)", "Linux")
	TRAIN_VERSION = $(shell grep -o '(neural-version "[0-9]\+")' src/options.lisp | \
	sed 's/(neural-version "\([0-9]\+\)")/\1/')
	SBCL_BIN = /usr/bin/sbcl
	LISP_BIN = /usr/bin/lisp
else ifeq ("$(SYSTEM)", "FreeBSD")
	TRAIN_VERSION = $(shell grep -o '(neural-version "[0-9]\+")' src/option.lisp | \
	sed -E 's/\(neural-version "([0-9]+)"\)/\1/')
	SBCL_BIN = /usr/local/bin/sbcl
	LISP_BIN = /usr/local/bin/lisp
endif

TRAIN_NAME = $(shell git branch | grep "*" | cut -f 2 -d ' ')-$(TRAIN_VERSION)
RAMEAUDEPS = t
hostname = $(shell hostname)
maindir = $(shell pwd)
c = 001

ifeq ($(RAMEAUDEPS),t)
	sbcl = $(SBCL_BIN) --disable-debugger --no-userinit
	lisp = $(LISP_BIN) -noinit 
	clisp = clisp -ansi -K full -norc
else
	sbcl = $(SBCL_BIN) --disable-debugger
	lisp = $(LISP_BIN) -batch -quiet
	clisp = clisp -ansi -K full
endif

lisp-files = $(wildcard src/*asd src/*.lisp src/lib/*.lisp tools/*.lisp src/algorithms/*.lisp)

neural-path = $(maindir)/neural-nets/


vpath %.fann $(neural-path)
vpath %.data $(neural-path)

.PHONY: update clean all doc update  resultados erros

default: rameau train-neural

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

train-neural: $(TRAIN_NAME)-context.fann $(TRAIN_NAME)-e-chord.fann

$(TRAIN_NAME)-e-chord-train.data:
	echo $@
	./rameau train --e-chord-data-set --e-chord-data $(neural-path)/$@

$(TRAIN_NAME)-context-train.data:
	./rameau train --context-data-set --context-data $(neural-path)/$@

$(TRAIN_NAME)-context.fann: $(TRAIN_NAME)-context-train.data
	./rameau train --context-fann-file --context-data $(neural-path)/$< \
	--context-fann $(neural-path)/$@

$(TRAIN_NAME)-e-chord.fann: $(TRAIN_NAME)-e-chord-train.data
	./rameau train --e-chord-fann-file --e-chord-data $(neural-path)/$< \
	--e-chord-fann $(neural-path)/$@

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

contagem.txt:
	for x in $$(awk '{print $$3}' anppom/cruzamentos.txt | uniq ); do echo "$$(grep -c $$x anppom/cruzamentos.txt) $$x"; done | sort  -n > contagem.txt

doc:
	cd docs ;\
	make pdf

update: cl-fann
	git pull --rebase


book: book-stuff
	sh gera-tex.sh
	latex book-corais.tex
	dvips book-corais.dvi

book-stuff: docs/corais.lytex
	lilypond-book -o out --psfonts -I music/chorales-bach/ docs/corais.lytex

.PHONY: anppom
anppom:
	./rameau cruz -f music/chorales-bach/*.ly -a es-net -v > anppom/cruzamentos.txt
	./rameau seventh -f music/chorales-bach/*.ly -a es-net -v > anppom/setimas.txt
	./rameau fifths  -f music/chorales-bach/*.ly -a es-net -v > anppom/quintas.txt
	./rameau octaves -f music/chorales-bach/*.ly -a es-net -v > anppom/oitavas.txt
	./rameau ambito -f music/chorales-bach/*.ly -a es-net -v > anppom/ambitos.txt
	./rameau jumps -f music/chorales-bach/*.ly -a es-net -v > anppom/saltos.txt
	./rameau cadences -f music/chorales-bach/*.ly -a es-net -v -m 100 > anppom/cadencias.txt

.PHONY: coral
coral:
	./rameau anal -f chora:$(c) -a es-net -S

all-png:
	./rameau anal -f music/chorales-bach/*.ly -a es-net -s > /dev/null
	cd analysis ; lilypond --png *.ly 2> /dev/null

sync: anppom
	rsync -v --progress --rsh=ssh anppom/* rameau@genos.mus.br:public_html/

sync-png: all-png
	rsync -v --progress --rsh=ssh analysis/*.png rameau@genos.mus.br:public_html/corais/

sync-all: sync sync-png

pauta:
	wget -O pauta.html "http://wiki.genos.mus.br/PautaReuniao"

clean-nets:
	rm -f neural-nets/*

clean-resultados:
	rm -f resultados/*

clean:
	rm -f rameau
	find . -name *.fasl -exec rm {} \;
	find . -name *.fas -exec rm {} \;
	find . -name *.lib -exec rm {} \;
	find . -name *.x86f -exec rm {} \;

clean-lisp-cache:
	rm -rf /var/cache/common-lisp-controller/$$UID/sbcl/local

cleanall: clean clean-nets clean-resultados lispclean
	rm -rf rameau cmurameau eclrameau clisprameau 

lispclean: clean
	@if [ $(hostname) == "phoenix" ]; then \
	rm -rf ~/lisp/fasl/* ;\
	find . ~/lisp -name *.fas -exec rm {} \; ;\
	else \
	rm -rf /var/cache/common-lisp-controller/$$UID/* ;\
	fi 
