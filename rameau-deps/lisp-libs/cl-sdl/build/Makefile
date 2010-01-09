#### -*- Mode: Makefile -*-

include ../Makefile.opts
include ../Makefile.common

DESTDIR=/usr/local
SDL_LIBDIR=$(DESTDIR)/lib/cl-sdl/

all:

clean:
	$(RM) $(STUBS)

install_sdl:
	install -m 0644 sdlstub.$(SHLIB_SUFFIX) $(SDL_LIBDIR)

install_opengl:
	install -m 0644 glstub.$(SHLIB_SUFFIX) $(SDL_LIBDIR)

install_ttf:
	install -m 0644 sdlttfstub.$(SHLIB_SUFFIX) $(SDL_LIBDIR)

install_img:
	install -m 0644 sdlimgstub.$(SHLIB_SUFFIX) $(SDL_LIBDIR)

install_mix:
	install -m 0644 sdlmixstub.$(SHLIB_SUFFIX) $(SDL_LIBDIR)
