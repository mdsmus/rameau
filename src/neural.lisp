;; Algoritmo de redes neurais, baseado na tese de T'sui (FIXME: bibliografia)

(defpackage :rameau-neural
  (:use #:cl
        #:nile_compile-net-lib
        #:nile_c2ompile-net-lib
        #:nile_run-net-lib
        #:arnesi
        #:rameau))

(in-package :rameau-neural)


; ----------------
; Algoritmo de redes neurais proof-of-concept
;  usa redes para reconhecer a tonica de um segmento
;  minimo, ignorando contexto.
; Só pra ter algo simples pra mostrar e testar

(eval-when (:compile-toplevel :load-toplevel)
  (defparameter *simple-netspec* (netspec 12 20 12))
  (defvar *simple-net* (mk-net *simple-netspec*)))

(defparameter *correctness-treshold* 0.9)

(defun lista-de-zeros (tam)
  (repeat-list tam 0.0))

(defun cria-pattern-segmento (seg)
  (let ((atual (lista-de-zeros 12)))
    (loop for nota in seg do
         (incf (nth (evento-pitch nota) atual)))
    atual))

(defun prepara-entrada-treinamento (coral)
  (make-patterns
   12
   (loop
      for seg in coral
      collect (cria-pattern-segmento seg))))

(defun prepara-saida-treinamento (gabarito)
  (make-patterns
   12
   (loop
      for nota in gabarito
      for atual = (lista-de-zeros 12) then (lista-de-zeros 12)
      when (chordp nota) do
        (incf (nth (note->code (stringify (chord-fundamental nota))) atual))
      collect atual)))

(defun simple-net-training-function (entrada saida)
  (trainer *simple-netspec*
           *simple-net*
           entrada
           saida
           :method :cg
           :max-cycles 10))
;;:error-lim (coerce 0.01 'type-act)))

(defun treina-simple-net (coral gabarito)
  (with-system rameau:tempered
    (let ((coral (segmentos-minimos (parse-file coral))))
      (loop for i from 0 to 11
         do (simple-net-training-function
                     (prepara-entrada-treinamento (transpose-segmentos coral i))
                     (prepara-saida-treinamento (transpose-chords gabarito i)))))))

(defun extrai-resultado-simple-net ()
  (let ((res (coerce (layer-act-vec (svref *simple-net* 2)) 'list)))
    (loop for i from 0
       for r in res
       when (> r *correctness-treshold*)
         return (make-chord :fundamental (print-note (code->note i) 'latin))
       finally (return (make-melodic-note)))))


(defun aplica-simple-net (segmento)
  (setf (layer-act-vec (svref *simple-net* 0))
        (aref (make-patterns 12 (list (cria-pattern-segmento segmento))) 0))
  (activation-fn *simple-netspec* *simple-net*)
  (extrai-resultado-simple-net))

(defun gera-gabarito-simple-net (segmentos)
  (mapcar #'aplica-simple-net segmentos))

(defun compara-gabarito-simple-net-individual (resultado gabarito)
  (if (and (chordp resultado) (chordp gabarito))
      (equal (chord-fundamental resultado)
             (chord-fundamental gabarito))
      (equal (type-of resultado) (type-of gabarito))))

(defun compara-gabarito-simple-net (resultado gabarito)
  (if (listp gabarito)
      (some (lambda (x) (compara-gabarito-simple-net-individual resultado x)) gabarito)
      (compara-gabarito-simple-net-individual resultado gabarito)))

(registra-algoritmo "Simple-net" #'gera-gabarito-simple-net #'compara-gabarito-simple-net)


#|
;;----------------

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

;(write-net *simple-net*)
|#