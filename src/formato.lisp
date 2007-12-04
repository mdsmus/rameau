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

(defstruct sequencia-de-notas
  (notas)
  (inicio)
  (dur))

(defun compara-notas (x y)
  (let ((a (evento-octave x))
        (b (evento-octave y)))
    (if (= a b)
        (< (evento-pitch x) (evento-pitch y))
        (< a b))))

(defun lista-notas (segmento)
  (mapcar (lambda (x)
            (print-note (code->note (evento-pitch x)) 'latin))
          (sort segmento #'compara-notas)))

(defun pitches (segmento)
  (mapcar #'evento-pitch segmento))

(defun calcula-duracoes (segmento)
  (mapcar (lambda (x) (evento-dur (first x))) segmento))

(defmethod copy ((obj sequencia-de-notas))
  (make-sequencia-de-notas :notas (copy (sequencia-de-notas-notas obj))
                           :inicio (sequencia-de-notas-inicio obj)
                           :dur (sequencia-de-notas-dur obj)))

(defmethod copy ((obj evento))
  (make-evento :pitch (evento-pitch obj)
               :octave (evento-octave obj)
               :dur (evento-dur obj)
               :inicio (evento-inicio obj)))

(defun cria-nota (nota &optional (octave "") dur articulation dur2) 
  (declare (ignore articulation))
  (let ((dur (if dur2 dur2 dur)))
    (make-sequencia-de-notas
     :notas (list
             (make-evento :pitch (note->code nota)
                          :octave (octave-from-string octave)
                          :dur dur
                          :inicio 0))
     :inicio 0
     :dur dur)))

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
  (if (cdr sequencias)
    (let* ((primeiro (car sequencias))
           (segundo (second sequencias))
           (resto (cddr sequencias))
           (movimentador (sequencia-de-notas-dur primeiro)))
      (setf (sequencia-de-notas-notas primeiro)
            (nconc (sequencia-de-notas-notas primeiro)
                   (movimenta-sequencia (sequencia-de-notas-notas segundo)
                                        (sequencia-de-notas-dur primeiro))))
      (incf (sequencia-de-notas-dur primeiro) (sequencia-de-notas-dur segundo))
      (coloca-expressoes-em-sequencia (cons primeiro resto)))
    (car sequencias)))

(defun %expmerge (exp1 exp2)
  (setf (sequencia-de-notas-dur exp1) (max (sequencia-de-notas-dur exp1)
                                           (sequencia-de-notas-dur exp2)))
  (setf (sequencia-de-notas-notas exp1)
        (merge 'list
               (sequencia-de-notas-notas exp1)
               (sequencia-de-notas-notas exp2)
               (lambda (x y)
                 (< (evento-inicio x)
                    (evento-inicio y)))))
  exp1)

(defun merge-exprs (exprs)
  (if (cdr exprs)
      (let* ((primeiro (car exprs))
             (segundo (second exprs))
             (resto (cddr exprs)))
        (%expmerge primeiro segundo)
        (merge-exprs (cons primeiro resto)))
      (car exprs)))



(defun menos-de-uma-quinta (a b)
  (let ((a (evento-pitch a))
        (b (evento-pitch b)))
    (< (module (- b a))
       (code->interval '(5 just)))))


(defun modificador-oitava (a b)
  (let ((pa (evento-pitch a))
        (pb (evento-pitch b))
        (oa (evento-octave a))
        (ob (evento-octave b)))
    (cond ((null pa) ob)
          ((null pb) ob)
          (t
           (+ (- ob 8)
              (if (< pa pb)
                  (if (menos-de-uma-quinta a b)
                      oa
                      (- oa 1))
                  (if (menos-de-uma-quinta b a)
                      oa
                      (+ oa 1))))))))

(defun %relativiza (nota expressao &optional oitava)
  (when expressao
    (let* ((prox-nota (first expressao))
           (oitava (if oitava oitava
                       (evento-octave nota)))
           (expressao (rest expressao)))
      (setf (evento-octave prox-nota) (modificador-oitava nota prox-nota))
      (%relativiza (if (null (evento-pitch prox-nota)) nota prox-nota)
       ;prox-nota
       expressao oitava))))

(defun relativiza (nota expressao)
  (%relativiza (car (sequencia-de-notas-notas nota)) (sequencia-de-notas-notas expressao))
  expressao)