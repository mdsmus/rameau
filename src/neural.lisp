; ----------------
; Algoritmo de redes neurais proof-of-concept
;  usa redes para reconhecer a tonica de um segmento
;  minimo, ignorando contexto.
; Só pra ter algo simples pra mostrar e testar

(defpackage :rameau-neural
  (:use #:cl
        #:nile_compile-net-lib
        #:nile_c2ompile-net-lib
        #:nile_run-net-lib
        #:arnesi
        #:rameau))

(in-package :rameau-neural)


(eval-when (:compile-toplevel :load-toplevel)
  (defparameter *simple-netspec* (netspec 12 12 12))
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

(defun treina-simple-net (coral gabarito)
  (with-system rameau:tempered
    (let ((coral (segmentos-minimos (parse-file coral))))
      (loop for i from 0 to 11
         do (simple-net-training-function
                     (prepara-entrada-treinamento (transpose-segmentos coral i))
                     (prepara-saida-treinamento (transpose-chords gabarito i)))))))

(defun extrai-resultado-simple-net (simple-net)
  (let ((res (coerce (layer-act-vec (svref simple-net 2)) 'list)))
    (loop for i from 0
       for r in res
       when (> r *correctness-treshold*)
         return (make-chord :fundamental (print-note (code->note i) 'latin))
       finally (return (make-melodic-note)))))


(defun aplica-simple-net (segmento)
  (setf (layer-act-vec (svref *simple-net* 0))
        (aref (make-patterns 12 (list (cria-pattern-segmento segmento))) 0))
  (activation-fn *simple-netspec* *simple-net*)
  (extrai-resultado-simple-net *simple-net*))

(defun gera-gabarito-simple-net (segmentos)
  (mapcar #'aplica-simple-net segmentos))

(defun compara-gabarito-simple-net-individual (resultado gabarito)
  (with-system rameau:tempered
    (if (and (chordp resultado) (chordp gabarito))
        (equal (chord-fundamental resultado)
               (chord-fundamental gabarito))
        (equal (type-of resultado) (type-of gabarito)))))

(defun compara-gabarito-simple-net (resultado gabarito)
  (if (listp gabarito)
      (some (lambda (x) (compara-gabarito-simple-net-individual resultado x)) gabarito)
      (compara-gabarito-simple-net-individual resultado gabarito)))

(registra-algoritmo "Simplenet" #'gera-gabarito-simple-net #'compara-gabarito-simple-net)

;; Rede neural com contexto, dois segmentos antes e um depois
;;


(defparameter *tamanho-contexto* 4)

(eval-when (:compile-toplevel :load-toplevel)
  (defparameter *context-netspec* (netspec 48 20 12))
  (defvar *context-net* (mk-net *context-netspec*)))

(defun cria-pattern-contexto (segmentos)
  (reduce #'nconc segmentos :key #'cria-pattern-segmento))

(defun prepara-entrada-treinamento-contexto (coral)
  (let ((coral (cons nil (cons nil coral)))
        (tamanho (length coral)))
    (make-patterns
     (* 12 *tamanho-contexto*)
     (loop for i from 0 to (1- tamanho)
        for c = coral then (cdr c)
        collect (cria-pattern-contexto
                 (safe-retorna-n-elementos c *tamanho-contexto*))))))

(defun activate-context-net ()
  (activation-fn *context-netspec* *context-net*))


(defun aplica-context-net (coral)
  (setf (layer-act-vec (aref *context-net* 0))
        (aref (make-patterns (* 12 *tamanho-contexto*)
                             (list (cria-pattern-contexto
                                    (safe-retorna-n-elementos coral *tamanho-contexto*))))
              0))
  (activation-fn *context-netspec* *context-net*)
  (extrai-resultado-simple-net *context-net*))

(defun gera-gabarito-context-net (segmentos)
  (maplist #'aplica-context-net (cons nil (cons nil segmentos)))) 

(defun context-net-training-function (entrada saida)
  (trainer *context-netspec*
           *context-net*
           entrada
           saida
           :method :cg
           :max-cycles 10
           :ext-funcs (:std-activate activate-context-net)))

(defun treina-context-net (coral gabarito)
  (with-system rameau:tempered
    (let ((coral (segmentos-minimos (parse-file coral))))
      (loop for i from 0 to 11
         do (context-net-training-function
                     (prepara-entrada-treinamento-contexto (transpose-segmentos coral i))
                     (prepara-saida-treinamento (transpose-chords gabarito i)))))))

(registra-algoritmo "Contextnet" #'gera-gabarito-context-net #'compara-gabarito-simple-net)
