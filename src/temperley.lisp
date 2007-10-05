;; Port para Common Lisp dos programas de análise harmônica Harmony e Meter.
;; Copyright (C) 2000 Daniel Sleator and David Temperley 
;; See http://www.link.cs.cmu.edu/music-analysis
;; for information about commercial use of this system

(in-package :rameau)

;; Parâmetros do programa Harmony

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

;; Parâmetros do programa Meter

(defparameter pip-time 35)
(defparameter tactus-min 420)
(defparameter tactus-max 1600)
(defparameter tactus-width 1.8)
(defparameter tactus-step 1.1)
(defparameter beat-interval-factor 3.0)
(defparameter note-factor 1.0)
(defparameter beat-slop 35)
(defparameter raising-change-penalty 3.0)
(defparameter meter-change-penalty 0.3)
(defparameter max-effective-length 1.0)
(defparameter duple-bonus 0.2)
(defparameter triple-bonus 1.4)
(defparameter note-bonus 0.2)



(defstruct evento-temperley
  (evento)
  (penalidade-dissonancia)
  (voice-leading-neighbor))

(defun converte-pra-evento-temperley (evento)
  (make-evento-temperley :evento evento))

(defun evento-temperley-dur (e)
  (evento-dur (evento-temperley-evento e)))

(defun evento-temperley-inicio (e)
  (evento-inicio (evento-temperley-evento e)))

(defun evento-temperley-pitch (e)
  (evento-pitch (evento-temperley-evento e)))

(defun evento-temperley-octave (e)
  (evento-octave (evento-temperley-evento e)))

(defun converte-milisegundos (inicio)
  (* (/ inicio 1/4) 1000.0))

(defun cria-evento-temperley (evento)
  (make-evento-temperley
   :evento (make-evento :pitch (evento-pitch evento)
                        :octave (evento-octave evento)
                        :dur (converte-milisegundos (evento-dur evento))
                        :inicio (converte-milisegundos (evento-inicio evento)))))

(defun penalidade-de-dissonancia (delta)
  (+ odp-constant
     (* odp-linear_factor delta)
     (* odp-quadratic-factor delta delta)))
     

(defun rotula-dissonancia-nota (musica)
  (let ((default-time 10.0)
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
                              1000.0)))
              (setf (penalidade-dissonancia nota) (penalidades-de-dissonancia delta-t))
              (return)))))))

(defun rotula-voice-leading-nota (musica)
  (let ((nota (first musica))
        (musica (rest musica)))
    (setf (voice-leading-neighbor nota) nil)
    (dolist (f-nota musica)
      (let ((delta-t (\ (- (evento-inicio f-nota)
                           (+ (evento-inicio nota) (evento-dur nota)))
                        1000.0)))
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
  (let* ((musica (mapcar #'cria-evento-temperley musica))
         (musica (rotula-dissonancia musica))
         (musica (rotula-voice-leading musica))
         (clist (segmentos-minimos musica))
         (m-clist (metrifica clist))
         (m-clist (penaliza-as-dissonancias m-clist))
         (cm-clist (compacta m-clist)))
    (gera-gabarito-temperley
     (calcula-tabela-harmonica
      (inicializa-tabela-harmonica cm-clist)))))