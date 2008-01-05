;; Port para Common Lisp dos programas de analise harmonica Harmony e Meter.
;; Copyright (C) 2000 Daniel Sleator and David Temperley 
;; See http://www.link.cs.cmu.edu/music-analysis
;; for information about commercial use of this system
;;
;; Here be dragons

(defpackage :rameau-temperley
  (:use #:cl #:rameau #:it.bese.arnesi))

(in-package :rameau-temperley)

(declaim (optimize speed 3))

;; Parametros do programa Harmony

(defparameter verbosity 2)
(defparameter buckets-per-unit-of-cog 5.0)
(defparameter pruning-cutoff   1.0)
(defparameter compat-values   '(-5.0 -5.0 -10.0 1.0 -3.0 -10.0 5.0 3.0 -10.0 -10.0 2.0 -10.0))
(defparameter tpc-var-factor   0.03)
(defparameter har-var-factor   0.2)
(defparameter odp-linear_factor   1.0)
(defparameter odp-quadratic-factor   0.1)
(defparameter odp-constant   1.0)
(defparameter compat_factor   1.0)
(defparameter sbp-weight   2.0)
(defparameter sbp-constant   1.5)
(defparameter half-life   2.0)
(defparameter voice-leading-penalty   3.0)
(defparameter voice-leading-time   1.0)
(defparameter alpha (/ (log 2.0) (* half-life 1000)))

;; Parametros do programa Meter

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

;; Constantes do programa Meter

(defparameter lowest-level 0)
(defparameter tactus-level 2)
(defparameter highest-level 4)
(defparameter low-levels tactus-level)
(defparameter high-levels (- highest-level tactus-level))
(defparameter n-levels (1+ highest-level))


;; Informacoes adicionais de um evento em temperley

(defstruct evento-temperley
  (evento-rameau)
  (penalidade-dissonancia)
  (forca-metrica)
  (voice-leading-neighbor)
  (tpc))

(defun evento-temperley-dur (e)
  (evento-dur (evento-temperley-evento-rameau e)))

(defun evento-temperley-inicio (e)
  (evento-inicio (evento-temperley-evento-rameau e)))

(defun evento-temperley-pitch (e)
  (evento-pitch (evento-temperley-evento-rameau e)))

(defun evento-temperley-octave (e)
  (evento-octave (evento-temperley-evento-rameau e)))

(defun fim-evento-temperley (e)
  (fim-evento (evento-temperley-evento-rameau e)))

(defun converte-milisegundos (inicio)
  (* (/ inicio 1/4) 1000.0))

(defun cria-evento-temperley (evento)
  (make-evento-temperley
   :evento-rameau (make-evento :pitch (evento-pitch evento)
                               :octave (evento-octave evento)
                               :dur (converte-milisegundos (evento-dur evento))
                               :inicio (converte-milisegundos (evento-inicio evento)))))

;; Estruturas de meter

(defstruct pip
  (notas)
  (score)
  (is-beat)
  (best-j))

(defstruct bl
  (pip)
  (best-back)
  (score))

(defstruct measure
  (score)
  (local-score)
  (one-pip)
  (two-pips1)
  (two-pips2)
  (best-beat-count)
  (left-pip)
  (right-pip))

;; variaveis globais

;; Funcoes de Meter

(defun quantiza (ti)
  "Determina em que 'pip' fica um evento no tempo"
  (round (/ (+ ti (/ pip-time 2)) pip-time)))

(defun dquantize (val round)
  (let ((valor (/ val pip-time)))
    (cond ((= round -1) (round valor))
          ((= round 1) (round (+ .999999 valor)))
          (t (round (+ .5 valor))))))

(defun ms-to-sec (ms)
  (/ ms 1000.0))

(defun pip-insere-notas (pip notas)
  (when notas
    (push (first notas)
          (pip-notas (aref pip (quantiza (evento-temperley-inicio (first notas))))))
    (pip-insere-notas pip (rest notas))))

(defun cria-pip-array (notas)
  (let* ((tamanho (quantiza (fim-evento-temperley (last1 notas))))
         (pip-array (make-array (list tamanho))))
    (dotimes (i tamanho)
      (setf (aref pip-array i) (make-pip))
      (setf (pip-is-beat (aref pip-array i)) (make-array (list n-levels))))
    (pip-insere-notas pip-array notas)
    (dotimes (i (- tamanho 1))
      (let ((atual (pip-notas (aref pip-array i)))
            (prox (pip-notas (aref pip-array (1+ i)))))
        (when (and atual prox)
          (setf (pip-notas (aref pip-array i)) (nconc atual prox))
          (setf (pip-notas (aref pip-array (1+ i))) nil))))
    pip-array))

(defcached base-score (notas higher-base)
  "A pontuacao de uma beat colocada exatamente sobre essas notas"
  (if notas
    (let* ((dur (length notas))
           (average-length (ms-to-sec
                            (/ (reduce #'+ notas :key #'evento-temperley-dur :initial-value 0)
                               dur))))
      (* note-factor (+ note-bonus
                        (* (sqrt dur)
                           (if higher-base 0.5 average-length)))))
    0.0))

(defun penalidade-desvio (x y)
  (* beat-interval-factor (- (abs (- x y)) beat-slop)))

(defun best-score (pip-array pip j min-pip max-pip use-higher-base)
  (let ((base (base-score (pip-notas (aref pip-array pip)) use-higher-base)))
    (if (> 0 (- pip j))
        (values (* base (sqrt (ms-to-sec (/ (+ tactus-min tactus-max) 2))))
                -1)
        (let ((melhor -100000000)
              (melhor-k 0))
          (loop
             for k from min-pip to max-pip
             for atual = (+ (aref (pip-score (aref pip-array (- pip j)))
                                  (- k min-pip))
                            (if (< (- pip j k) 0)
                                0
                                (- (penalidade-desvio (* k pip-time)
                                                      (* j pip-time))))
                            (* base
                               (sqrt
                                (ms-to-sec (/ (* pip-time (* 2 j)) 2)))))
             when (< melhor atual) do
               (setf melhor atual)
               (setf melhor-k k))
          (values melhor melhor-k)))))

(defun label-beats (j pip level min max pip-array)
  (let* ((k 0))
    (loop
       (setf (aref (pip-is-beat (aref pip-array pip))
                   level)
             t)
       (setf (pip-best-j (aref pip-array pip)) j)
       (when (< (- pip j) 0)
         (return-from label-beats))
       (multiple-value-bind (novo-res novo-k)
           (best-score pip-array pip j min max (= level highest-level))
         (declare (ignore novo-res))
         (setf k novo-k)
         (decf pip j)
         (setf j k)))))

(defun evaluate-solution (pip-array min-pip max-pip level compute-beats)
  (let* ((tam (length pip-array))
         (valores (loop
                     for pip from (- tam 1) downto (- tam max-pip)
                     with best = 0.0
                     with best-j = min-pip
                     with best-pip = pip do
                       (loop for j from min-pip to max-pip do
                            (let ((score (aref (pip-score (aref pip-array pip))
                                               (- j min-pip))))
                              (when (< best score)
                                (setf best score)
                                (setf best-j j)
                                (setf best-pip pip))))
                     finally (return (list best best-j best-pip))))
         (best (first valores))
         (best-j (second valores))
         (best-pip (third valores)))
    (when compute-beats (label-beats best-j best-pip level min-pip max-pip pip-array))
    best))


(defun compute-tactus-scores (min-pip max-pip pip-array)
  (loop
     for pip from 0 to (- (length pip-array) 1) do
       (loop for j from min-pip to max-pip do
            (setf (aref (pip-score (aref pip-array pip))
                        (- j min-pip))
                  (best-score pip-array pip j min-pip max-pip nil))))
  pip-array)

(defun clear-score (array min max)
  (dotimes (i (length array))
    (setf (pip-score (aref array i))
          (make-array (list (1+ (- max min))) :initial-element 0.0)))
  array)

(defun resultados-tactus (pip)
  (loop 
     for tmin = tactus-min then (* tmin tactus-step)
     for tmax = (* tactus-min tactus-width) then (* tmax tactus-step)
     for min = (dquantize tmin 0) then (dquantize tmin 0)
     for max = (dquantize tmax 0) then (dquantize tmax 0)
     for score = (clear-score pip min max) then (clear-score pip min max)
     until (>= tmax tactus-max)
     collect (list (evaluate-solution (compute-tactus-scores min max pip)
                                      min max tactus-level nil)
                   min max)))

(defun compute-tactus-level (pip)
  (let* ((resultados (resultados-tactus pip))
         (resultado (first (max-predicado #'car resultados)))
         (min-pip (second resultado))
         (max-pip (third resultado)))
    (clear-score pip min-pip max-pip)
    (compute-tactus-scores min-pip max-pip pip)
    (evaluate-solution pip min-pip max-pip tactus-level t))
  tactus-level)

(defun build-bl-array (level pip-array)
  (let* ((n-bl (loop for i from 0 to (- (length pip-array) 1)
                  counting (aref (pip-is-beat (aref pip-array i)) level)
                  into n-bl finally (return n-bl)))
         (bl-array (make-array (list n-bl)))
         (i 0))
    (loop for bl from 0 to (- n-bl 1) do
         (setf (aref bl-array bl) (make-bl))
         (setf (bl-score (aref bl-array bl)) (make-array '(2))))
    (loop for pip from 0 to (1- (length pip-array)) do
         (when (aref (pip-is-beat (aref pip-array pip)) level)
           (let ((atual (aref bl-array i)))
             (setf (aref (bl-score atual) 0) 0.0)
             (setf (aref (bl-score atual) 1) 0.0)
             (setf (bl-pip atual) pip)
             (incf i))))
    bl-array))

(defun best-raising-choice (base-beat back use-higher-base pip-array bl-array)
  (let ((base (base-score (pip-notas (aref pip-array (bl-pip (aref bl-array base-beat))))
                          use-higher-base)))
    (if (< (- base-beat back) 0)
        (values base -1) 
        (let ((choice)
              (best-score 0.0))
          (loop for try from 2 to 3 do
               (let ((score (+ (* (+ 1.0
                                     (* (- try 2)
                                        (- triple-bonus 1.0)))
                                  base)
                               (aref (bl-score (aref bl-array (- base-beat back)))
                                     (- try 2)))))
                 (unless (= try back) (decf score raising-change-penalty))
                 (when (or (= try 2) (< best-score score))
                   (setf best-score score)
                   (setf choice try))))
          (values best-score choice)))))

(defun label-raised-beats (beat back level bl-array pip-array)
  (unless (= beat -1)
    (loop
       (format t "back: ~a" back)
       (setf (aref (pip-is-beat (aref pip-array (bl-pip (aref bl-array beat))))
                   level)
             t)
       (setf (bl-best-back (aref bl-array beat)) back)
       (multiple-value-bind (value k)
           (best-raising-choice beat back (= level highest-level) pip-array bl-array)
         (declare (ignore value))
         (decf beat back)
         (setf back k)))))

(defun evaluate-raised-solution (new-level compute-beats bl-array pip-array)
  (let ((best 0.0)
        (best-back -1)
        (best-beat -1))
    (loop for beat from (1- (length bl-array)) downto (- (length bl-array) 3) do
         (loop for back from 2 to 3 do
              (let ((score (aref (bl-score (aref bl-array beat)) (- back 2))))
                (if (or (= best-back -1)
                        (< best score))
                    (setf best score)
                    (progn
                      (setf best-back back)
                      (setf best-beat beat))))))
    (when compute-beats (label-raised-beats best-beat best-back new-level bl-array pip-array))
    best))

(defun compute-higher-level-scores (bl-array new-level pip-array)
  (loop for beat from 0 to (- (length bl-array) 1) do
       (loop for back from 2 to 3 do
            (setf (aref (bl-score (aref bl-array beat)) (- back 2))
                  (best-raising-choice beat back
                                       (= new-level highest-level)
                                       pip-array bl-array)))))

(defun compute-higher-level (pip-array level)
  (let* ((new-level (1+ level))
         (bl-array (build-bl-array level pip-array)))
    (compute-higher-level-scores bl-array new-level pip-array)
    (evaluate-raised-solution new-level t bl-array pip-array)
    new-level))

(let ((dummy (make-pip)))
  (defun xpip (p pip-array)
    (if (or (< p 0)
            (> p (length pip-array)))
        (progn
          (setf (pip-is-beat dummy) (pip-is-beat (aref pip-array 0)))
          (setf (pip-score dummy) (pip-score (aref pip-array 0)))
          dummy)
        (aref pip-array p))))

(defun build-measure-array (pip-array base-level)
  (let* ((m 0)
         (first-beat-pip 0)
         (last-beat-pip 0)
         (n-beats 0)
         (n-measures 0)
         (measure-array)
         (d-average-pips-per-beat 0.0)
         (average-pips-per-beat 0)
         (first-pseudo-pip 0)
         (last-pseudo-pip 0))
    (loop
       for pip from 0 to (1- (length pip-array))
       when (aref (pip-is-beat (aref pip-array pip)) base-level) do
         (when (= first-beat-pip 0) (setf first-beat-pip pip))
         (setf last-beat-pip pip)
         (incf n-beats))
    (setf d-average-pips-per-beat (coerce
                                   (/ (- last-beat-pip first-beat-pip)
                                      (- n-beats 1))
                                   'float))
    (setf average-pips-per-beat (round (+ 0.5 d-average-pips-per-beat)))

    (setf first-pseudo-pip first-beat-pip)
    (when (> first-beat-pip 0)
      (decf first-pseudo-pip average-pips-per-beat)
      (when (<= first-pseudo-pip 0) (setf first-pseudo-pip -1)))

    (setf last-pseudo-pip last-beat-pip)
    (when (< last-beat-pip (1- (length pip-array)))
      (incf last-pseudo-pip average-pips-per-beat)
      (when (<= last-pseudo-pip (1- (length pip-array))
                (setf last-pseudo-pip (1- (length pip-array))))))

    (loop
       for pip from (1+ first-pseudo-pip) to (1- last-pseudo-pip) do
       (when (aref (pip-is-beat (xpip pip pip-array)) base-level) (incf n-measures)))
    (incf n-measures)

    (setf measure-array (make-array (list n-measures)))
    (loop for i from 0 to (1- n-measures) do
         (setf (aref measure-array i) (make-measure))
         (setf (measure-local-score (aref measure-array i))
               (make-array '(3) :initial-element 0.0))
         (setf (measure-score (aref measure-array i))
               (make-array '(3) :initial-element 0.0)))

    (setf m 0)
    (setf (measure-left-pip (aref measure-array 0)) first-pseudo-pip)
    (loop for pip from (1+ first-pseudo-pip) to (1- last-pseudo-pip) do
       (when (aref (pip-is-beat (xpip pip pip-array)) base-level)
         (setf (measure-right-pip (aref measure-array m)) pip)
         (setf (measure-left-pip (aref measure-array (1+ m))) pip)
         (incf m)))
    (setf (measure-right-pip (aref measure-array m)) last-pseudo-pip)

    (loop for m from 0 to (1- n-measures) do
         (setf (measure-best-beat-count (aref measure-array m)) -1))
    measure-array))

(defun measure-score-1 (m n-beats measure-array pip-array)
  (let* ((bp1 0)
         (bp2 0)
         (left (measure-left-pip (aref measure-array m)))
         (right (measure-right-pip (aref measure-array m)))
         (first t)
         score
         (bscore 0.0))
    (if (= 1 n-beats)
      (progn
        (loop for p1 from (1+ left) to (1- right) do
             (setf score (+ (base-score (pip-notas (xpip p1 pip-array)) nil)
                            duple-bonus
                            (- (penalidade-desvio (* pip-time (- p1 left))
                                                  (* pip-time (- right p1))))))
             (when (or first (> score bscore))
               (setf first nil)
               (setf bp1 p1)
               (setf bscore score)))
        (setf (measure-one-pip (aref measure-array m)) bp1)
        (when first (setf (measure-one-pip (aref measure-array m)) left)))
      (progn
        (loop for p1 from (1+ left) to (1- right) do
             (loop for p2 from (1+ p1) to (1- right) do
                  (setf score (+ (base-score (xpip p1 pip-array) nil)
                                 (base-score (xpip p2 pip-array) nil)
                                 (- (penalidade-desvio (* pip-time (- p1 left))
                                                       (* pip-time (- p2 p1))))
                                 (- (penalidade-desvio (* pip-time (- p2 p1))
                                                       (* pip-time (- right p1))))))
                  (when (or first (> score bscore))
                    (setf first nil)
                    (setf bp1 p1)
                    (setf bp2 p2)
                    (setf bscore score))))
        (setf (measure-two-pips1 (aref measure-array m)) bp1)
        (setf (measure-two-pips2 (aref measure-array m)) bp2)
        (when first
          (setf (measure-two-pips1 (aref measure-array m)) left)
          (setf (measure-two-pips2 (aref measure-array m)) left))))

    (setf (aref (measure-local-score (aref measure-array m)) n-beats) bscore)))

(defun best-beat-score (m xb measure-array)
  (loop for yb from 1 to 2
     for score = 0.0 then 0.0
     with best-score = 0
     with besty = -1 do
       (unless (= xb yb) (incf score (- meter-change-penalty)))
       (incf score (+ (aref (measure-local-score (aref measure-array m)) xb)
                      (aref (measure-score (aref measure-array m)) yb)))
       (when (or (= -1 besty) (> score best-score))
         (setf besty yb)
         (setf best-score score))
     finally (return (values best-score besty))))

(defun compute-measure-scores (measure-array pip-array)
  (loop for m from 0 to (1- (length measure-array)) do
       (loop for n-beats from 1 to 2 do
            (measure-score-1 m n-beats measure-array pip-array)))
  (loop for n-beats from 1 to 2  do
       (setf (aref (measure-score (aref measure-array 0)) n-beats)
             (aref (measure-local-score (aref measure-array 0)) n-beats)))
  (loop for m from 1 to (1- (length measure-array)) do
       (loop for xb from 1 to 2 do
            (setf (aref (measure-score (aref measure-array m)) xb)
                  (best-beat-score m xb measure-array)))))

(defun insert-beats (new-level pip-array measure-array)
  (let ((base-level (1+ new-level)))
    (loop
       for pip from 0 to (1- (length pip-array)) do
         (setf (aref (pip-is-beat (aref pip-array pip)) new-level)
               (aref (pip-is-beat (aref pip-array pip)) base-level)))
    (multiple-value-bind (best-score bb)
        (loop
           for n-beats from 1 to 2
           with m = (1- (length measure-array))
           with best-score = 0
           with score = 0
           with bb = -1 do
             (setf score (aref (measure-score (aref measure-array m)) n-beats))
             (when (or (= bb -1) (> score best-score))
               (setf bb n-beats)
               (setf best-score score))
           finally (return (values best-score bb)))
      (declare (ignore best-score))
      (loop
         for m from (1- (length measure-array)) downto 0 do
           (setf (measure-best-beat-count (aref measure-array m)) bb)
           (if (= bb 1)
               (setf (aref (pip-is-beat (xpip (measure-one-pip (aref measure-array m))
                                              pip-array))
                           new-level)
                     t)
               (progn
                 (setf (aref (pip-is-beat (xpip (measure-two-pips1 (aref measure-array m))
                                                pip-array))
                             new-level)
                       t)
                 (setf (aref (pip-is-beat (xpip (measure-two-pips2 (aref measure-array m))
                                                pip-array))
                             new-level)
                       t)))
           (when (= m 0) (return))
           (multiple-value-bind (a new-b)
               (best-beat-score m bb measure-array)
             (declare (ignore a))
             (setf bb new-b))))))



(defun compute-lower-level (pip-array level)
  (let* ((new-level (1- level))
         (measure-array (build-measure-array pip-array level)))
    (compute-measure-scores measure-array pip-array)
    (insert-beats new-level pip-array measure-array)
    new-level))

(defun conta-beats (is-beat)
  (loop for i from 0 to (1- (length is-beat))
     counting (not (eq 0 (aref is-beat i))) into beats
     finally (return beats)))

(defun adjust-notes (pip-array)
  "Pega as notas do pip-array, coloca as beats e reconstroi a musica"
  (loop for pip from 0 to (1- (length pip-array)) do
       (let ((atual (aref pip-array pip)))
         (let ((beat-level (conta-beats (pip-is-beat atual))))
           (loop for i in (pip-notas atual) do
                (setf (evento-temperley-forca-metrica i) beat-level)))))
  (loop for pip from 0 to (1- (length pip-array))
     when (pip-notas (aref pip-array pip)) collect (pip-notas (aref pip-array pip))))
                  

(defun calcula-metrica (notas)
  (let* ((pip-array (cria-pip-array notas))
         (tact (compute-tactus-level pip-array))
         (tact+1 (compute-higher-level pip-array tact))
         (tact+2 (compute-higher-level pip-array tact+1))
         (tact-1 (compute-lower-level pip-array tact))
         (tact-2 (compute-lower-level pip-array tact-1)))
    (declare (ignore tact+2 tact-2))
    (adjust-notes pip-array)))

;; Estruturas de Harmony

(defstruct column
  (chord)
  (table)
  (my-mass)
  (chord-mass)
  (note-mass)
  (decayed-prior-note-mass)
  (decayed-prior-chord-mass))

(defstruct bucket
  (int-tpc-cog)
  (int-har-cog)
  (score)
  (tpc-prime)
  (tpc-variance)
  (har-variance)
  (tpc-cog)
  (har-cog)
  (root)
  (window)
  (orn-diss-penalty)
  (local-voice-leading-penalty)
  (compatibility)
  (prev-bucket))

(defstruct side-effect
  (tpc-choice)
  (compatibility)
  (orn-diss-penalty)
  (strong-beat-penalty)
  (tpc-variance)
  (tpc-cog))


;; constantes de harmony

(defparameter lowest-tpc -24)
(defparameter highest-tpc 34)


(defparameter *side-effect* (make-side-effect
                             :tpc-choice (make-array '(100) :initial-element 0)))



;; Funcoes de Harmony


(defun penalidade-de-dissonancia (delta)
  (+ odp-constant
     (* odp-linear_factor delta)
     (* odp-quadratic-factor delta delta)))
     

(defun rotula-dissonancia (musica)
  (let ((default-time 10.0))
    (loop for nota-list = musica then (cdr nota-list)
       for nota = (first nota-list) then (first nota-list)
       unless nota-list do (return)
       do
         (setf (evento-temperley-penalidade-dissonancia nota)
               (penalidade-de-dissonancia default-time))
         (loop for f-nota-list = (cdr nota-list) then (cdr f-nota-list)
            for f-nota = (first f-nota-list) then (first f-nota-list)
            unless f-nota-list do (return)
            unless (= (evento-temperley-inicio nota)
                      (evento-temperley-inicio f-nota))
            do
              (when (not (= (evento-temperley-pitch nota)
                            (evento-temperley-pitch f-nota)))
                (when (or (= (evento-temperley-pitch nota)
                             (+ (evento-temperley-pitch f-nota) 1))
                          (= (evento-temperley-pitch nota)
                             (+ (evento-temperley-pitch f-nota) 2))
                          (= (evento-temperley-pitch nota)
                             (+ (evento-temperley-pitch f-nota) -1))
                          (= (evento-temperley-pitch nota)
                             (+ (evento-temperley-pitch f-nota) -2)))
                  (let ((delta-t (/ (- (evento-temperley-inicio f-nota)
                                       (evento-temperley-inicio nota))
                                    1000.0)))
                    (setf (evento-temperley-penalidade-dissonancia nota)
                          (penalidade-de-dissonancia delta-t))
                    (return)))))))
  musica)

(defun rotula-voice-leading (musica)
  (loop for nota-list = musica then (cdr nota-list)
     for nota = (first nota-list) then (first nota-list)
     unless nota-list do (return)
     do
       (setf (evento-temperley-voice-leading-neighbor nota) 0)
       (dolist (f-nota nota-list)
         (let ((delta-t (/ (- (evento-temperley-inicio f-nota)
                              (+ (evento-temperley-inicio nota) (evento-temperley-dur nota)))
                           1000.0)))
           (when (> delta-t 0)
             (when (> delta-t voice-leading-time) (return))
             (when (= (evento-temperley-pitch nota) (+ 1 (evento-temperley-pitch f-nota)))
               (setf (evento-temperley-voice-leading-neighbor nota) 1)
               (return))
            (when (= (evento-temperley-pitch nota) (- (evento-temperley-pitch f-nota) 1))
              (setf (evento-temperley-voice-leading-neighbor nota) -1)
              (return))))))
  musica)

(defun temperley-metrifica (musica)
  (let* ((musica (reduce #'nconc (segmentos-minimos musica) :from-end t))
         (musica (loop for i in musica collect (cria-evento-temperley i))))
    (calcula-metrica musica)))

(defun penaliza-dissonancia (clist)
  (loop for ch in clist do
       (loop for note in ch
          for old = (evento-temperley-penalidade-dissonancia note) do
            (setf (evento-temperley-penalidade-dissonancia note)
                  (min 10.0
                       (* (evento-temperley-penalidade-dissonancia note)
                          (min 1.0
                               (* 1.4 (sqrt (/ (* (evento-temperley-forca-metrica note)
                                                  (evento-temperley-dur note))
                                               1000.0)))))))
            (dbg 'rameau::temperley3 "penalidade: ~a ~a ~a ~a~%"
                 (evento-temperley-penalidade-dissonancia note)
                 old
                 (evento-temperley-forca-metrica note)
                 (evento-temperley-dur note))))
  clist)

(defun inicializa-tabela-harmonica (clist)
  (let* ((n-chords (length clist))
         (column-table (make-array (list n-chords))))
    (loop
       for i from 0 to (1- n-chords)
       for ch in clist do
         (setf (aref column-table i)
               (make-column :chord ch :table (make-hash-table :test #'equal)
                                      :my-mass (/ (evento-temperley-dur (first ch))
                                                  1000.0)))
         (let ((atual (aref column-table i))
               (n (length ch)))
           (if (= i 0)
               (progn
                 (setf (column-note-mass atual) (* n (column-my-mass atual)))
                 (setf (column-chord-mass atual) (column-my-mass atual))
                 (setf (column-decayed-prior-note-mass atual) 0.0)
                 (setf (column-decayed-prior-chord-mass atual) 0.0))
               (let* ((delta-t (coerce (- (evento-temperley-inicio (first ch))
                                          (evento-temperley-inicio
                                           (first (column-chord (aref column-table (1- i))))))
                                       'float))
                      (decay (exp (* (- alpha) delta-t))))
                 (setf (column-chord-mass atual) (+ (* decay
                                                       (column-chord-mass (aref column-table (1- i))))
                                                    (column-my-mass atual)))
                 (setf (column-note-mass atual) (+ (* decay
                                                      (column-note-mass (aref column-table (1- i))))
                                                   (column-my-mass atual)))
                 (setf (column-decayed-prior-note-mass atual) (* decay
                                                                 (column-note-mass
                                                                  (aref column-table (1- i)))))
                 (setf (column-decayed-prior-chord-mass atual) (* decay
                                                                  (column-chord-mass
                                                                   (aref column-table (1- i)))))))))
    column-table))

(defun pitch-to-tpc (note)
  (labels
      ((pitch-to-npc (p)
         (mod (+ p  12000000) 12))
       (base-tpc (n)
         (mod (+ 2 (* 7 n) 12000000)
              12)))
    (declare (fixnum note)
             (inline pitch-to-npc base-tpc))
    (base-tpc (pitch-to-npc note))))

(defun apply-window (note window)
  (declare (fixnum note window))
  (let ((base-tpc (pitch-to-tpc note)))
    (+ (mod (+ base-tpc (- window) 12000000)
            12)
       window)))

(defun is-canonical-window (chord window)
  (if (null chord)
      (= window 0)
        (loop for note in chord
           when (= window (apply-window (evento-temperley-pitch note) window))
           do (return t)
           finally (return nil))))

(defun discrete-cog (cog)
  (round (* cog buckets-per-unit-of-cog)))

(defun compatibility (root tpc)
  (declare (fixnum root tpc))
  (let ((i (+ 6 (- tpc root))))
    (if (and (>= i 0) (< i (length compat-values)))
        (nth i compat-values)
        -10.0)))

(defun note-ornamental-dissonance-penalty (root tpc chord note same-roots)
  (declare (ignore same-roots chord))
  (if (not (= -10.0 (compatibility root tpc)))
      0.0
      (evento-temperley-penalidade-dissonancia note)))

(defun tpc-variance (cog tpc my-mass decayed-prior-chord-mass)
  (declare (ignore decayed-prior-chord-mass)
           (float cog my-mass decayed-prior-chord-mass)
           (fixnum tpc))
  (let ((delta-cog (abs (- cog tpc))))
    (* delta-cog delta-cog my-mass)))

(defun tpc-choice-score (root window same-roots ch my-mass decayed-prior-note-mass tpc-cog)
  (let* ((nnotes (length ch)))
    (setf (side-effect-compatibility *side-effect*) 0.0
          (side-effect-orn-diss-penalty *side-effect*) 0.0
          (side-effect-tpc-variance *side-effect*) 0.0)
    (if (> same-roots 0)
        (setf (side-effect-strong-beat-penalty *side-effect*) 0.0)
        (setf (side-effect-strong-beat-penalty *side-effect*)
              (max (- (/ (* sbp-weight 1000.0)
                         (evento-temperley-forca-metrica (first ch)))
                      sbp-constant)
                   0.0)))
    (loop for i from 0
       for note in ch do
         (let* ((tpc (apply-window (evento-temperley-pitch note) window))
                (compat (if (eq -10.0 (compatibility root tpc))
                            0
                            (* (compatibility root tpc) my-mass)))
                (orn-diss-penalty (note-ornamental-dissonance-penalty root tpc ch note same-roots))
                (variance (tpc-variance tpc-cog tpc my-mass decayed-prior-note-mass)))
           (setf (aref (side-effect-tpc-choice *side-effect*) i) tpc)
           (incf (side-effect-compatibility *side-effect*) compat)
           (incf (side-effect-orn-diss-penalty *side-effect*) orn-diss-penalty)
           (incf (side-effect-tpc-variance *side-effect*) variance)))
    (let ((average-tpc 0))
      (loop for i from 0 to (1- nnotes) do
           (incf average-tpc (coerce (/ (aref (side-effect-tpc-choice *side-effect*) i)
                                        nnotes)
                                     'float)))
      (setf (side-effect-tpc-cog *side-effect*)
            (/ (+ (* tpc-cog decayed-prior-note-mass) (* average-tpc nnotes my-mass))
               (+ (* nnotes my-mass) decayed-prior-note-mass))))))

(defun compute-voice-leading-penalty (chord tpc-cog window)
  (let ((total 0.0))
    (loop for note in chord
       when (or (and (eq 1 (evento-temperley-voice-leading-neighbor note))
                     (> (apply-window (evento-temperley-pitch note) window) (+ 4.0 tpc-cog)))
                (and (eq -1 (evento-temperley-voice-leading-neighbor note))
                     (< (apply-window (evento-temperley-pitch note) window) (+ -4.0 tpc-cog))))
       do (incf total voice-leading-penalty))
    total))

(defun initialize-first-harmonic-column (column-table)
  (loop for window from lowest-tpc to (- highest-tpc 11)
     when (is-canonical-window (column-chord (aref column-table 0)) window)
     do
       (loop for root from -4 to 7 do
            (loop for tpc-prime from (- root 5) to (+ root 6) do
                 (let* ((cog (coerce root 'float))
                        (b (discrete-cog cog)))
                   (tpc-choice-score root window 0 (column-chord (aref column-table 0))
                                     (column-my-mass (aref column-table 0)) 1.0
                                     (coerce tpc-prime 'float))
                   (setf (gethash (list (discrete-cog (side-effect-tpc-cog *side-effect*))
                                        b
                                        root
                                        window)
                                  (column-table (aref column-table 0)))
                         (make-bucket :int-tpc-cog (discrete-cog (side-effect-tpc-cog *side-effect*))
                                      :int-har-cog b
                                      :root root
                                      :window window
                                      :tpc-prime tpc-prime
                                      :tpc-cog (side-effect-tpc-cog *side-effect*)
                                      :har-cog cog
                                      :har-variance 0.0
                                      :orn-diss-penalty 0.0
                                      :compatibility (side-effect-compatibility *side-effect*)
                                      :local-voice-leading-penalty 0.0
                                      :tpc-variance (side-effect-tpc-variance *side-effect*)
                                      :score (+ (side-effect-compatibility *side-effect*)
                                                (- (side-effect-orn-diss-penalty *side-effect*))
                                                (- (compute-voice-leading-penalty
                                                    (column-chord (aref column-table 0))
                                                    (side-effect-tpc-cog *side-effect*)
                                                    window))))))))))

(defun windows-differ-in-chord (window1 window2 chord)
  nil)

(defun prune-table (table)
  (let ((count 0)
        (badcount 0)
        (best nil)
        (newtable (make-hash-table :test #'equal)))
    (loop for h being the hash-keys in table using (hash-value bu) do
         (incf count)
         (when (or (null best) (> (bucket-score bu) (bucket-score best)))
               (setf best bu)))
    (loop for h being the hash-keys in table using (hash-value bu) do
         (if (< (bucket-score bu) (- (bucket-score best) pruning-cutoff))
             (incf badcount)
             (setf (gethash h newtable) bu)))
    (clrhash table)
    newtable))

(defun calcula-tabela-harmonica (column-table chords)
  (initialize-first-harmonic-column column-table)
  (loop for column from 1 to (1- (length chords))
     with this-dbg = nil
     do
       (setf this-dbg nil)
       (loop for window from lowest-tpc to (- highest-tpc 11)
          when (is-canonical-window (column-chord (aref column-table column)) window) do
            (loop for h being the hash-keys in (column-table (aref column-table (1- column)))
               using (hash-value bu) do
                 (loop
                    for my-root from (floor (- (bucket-har-cog bu) 12.0))
                    to (round (+ (bucket-har-cog bu) 12.0)) do
                      (let* ((current-cog (coerce my-root 'float))
                             (delta-cog (- current-cog (bucket-root bu)))
                             (har-variance (abs (* delta-cog
                                                   (column-my-mass (aref column-table column))
                                                   har-var-factor))))
                        (tpc-choice-score my-root
                                          window
                                          (if (= (bucket-root bu) my-root) 1 0)
                                          (column-chord (aref column-table column))
                                          (column-my-mass (aref column-table column))
                                          (column-decayed-prior-note-mass (aref column-table column))
                                          (bucket-tpc-cog bu))
                        (let* ((local-voice-leading-penalty (compute-voice-leading-penalty
                                                             (column-chord (aref column-table column))
                                                             (side-effect-tpc-cog *side-effect*)
                                                             window))
                               (score (- (+ (bucket-score bu)
                                            (side-effect-compatibility *side-effect*))
                                         ;(side-effect-orn-diss-penalty *side-effect*)
                                         har-variance
                                         (* tpc-var-factor (side-effect-tpc-variance *side-effect*))
                                         local-voice-leading-penalty))
                               (new-cog
                                (/
                                 (+
                                  (* (bucket-har-cog bu)
                                     (column-decayed-prior-note-mass (aref column-table column)))
                                  (* current-cog
                                     (column-my-mass (aref column-table column))))
                                 (column-chord-mass (aref column-table column))))
                               (int-tpc-cog (discrete-cog (side-effect-tpc-cog *side-effect*)))
                               (int-har-cog (discrete-cog new-cog))
                               (bu1 (gethash (list int-tpc-cog
                                                   int-har-cog
                                                   my-root
                                                   window)
                                             (column-table (aref column-table column))))
                               (new-guy (not bu1)))
                          (when (and (not this-dbg)
                                      (>= (side-effect-compatibility *side-effect*)
                                         5)
                                      (> (bucket-score bu) 0))
                            (dbg 'rameau::temperley2 "1: ~a, 2: ~a, 3: ~a. 4: ~a, 5: ~a, 6: ~a~%"
                                 (bucket-score bu)
                                 (side-effect-compatibility *side-effect*)
                                 (side-effect-orn-diss-penalty *side-effect*)
                                 har-variance
                                 (* tpc-var-factor (side-effect-tpc-variance *side-effect*))
                                 local-voice-leading-penalty)
                            (setf this-dbg t))
                          (when new-guy
                            (let ((b (make-bucket :int-tpc-cog int-tpc-cog
                                                  :int-har-cog int-har-cog
                                                  :root my-root
                                                  :window window)))
                              (setf (gethash (list int-tpc-cog
                                                   int-har-cog
                                                   my-root
                                                   window)
                                             (column-table (aref column-table column)))
                                    b)
                              (setf bu1 b)))
                        (when (or new-guy
                                  (> score (bucket-score bu1)))
                          (setf (bucket-score bu1) score
                                (bucket-har-variance bu1) har-variance
                                (bucket-tpc-variance bu1) (side-effect-tpc-variance *side-effect*)
                                (bucket-har-cog bu1) new-cog
                                (bucket-tpc-cog bu1) (side-effect-tpc-cog *side-effect*)
                                (bucket-orn-diss-penalty bu1) (side-effect-orn-diss-penalty *side-effect*)
                                (bucket-compatibility bu1) (side-effect-compatibility *side-effect*)
                                (bucket-local-voice-leading-penalty bu1) local-voice-leading-penalty
                                (bucket-prev-bucket bu1) bu)))))))
       (setf (column-table (aref column-table column))
             (prune-table (column-table (aref column-table column)))))
  column-table)

(let ((letters '("f" "c" "g" "d" "a" "e" "b")))
  (defun tpc-string (tpc)
    (let* ((letl (mod (1- tpc) 7))
           (letl (if (< letl 0) (- letl) letl))
           (sharps (/ (- tpc 1 letl) 7))
           (accidental (if (< sharps 0) "b" "#"))
           (sharps (abs sharps)))
      (concat (nth letl letters) (repeat-string sharps accidental)))))

(defvar *bu* nil)

(defun exibe-score-roots (stream ignore1 ignore2 ignore3)
  (declare (ignore ignore1 ignore2 ignore3))
  (format stream "Bucket ~a~%" *bu*)
  (loop for i = *bu* then (bucket-prev-bucket i)
     unless i do (return)
     do (format stream "Root ~a~%"
                (tpc-string (bucket-root i)))))

(defun gera-gabarito-temperley (column-table chords)
  (let* ((n-chords (length chords))
         (bucket-choice (make-array (list n-chords)))
         (best-b nil))
    (loop for i from 0 to (1- n-chords) do
         (setf (aref bucket-choice i) (make-bucket)))
    (loop for h being the hash-keys in (column-table (aref column-table (1- n-chords)))
       using (hash-value bu)
       when (or (null best-b) (< (bucket-score best-b) (bucket-score bu))) do
         (setf best-b bu))
    (let ((*bu* best-b)) (dbg 'rameau::temperley
                          "Scores: ~/rameau-temperley::exibe-score-roots/" best-b))
    (loop for i from (1- n-chords) downto 0 do
         (setf (aref bucket-choice i) best-b
               best-b (bucket-prev-bucket best-b)))
    (loop for i from 0 to (1- n-chords)
       collect (make-chord :fundamental (print-note
                                         (code->note
                                          (note->code
                                           (tpc-string (bucket-root (aref bucket-choice i)))))
                                         'latin)))))

(defun temperley (segmentos)
  (let* ((musica (reduce #'append segmentos :from-end t))
         (musica (mapcar #'cria-evento-temperley musica))
         (musica (rotula-dissonancia musica))
         (musica (rotula-voice-leading musica))
         (m-clist (calcula-metrica musica))
         (m-clist (penaliza-dissonancia m-clist)))
    (gera-gabarito-temperley
     (calcula-tabela-harmonica (inicializa-tabela-harmonica m-clist) m-clist)
     m-clist)))

(registra-algoritmo "Temperley" #'temperley #'compara-gabarito-fundamental)