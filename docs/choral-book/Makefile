book: book-stuff
	sh gera-tex.sh
	latex book-corais.tex
	dvips book-corais.dvi

book-stuff: corais.lytex
	lilypond-book -o out --psfonts -I ../../music/chorales-bach/ corais.lytex

clean:
	rm -f book-corais.{aux,dvi,log,tex}
	rm -rf out

cleanall: clean
	rm -f book-corais.ps
