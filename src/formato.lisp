(defpackage #:formato
  (:export flatten
           emite-evento
           move-evento-no-tempo
           movimenta-sequencia
           emite-sequencia
           emite-acorde
           cria-nota
           cria-nota-artic)
  (:use #:cl))

(use-package '#:common-lisp)
(in-package #:formato)

(defun flatten-list (l)
  (when l
    (if (atom l)
        l
        (if (atom (car l))
            (cons (car l) (flatten-list (cdr l)))
            (nconc (flatten-list (car l)) (flatten-list (cdr l)))))))



(defun flatten (&rest lists)
  (princ "saida: ")
  (print lists)
  (flatten-list lists))


;; A priori usar a codificação de Jamary
(defun nota->pitch (nota)
  (mod (let
           ((acid
             (let
                 ((a (subseq nota 1)))
               (cond
                 ((equal a "is") 1)
                 ((equal a "isis") 2)
                 ((equal a "es") -1)
                 ((equal a "eses") -2)
                 (t 0)))))
         (+ acid
            (case (aref nota 0)
              (#\a 69)
              (#\b 83)
              (#\c 0)
              (#\d 14)
              (#\e 28)
              (#\f 41)
              (#\g 55))))
       96))

(nota->pitch "c")
(nota->pitch "ceses")


(defun cria-nota (nota &optional (dur 1) (artic nil))
  (declare (ignore artic))
  (list (nota->pitch nota) dur))


(defun cria-nota-dur (nota dur)
  (cria-nota nota dur nil))

(defun cria-nota-artic (nota artic)
  (cria-nota nota 1 artic))

(defun pitch (nota)
  (first nota))

(defun dur (nota)
  (second nota))

(defun emite-evento (nota duracao inicio)
  (list nota duracao inicio))


(defun move-evento-no-tempo (evento tempo)
  (list (first evento) (second evento) (+ (third evento) tempo)))


(defun emite-sequencia (&rest notas)
  (let ((seq nil)
        (inicio 0))
    (dolist (n notas)
      (setf seq (cons (emite-evento (pitch n) (dur n) inicio) seq))
      (setf inicio (+ inicio (dur n))))
    (nreverse seq)))



(defun emite-acorde (&rest notas)
  (mapcar (lambda (n)
            (emite-evento (pitch n) (dur n) 0))
          notas))

(defun movimenta-sequencia (seq)
  (mapcar #'move-evento-no-tempo seq))

