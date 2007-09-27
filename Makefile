pop2gab: pop2gab.lisp
	sbcl --load pop2gab.lisp --eval "(sb-ext:save-lisp-and-die \"pop2gab\" :executable t :toplevel 'rameau::main)"