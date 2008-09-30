;;#+sbcl(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))
#+cmu(setf ext::*complain-about-illegal-switches* nil)

#+sbcl(proclaim '(optimize
                  (compilation-speed 0)
                  (debug 2)
                  (safety 2)
                  (space 0)
                  (speed 0)))

#+(or sbcl ecl) (require 'asdf)

(defun main-path ()
  (format nil "~a" (or #+ecl (si::getcwd)
                       #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))

(defparameter *asdf-file* (concatenate 'string (main-path) "rameau-deps/asdf/asdf.lisp"))

#+(or clisp cmu) (load *asdf-file*)

(push (concatenate 'string (main-path) "src/") asdf:*central-registry*)

(defun get-dir-list (path)
  (directory (concatenate 'string (main-path) path)))

(when *use-rameau-deps*
  (loop for p in (append (get-dir-list "rameau-deps/*/*")
                         (get-dir-list "rameau-deps/*")) do
        (push (format nil "~a" p) asdf:*central-registry*)))

(asdf:oos 'asdf:load-op :rameau :verbose nil)
                                        ;(asdf:oos 'asdf:load-op :rameau-test :verbose nil)

#+sbcl(sb-ext:save-lisp-and-die "rameau" :purify t :executable t :toplevel #'rameau-main:main)

#+cmu(extensions:save-lisp "cmurameau" :init-function #'rameau-main:main)

#+clisp(ext:saveinitmem "clisprameau" :script nil :quiet t :executable t :init-function #'rameau-main:main)

#+ecl(progn (loop for file in '("src/rameau.lisp"
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
                                "src/utils.lisp")
                  do (compile-file file :system-p t))
            (c:build-program "eclrameau"
                             :lisp-files '("/home/kroger/lisp/site/arnesi/libarnesi.so"
                                           "src/rameau-base.o"
                                           "src/utils.o"
                                           "src/packages.o"
                                           "src/cifras.o"
                                           "src/formato.o"
                                           "src/musiclib.o"
                                           "src/pardo.o"
                                           "src/parser-grammar.o"
                                           "src/parser.o"
                                           "src/segmento.o"
                                           "src/temperley.o"
                                           "src/rameau.o"
                                           )
                             ))

#+(or ecl clisp)(quit)