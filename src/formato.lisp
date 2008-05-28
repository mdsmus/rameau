(in-package #:rameau)

(defparameter *current-key* '("c" "\\major"))
(defparameter *current-sig* "4/4")

(defstruct event
  (text-repr)
  (voice-name)
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
  (dur)
  (relativized))

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

(defun print-event-note (e)
  (when (event-p e)
    (print-note (code->notename (event-pitch e)))))

(defun absolute-pitch (e1)
  (+ (event-pitch e1) (* (get-module) (event-octave e1))))

(defun absolute-interval (e1 e2)
  (- (absolute-pitch e1)
     (absolute-pitch e2)))

(defun absolute-interval-code (e1 e2)
  (let* ((i (absolute-interval e1 e2))
         (sig (if (< i 0) '- '+)))
    (cons sig (module (abs i)))))

(defun print-absolute-interval (inter)
  (format nil "~a ~a" (if (eq '+ (first inter)) "up" "down") (print-interval (cdr inter))))

(defun event-equal (x y)
  (if 
      (or
       (and (event-p x)
            (event-p y)
;            (equal (event-octave x)
;                   (event-octave y))
            (equal (event-pitch x)
                   (event-pitch y))
            (equal (event-dur x)
                   (event-dur y))
            (equal (event-start x)
                   (event-start y)))
       (and (listp x)
            (listp y)
            (every #'event-equal x y)))
      t
      (progn (format t "Expected ~a,~% but saw ~a~%" x y)
             nil)))
       
(defun list-events (segmento)
  (mapcar (lambda (x)
            (print-note (code->notename (event-pitch x)) 'latin))
          (sorted segmento #'event-<)))

(defun pitches (segmento)
  (mapcar #'event-pitch segmento))

(defun durations (segmento)
  (mapcar (lambda (x) (event-dur (first x))) segmento))

(defun make-note (nota &optional (octave "") igno (dur (make-instance 'dur-node :dur nil))  &rest ignore) 
  (declare (ignore ignore igno))
  (make-note-sequence
   :notas (list
           (make-event :pitch (parse-note nota)
                       :octave (octave-from-string octave)
                       :dur (node-dur dur)
                       :start 0
                       :text-repr (list nota octave igno dur ignore)
                       :key *current-key*
                       :time-sig *current-sig*))
   :start 0
   :text-repr (list nota octave igno dur ignore)
   :dur (node-dur dur)))

(defun make-skip (skip igno dur)
  (make-note "s" "" igno dur))

(defun move-event (event tempo)
  "[DONTCHECK]"
  (setf (event-start event) (+ (event-start event) tempo))
  event)

(defun move-sequence (seq tempo)
  "[DONTCHECK]"
  (mapcar (lambda (x) (move-event x tempo))
          seq))


(defun event-end (event)
  (+ (event-start event) (event-dur event)))

(defun sequence-expressions (sequencias)
  "Creates a single sequence from a list of \texttt{note-sequence}s"
  (if (note-sequence-p sequencias)
      sequencias
      (if (cdr sequencias)
          (let* ((primeiro (sequence-expressions (car sequencias)))
                 (segundo (sequence-expressions (second sequencias)))
                 (resto (cddr sequencias))
                 ;(foo             (format t "pri: ~a~%" primeiro))
                 (movimentador (note-sequence-dur primeiro)))
            (setf (note-sequence-notas primeiro)
                  (nconc (note-sequence-notas primeiro)
                   (move-sequence (note-sequence-notas segundo)
                                  (note-sequence-dur primeiro))))
            (incf (note-sequence-dur primeiro) (note-sequence-dur segundo))
            (sequence-expressions (cons primeiro resto)))
          (car sequencias))))

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
  "[DONTCHECK]"
  (if (note-sequence-p exprs)
      exprs
      (if (cdr exprs)
          (let* ((primeiro (car exprs))
                 (segundo (second exprs))
                 (resto (cddr exprs)))
            (%expmerge primeiro segundo)
            (merge-exprs (cons primeiro resto)))
          (car exprs))))



(defun but-a-fifth-apart (a b)
  (let ((a (event-pitch a))
        (b (event-pitch b)))
    (< (first (interval->code (module (- b a))))
       5)))

(defun same-note (a b)
  (< (abs (- a b)) (code->interval '(2 dim 6))))

(defun modificador-oitava (a b)
  "[DONTCHECK]"
  (let ((pa (event-pitch a))
        (pb (event-pitch b))
        (oa (event-octave a))
        (ob (event-octave b)))
    (cond ((null pa) ob)
          ((null pb) ob)
          ((same-note pa pb) (+ oa ob))
          (t
           (+ ob
              (if (< pa pb)
                  (if (but-a-fifth-apart a b)
                      oa
                      (- oa 1))
                  (if (but-a-fifth-apart a b)
                      (+ oa 1)
                      oa)))))))


(defun %do-relative (nota expressao &optional oitava)
         (when expressao
           (let* ((prox-nota (first expressao))
                  (oitava (if oitava oitava
                              (event-octave nota)))
                  (expressao (rest expressao)))
             (setf (event-octave prox-nota) (modificador-oitava nota prox-nota))
             (%do-relative (if (null (event-pitch prox-nota)) nota prox-nota)
                           expressao oitava))))

(defun do-relative (nota expressao)
  (let ((expressao (if (listp expressao) (sequence-expressions (remove-if #'null expressao)) expressao)))
    (%do-relative (car (note-sequence-notas nota)) (note-sequence-notas expressao))
    expressao))


(defun transpose-segmentos (segmentos valor)
  "[DONTCHECK]"
  (loop for notas in segmentos collect
       (loop for n in notas collect
            (make-event :pitch (module (+ (event-pitch n) valor))
                         :octave (event-octave n)
                         :dur (event-dur n)
                         :start (event-start n)
                         :voice-name (event-voice-name n)
                         :key (event-key n)
                         :time-sig (event-time-sig n)))))

(defun tempera (nota)
  "[DONTCHECK]"
  (with-system tempered
    (make-event :pitch (module (event-pitch nota))
                 :octave (event-octave nota)
                 :dur (event-dur nota)
                 :start (event-start nota)
                 :voice-name (event-voice-name nota)
                 :key (event-key nota)
                 :time-sig (event-time-sig nota))))

(defun temperado (segmentos)
  (mapcar (lambda (x) (mapcar #'tempera x)) segmentos))