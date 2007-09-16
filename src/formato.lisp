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

(defstruct evento
  (pitch)
  (octave)
  (dur)
  (inicio)
  (passagem?))


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
  (assert (not (listp evento)))
  (make-evento :pitch (evento-pitch evento)
               :dur (evento-dur evento)
               :inicio (+ (evento-inicio evento) tempo)
               :octave (evento-octave evento)))

(defun movimenta-sequencia (seq tempo)
  (assert (listp seq))
      (mapcar (lambda (x) (move-evento-no-tempo x tempo))
              seq))
  

(defun fim-evento (evento)
  (+ (evento-inicio evento) (evento-dur evento)))


(defun coloca-expressoes-em-sequencia (sequencias)
  "Leva uma lista de expressões musicais e as arruma em sequência"
  (when sequencias
      (let* ((primeiro (car sequencias))
             (outros (cdr sequencias))
             (fim-primeiro (reduce #'max (mapcar #'fim-evento primeiro)))
             (inicio-primeiro (evento-inicio (car primeiro)))
             (movimentador (- fim-primeiro inicio-primeiro)))
        (append primeiro
                (coloca-expressoes-em-sequencia
                 (mapcar (lambda (x) (movimenta-sequencia x movimentador))
                         outros))))))

(defun menos-mod-96 (a b)
  (mod (- a b) 96))

(defun menos-de-uma-quarta (a b)
  (let ((a (evento-pitch a))
        (b (evento-pitch b)))
    (< (menos-mod-96 b a)
       41)))

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

