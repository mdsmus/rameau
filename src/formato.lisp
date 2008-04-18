(in-package #:rameau)

(defparameter *current-key* '("c" "\\major"))
(defparameter *current-sig* "4/4")


;; The atomic structures returned by the parser are \\texttt{event}s,
;; \\texttt{note-sequence}s and \\texttt{note-simultaneous}. These are
;; distinct from their AST counterparts defined in parser.lisp.
;;

(defstruct event
  (text-repr)
  (pitch)
  (octave)
  (dur)
  (start)
  (key)
  (time-sig))

(defstruct note-sequence
  (text-repr)
  (notas)
  (start)
  (dur))

(defstruct note-simultaneous
  (text-repr)
  (notes)
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

(defun durations (segmento)
  (mapcar (lambda (x) (event-dur (first x))) segmento))

(defun make-note (nota &optional (octave "") dur  &rest ignore) 
  (declare (ignore ignore))
  (make-note-sequence
   :notas (list
           (make-event :pitch (parse-note nota)
                       :octave (octave-from-string octave)
                       :dur dur
                       :start 0
                       :key *current-key*
                       :time-sig *current-sig*))
   :start 0
   :dur dur))

(defun make-skip (skip dur ignore)
  (declare (ignore skip ignore))
  (make-note "s" "" dur))

(defun move-event (event tempo)
  (setf (event-start event) (+ (event-start event) tempo))
  event)

(defun move-sequence (seq tempo)
  (mapcar (lambda (x) (move-event x tempo))
          seq))


(defun event-end (event)
  (+ (event-start event) (event-dur event)))

(defun sequence-expressions (sequencias)
  "Creates a single sequence from a list of \texttt{note-sequence}s"
  (if (cdr sequencias)
    (let* ((primeiro (car sequencias))
           (segundo (second sequencias))
           (resto (cddr sequencias))
           (movimentador (note-sequence-dur primeiro)))
      (setf (note-sequence-notas primeiro)
            (nconc (note-sequence-notas primeiro)
                   (move-sequence (note-sequence-notas segundo)
                                        (note-sequence-dur primeiro))))
      (incf (note-sequence-dur primeiro) (note-sequence-dur segundo))
      (sequence-expressions (cons primeiro resto)))
    (car sequencias)))

(defun %expmerge (exp1 exp2)
  (setf (note-sequence-dur exp1) (max (note-sequence-dur exp1)
                                           (note-sequence-dur exp2)))
  (setf (note-sequence-notas exp1)
        (merge 'list
               (note-sequence-notas exp1)
               (note-sequence-notas exp2)
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



(defun but-a-fifth-apart (a b)
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
                  (if (but-a-fifth-apart a b)
                      oa
                      (- oa 1))
                  (if (but-a-fifth-apart b a)
                      oa
                      (+ oa 1))))))))

(defun %do-relative (nota expressao &optional oitava)
  (when expressao
    (let* ((prox-nota (first expressao))
           (oitava (if oitava oitava
                       (event-octave nota)))
           (expressao (rest expressao)))
      (setf (event-octave prox-nota) (modificador-oitava nota prox-nota))
      (%do-relative (if (null (event-pitch prox-nota)) nota prox-nota)
       ;prox-nota
       expressao oitava))))

(defun do-relative (nota expressao)
  (%do-relative (car (note-sequence-notas nota)) (note-sequence-notas expressao))
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
  move-event
  move-sequence
  cria-skip
  %expmerge
  merge-exprs
  modificador-oitava
  %do-relative
  transpose-segmentos
  )

(defun temperado (segmentos)
  (mapcar (lambda (x) (mapcar #'tempera x)) segmentos))