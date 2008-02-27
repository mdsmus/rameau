(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :fann))

(defpackage :rameau-neural
  (:use #:cl
        #:fann
        #:arnesi
        #:rameau))

(in-package :rameau-neural)

(defparameter *neural-path* (concat (rameau-path) "neural-nets/"))


(defun cria-pattern-segmento (seg &optional diff)
  (let ((diff (or diff (extrai-diff seg))))
    (mapcar (lambda (x) (coerce x 'float)) (extrai-feature-list seg diff))))

(defun cria-pattern-saida (gabarito diff)
  (let ((atual (make-list (1+ (get-module)) :initial-element 0)))
    (if (chordp gabarito)
      (incf (nth (module (- (note->code (stringify (chord-fundamental gabarito))) diff)) atual))
      (incf (nth (get-module) atual)))
    atual))

(defun extrai-resultado-fundamental (diff output)
  (loop for i from 0
     for r in output
     with maxi = 0
     with maxr = 0
     when (< maxr r) do (setf maxi i maxr r)
     finally (return (if (= (get-module) maxi)
                         (make-melodic-note)
                         (make-chord :fundamental (print-note (code->note (module (+ diff maxi)))
                                                              'latin))))))



(defvar *chord-net* nil)

(defparameter *chord-net-file* (concat *neural-path* "chord-net.fann"))
(defparameter *chord-net-train-data* (concat *neural-path* "chord-net-train.data"))


(defun load-chord-net ()
  (if (cl-fad:file-exists-p *chord-net-file*)
      (setf *chord-net* (load-from-file *chord-net-file*))
      (treina-chord-net)))

(defun save-chord-net ()
  (save-to-file *chord-net* *chord-net-file*))

(defun cria-pattern-saida-modo (gabarito)
  (if (chordp gabarito)
      (cond ((and (equal (chord-mode gabarito) nil)
                  (equal (chord-7th gabarito) nil))
             (list 1 0 0 0 0 0 0 0 0 1))
            ((and (equal (chord-mode gabarito) nil)
                  (equal (chord-7th gabarito) "7"))
             (list 1 0 0 0 1 0 0 0 0 0))
            ((and (equal (chord-mode gabarito) nil)
                  (equal (chord-7th gabarito) "7+"))
             (list 1 0 0 0 0 0 1 0 0 0))
            ((and (equal (chord-mode gabarito) "m")
                  (equal (chord-7th gabarito) nil))
             (list 0 1 0 0 0 0 0 0 0 1))
            ((and (equal (chord-mode gabarito) "m")
                  (equal (chord-7th gabarito) "7"))
             (list 0 1 0 0 1 0 0 0 0 0))
            ((and (equal (chord-mode gabarito) "°")
                  (equal (chord-7th gabarito) "7-"))
             (list 0 0 1 0 0 0 1 0 0 0))
            ((and (equal (chord-mode gabarito) "°")
                  (equal (chord-7th gabarito) nil))
             (list 0 0 1 0 0 0 0 0 0 1))
            ((and (equal (chord-mode gabarito) "ø")
                  (equal (chord-7th gabarito) "7"))
             (list 0 0 0 1 1 0 0 0 0 0))
            ((equal (chord-mode gabarito) "!")
             (list 0 0 0 0 0 0 0 1 0 1))
            ((equal (chord-mode gabarito) "+")
             (list 0 0 0 0 0 0 0 0 1 1))
            (t
             (list 0 0 0 0 0 0 0 0 0 1)))
      (list 0 0 0 0 0 0 0 0 0 0)))

(defun cria-pattern-saida-acorde (gabarito diff)
  (append (cria-pattern-saida gabarito diff)
          (cria-pattern-saida-modo gabarito)))

(defun prepara-exemplos-treinamento-chord-net (coral gabarito)
  (loop for c in coral
     for gab in gabarito
     for d = (extrai-diff c)
     if (listp gab)
       nconc (prepara-exemplos-treinamento-chord-net (repeat-list (length gab) c)
                                                     gab)
     else
       nconc (list (list (cria-pattern-segmento c d)
                         (cria-pattern-saida-acorde gab d)))))


(defun gera-dados-treinamento-chord-net ()
  (with-system rameau:tempered
    (loop for i in *exemplos-de-treinamento*
       nconc (prepara-exemplos-treinamento-chord-net (temperado (first i)) (second i)))))

(defun gera-arquivo-treinamento-chord-net ()
  (let* ((dados (gera-dados-treinamento-chord-net))
         (tamanho (length dados)))
    (with-open-file (f *chord-net-train-data* :direction :output)
      (format f "~a ~a ~a~%" tamanho 12 23)
      (loop for d in dados
         do
           (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
           (format f "~{~a ~}~%" (second d))))))

(unless (cl-fad:file-exists-p *chord-net-train-data*)
  (gera-arquivo-treinamento-chord-net))

(defun treina-chord-net ()
  (if (cl-fad:file-exists-p *chord-net-train-data*)
      (progn
        (setf *chord-net* (make-net 12 25 23))
        (train-on-file *chord-net*
                       *chord-net-train-data*
                       1000
                       100
                       0.1)
        (save-chord-net))
      (progn
        (gera-arquivo-treinamento-chord-net)
        (treina-chord-net))))


(unless (cl-fad:file-exists-p *chord-net-file*)
  (treina-chord-net))

(defun extrai-resultado-chord-net (diff res)
  (let ((fundamental (extrai-resultado-fundamental diff (safe-retorna-n-elementos res (1+ (get-module)))))
        (resto (nthcdr (1+ (get-module)) res)))
    (if (chordp fundamental)
        (make-chord :fundamental (chord-fundamental fundamental)
                    :mode (cond ((and (> (nth 0 resto) (nth 1 resto))
                                      (> (nth 0 resto) (nth 2 resto))
                                      (> (nth 0 resto) (nth 3 resto))
                                      (> (nth 0 resto) (nth 7 resto))
                                      (> (nth 0 resto) (nth 8 resto)))
                                 nil)
                                ((and (> (nth 1 resto) (nth 0 resto))
                                      (> (nth 1 resto) (nth 2 resto))
                                      (> (nth 1 resto) (nth 3 resto))
                                      (> (nth 1 resto) (nth 7 resto))
                                      (> (nth 1 resto) (nth 8 resto)))
                                 "m")
                                ((and (> (nth 2 resto) (nth 0 resto))
                                      (> (nth 2 resto) (nth 1 resto))
                                      (> (nth 2 resto) (nth 3 resto))
                                      (> (nth 2 resto) (nth 7 resto))
                                      (> (nth 2 resto) (nth 8 resto)))
                                 "°")
                                ((and (> (nth 3 resto) (nth 0 resto))
                                      (> (nth 3 resto) (nth 1 resto))
                                      (> (nth 3 resto) (nth 2 resto))
                                      (> (nth 3 resto) (nth 7 resto))
                                      (> (nth 3 resto) (nth 8 resto)))
                                 "ø")
                                ((and (> (nth 7 resto) (nth 0 resto))
                                      (> (nth 7 resto) (nth 1 resto))
                                      (> (nth 7 resto) (nth 2 resto))
                                      (> (nth 7 resto) (nth 3 resto))
                                      (> (nth 7 resto) (nth 8 resto)))
                                 "!")
                                ((and (> (nth 8 resto) (nth 0 resto))
                                      (> (nth 8 resto) (nth 1 resto))
                                      (> (nth 8 resto) (nth 2 resto))
                                      (> (nth 8 resto) (nth 3 resto))
                                      (> (nth 8 resto) (nth 7 resto)))
                                 "+")
                                )
                    :7th (cond ((and (> (nth 9 resto) (nth 5 resto))
                                     (> (nth 9 resto) (nth 3 resto))
                                     (> (nth 9 resto) (nth 6 resto))
                                     (> (nth 9 resto) (nth 4 resto)))
                                nil)
                               ((and (> (nth 4 resto) (nth 5 resto))
                                     (> (nth 4 resto) (nth 6 resto))
                                     (> (nth 4 resto) (nth 9 resto)))
                                 "7")
                               ((and (> (nth 5 resto) (nth 4 resto))
                                     (> (nth 5 resto) (nth 9 resto))
                                     (> (nth 5 resto) (nth 6 resto)))
                                "7-")
                               ((and (> (nth 6 resto) (nth 4 resto))
                                     (> (nth 6 resto) (nth 9 resto))
                                     (> (nth 6 resto) (nth 5 resto)))
                                "7+")
                                ((and (> (nth 3 resto) (nth 0 resto))
                                      (> (nth 3 resto) (nth 1 resto))
                                      (> (nth 3 resto) (nth 2 resto))
                                      (> (nth 3 resto) (nth 7 resto))
                                      (> (nth 3 resto) (nth 8 resto)))
                                "7")))
        (make-melodic-note))))

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

(register-algorithm "Simple-net" #'aplica-chord-net #'compara-gabarito-tonal)

