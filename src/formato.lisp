;; Formato interno:
;; O formato interno é uma lista de eventos. Cada evento é uma nota
;; que soa, e soa em uma altura (pitch), por um certo tempo (dur) a
;; partir de um certo instante na música (inicio). Isso é representado
;; na struct evento.

;; Antes disso, no entanto, as notas são processadas pra se extrair a
;; duração e a altura. Isso é feito usando a struct nota, que
;; desaparece depois do primeiro passo de processamento, quando as
;; notas são transformadas em eventos.

;; As funções desse arquivo só fazem essa conversão, de notas pra
;; eventos, e representam esses eventos, e os manipulam de forma
;; básica.

;; *notes-names* é útil para o parser

(in-package #:rameau)

(defstruct evento
  (pitch)
  (octave)
  (dur)
  (inicio))

(defun cria-nota (nota &optional (octave "") dur articulation dur2) 
  (declare (ignore articulation))
  (let ((dur (if dur2 dur2 dur)))
    (make-evento :pitch (note->code nota)
                 :octave (octave-from-string octave)
                 :dur dur
                 :inicio 0)))

(defun cria-skip (skip dur)
  (declare (ignore skip))
  (cria-nota "s" "" dur))

(defun move-evento-no-tempo (evento tempo)
  (setf (evento-inicio evento) (+ (evento-inicio evento) tempo))
  evento)

(defun movimenta-sequencia (seq tempo)
  (mapcar (lambda (x) (move-evento-no-tempo x tempo))
          seq))
  
(defun fim-evento (evento)
  (+ (evento-inicio evento) (evento-dur evento)))

(defun coloca-expressoes-em-sequencia (sequencias)
  "Leva uma lista de expressões musicais e as arruma em sequência"
  (when sequencias
      (let* ((primeiro (car sequencias))
             (outros (cdr sequencias))
             (fim-primeiro (fim-evento (last1 primeiro)))
             (inicio-primeiro (evento-inicio (car primeiro)))
             (movimentador (- fim-primeiro inicio-primeiro)))
        (nconc primeiro
                (coloca-expressoes-em-sequencia
                 (mapcar (lambda (x) (movimenta-sequencia x movimentador))
                         outros))))))

(defun menos-de-uma-quarta (a b)
  (let ((a (evento-pitch a))
        (b (evento-pitch b)))
    (< (module (- b a))
       (code->interval '(4 just)))))


(defun modificador-oitava (a b)
  (let ((pa (evento-pitch a))
        (pb (evento-pitch b))
        (oa (evento-octave a))
        (ob (evento-octave b)))
    (cond ((null pa) 0)
          ((null pb) 0)
          (t
           (+ (- ob 8)
              (if (< pa pb)
                  (if (menos-de-uma-quarta a b)
                      oa
                      (- oa 1))
                  (if (menos-de-uma-quarta b a)
                      oa
                      (+ oa 1))))))))

(defun relativiza (nota expressao &optional seq oitava)
  (if (not expressao)
      (nreverse seq)
      (let* ((prox-nota (first expressao))
             (oitava (if oitava oitava
                         (evento-octave nota)))
             (expressao (rest expressao))
             (evento-novo
              (make-evento
               :pitch (evento-pitch prox-nota)
               :dur (evento-dur prox-nota)
               :inicio (evento-inicio prox-nota)
               :octave (modificador-oitava nota prox-nota)))
             (seq 
              (cons evento-novo seq)))
        (relativiza evento-novo expressao seq oitava))))

