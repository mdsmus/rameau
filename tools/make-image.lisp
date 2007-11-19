#+(or sbcl ecl) (require 'asdf)

(defun main-path ()
  (format nil "~a" (or #+ecl (si::getcwd)
                       #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))

(push (concatenate 'string (main-path) "src/") asdf:*central-registry*)
(push (concatenate 'string (main-path) "src/lib/") asdf:*central-registry*)

#-ecl(load "tools/rameau.lisp")
#+sbcl(sb-ext:save-lisp-and-die "rameau" :executable t :toplevel #'rameau-tools:main)
#+cmu(extensions:save-lisp "cmurameau" :init-function #'rameau-tools:main)
#+ecl(progn (compile-file "tools/rameau.lisp" :system-p t)
            ;;(c:build-program "eclrameau" :lisp-files '("rameau.o"))
            )

#+clisp(ext:saveinitmem "clisprameau" :script t :quiet t :executable t :init-function #'rameau-tools:main)

#+(or ecl clisp)(quit)