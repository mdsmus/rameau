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

(defun compara-gabarito-tree-individual (resultado gabarito)
  (with-system rameau:tempered
    (if (and (chordp resultado) (chordp gabarito))
        (equal (chord-fundamental resultado)
               (chord-fundamental gabarito))
        (equal (type-of resultado) (type-of gabarito)))))

(defun compara-gabarito-tree (resultado gabarito)
  (if (listp gabarito)
      (some (lambda (x) (compara-gabarito-tree-individual resultado x)) gabarito)
      (compara-gabarito-tree-individual resultado gabarito)))

(registra-algoritmo "DecisionTree" #'gera-gabarito-decision-tree #'compara-gabarito-tree)