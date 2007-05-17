;; segmento.lisp - algoritmo de segmentação e definição de segmentos
(defpackage #:segment
  (:use #:cl))

(in-package #:segment)

; Um segmento mínimo é uma lista de pares (n . p), onde p é a quantidade de
; vezes em que a nota n toca no segmento, ordenada por nota.
; Um segmento é um merge de segmentos mínimos.
; (dúvidas quanto a isso, mande-me email, alexandre.tp@gmail.com , que eu posso
;  muito bem estar enganado quanto a esses detalhes mais musicais da coisa)
;
; Exemplo: ((c . 1) (e . 1) (g . 1)) para um acorde de dó maior

(defun merge-segment (s1 s2)
  "Junta os segmentos s1 e s2 em um segmento maior"
  (cond ((null s1) s2)
        ((null s2) s1)
        ((equal (caar s1) (caar s2))
         (let
             ((peso (+ (cdr (car s1)) (cdr (car s2))))
              (nota (caar s1))
              (resto (merge-segment (cdr s1) (cdr s2))))
           (cons (cons nota peso) resto)))
        ((string< (caar s1) (caar s2))
         (cons (car s1) (merge-segment (cdr s1) s2)))
        (t
         (cons (car s2) (merge-segment s1 (cdr s2))))))

(defvar *C*  '((c . 1) (e . 1) (g . 1)))
(defvar *Dm* '((a . 1) (d . 1) (f . 1)))
(merge-segment *C* *C*)
(merge-segment *C* *Dm*)
(merge-segment *C* (merge-segment *C* *Dm*))

  
