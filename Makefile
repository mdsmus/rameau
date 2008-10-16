SHELL = /bin/bash

SBCL_BIN = sbcl
LISP_BIN = lisp
PWD = "$(shell pwd -P)/"

SYSTEM = $(shell uname -s)

ifeq ($(SYSTEM), Linux)
	LIBC = /lib/libc.so.6
else ifeq ($(findstring CYGWIN,$(SYSTEM)), CYGWIN)
	LIBC = /lib/libc.a
endif

GIT_COMMIT = $(shell git log --pretty=format:%H -n 1)
KERNEL_INFO = $(shell uname -a)
LIBC_VERSION = $(shell $(LIBC) | grep -o "release version [0-9]\+\.[0-9]\+" | awk '{print $$3}')
RAMEAU_VERSION = $(shell grep "\* Rameau [0-9]\+\.[0-9]\+" RELEASE -m 1 -o | awk '{print $$3}')
COMPILATION_DATE = $(shell date)
USER = $(shell echo $$USER)

TRAIN_NAME = $(shell git branch | grep "*" | cut -f 2 -d ' ')-$(TRAIN_VERSION)
RAMEAUDEPS = t
hostname = $(shell hostname)
maindir = $(shell pwd)
c = 001

prefix = /usr/local/
INSTALL = /bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = cp -R

ifeq ($(RAMEAUDEPS),t)
	sbcl = $(SBCL_BIN) --disable-debugger --no-userinit
	lisp = $(LISP_BIN) -noinit 
	clisp = clisp -ansi -K full -norc
else
	sbcl = $(SBCL_BIN) --disable-debugger
	lisp = $(LISP_BIN) -batch -quiet
	clisp = clisp -ansi -K full
endif

lisp-files = $(wildcard src/*.asd src/*.lisp tools/*.lisp src/tests/*.lisp src/algorithms/*.lisp src/commands/*.lisp src/cl-lily/*.lisp)

.PHONY: update clean all doc train data all-rameau check visuals

default: train

train: rameau
	./rameau setup

data:
	./rameau report -f chor:042,044,046,048,050 chor:53..57
	./rameau data -f chor:042,044,046,048,050 chor:53..57

all-rameau: rameau cmurameau clisprameau

check: rameau
	./rameau check all

visuals:
	./rameau algorithms -o visualize

## rule build rameau to user instalation
rameau-install: $(lisp-files)
	${sbcl} --eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" \
	--eval "(defparameter *git-commit* \"${GIT_COMMIT}\")" \
	--eval "(defparameter *kernel-info* \"${KERNEL_INFO}\")" \
	--eval "(defparameter *libc-version* \"${LIBC_VERSION}\")" \
	--eval "(defparameter *rameau-version* \"${RAMEAU_VERSION}\")" \
	--eval "(defparameter *compilation-date* \"${COMPILATION_DATE}\")" \
	--eval "(defparameter *user* \"${USER}\")" \
	--eval "(defparameter *main-path* \"${PWD}\")" \
	--eval "(defparameter *install-path* \"${prefix}/share/rameau/\")" \
	--load "tools/make-image.lisp"

rameau: $(lisp-files)
	${sbcl} --eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" \
	--eval "(defparameter *git-commit* \"${GIT_COMMIT}\")" \
	--eval "(defparameter *kernel-info* \"${KERNEL_INFO}\")" \
	--eval "(defparameter *libc-version* \"${LIBC_VERSION}\")" \
	--eval "(defparameter *rameau-version* \"${RAMEAU_VERSION}\")" \
	--eval "(defparameter *compilation-date* \"${COMPILATION_DATE}\")" \
	--eval "(defparameter *user* \"${USER}\")" \
	--eval "(defparameter *main-path* \"${PWD}/\")" \
	--eval "(defparameter *install-path* \"${PWD}\")" \
	--load "tools/make-image.lisp"

checa-notas: tools/read-notes.lisp
	${sbcl} --eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" --load "tools/make-image-read-notes.lisp"

cmurameau: $(lisp-files)
	${lisp} -eval "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" -load "tools/make-image.lisp"

eclrameau: $(lisp-files)
	ecl -eval  "(load \"tools/make-image.lisp\")"

clisprameau: $(lisp-files)
	${clisp} -x "(defparameter *use-rameau-deps* ${RAMEAUDEPS})" -x "(load \"tools/make-image.lisp\")"

update: 
	git pull --rebase

update-modules:
	git submodule init
	git submodule update
	cd rameau-deps/lisp-libs && git checkout master && git pull
	cd rameau-deps/cl-fann && git checkout master && git pull

coral:
	./rameau anal -f chora:$(c) -a es-net -S

all-png:
	./rameau anal -f music/chorales-bach/*.ly -a es-net -s > /dev/null
	cd analysis ; lilypond --png *.ly 2> /dev/null

indent:
	for file in $(lisp-files) ;\
	do \
	emacs --batch $$file -q --load "${maindir}/tools/cl-indent" --load "${maindir}/tools/enforce-style" -f rameau-style ;\
	done

doc: rameau
	./rameau doc
	cd rameau-documentation; \
	make

build-install:
	# compile rameau and training data on this directory. the goal
	# here is only to generate the training data.
	$(MAKE) train
	# compile rameau again (but not the training data), but with a
	# different destination path
	$(MAKE) rameau-install

install: 
	$(INSTALL_PROGRAM) -d $(prefix)/share/rameau/
	$(INSTALL_PROGRAM) -d $(prefix)/bin
	$(INSTALL_PROGRAM) rameau $(prefix)/bin/
	$(INSTALL_DATA) music $(prefix)/share/rameau/
	$(INSTALL_DATA) web $(prefix)/share/rameau/
	$(INSTALL_DATA) answer-sheets $(prefix)/share/rameau/
	$(INSTALL_DATA) algorithms  $(prefix)/share/rameau/

uninstall:
	rm -rf $(prefix)/bin/rameau
	rm -rf $(prefix)/share/rameau

clean:
	rm -f rameau cmurameau eclrameau clisprameau checa-notas
	rm -f web/cache.store

cleanall: clean clean-algs clean-web clean-lib clean-doc

distclean: cleanall clean-deps clean-analysis clean-score clean-midi clean-cache clean-web clean-deps
	cd docs/choral-book && $(MAKE) cleanall

# remove os fasls do rameau, sem remover das bibliotecas
lisp-clean: clean-lib
	-find ~/lisp/fasl/ -type f | grep rameau | xargs rm -f

lisp-clean-all: clean-lib clean
	rm -rf /var/cache/common-lisp-controller/\$${UID}/sbcl/local
	rm -rf ~/lisp/fasl/*

clean-algs:
	rm -f algorithms/*

clean-analysis:
	rm -f analysis/*

clean-doc:
	rm -f rameau-documentation/*.{tex,html}

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

