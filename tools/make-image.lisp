;;#+sbcl(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))
#+cmu(setf ext::*complain-about-illegal-switches* nil)

#+sbcl(proclaim '(optimize
                  (compilation-speed 0)
                  (debug 3)
                  (safety 3)
                  (space 0)
                  (speed 0)))

(defparameter *asdf-file*
  (merge-pathnames "rameau-deps/lisp-libs/asdf/asdf.lisp" *main-path*))

#+(or clisp cmu) (load *asdf-file*)
#+(or sbcl ecl) (require 'asdf)

(push (merge-pathnames "src/" *main-path*) asdf:*central-registry*)

(setf (logical-pathname-translations "rameau")
      `(("user-data;*.*.*"      ,(merge-pathnames ".rameau/" (user-homedir-pathname)))
        ("**;*.*.*" ,(merge-pathnames "**/" *install-path*))))

(when *use-rameau-deps*
  ;; use symbolics links on systems, but windows is pretty bad with
  ;; links so we have to push them one by one
  #-win32(push (merge-pathnames "rameau-deps/lisp-libs/systems/" *main-path*)
                 asdf:*central-registry*)
  #+win32
  (loop for path in (directory (merge-pathnames "rameau-deps/*/*/" *main-path*))
        do (push path asdf:*central-registry*))

  (loop for path in (directory (merge-pathnames "rameau-deps/*" *main-path*))
        do (push path asdf:*central-registry*)))

(asdf:oos 'asdf:load-op :rameau :verbose nil)

#+sbcl(sb-ext:save-lisp-and-die "rameau" :purify t :executable t :toplevel #'rameau:main)

#+cmu(extensions:save-lisp "cmurameau" :init-function #'rameau:main)

#+clisp(ext:saveinitmem "clisprameau" :script nil :quiet t :executable t :init-function #'rameau:main)
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