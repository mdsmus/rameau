(defun main-path ()
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))

(push (concatenate 'string (main-path) "src/") asdf:*central-registry*)
(push (concatenate 'string (main-path) "src/lib/") asdf:*central-registry*)

#-ecl(load "tools/rameau.lisp")
#+sbcl(sb-ext:save-lisp-and-die "rameau" :executable t :toplevel #'main)
#+cmu(extensions:save-lisp "cmurameau" :init-function #'main)
#+ecl(compile-file "tools/rameau.lisp" :system-p t)
#+clisp(ext:saveinitmem "clisprameau" :script t :quiet t :executable t :init-function #'main)

#+(or ecl clisp)(quit)