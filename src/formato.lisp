(defpackage #:formato
  (:export flatten
           emite-evento
           move-evento-no-tempo
           movimenta-sequencia
           emite-sequencia
           emite-acorde
           cria-nota
           cria-nota-artic
           inicio)
  (:use #:cl))


(in-package #:formato)

(export 'inicio)


(defun flatten-list (l)
  (when l
    (if (atom l)
        l
        (if (atom (car l))
            (cons (car l) (flatten-list (cdr l)))
            (nconc (flatten-list (car l)) (flatten-list (cdr l)))))))



(defun flatten (&rest lists)
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
              (#\g 55)
              (t (error "droga")))))
       96))

(nota->pitch "c")
(nota->pitch "ceses")


(defstruct nota
  (pitch)
  (dur 1))

(defun cria-nota (nota &optional (dur 1) (artic nil))
  (declare (ignore artic))
  (make-nota :pitch (nota->pitch nota) :dur dur))

(cria-nota "a")
(cria-nota "cis" 2)

(defun cria-nota-dur (nota dur)
  (cria-nota nota dur nil))

(defun cria-nota-artic (nota artic)
  (cria-nota nota 1 artic))

(defun pitch (nota)
  (nota-pitch nota))

(defun dur (nota)
  (nota-dur nota))

(defun inicio (evento)
  (evento-inicio evento))

(defstruct evento
  (pitch)
  (dur)
  (inicio))

(defun emite-evento (nota duracao inicio)
  (make-evento :pitch nota :dur duracao :inicio inicio))


(defun move-evento-no-tempo (evento tempo)
  (make-evento :pitch (evento-pitch evento)
               :dur (evento-dur evento)
               :inicio (+ (evento-inicio evento) tempo)))


(defun emite-sequencia (notas)
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

