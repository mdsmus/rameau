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

(defparameter *and-net* (mk-net (netspec 3 2 1)))

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
  (trainer (netspec 3 2 1)
           and-net
           *and-input*
           *and-output*
           :method :sd
           :error-lim (coerce 0.001 'type-act)))

(defun run-and (and-net pattern-in)
  (setf (layer-act-vec (svref and-net 0))
        (svref pattern-in 0))
  (activation-fn (netspec 3 2 1) and-net)
  (aref (layer-act-vec (svref and-net 2)) 0))
  

(train-and *and-net*)
(run-and *and-net* (patterns 3 (0 0 0)))

;(write-net *and-net*)
