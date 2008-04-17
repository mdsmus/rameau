;; Implementação da segmentação

(in-package #:rameau)

(defun group-by (inicio resto)
  "Helper grouping function"
  (if resto
      (if (= inicio (evento-inicio (car resto)))
          (multiple-value-bind (segmento restante) (group-by inicio (cdr resto))
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
           (inicio (evento-inicio primeiro))
           (resto (cdr musica)))
      (multiple-value-bind (grupo restante) (group-by inicio resto)
        
        (cons (cons primeiro grupo)
              (group-with-start restante))))))

(defun correct-segments (segmento proximo)
  "Split the notes in segment to ensure they do not overflow the
  possible sonority. Any too long notes are bunked into the next
  sonority."
  (declare (list proximo))
  (let* ((sobras nil)
         (proximo-evento (if proximo (evento-inicio (first proximo))))
         (proximo-inicio (if proximo
                             (min proximo-evento
                                  (+ (smallest segmento #'evento-dur)
                                     (evento-inicio (first segmento))))
                             (+ (smallest segmento #'evento-dur)
                                     (evento-inicio (first segmento)))))
         (tamanho (- proximo-inicio (evento-inicio (first segmento)))))
    (dbg 'segmento "Prox-ini: ~a, Tam: ~a ~%" proximo-inicio tamanho)
    (values (mapcar (lambda (nota)
                      (if (= (evento-dur nota) tamanho)
                          nota
                          (progn
                            (push (make-evento
                                   :pitch (evento-pitch nota)
                                   :octave (evento-octave nota)
                                   :dur (- (evento-dur nota) tamanho)
                                   :inicio (+ tamanho (evento-inicio nota))
                                   :key (evento-key nota)
                                   :time-sig (evento-time-sig nota))
                                  sobras)
                            (make-evento
                             :pitch (evento-pitch nota)
                             :octave(evento-octave nota)
                             :dur tamanho
                             :inicio (evento-inicio nota)
                             :key (evento-key nota)
                             :time-sig (evento-time-sig nota)))))
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
                                                         (< (evento-inicio x)
                                                            (evento-inicio y)))))
                                 (cddr musica))))
          (cons segmento (resplit-segments segmentos))))
      musica))

(defun sonorities (musica)
  (resplit-segments (group-with-start musica)))

(do-not-test group-by group-with-start resplit-segments correct-segments)

