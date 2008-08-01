SYSTEM = $(shell uname -s)

SBCL_BIN = sbcl
LISP_BIN = lisp

GIT_COMMIT = $(shell git log --pretty=format:%H -n 1)
KERNEL_INFO = $(shell uname -a)
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

neural-path = $(maindir)/algorithms/


.PHONY: update clean all doc update

default: rameau 

data:
	./rameau report -f chor:042,044,046,048,050 chor:53..57
	./rameau data -f chor:042,044,046,048,050 chor:53..57

all-rameau: rameau cmurameau clisprameau

check: rameau
	./rameau check all

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

visuals:
	./rameau algorithms -o visualize

rameau-deps:
	$(MAKE) cl-fann rameau

rameau: $(lisp-files) rameau-deps
	${sbcl} --eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" \
	--eval "(defparameter *git-commit* \"${GIT_COMMIT}\")" \
	--eval "(defparameter *kernel-info* \"${KERNEL_INFO}\")" \
	--load "tools/make-image.lisp"

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

coral:
	./rameau anal -f chora:$(c) -a es-net -S

all-png:
	./rameau anal -f music/chorales-bach/*.ly -a es-net -s > /dev/null
	cd analysis ; lilypond --png *.ly 2> /dev/null

pauta:
	wget -O pauta.html "http://wiki.genos.mus.br/PautaReuniao"

doc: rameau
	./rameau doc
	cd rameau-documentation; \
	make

clean:
	rm -f rameau cmurameau eclrameau clisprameau checa-notas
	rm -f web/cache.store

cleanall: clean clean-algs clean-web clean-lib clean-doc

distclean: cleanall clean-deps clean-analysis clean-score clean-midi clean-cache clean-web clean-deps
	cd docs/choral-book && $(MAKE) cleanall

lispclean: clean-lib clean
	rm -rf /var/cache/common-lisp-controller/$$UID/sbcl/local
	rm -rf ~/lisp/fasl/*

clean-algs:
	rm -f algorithms/*

clean-analysis:
	rm -f analysis/*

clean-doc:
	rm -f rameau-documentation/*.tex

clean-score:
	rm -f music/*/*.{pdf,ps}
	rm -f regressao/*.{pdf,ps}

clean-midi:
	rm -f music/*/*.midi

clean-visuals:
	rm -f docs/view-hmm-{note,trans,prior}-probabilities.png

clean-lib:
	find -name *.fasl -or -name *.o -or -name *.fas -or -name *.lib -or -name *.x86f | xargs rm -f

clean-cache:
	rm -f algorithms/{ES,EC,S}-{Bay,Hmm,Net,Knn,tree}.store
	rm -f web/cache.store

clean-web:
	rm -f web/*.ly
	rm -f web/cache.store

clean-deps:
	rm -rf rameau-deps

