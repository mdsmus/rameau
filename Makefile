SYSTEM = $(shell uname -s)

ifeq ("$(SYSTEM)", "Linux")
	TRAIN_VERSION = $(shell grep -o '(neural-version "[0-9]\+")' src/options.lisp | \
	sed 's/(neural-version "\([0-9]\+\)")/\1/')
	SBCL_BIN = /usr/bin/sbcl
	LISP_BIN = /usr/bin/lisp
else ifeq ("$(SYSTEM)", "FreeBSD")
	TRAIN_VERSION = $(shell grep -o '(neural-version "[0-9]\+")' src/options.lisp | \
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
.PHONY: coral

default: rameau 

all-rameau: rameau cmurameau clisprameau

check: rameau
	./rameau check all

unit: rameau
	./rameau teste unidade -v

test: rameau unit
	./rameau a c -f 001

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

train:
	./rameau algorithms -o train

rameau: $(lisp-files)
	@if [ ! -d rameau-deps/ ]; then \
	echo rode make deps rameau ;\
	else \
	${sbcl} --eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" --load "tools/make-image.lisp" ;\
	fi

checa-notas: tools/read-notes.lisp
	${sbcl} --eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" --load "tools/make-image-read-notes.lisp"

cmurameau: $(lisp-files)
	${lisp} -eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" -load "tools/make-image.lisp"

eclrameau: $(lisp-files)
	ecl -eval  "(load \"tools/make-image.lisp\")"

clisprameau: $(lisp-files)
	${clisp} -x "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" -x "(load \"tools/make-image.lisp\")"

update: cl-fann
	git pull --rebase

book: book-stuff
	sh gera-tex.sh
	latex book-corais.tex
	dvips book-corais.dvi

book-stuff: docs/corais.lytex
	lilypond-book -o out --psfonts -I music/chorales-bach/ docs/corais.lytex

coral:
	./rameau anal -f chora:$(c) -a es-net -S

all-png:
	./rameau anal -f music/chorales-bach/*.ly -a es-net -s > /dev/null
	cd analysis ; lilypond --png *.ly 2> /dev/null

pauta:
	wget -O pauta.html "http://wiki.genos.mus.br/PautaReuniao"

clean-nets:
	rm -f neural-nets/*

clean:
	rm -f rameau
	rm -f tools/algorithms.store
	rm -f web/cache.store
	rm -f music/*/*.{pdf,ps}
	rm -f regressao/*.{pdf,ps}
	rm -f book-corais.tex
	rm -f checa-notas
	rm -f analysis/*
	rm -f music/chorales-bach/*.midi
	find . -name *.o -exec rm {} \;
	find . -name *.fasl -exec rm {} \;
	find . -name *.fas -exec rm {} \;
	find . -name *.lib -exec rm {} \;
	find . -name *.x86f -exec rm {} \;

clean-web:
	rm -f web/*.ly
	rm -f web/cache.store

lispclean:
	rm -rf /var/cache/common-lisp-controller/$$UID/sbcl/local
	rm -rf ~/lisp/fasl/*

cleanall: clean clean-nets lispclean clean-web
	rm -rf rameau cmurameau eclrameau clisprameau 

clean-deps:
	rm -rf rameau-deps

distclean: cleanall clean-deps
