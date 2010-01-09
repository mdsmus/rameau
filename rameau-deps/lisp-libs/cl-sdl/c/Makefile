#### -*- Mode: Makefile -*-
#### Author: Matthew Danish <mrd@debian.org>
#### C glue GNU makefile

include ../Makefile.opts
include ../Makefile.common

all: $(STUBS)
	mv $(STUBS) ../build/

sdlstub.$(SHLIB_SUFFIX): sdlstub.c
	$(CC) $(SDL_CFLAGS) -o $@ $< $(SDL_LDFLAGS)

glstub.$(SHLIB_SUFFIX): glstub.c
	$(CC) $(GL_CFLAGS) -o $@ $< $(GL_LDFLAGS)

sdlttfstub.$(SHLIB_SUFFIX): sdlttfstub.c
	$(CC) $(SDL_TTF_CFLAGS) -o $@ $< $(SDL_TTF_LDFLAGS)
sdlimgstub.$(SHLIB_SUFFIX): sdlimgstub.c
	$(CC) $(SDL_IMG_CFLAGS) -o $@ $< $(SDL_IMG_LDFLAGS)
sdlmixstub.$(SHLIB_SUFFIX): sdlmixstub.c
	$(CC) $(SDL_MIX_CFLAGS) -o $@ $< $(SDL_MIX_LDFLAGS)

clean:
	rm -f $(STUBS)