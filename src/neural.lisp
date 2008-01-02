; ----------------
; Algoritmo de redes neurais proof-of-concept
;  usa redes para reconhecer a tonica de um segmento
;  minimo, ignorando contexto.
; Só pra ter algo simples pra mostrar e testar

(defpackage :rameau-neural
  (:use #:cl
        #:fann
        #:arnesi
        #:rameau-tools
        #:rameau))

(in-package :rameau-neural)

(defvar *simple-net* nil)

(defparameter *simple-net-file* (concat (rameau-path) "simple-net.fann"))
(defparameter *simple-net-train-data* (concat (rameau-path) "simple-net-train.data"))

(defparameter *correctness-treshold* 0.9)



(defun load-simple-net ()
  (if (cl-fad:file-exists-p *simple-net-file*)
      (setf *simple-net* (load-from-file *simple-net-file*))
      (progn
        (treina-simple-net)
        (load-simple-net))))

(defun save-simple-net ()
  (save-to-file *simple-net* *simple-net-file*))

(defun lista-de-zeros (tam)
  (repeat-list tam 0))

(defun cria-pattern-segmento (seg)
  (let ((atual (lista-de-zeros 12)))
    (loop for nota in seg do
         (incf (nth (evento-pitch nota) atual)))
    atual))

(defun cria-pattern-saida (gabarito)
  (let ((atual (lista-de-zeros 12)))
    (when (chordp gabarito)
      (incf (nth (note->code (stringify (chord-fundamental gabarito))) atual)))
    atual))
     
(defun prepara-exemplos-treinamento-simple-net-individual (coral gabarito)
  (loop for segmento in coral
     for gab in gabarito
     if (listp gab)
       nconc (prepara-exemplos-treinamento-simple-net (repeat-list segmento (length gab))
                                                      gab)
     else
       nconc (list (list (cria-pattern-segmento segmento)
                         (cria-pattern-saida gab)))))

(defun prepara-exemplos-treinamento-simple-net (coral gabarito)
  (loop for i from 0 to 11
     for c = (transpose-segmentos coral i)
     for g = (transpose-chords gabarito i)
     nconc (prepara-exemplos-treinamento-simple-net-individual c g)))

(defun gera-dados-treinamento-simple-net ()
  (with-system rameau:tempered
    (loop for i in '("001" "003" "004" "006" "012" "018" "136")
       for nome = (first (rameau-tools::processa-files "corais" (list i)))
       for f = (segmentos-minimos (parse-file nome))
       for g = (rameau-tools::processa-gabarito nome "corais")
       nconc (prepara-exemplos-treinamento-simple-net f g))))

(defun gera-arquivo-treinamento-simple-net ()
  (let* ((dados (gera-dados-treinamento-simple-net))
         (tamanho (length dados)))
    (with-open-file (f *simple-net-train-data* :direction :output)
      (format f "~a ~a ~a~%" tamanho 12 12)
      (loop for d in dados
         do
           (format f "~{~a ~}~%" (first d))
           (format f "~{~a ~}~%" (second d))))))

(unless (cl-fad:file-exists-p *simple-net-train-data*)
  (gera-arquivo-treinamento-simple-net))

(defun treina-simple-net ()
  (if (cl-fad:file-exists-p *simple-net-train-data*)
      (progn
        (setf *simple-net* (make-net 12 12 12))
        (train-on-file *simple-net*
                       *simple-net-train-data*
                       5000
                       100
                       0.1)
        (save-simple-net)
        (setf *simple-net* nil))
      (progn
        (gera-arquivo-treinamento-simple-net)
        (treina-simple-net))))


(unless (cl-fad:file-exists-p *simple-net-file*)
  (treina-simple-net))

(defun extrai-resultado-simple-net (output)
  (loop for i from 0
     for r in output
     when (> r *correctness-treshold*)
       return (make-chord :fundamental (print-note (code->note i) 'latin))
     finally (return (make-melodic-note))))

(defun aplica-simple-net (inputs)
  (unless *simple-net*
    (load-simple-net))
  (mapcar (lambda (x) (extrai-resultado-simple-net (run-net *simple-net* (cria-pattern-segmento x)))) inputs))

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


(registra-algoritmo "Simplenet" #'aplica-simple-net #'compara-gabarito-simple-net)

    
#|


(eval-when (:compile-toplevel :load-toplevel)
  (defparameter *simple-netspec* (netspec 12 12 12))
  (defvar *simple-net* (mk-net *simple-netspec*)))

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
|#