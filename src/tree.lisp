(defpackage :rameau-tree
  (:use #:cl
        #:arnesi
        #:rameau
        #:machine-learning))

(in-package :rameau-tree)


(defparameter *decision-tree* nil)

(defparameter *classes* '(a  b  c  d  e  f  g  --
                          a# b# c# d# e# f# g#
                          ab bb cb db eb fb gb))

(defparameter *atributos* '(
                            (pitch1 0 1 2 3 4 5 6 7 8 9 10 11)
                            (pitch2 0 1 2 3 4 5 6 7 8 9 10 11)
                            (pitch3 0 1 2 3 4 5 6 7 8 9 10 11)
                            (pitch4 0 1 2 3 4 5 6 7 8 9 10 11)
                            ))


(defparameter *nomes* '(pitch1 pitch2 pitch3 pitch4))

(defun prepara-segmento (segmento)
  (loop for nota in segmento
     for n in *nomes* collect (cons n (evento-pitch nota))))

(defun prepara-exemplo-treinamento (coral gabarito)
  (loop for s in coral
     for g in gabarito
     collect (make-example :name "foo"
                           :class (if (chordp g) (chord-fundamental g)
                                      '--)
                           :values (prepara-segmento s))))

(defun prepara-entrada-treinamento (corais gabaritos)
   (loop for c in corais
      for g in gabaritos
      nconc (loop for i from 0 to 11
               nconc (prepara-exemplo-treinamento (transpose-segmentos c i)
                                                  (transpose-chords g i)))))

(defun treina-decision-tree (corais gabaritos)
  (setf *decision-tree* (id3 (prepara-entrada-treinamento corais gabaritos)
                             *atributos*
                             *classes*)))

(defun aplica-decision-tree (segmento)
  (let ((res (classify (make-example :values (prepara-segmento segmento)) *decision-tree*)))
    (if (eq res '--)
        (make-melodic-note)
        (make-chord :fundamental (stringify res)))))

(defun exibe-tree (&rest args)
  (declare (ignore args))
  (print-tree *decision-tree*))

(defun gera-gabarito-decision-tree (coral)
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree::exibe-tree/ ~%" *decision-tree*)
  (mapcar #'aplica-decision-tree coral))

(registra-algoritmo "decision-tree" #'gera-gabarito-decision-tree #'compara-gabarito-fundamental)

(defun treina-tree ()
  (format t "Agora treinando a arvore de decisao: ~%")
  (with-system rameau:tempered
    (multiple-value-bind (corais gabaritos)
        (unzip(loop for i in '("001" "003" "004" "006" "012" "018" "136")
                 for f = (first (processa-files "corais" (list i)))
                 for g = (processa-gabarito f "corais")
                 collect (list (segmentos-minimos (parse-file f)) g)))
      (treina-decision-tree corais gabaritos)))
  (format t "Treinada.~%"))

(treina-tree)


(defparameter *context-tree* nil)

(defparameter *context-atributos* '(
                                    (pitch1 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch2 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch3 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch4 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch5 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch6 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch7 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch8 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch9 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch10 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch11 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch12 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch13 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch14 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch15 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch16 0 1 2 3 4 5 6 7 8 9 10 11)
                                    ))


(defparameter *context-nomes* '(pitch1 pitch2 pitch3 pitch4
                                pitch5 pitch6 pitch7 pitch8
                                pitch9 pitch10 pitch11 pitch12
                                pitch13 pitch14 pitch15 pitch16))


(defun prepara-context-segmento (segmentos)
 (loop for notas =  (reduce #'append segmentos) then (cdr notas)
    for nota = (aif (first notas) it nota)
    for n in *context-nomes* collect (cons n (if nota (evento-pitch nota) nil))))

(defun prepara-context-exemplo-treinamento (coral gabarito)
  (butlast
   (loop for s = (cons nil (cons nil coral)) then (cdr s)
      for g in gabarito
      if (listp g)
        collect (prepara-context-exemplo-treinamento (repeat-list s (length g)) g)
      else
        collect (make-example :name "foo"
                              :class (if (chordp g) (chord-fundamental g)
                                         '--)
                              :values (prepara-context-segmento s)))
   2))


(defun prepara-context-entrada-treinamento (corais gabaritos)
   (loop for c in corais
      for g in gabaritos
      nconc (loop for i from 0 to 11
               nconc (prepara-context-exemplo-treinamento (transpose-segmentos c i)
                                                          (transpose-chords g i)))))

(defun gera-treina-context-tree (corais gabaritos)
  (setf *context-tree* (id3 (prepara-context-entrada-treinamento corais gabaritos)
                            *context-atributos*
                            *classes*)))

(defun aplica-context-tree (segmento)
  (let ((res (classify (make-example :values (prepara-context-segmento
                                              (safe-retorna-n-elementos segmento 4)))
                       *context-tree*)))
    (if (eq res '--)
        (make-melodic-note)
        (make-chord :fundamental (stringify res)))))

(defun exibe-context-tree (&rest args)
  (declare (ignore args))
  (print-tree *context-tree*))

(defun gera-gabarito-context-tree (coral)
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree::exibe-tree/ ~%" *decision-tree*)
  (butlast (maplist #'aplica-context-tree (cons nil (cons nil coral))) 2))


(defun treina-context-tree ()
  (with-system rameau:tempered
    (multiple-value-bind (corais gabaritos)
        (unzip(loop for i in '("001" "003" "004" "006" "012" "018" "136")
                 for f = (first (processa-files "corais" (list i)))
                 for g = (processa-gabarito f "corais")
                 collect (list (segmentos-minimos (parse-file f)) g)))
      (gera-treina-context-tree corais gabaritos))))
(treina-context-tree)

(registra-algoritmo "Context-tree" #'gera-gabarito-context-tree #'compara-gabarito-fundamental)