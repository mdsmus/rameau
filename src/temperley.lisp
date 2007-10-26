;; Port para Common Lisp dos programas de análise harmônica Harmony e Meter.
;; Copyright (C) 2000 Daniel Sleator and David Temperley 
;; See http://www.link.cs.cmu.edu/music-analysis
;; for information about commercial use of this system
;;
;; Here be dragons

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

;; Constantes do programa Meter

(defparameter lowest-level 0)
(defparameter tactus-level 2)
(defparameter highest-level 4)
(defparameter low-levels tactus-level)
(defparameter high-levels (- high-level tactus-level))
(defparameter n-levels (1+ highest-level))


;; Informações adicionais de um evento em temperley

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

;; Estruturas de meter

(defstruct pip
  (notas)
  (beats)
  (score)
  (is-beat)
  (best-j))

(defstruct bl
  (pip)
  (best-back)
  (score))

;; variáveis globais

;; Funções de Meter

(defun quantiza (t)
  "Determina em que 'pip' fica um evento no tempo"
  (/ (+ t (/ pip-time 2)) pip-time))

(defun dquantize (val round)
  (let ((valor (/ val pip-time)))
    (cond ((= round -1) (round valor))
          ((= round 1) (round (+ .999999 valor)))
          (t (round (+ .5 valor))))))

(defun ms-to-sec (ms)
  (/ ms 1000.0))

(defun pip-insere-notas (pip notas)
  (when notas
    (pushf (pip-notas (aref pip (quantiza (evento-inicio (first notas)))))
           (first notas))
    (pip-insere-notas pip (rest notas))))

(defun cria-pip-array (notas)
  (let* ((tamanho (quantiza (fim-evento (last1 notas))))
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

(defun base-score (notas higher-base)
  "A pontuação de uma beat colocada exatamente sobre essas notas"
  (let ((dur (length notas))
        (average-length (ms-to-sec
                         (/ (reduce #'+ notas :key #'evento-dur :initial-value 0)
                            dur))))
    (* note-factor (+ note-bonus
                      (* (sqrt dur)
                         (if higher-base 0.5 average-length))))))

(defun penalidade-desvio (x y)
  (* beat-interval-factor (- (abs (x - y)) beat-slop)))

(defun best-score (pip-array pip j min-pip max-pip use-higher-base)
  (let ((base (base-score (pip-notas (aref pip-array pip)) use-higher-base)))
    (if (< 0 (- pip j))
        (values (* base (sqrt (ms-to-sec (/ (+ tactus-min tactus-max) 2))))
                -1)
        (let ((melhor
               (car
                (max-predicado
                 #'second
                 (loop
                    for k from min-pip to max-pip
                    collect
                      (list
                       k
                       (+ (aref (pip-score (aref pip-array (- pip j)))
                                k)
                          (if (< (- pip j k) 0)
                              0
                              (- (penalidade-desvio (* k pip-time)
                                                    (* j pip-time))))
                          (* base
                             (sqrt (ms-to-sec
                                    (/ (* pip-time (* 2 j)) 2))0))))))))
              (values (second melhor) (first melhor)))))))

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
         (setf k novo-k)
         (decf pip j)
         (setf j k)))))

(defun evaluate-solution (pip-array min-pip max-pip level compute-beats)
  (let* ((tam (length pip-array))
         (valores (loop
                     for pip from (- tam 1) downto (- tam max-pip) do
                     with best = 0.0 and best-j = min-pip and best-pip = pip do
                       (loop for j from min-pip to max-pip do
                            (let ((score (aref (pip-score (aref (pip-array pip)))
                                               j)))
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
            (setf (aref (pip-score (aref (pip-array pip)))
                        j)
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
     for score = (clear-score pip min max) then (clears-core pip min max)
     until (>= tmax tactus-max)
     collect (list (evaluate-solution (compute-tactus-scores min max pip)
                                      min max tactus-level nil)
                   min max)))

(defun compute-tactus-level (pip)
  (let* ((resultados (resultados-tactus pip))
         (resultado (first (max-predicado #'caar resultados)))
         (score (first resultado))
         (min-pip (second resultado))
         (max-pip (third resultado)))
    (clear-score pip min max)
    (compute-tactus-scores min max pip)
    (evaluate-solution pip min max tactus-level t))
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
    (loop for pip from 0 to (- (length pip-array 1)) do
         (when (aref (pip-is-beat (aref pip-array pip)) level)
           (let ((atual (aref bl-array i)))
             (setf (aref (bl-score atual) 0) 0.0)
             (setf (aref (bl-score atual) 1) 0.0)
             (setf (bl-pip atual) pip)
             (incf i))))
    bl-array))

(defun best-raising-choice (base-beat back use-higher-base pip-array bl-array)
  (let ((base (base-score (pip-notes (aref pip-array (bl-pip (aref bl-array base-beat))))
                          use-higher-base)))
    (if (< (- base-beat back) 0)
        (values base -1) ;; retirada dependência em is-first-beat
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
  (loop
     (setf (aref (pip-is-beat (aref pip-array (bl-pip (aref bl-array beat))))
                 level)
           t)
     (setf (bl-best-back (aref bl-array beat)) back)
     (multiple-value-bind (value k)
         (best-raising-choice beat back (= level highest-level) pip-array bl-array)
       (declare (ignore value))
       (decf beat back)
       (setf back k))))

(defun evaluate-raised-solution (new-level compute-beats bl-array)
  (let ((best 0.0)
        (best-back -1)
        (best-beat -1))
    (loop for beat from (- (length bl-array) 1) downto (- (length bl-array 3)) do
         (loop for back from 2 to 3 do
              (let ((score (aref (bl-score (aref bl-array beat)) (- back 2))))
                (if (or (= best-back -1)
                        (< best score))
                    (setf best score)
                    (setf best-back back)
                    (setf best-beat beat)))))
    (when compute-beats (label-raise-beats best-beat best-back level bl-array pip-array))
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
         (bl-array (build-bl-array level pip-array))
         (scores (compute-higher-level-scores bl-array new-level pip-array))
         (solution (evaluate-raised-solution new-level true bl-array)))
    new-level))



(defun calcula-metrica (notas)
  (let* ((pip-array (cria-pip-array notas))
         (tact (compute-tactus-level pip))
         (tact+1 (compute-higher-level pip tact))
         (tact+2 (compute-higher-level pip tact+1))
         (tact-1 (compute-lower-level pip tact))
         (tact-2 (compute-lower-level pip tact-1)))
    (adjust-notes pip notas)))

;; Funções de Harmony

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


(defun temperley (musica)
  (let* ((musica (reduce #'nconc (segmentos-minimos musica) :from-end t))
         (musica (mapcar #'cria-evento-temperley musica))
         (musica (calcula-metrica musica))
         (musica (rotula-dissonancia musica))
         (musica (rotula-voice-leading musica))
         (clist (segmentos-minimos musica))
         (m-clist (metrifica clist musica))
         (m-clist (penaliza-as-dissonancias m-clist))
         (cm-clist (compacta m-clist)))
    (gera-gabarito-temperley
     (calcula-tabela-harmonica
      (inicializa-tabela-harmonica cm-clist)))))