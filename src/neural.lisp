; ----------------
; Algoritmo de redes neurais proof-of-concept
;  usa redes para reconhecer a tonica de um segmento
;  minimo, ignorando contexto.
; Só pra ter algo simples pra mostrar e testar

(defpackage :rameau-neural
  (:use #:cl
        #:fann
        #:arnesi
        #:rameau))

(in-package :rameau-neural)

(defvar *simple-net* nil)

(defparameter *simple-net-file* (concat (rameau-path) "simple-net.fann"))
(defparameter *simple-net-train-data* (concat (rameau-path) "simple-net-train.data"))

(defparameter *correctness-treshold* 0.5)



(defun load-simple-net ()
  (if (cl-fad:file-exists-p *simple-net-file*)
      (setf *simple-net* (load-from-file *simple-net-file*))
      (progn
        (treina-simple-net)
        (load-simple-net))))

(defun save-simple-net ()
  (save-to-file *simple-net* *simple-net-file*))

(defun cria-pattern-segmento (seg)
  (let ((atual (make-list 12 :initial-element 0)))
    (loop for nota in seg do
         (incf (nth (evento-pitch nota) atual)))
    atual))

(defun cria-pattern-saida (gabarito)
  (let ((atual (make-list 12 :initial-element 0)))
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
    (loop for i in '("001" "002" "004" "006" "012" "018" "136")
       for nome = (first (processa-files "corais" (list i)))
       for f = (segmentos-minimos (parse-file nome))
       for g = (processa-gabarito nome "corais")
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
        (save-simple-net))
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

(registra-algoritmo "Simple-net" #'aplica-simple-net #'compara-gabarito-fundamental)


(defvar *context-net* nil)

(defparameter *context-net-file* (concat (rameau-path) "context-net.fann"))
(defparameter *context-net-train-data* (concat (rameau-path) "context-net-train.data"))


(defun load-context-net ()
  (if (cl-fad:file-exists-p *context-net-file*)
      (setf *context-net* (load-from-file *context-net-file*))
      (progn
        (treina-context-net)
        (load-context-net))))

(defun save-context-net ()
  (save-to-file *context-net* *context-net-file*))

(defun cria-pattern-contexto (segmentos)
  (reduce #'nconc segmentos :key #'cria-pattern-segmento))

(defun prepara-exemplos-treinamento-context-net-individual (coral gabarito)
  (loop for c = (cons nil (cons nil coral)) then (cdr c)
     for gab in gabarito
     if (listp gab)
       nconc (prepara-exemplos-treinamento-simple-net (repeat-list coral (length gab))
                                                      gab)
     else
       nconc (list (list (cria-pattern-contexto (safe-retorna-n-elementos c 4))
                         (cria-pattern-saida gab)))))


(defun prepara-exemplos-treinamento-context-net (coral gabarito)
  (loop for i from 0 to 11
     for c = (transpose-segmentos coral i)
     for g = (transpose-chords gabarito i)
     nconc (prepara-exemplos-treinamento-context-net-individual c g)))

(defun gera-dados-treinamento-context-net ()
  (with-system rameau:tempered
    (loop for i in '("001" "002" "004" "005" "006" "007" "012" "018" "136")
       for nome = (first (processa-files "corais" (list i)))
       for f = (segmentos-minimos (parse-file nome))
       for g = (processa-gabarito nome "corais")
       nconc (prepara-exemplos-treinamento-context-net f g))))

(defun gera-arquivo-treinamento-context-net ()
  (let* ((dados (gera-dados-treinamento-context-net))
         (tamanho (length dados)))
    (with-open-file (f *context-net-train-data* :direction :output)
      (format f "~a ~a ~a~%" tamanho 48 12)
      (loop for d in dados
         do
           (format f "~{~a ~}~%" (first d))
           (format f "~{~a ~}~%" (second d))))))

(unless (cl-fad:file-exists-p *context-net-train-data*)
  (gera-arquivo-treinamento-context-net))

(defun treina-context-net ()
  (if (cl-fad:file-exists-p *context-net-train-data*)
      (progn
        (setf *context-net* (make-net 48 24 12))
        (train-on-file *context-net*
                       *context-net-train-data*
                       5000
                       100
                       0.07)
        (save-context-net))
      (progn
        (gera-arquivo-treinamento-context-net)
        (treina-context-net))))


(unless (cl-fad:file-exists-p *context-net-file*)
  (treina-context-net))

(defun aplica-context-net (inputs)
  (unless *context-net*
    (load-context-net))
  (maplist (lambda (x) (extrai-resultado-simple-net
                        (run-net *context-net*
                                 (cria-pattern-contexto (safe-retorna-n-elementos x 4)))))
           (cons nil (cons nil inputs))))

(registra-algoritmo "Context-net" #'aplica-context-net #'compara-gabarito-fundamental)
    


(defvar *chord-net* nil)

(defparameter *chord-net-file* (concat (rameau-path) "chord-net.fann"))
(defparameter *chord-net-train-data* (concat (rameau-path) "chord-net-train.data"))


(defun load-chord-net ()
  (if (cl-fad:file-exists-p *chord-net-file*)
      (setf *chord-net* (load-from-file *chord-net-file*))
      (treina-chord-net)))

(defun save-chord-net ()
  (save-to-file *chord-net* *chord-net-file*))

(defun cria-pattern-saida-acorde (gabarito)
  (append (cria-pattern-saida gabarito)
          (if (chordp gabarito)
              (cond ((and (equal (chord-mode gabarito) nil)
                          (equal (chord-7th gabarito) nil))
                     (list 1 0 0 0 0 0 0))
                    ((and (equal (chord-mode gabarito) nil)
                          (equal (chord-7th gabarito) "7"))
                     (list 1 0 0 0 1 0 0))
                    ((and (equal (chord-mode gabarito) nil)
                          (equal (chord-mode gabarito) "7+"))
                     (list 1 0 0 0 0 0 1))
                    ((and (equal (chord-mode gabarito) "m")
                          (equal (chord-7th gabarito) nil))
                     (list 0 1 0 0 0 0 0))
                    ((and (equal (chord-mode gabarito) "m")
                          (equal (chord-7th gabarito) "7"))
                     (list 0 1 0 0 1 0 0))
                    ((and (equal (chord-mode gabarito) "°")
                          (equal (chord-7th gabarito) "7-"))
                     (list 0 0 1 0 0 0 1))
                    ((and (equal (chord-mode gabarito) "°")
                          (equal (chord-7th gabarito) nil))
                     (list 0 0 1 0 0 0 0))
                    ((and (equal (chord-mode gabarito) "ø")
                          (equal (chord-7th gabarito) "7"))
                     (list 0 0 0 1 1 0 0))
                    (t
                     (list 0 0 0 0 0 0 0)))
              (list 0 0 0 0 0 0 0))))

(defun prepara-exemplos-treinamento-chord-net-individual (coral gabarito)
  (loop for c in coral
     for gab in gabarito
     if (listp gab)
       nconc (prepara-exemplos-treinamento-chord-net-individual (repeat-list c (length gab))
                                                                gab)
     else
       nconc (list (list (cria-pattern-segmento c)
                         (cria-pattern-saida-acorde gab)))))


(defun prepara-exemplos-treinamento-chord-net (coral gabarito)
  (loop for i from 0 to 11
     for c = (transpose-segmentos coral i)
     for g = (transpose-chords gabarito i)
     nconc (prepara-exemplos-treinamento-chord-net-individual c g)))

(defun gera-dados-treinamento-chord-net ()
  (with-system rameau:tempered
    (loop for i in '("001" "002" "004" "005" "006" "007" "012" "018" "136")
       for nome = (first (processa-files "corais" (list i)))
       for f = (segmentos-minimos (parse-file nome))
       for g = (processa-gabarito nome "corais")
       nconc (prepara-exemplos-treinamento-chord-net f g))))

(defun gera-arquivo-treinamento-chord-net ()
  (let* ((dados (gera-dados-treinamento-chord-net))
         (tamanho (length dados)))
    (with-open-file (f *chord-net-train-data* :direction :output)
      (format f "~a ~a ~a~%" tamanho 12 19)
      (loop for d in dados
         do
           (format f "~{~a ~}~%" (first d))
           (format f "~{~a ~}~%" (second d))))))

(unless (cl-fad:file-exists-p *chord-net-train-data*)
  (gera-arquivo-treinamento-chord-net))

(defun treina-chord-net ()
  (if (cl-fad:file-exists-p *chord-net-train-data*)
      (progn
        (setf *chord-net* (make-net 12 50 19))
        (train-on-file *chord-net*
                               *chord-net-train-data*
                               5000
                               100
                               0.3)
        (save-chord-net))
      (progn
        (gera-arquivo-treinamento-chord-net)
        (treina-chord-net))))


(unless (cl-fad:file-exists-p *chord-net-file*)
  (treina-chord-net))

(defun extrai-resultado-chord-net (res)
  (if (chordp (extrai-resultado-simple-net (safe-retorna-n-elementos res 12)))
      (make-chord :fundamental (chord-fundamental (extrai-resultado-simple-net
                                                   (safe-retorna-n-elementos res 12)))
                  :mode (cond ((>= (nth 12 res) *correctness-treshold*)
                               nil)
                              ((>= (nth 13 res) *correctness-treshold*)
                               "m")
                              ((>= (nth 14 res) *correctness-treshold*)
                               "°")
                              ((>= (nth 15 res) *correctness-treshold*)
                               "ø"))
                  :7th (cond ((>= (nth 16 res) *correctness-treshold*)
                              "7")
                             ((>= (nth 17 res) *correctness-treshold*)
                             "7-")
                             ((>= (nth 18 res) *correctness-treshold*)
                             "7+")))
      (make-melodic-note)))

(defun aplica-chord-net (inputs)
  (load-chord-net)
  (mapcar (lambda (x) (extrai-resultado-chord-net
                        (run-net *chord-net*
                                 (cria-pattern-segmento x))))
           inputs))

(registra-algoritmo "Chord-net" #'aplica-chord-net #'compara-gabarito-modo-setima)
    
