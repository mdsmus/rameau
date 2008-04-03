(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :fann))

(defpackage :rameau-neural
  (:use #:cl
        #:fann
        #:arnesi
        #:rameau))

(in-package :rameau-neural)

(defparameter *versao* "-0003-")

(defparameter *neural-path* (concat *rameau-path* "neural-nets/" "master" *versao*))

(defparameter *hidden-units* 22)

(defparameter *root-increment* 4)

(defun extrai-diffs (segmento)
  (mapcar #'evento-pitch segmento))

(defun cria-pattern-segmento (seg &optional diff)
  (let ((diff (or diff (extrai-diff seg))))
    (mapcar (lambda (x) (coerce x 'float)) (extrai-feature-list seg diff))))

(defun cria-pattern-saida (gabarito diff)
  (let ((atual (make-list (+ *root-increment* (get-module)) :initial-element 0)))
    (cond ((chordp gabarito)
           (incf (nth (module (- (note->code (stringify (chord-fundamental gabarito))) diff)) atual)))
          ((melodic-note-p gabarito)
           (incf (nth (get-module) atual)))
          ((equal 'it (augmented-sixth-type gabarito))
           (incf (nth (1+ (get-module)) atual)))
          ((equal 'al (augmented-sixth-type gabarito))
           (incf (nth (+ 2 (get-module)) atual)))
          ((equal 'fr (augmented-sixth-type gabarito))
           (incf (nth (+ 3 (get-module)) atual)))
          (t (format t "gabarito: ~s ~s~%" 'al (augmented-sixth-type gabarito))))
           
    atual))

(defun extrai-resultado-fundamental (diff output)
  (loop for i from 0
     for r in output
     with maxi = 0
     with maxr = 0
     when (< maxr r) do (setf maxi i maxr r)
     finally (return (cond ((= (get-module) maxi)
                            (make-melodic-note))
                           ((> (get-module) maxi)
                            (make-chord :fundamental (print-note (code->notename (module (+ diff maxi)))
                                                              'latin)))
                           ((= (+ 1 (get-module)) maxi)
                            (make-augmented-sixth :type "IT"))
                           ((= (+ 2 (get-module)) maxi)
                            (make-augmented-sixth :type "AL"))
                           ((= (+ 3 (get-module)) maxi)
                            (make-augmented-sixth :type "FR"))
                           (t (format t "module: ~a, maxi: ~a, output: ~a" (get-module) maxi output)
                              (error "erro"))))))

(defvar *chord-net* nil)

(defparameter *chord-net-file* (concat *neural-path* "chord-net.fann"))
(defparameter *chord-net-train-data* (concat *neural-path* "chord-net-train.data"))

(defparameter *mode-length* 5)
(defparameter *7th-length* 4)

(defun load-chord-net ()
  (if (cl-fad:file-exists-p *chord-net-file*)
      (setf *chord-net* (load-from-file *chord-net-file*))
      (treina-chord-net)))

(defun save-chord-net ()
  (save-to-file *chord-net* *chord-net-file*))

(defun make-empty-pattern ()
  (repeat-list (+ *mode-length* *7th-length*) 0))

(defun make-pattern-7th (7th)
  (let ((pattern (repeat-list *7th-length* 0)))
    (incf (nth (cond ((equal 7th nil)
                      0)
                     ((equal 7th "7")
                      1)
                     ((equal 7th "7-")
                      2)
                     ((equal 7th "7+")
                      3))
               pattern))
    pattern))

(defun extract-7th (lista)
  (loop for i from 0
     for l in lista
     with maxi = 0
     with maxl = (first lista)
     when (< maxl l) do (setf maxi i maxl l)
     finally (return (cond ((= maxi 0) nil)
                           ((= maxi 1) "7")
                           ((= maxi 2) "7-")
                           ((= maxi 3) "7+")
                           (t (error "Sétima não encontrada"))))))

(defun make-pattern-modo (modo)
  (let ((pattern (repeat-list *mode-length* 0)))
    (incf (nth (cond ((equal modo nil)
                      0)
                     ((equal modo "m")
                     1)
                     ((equal modo "+")
                     2)
                     ((or (equal modo "°")
                          (equal modo "ø"))
                     3)
                     ((equal modo "!")
                     4))
               pattern))
    pattern))

(defun extract-mode (modo 7th)
  (loop for i from 0
     for m in modo
     with maxi = 0
     with maxm = (first modo)
     when (< maxm m) do (setf maxm m maxi i)
     finally (return (cond ((= maxi 0) nil)
                           ((= maxi 1) "m")
                           ((= maxi 2) "+")
                           ((= maxi 3) (if (equal "7" 7th) "ø" "°"))
                           ((= maxi 4) "!")))))

(defun cria-pattern-saida-modo (gabarito)
  (if (chordp gabarito)
      (append (make-pattern-modo (chord-mode gabarito))
              (make-pattern-7th (chord-7th gabarito)))
      (make-empty-pattern)))

(defun cria-pattern-saida-acorde (gabarito diff)
  (append (cria-pattern-saida gabarito diff)
          (cria-pattern-saida-modo gabarito)))

(defun prepara-exemplos-treinamento-chord-net (coral gabarito &optional
                                               (diff-func #'extrai-diffs)
                                               (feature #'cria-pattern-segmento))
  (loop for c in coral
     for gab in gabarito
     for ds = (funcall diff-func c)
     if (listp gab)
       nconc (prepara-exemplos-treinamento-chord-net (repeat-list (length gab) c)
                                                     gab diff-func feature)
     else
       nconc (loop for d in ds
                nconc (list (list (funcall feature c d)
                                  (cria-pattern-saida-acorde gab d))))))


(defun gera-dados-treinamento-chord-net ()
  (with-system rameau:tempered
    (loop for i in *exemplos-de-treinamento*
       nconc (prepara-exemplos-treinamento-chord-net (temperado (first i)) (second i)))))

(defun gera-arquivo-treinamento-chord-net ()
  (let* ((dados (gera-dados-treinamento-chord-net))
         (tamanho (length dados)))
    (with-open-file (f *chord-net-train-data* :direction :output)
      (format f "~a ~a ~a~%" tamanho 12 25)
      (loop for d in dados
         do
           (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
           (format f "~{~a ~}~%" (second d))))))

(unless (cl-fad:file-exists-p *chord-net-train-data*)
  (gera-arquivo-treinamento-chord-net))

(defun treina-chord-net ()
  (if (cl-fad:file-exists-p *chord-net-train-data*)
      (progn
        (setf *chord-net* (make-net 12 *hidden-units* 25))
        (train-on-file *chord-net*
                       *chord-net-train-data*
                       1200
                       100
                       0.1)
        (save-chord-net))
      (progn
        (gera-arquivo-treinamento-chord-net)
        (treina-chord-net))))


(unless (cl-fad:file-exists-p *chord-net-file*)
  (treina-chord-net))

(defun extrai-resultado-chord-net (diff res)
  (let ((fundamental (extrai-resultado-fundamental
                      diff
                      (safe-retorna-n-elementos res (+ *root-increment* (get-module)))))
        (resto (nthcdr (+ *root-increment* (get-module)) res)))
    (if (chordp fundamental)
        (let* ((7th (extract-7th (nthcdr *mode-length* resto)))
               (mode (extract-mode (safe-retorna-n-elementos resto *mode-length*) 7th)))
          
          (make-chord :fundamental (chord-fundamental fundamental)
                      :mode mode
                      :7th 7th))
        fundamental)))

(defun aplica-chord-net (inputs)
  (load-chord-net)
  (coloca-inversoes
   inputs
   (with-system tempered
     (mapcar (lambda (x) (let ((d (extrai-diff x)))
                           (extrai-resultado-chord-net
                            d
                            (run-net *chord-net*
                                     (cria-pattern-segmento x)))))
             (temperado inputs)))))

;(register-algorithm "S-net" #'aplica-chord-net #'compara-gabarito-tonal)

(defvar *e-chord-net* nil)

(defparameter *e-chord-net-file* (concat *neural-path* "e-chord-net.fann"))
(defparameter *e-chord-net-train-data* (concat *neural-path* "e-chord-net-train.data"))

(defun load-e-chord-net ()
  (if (cl-fad:file-exists-p *e-chord-net-file*)
      (setf *e-chord-net* (load-from-file *e-chord-net-file*))
      (treina-e-chord-net)))

(defun save-e-chord-net ()
  (save-to-file *e-chord-net* *e-chord-net-file*))

(defun run-e-chord-net (x)
  (let ((d (extrai-diff x)))
    (extrai-resultado-chord-net
     d
     (run-net *e-chord-net*
              (cria-pattern-segmento x d)))))

(defun aplica-e-chord-net (inputs)
  (load-e-chord-net)
  (coloca-inversoes inputs (mapcar #'run-e-chord-net inputs)))

(defun gera-dados-treinamento-e-chord-net ()
  (loop for i in *exemplos-de-treinamento*
     nconc (prepara-exemplos-treinamento-chord-net (first i) (second i))))



(defun gera-arquivo-treinamento-e-chord-net ()
  (let* ((dados (gera-dados-treinamento-e-chord-net))
         (tamanho (length dados)))
    (with-open-file (f *e-chord-net-train-data* :direction :output)
      (format f "~a ~a ~a~%" tamanho 96 109)
      (loop for d in dados
         do
           (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
           (format f "~{~a ~}~%" (second d))))))

(unless (cl-fad:file-exists-p *e-chord-net-train-data*)
  (gera-arquivo-treinamento-e-chord-net))

(defun treina-e-chord-net ()
  (if (cl-fad:file-exists-p *e-chord-net-train-data*)
      (progn
        (setf *e-chord-net* (make-net 96 *hidden-units* 109))
        (train-on-file *e-chord-net*
                       *e-chord-net-train-data*
                       1500
                       100
                       0.1)
        (save-e-chord-net))
      (progn
        (gera-arquivo-treinamento-e-chord-net)
        (treina-e-chord-net))))

(unless (cl-fad:file-exists-p *e-chord-net-file*)
  (treina-e-chord-net))

(register-algorithm "ES-net" #'aplica-e-chord-net #'compara-gabarito-tonal)

(defparameter *context-net* nil)

(defparameter *context-net-file* (concat *neural-path* "context-net.fann"))
(defparameter *context-net-train-data* (concat *neural-path* "context-net-train.data"))

(defparameter *contexto-antes* 1)
(defparameter *contexto-depois* 1)

(defun context-extrai-diffs (segmento)
  (extrai-diffs (nth *contexto-antes* segmento)))

(defun context-extrai-diff (segmentos)
  (extrai-diff (nth *contexto-antes* segmentos)))

(defun context-extrai-features (segmento &optional diff)
  (let ((diff (or diff (context-extrai-diff segmento))))
    (loop for s in segmento nconc (cria-pattern-segmento s diff))))

(defun load-context-net ()
  (if (cl-fad:file-exists-p *context-net-file*)
      (setf *context-net* (load-from-file *context-net-file*))
      (treina-context-net)))

(defun save-context-net ()
  (save-to-file *context-net* *context-net-file*))

(defun run-context-net (x)
  (let ((d (context-extrai-diff x)))
    (extrai-resultado-chord-net
     d
     (run-net *context-net*
              (context-extrai-features x d)))))

(defun aplica-context-net (inputs)
  (load-context-net)
  (let ((contexto (butlast (coloca-contexto inputs *contexto-antes* *contexto-depois*)
                           *contexto-antes*)))
    (coloca-inversoes inputs (mapcar #'run-context-net contexto))))

(defun gera-dados-treinamento-context-net ()
  (loop for i in *exemplos-de-treinamento*
     nconc (prepara-exemplos-treinamento-chord-net (coloca-contexto (first i)
                                                                    *contexto-antes*
                                                                    *contexto-depois*)
                                                   (second i)
                                                   #'context-extrai-diffs
                                                   #'context-extrai-features)))

(defun gera-arquivo-treinamento-context-net ()
  (let* ((dados (gera-dados-treinamento-context-net))
         (tamanho (length dados)))
    (with-open-file (f *context-net-train-data* :direction :output)
      (format f "~a ~a ~a~%" tamanho (* (+ 1 *contexto-depois* *contexto-antes*) 96) 109)
      (loop for d in dados
         do
           (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
           (format f "~{~a ~}~%" (second d))))))

(unless (cl-fad:file-exists-p *context-net-train-data*)
  (gera-arquivo-treinamento-context-net))

(defun treina-context-net ()
  (if (cl-fad:file-exists-p *context-net-train-data*)
      (progn
        (setf *context-net* (make-net (* (+ 1 *contexto-depois* *contexto-antes*) 96)
                                      *hidden-units*
                                      109))
        (train-on-file *context-net*
                       *context-net-train-data*
                       1500
                       100
                       0.1)
        (save-context-net))
      (progn
        (gera-arquivo-treinamento-context-net)
        (treina-context-net))))

(unless (cl-fad:file-exists-p *context-net-file*)
  (treina-context-net))

(register-algorithm "EC-net" #'aplica-context-net #'compara-gabarito-tonal)
