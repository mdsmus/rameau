(in-package #:rameau)

(defparameter *current-key* '("c" "\\major"))
(defparameter *current-sig* "4/4")

(defstruct event
  (pitch)
  (octave)
  (dur)
  (start)
  (key)
  (time-sig))

(defstruct sequencia-de-notas
  (notas)
  (start)
  (dur))

(defun event-< (x y)
  (let ((a (event-octave x))
        (b (event-octave y)))
    (if (= a b)
        (< (event-pitch x) (event-pitch y))
        (< a b))))

(defun list-events (segmento)
  (mapcar (lambda (x)
            (print-note (code->notename (event-pitch x)) 'latin))
          (sorted segmento #'event-<)))

(defun pitches (segmento)
  (mapcar #'event-pitch segmento))

(defun calcula-duracoes (segmento)
  (mapcar (lambda (x) (event-dur (first x))) segmento))

(defun cria-nota (nota &optional (octave "") dur articulation dur2) 
  (declare (ignore articulation))
  (let ((dur (if dur2 dur2 dur)))
    (make-sequencia-de-notas
     :notas (list
             (make-event :pitch (parse-note nota)
                          :octave (octave-from-string octave)
                          :dur dur
                          :start 0
                          :key *current-key*
                          :time-sig *current-sig*))
     :start 0
     :dur dur)))

(defun cria-skip (skip dur)
  (declare (ignore skip))
  (cria-nota "s" "" dur))

(defun move-event-no-tempo (event tempo)
  (setf (event-start event) (+ (event-start event) tempo))
  event)

(defun movimenta-sequencia (seq tempo)
  (mapcar (lambda (x) (move-event-no-tempo x tempo))
          seq))


(defun fim-event (event)
  (+ (event-start event) (event-dur event)))

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
                 (< (event-start x)
                    (event-start y)))))
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
  (let ((a (event-pitch a))
        (b (event-pitch b)))
    (< (module (- b a))
       (code->interval '(5 just)))))


(defun modificador-oitava (a b)
  (let ((pa (event-pitch a))
        (pb (event-pitch b))
        (oa (event-octave a))
        (ob (event-octave b)))
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
                       (event-octave nota)))
           (expressao (rest expressao)))
      (setf (event-octave prox-nota) (modificador-oitava nota prox-nota))
      (%relativiza (if (null (event-pitch prox-nota)) nota prox-nota)
       ;prox-nota
       expressao oitava))))

(defun relativiza (nota expressao)
  (%relativiza (car (sequencia-de-notas-notas nota)) (sequencia-de-notas-notas expressao))
  expressao)

(defun transpose-segmentos (segmentos valor)
  (loop for notas in segmentos collect
       (loop for n in notas collect
            (make-event :pitch (module (+ (event-pitch n) valor))
                         :octave (event-octave n)
                         :dur (event-dur n)
                         :start (event-start n)
                         :key (event-key n)
                         :time-sig (event-time-sig n)))))

(defun tempera (nota)
  (with-system tempered
    (make-event :pitch (module (event-pitch nota))
                 :octave (event-octave nota)
                 :dur (event-dur nota)
                 :start (event-start nota)
                 :key (event-key nota)
                 :time-sig (event-time-sig nota))))

(do-not-test tempera
  move-event-no-tempo
  movimenta-sequencia
  cria-skip
  coloca-expressoes-em-sequencia
  %expmerge
  merge-exprs
  modificador-oitava
  %relativiza
  transpose-segmentos
  )

(defun temperado (segmentos)
  (mapcar (lambda (x) (mapcar #'tempera x)) segmentos))