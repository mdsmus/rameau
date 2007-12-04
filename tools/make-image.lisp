#+sbcl(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

#+cmu(setf ext::*complain-about-illegal-switches* nil)

(declaim (optimize (compilation-speed 0)
                   (debug 3)
                   (safety 3)
                   (space 1)
                   (speed 1)))

#+(or sbcl ecl) (require 'asdf)

(defun main-path ()
  (format nil "~a" (or #+ecl (si::getcwd)
                       #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))

(push (concatenate 'string (main-path) "src/") asdf:*central-registry*)
(push (concatenate 'string (main-path) "src/lib/") asdf:*central-registry*)

#+(or sbcl ecl) (require 'rameau)
#+(or clisp cmu) (asdf:oos 'asdf:load-op :rameau :verbose nil)

(load "tools/rameau.lisp")

#+sbcl(sb-ext:save-lisp-and-die "rameau" :executable t :toplevel #'rameau-tools:main)

#+cmu(extensions:save-lisp "cmurameau" :init-function #'rameau-tools:main)

#+ecl(progn (loop for file in '("tools/rameau.lisp"
                    "src/cifras.lisp"
                    "src/formato.lisp"
                    "src/musiclib.lisp"
                    "src/packages.lisp"
                    "src/pardo.lisp"
                    "src/parser-grammar.lisp"
                    "src/parser.lisp"
                    "src/rameau-base.lisp"
                    "src/segmento.lisp"
                    "src/temperley.lisp"
                    "src/test-cifras.lisp"
                    "src/test-formato.lisp"
                    "src/test-musiclib.lisp"
                    "src/test-pardo.lisp"
                    "src/test-parser.lisp"
                    "src/test-utils.lisp"
                    "src/utils.lisp")
               do (compile-file file :system-p t))
            (c:build-program "eclrameau" :lisp-files '("tools/rameau.o"
                                                       "src/cifras.o"
                                                       "src/formato.o"
                                                       "src/musiclib.o"
                                                       "src/packages.o"
                                                       "src/pardo.o"
                                                       "src/parser-grammar.o"
                                                       "src/parser.o"
                                                       "src/rameau-base.o"
                                                       "src/segmento.o"
                                                       "src/temperley.o"
                                                       "src/test-cifras.o"
                                                       "src/test-formato.o"
                                                       "src/test-musiclib.o"
                                                       "src/test-pardo.o"
                                                       "src/test-parser.o"
                                                       "src/test-utils.o"
                                                       "src/utils.o"
                                                       ))
            )

#+clisp(ext:saveinitmem "clisprameau" :script t :quiet t :executable t :init-function #'rameau-tools:main)

#+(or ecl clisp)(quit)