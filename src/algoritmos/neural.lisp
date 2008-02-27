(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :fann))

(defpackage :rameau-neural
  (:use #:cl
        #:fann
        #:arnesi
        #:rameau))

(in-package :rameau-neural)

(defparameter *neural-path* (concat (rameau-path) "neural-nets/"))


(defun cria-pattern-segmento (seg)
  (with-system tempered
    (mapcar (lambda (x) (coerce x 'float)) (extrai-feature-list seg 0))))

(defun cria-pattern-saida (gabarito)
  (let ((atual (make-list 13 :initial-element 0)))
    (if (chordp gabarito)
      (incf (nth (note->code (stringify (chord-fundamental gabarito))) atual))
      (incf (nth 12 atual)))
    atual))


(defun extrai-resultado-fundamental (output)
  (with-system tempered
    (loop for i from 0
       for r in output
       with maxi = 0
       with maxr = 0
       when (< maxr r) do (setf maxi i maxr r)
       finally (return (if (= 12 maxi)
                           (make-melodic-note)
                           (make-chord :fundamental (print-note (code->note maxi) 'latin)))))))


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

(defun cria-pattern-saida-acorde (gabarito)
  (append (cria-pattern-saida gabarito)
          (cria-pattern-saida-modo gabarito)))

(defun prepara-exemplos-treinamento-chord-net-individual (coral gabarito)
  (loop for c in coral
     for gab in gabarito
     if (listp gab)
       nconc (prepara-exemplos-treinamento-chord-net-individual (repeat-list (length gab) c)
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
        (setf *chord-net* (make-net 12 55 23))
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

(defun extrai-resultado-chord-net (res)
  (with-system tempered
    (if (chordp (extrai-resultado-fundamental (safe-retorna-n-elementos res 13)))
        (make-chord :fundamental (chord-fundamental (extrai-resultado-fundamental
                                                     (safe-retorna-n-elementos res 13)))
                    :mode (cond ((and (> (nth 13 res) (nth 14 res))
                                      (> (nth 13 res) (nth 15 res))
                                      (> (nth 13 res) (nth 16 res))
                                      (> (nth 13 res) (nth 20 res))
                                      (> (nth 13 res) (nth 21 res)))
                                 nil)
                                ((and (> (nth 14 res) (nth 13 res))
                                      (> (nth 14 res) (nth 15 res))
                                      (> (nth 14 res) (nth 16 res))
                                      (> (nth 14 res) (nth 20 res))
                                      (> (nth 14 res) (nth 21 res)))
                                 "m")
                                ((and (> (nth 15 res) (nth 13 res))
                                      (> (nth 15 res) (nth 14 res))
                                      (> (nth 15 res) (nth 16 res))
                                      (> (nth 15 res) (nth 20 res))
                                      (> (nth 15 res) (nth 21 res)))
                                 "°")
                                ((and (> (nth 16 res) (nth 13 res))
                                      (> (nth 16 res) (nth 14 res))
                                      (> (nth 16 res) (nth 15 res))
                                      (> (nth 16 res) (nth 20 res))
                                      (> (nth 16 res) (nth 21 res)))
                                 "ø")
                                ((and (> (nth 20 res) (nth 13 res))
                                      (> (nth 20 res) (nth 14 res))
                                      (> (nth 20 res) (nth 15 res))
                                      (> (nth 20 res) (nth 16 res))
                                      (> (nth 20 res) (nth 21 res)))
                                 "!")
                                ((and (> (nth 21 res) (nth 13 res))
                                      (> (nth 21 res) (nth 14 res))
                                      (> (nth 21 res) (nth 15 res))
                                      (> (nth 21 res) (nth 16 res))
                                      (> (nth 21 res) (nth 20 res)))
                                 "+")
                                )
                    :7th (cond ((and (> (nth 22 res) (nth 18 res))
                                     (> (nth 22 res) (nth 16 res))
                                     (> (nth 22 res) (nth 19 res))
                                     (> (nth 22 res) (nth 17 res)))
                                nil)
                               ((and (> (nth 17 res) (nth 18 res))
                                     (> (nth 17 res) (nth 19 res))
                                     (> (nth 17 res) (nth 22 res)))
                                 "7")
                               ((and (> (nth 18 res) (nth 17 res))
                                     (> (nth 18 res) (nth 22 res))
                                     (> (nth 18 res) (nth 19 res)))
                                "7-")
                               ((and (> (nth 19 res) (nth 17 res))
                                     (> (nth 19 res) (nth 22 res))
                                     (> (nth 19 res) (nth 18 res)))
                                "7+")
                                ((and (> (nth 16 res) (nth 13 res))
                                      (> (nth 16 res) (nth 14 res))
                                      (> (nth 16 res) (nth 15 res))
                                      (> (nth 16 res) (nth 20 res))
                                      (> (nth 16 res) (nth 21 res)))
                                "7")))
        (make-melodic-note))))

(defun aplica-chord-net (inputs)
  (load-chord-net)
  (coloca-inversoes
   inputs
   (with-system tempered
     (mapcar (lambda (x) (extrai-resultado-chord-net
                          (run-net *chord-net*
                                   (cria-pattern-segmento x))))
             (temperado inputs)))))

(register-algorithm "Simple-net" #'aplica-chord-net #'compara-gabarito-modo-setima)
    
