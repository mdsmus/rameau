
(in-package :rameau)

(defparameter verbosity 2)
(defparameter pruning-cutoff   10.0)
(defparameter compat-values   '(-5.0 -5.0 -10.0 1.0 -3.0 -10.0 5.0 3.0 -10.0 -10.0 2.0 -10.0))
(defparameter tpc-var-factor   0.3)
(defparameter har-var-factor   2.0)
(defparameter odp-linear_factor   3.0)
(defparameter odp-quadratic-factor   1.0)
(defparameter odp-constant   2.0)
(defparameter compat_factor   1.0)
(defparameter sbp-weight   2.0)
(defparameter sbp-constant   1.5)
(defparameter half-life   2.0)
(defparameter voice-leading-penalty   3.0)
(defparameter voice-leading-time   1.0)


(defun penalidade-de-dissonancia (delta)
  (+ odp-constant
     (* odp-linear_factor delta)
     (* odp-quadratic-factor delta delta)))
     

;; Problema número 1: como o algoritmo de Temperley é baseado em midi ele calcula os
;; tempos em segundos, em vez de em batidas. Temos mais informação que ele nesse quesito
;; e podemos usar isso, mas não sei como. FIXME.

(defun rotula-dissonancia-nota (musica)
  (let ((default-time 10)
        (nota (first musica))
        (musica (rest musica)))
    (setf (penalidade-dissonancia nota) (penalidades-de-dissonancia default-time))
    (dolist (f-nota musica)
      (when (not (= (evento-pitch nota)
                    (evento-pitch f-nota)))
        (if (or (= (evento-pitch nota)
                   (+ (evento-pitch f-nota) 1))
                (= (evento-pitch nota)
                   (+ (evento-pitch f-nota) 2))
                (= (evento-pitch nota)
                   (+ (evento-pitch f-nota) -1))
                (= (evento-pitch nota)
                   (+ (evento-pitch f-nota) -2)))
            (let ((delta-t (/ (- (evento-inicio f-nota)
                                 (evento-inicio nota))
                              1000)))
              (setf (penalidade-dissonancia nota) (penalidades-de-dissonancia delta-t))
              (return)))))))

(defun rotula-voice-leading-nota (musica)
  (let ((nota (first musica))
        (musica (rest musica)))
    (setf (voice-leading-neighbor nota) nil)
    (dolist (f-nota musica)
      (let ((delta-t (\ (- (evento-inicio f-nota)
                           (+ (evento-inicio nota) (evento-dur nota)))
                        1000)))
        (when (> delta-t 0)
            (when (> delta-t voice-leading-time) (return))
            (when (= (evento-pitch note) (+ 1 (evento-pitch f-nota)))
              (setf (voice-leading-neighbor nota) 1)
              (return))
            (when (= (evento-pitch note) (- (evento-pitch f-nota) 1))
              (setf (voice-leading-neighbor nota) -1)
              (return)))))))


  
(defun rotula-dissonancia (musica)
  (mapl #'rotula-dissonancia-nota musica))

(defun rotula-voice-leading (musica)
  (mapl #'rotula-voice-leading-nota musica))

(defun metrifica (segmentos)
  

(defun temperley (musica)
  (let* ((musica (rotula-dissonancia musica))
         (musica (rotula-voice-leading musica))
         (clist (segmentos-minimos musica))
         (m-clist (metrifica clist))
         (m-clist (penaliza-as-dissonancias m-clist))
         (cm-clist (compacta m-clist)))
    (gera-gabarito-temperley
     (calcula-tabela-harmonica
      (inicializa-tabela-harmonica cm-clist)))))