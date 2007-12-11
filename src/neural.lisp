;; Algoritmo de redes neurais, baseado na tese de T'sui (FIXME: bibliografia)

(asdf:oos 'asdf:load-op :nile)

(defpackage :rameau-neural
  (:use #:common-lisp
        #:nile_compile-tools
        #:nile_compile-net-lib
        #:nile_c2ompile-net-lib
        #:nile_run-net-lib
        #:arnesi
        #:rameau))

(in-package :rameau-neural)

(defparameter *and-net* (mk-net (netspec 3 1 1)))

(defparameter *and-input* (patterns 3
                                    (0 0 0)
                                    (0 0 1)
                                    (0 1 0)
                                    (1 0 1)
                                    (1 0 0)
                                    (1 1 0)
                                    (1 1 1)))

(defparameter *and-output* (patterns 1
                                     (0)
                                     (0)
                                     (0)
                                     (0)
                                     (0)
                                     (0)
                                     (1)))




(defun train-and (and-net)
  (trainer (netspec 3 1 1)
           and-net
           *and-input*
           *and-output*
           :method :sd
           :error-lim (coerce 0.01 'type-act)))

(defun run-and (and-net pattern-in res)
  (all-pattern-error (netspec 3 1 1)
                     and-net
                     pattern-in
                     (make-patterns 1 (list res))
                     1))

(train-and *and-net*)
(run-and *and-net* (patterns 3 (0 1 1)) 1)

