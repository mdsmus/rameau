#### -*- Mode: Makefile -*-
#### Author: Matthew Danish <mrd@debian.org>
#### Main GNU Makefile

DESTDIR=/usr/local

all: Makefile.opts
	(cd c; ${MAKE})

clean: Makefile.opts
	(cd build; ${MAKE} clean)
	$(RM) Makefile.opts

lispclean:
	find . -name '*.x86f' | xargs rm -f
	find . -name '*.fasla16' | xargs rm -f
	find . -name '*.fasl' | xargs rm -f
	find . -name '*.ufsl' | xargs rm -f

Makefile.opts:
	(sh select_platform.sh)

install_sdl:
	(cd build; ${MAKE} install_sdl DESTDIR=$(DESTDIR))

install_opengl:
	(cd build; ${MAKE} install_opengl DESTDIR=$(DESTDIR))

install_ttf:
	(cd build; ${MAKE} install_ttf DESTDIR=$(DESTDIR))

install_img:
	(cd build; ${MAKE} install_img DESTDIR=$(DESTDIR))

install_mix:
	(cd build; ${MAKE} install_mix DESTDIR=$(DESTDIR))

install: install_sdl install_opengl install_ttf install_img install_mix
