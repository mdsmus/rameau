;; Implementação da segmentação

(in-package #:rameau)

(defun group-by (start resto)
  "Helper grouping function"
  (if resto
      (if (= start (event-start (car resto)))
          (multiple-value-bind (segmento restante) (group-by start (cdr resto))
            (values (cons (car resto) segmento)
                    restante))
          (values
           nil
           resto))
      (values nil nil)))
  
(defun group-with-start (musica)
  "Group \\texttt{music} by the on-set times of the notes."
  (when musica
    (let* ((primeiro (first musica))
           (start (event-start primeiro))
           (resto (cdr musica)))
      (multiple-value-bind (grupo restante) (group-by start resto)
        
        (cons (cons primeiro grupo)
              (group-with-start restante))))))

(defun correct-segments (segmento proximo)
  "Split the notes in segment to ensure they do not overflow the
  possible sonority. Any too long notes are bunked into the next
  sonority."
  (declare (list proximo))
  (let* ((sobras nil)
         (proximo-event (if proximo (event-start (first proximo))))
         (proximo-start (if proximo
                             (min proximo-event
                                  (+ (smallest segmento #'event-dur)
                                     (event-start (first segmento))))
                             (+ (smallest segmento #'event-dur)
                                     (event-start (first segmento)))))
         (tamanho (- proximo-start (event-start (first segmento)))))
    (dbg 'segmento "Prox-ini: ~a, Tam: ~a ~%" proximo-start tamanho)
    (values (mapcar (lambda (nota)
                      (if (= (event-dur nota) tamanho)
                          nota
                          (progn
                            (push (make-event
                                   :pitch (event-pitch nota)
                                   :octave (event-octave nota)
                                   :dur (- (event-dur nota) tamanho)
                                   :start (+ tamanho (event-start nota))
                                   :key (event-key nota)
                                   :time-sig (event-time-sig nota))
                                  sobras)
                            (make-event
                             :pitch (event-pitch nota)
                             :octave(event-octave nota)
                             :dur tamanho
                             :start (event-start nota)
                             :key (event-key nota)
                             :time-sig (event-time-sig nota)))))
                    segmento)
            sobras)))

(defun resplit-segments (musica)
  "Create the sonorities of a piece already grouped by note onset
  time.

  For this, it is necessary to ensure that the notes in every sonority
  have the same on-set and off-set times. This is accomplished by
  splitting notes, which is made by correct-segments."
  (if (cdr musica)
      (multiple-value-bind
            (segmento sobras)
          (correct-segments (first musica) (second musica))
        (let* ((sobras-acumuladas (nconc sobras (second musica)))
               (segmentos (nconc (group-with-start (sort sobras-acumuladas
                                                       (lambda (x y)
                                                         (< (event-start x)
                                                            (event-start y)))))
                                 (cddr musica))))
          (cons segmento (resplit-segments segmentos))))
      musica))

(defun sonorities (musica)
  (resplit-segments (group-with-start musica)))

(do-not-test group-by group-with-start resplit-segments correct-segments)
