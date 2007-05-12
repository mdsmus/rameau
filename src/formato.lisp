(defpackage #:formato
  (:export 
           emite-evento
           move-evento-no-tempo
           movimenta-sequencia
           emite-sequencia
           emite-acorde
           cria-nota
           cria-nota-artic
           inicio
           concatena-sequencias)
  (:use #:cl))


(in-package #:formato)

#|

Formato interno:

O formato interno é uma lista de eventos. Cada evento é uma nota que soa, e
soa em uma altura (pitch), por um certo tempo (dur) a partir de um certo
instante na música (inicio). Isso é representado na struct evento.

Antes disso, no entanto, as notas são processadas pra se extrair a duração e
a altura. Isso é feito usando a struct nota, que desaparece depois do primeiro
passo de processamento, quando as notas são transformadas em eventos.

As funções desse arquivo só fazem essa conversão, de notas pra eventos, e
representam esses eventos, e os manipulam de forma básica.


|#



;; (pitch-from-note nota) - converte "c" em 0, por exemplo
;; A priori usar a codificação de Jamary
(defun pitch-from-note (nota)
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



(defstruct nota
  (pitch)
  (dur 1))

(defun cria-nota (nota &optional (dur 1) (artic nil))
  (declare (ignore artic))
  (make-nota :pitch (pitch-from-note nota) :dur dur))

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

(defstruct evento
  (pitch)
  (dur)
  (inicio))


(defun inicio (evento)
  (evento-inicio evento))


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

(defun movimenta-sequencia (seq tempo)
  (mapcar (lambda (x)
            (move-evento-no-tempo x tempo))
          seq))


(defun fim-da-execucao (seq)
  (let ((l (first (last seq))))
    (+ (evento-inicio l) (evento-dur l))))

(defun concatena-sequencias (a b)
  (nconc a (movimenta-sequencia b (fim-da-execucao a))))