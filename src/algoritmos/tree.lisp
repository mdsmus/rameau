
(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :machine-learning))

(defpackage :rameau-tree
  (:use #:cl
        #:arnesi
        #:rameau
        #:machine-learning))

(in-package :rameau-tree)


(defparameter *decision-tree* nil)

(defparameter *classes* '(a  b  c  d  e  f  g  --
                          a# b# c# d# e# f# g#
                          ab bb cb db eb fb gb))

(defparameter *atributos* '(
                            (pitch1 0 1 2 3 4 5 6 7 8 9 10 11)
                            (pitch2 0 1 2 3 4 5 6 7 8 9 10 11)
                            (pitch3 0 1 2 3 4 5 6 7 8 9 10 11)
                            (pitch4 0 1 2 3 4 5 6 7 8 9 10 11)
                            ))


(defparameter *nomes* '(pitch1 pitch2 pitch3 pitch4))

(defun prepara-segmento (segmento)
  (loop for nota in segmento
     for n in *nomes* collect (cons n (evento-pitch nota))))

(defun prepara-exemplo-treinamento (coral gabarito)
  (loop for s in coral
     for g in gabarito
     collect (make-example :name "foo"
                           :class (if (chordp g) (chord-fundamental g)
                                      '--)
                           :values (prepara-segmento s))))

(defun prepara-entrada-treinamento (corais gabaritos)
   (loop for c in corais
      for g in gabaritos
      nconc (loop for i from 0 to 11
               nconc (prepara-exemplo-treinamento (transpose-segmentos c i)
                                                  (transpose-chords g i)))))

(defun treina-decision-tree (corais gabaritos)
  (setf *decision-tree* (id3 (prepara-entrada-treinamento corais gabaritos)
                             *atributos*
                             *classes*)))

(defun aplica-decision-tree (segmento)
  (let ((res (classify (make-example :values (prepara-segmento segmento)) *decision-tree*)))
    (if (eq res '--)
        (make-melodic-note)
        (make-chord :fundamental (stringify res)))))

(defun exibe-tree (&rest args)
  (declare (ignore args))
  (print-tree *decision-tree*))

(defun gera-gabarito-decision-tree (coral)
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree::exibe-tree/ ~%" *decision-tree*)
  (mapcar #'aplica-decision-tree coral))

(register-algorithm "Simple-tree" #'gera-gabarito-decision-tree #'compara-gabarito-fundamental)

(defun treina-tree ()
  (with-system rameau:tempered
    (multiple-value-bind (corais gabaritos)
        (unzip *exemplos-de-treinamento*)
      (treina-decision-tree corais gabaritos))))

(treina-tree)


(defparameter *context-tree* nil)

(defparameter *context-atributos* '(
                                    (pitch1 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch2 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch3 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch4 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch5 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch6 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch7 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch8 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch9 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch10 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch11 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch12 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch13 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch14 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch15 0 1 2 3 4 5 6 7 8 9 10 11)
                                    (pitch16 0 1 2 3 4 5 6 7 8 9 10 11)
                                    ))


(defparameter *context-nomes* '(pitch1 pitch2 pitch3 pitch4
                                pitch5 pitch6 pitch7 pitch8
                                pitch9 pitch10 pitch11 pitch12
                                pitch13 pitch14 pitch15 pitch16))


(defun prepara-context-segmento (segmentos)
 (loop for notas =  (reduce #'append segmentos) then (cdr notas)
    for nota = (aif (first notas) it nota)
    for n in *context-nomes* collect (cons n (if nota (evento-pitch nota) nil))))

(defun prepara-context-exemplo-treinamento (coral gabarito)
  (butlast
   (loop for s = (cons nil (cons nil coral)) then (cdr s)
      for g in gabarito
      if (listp g)
        collect (prepara-context-exemplo-treinamento (repeat-list s (length g)) g)
      else
        collect (make-example :name "foo"
                              :class (if (chordp g) (chord-fundamental g)
                                         '--)
                              :values (prepara-context-segmento s)))
   2))


(defun prepara-context-entrada-treinamento (corais gabaritos)
   (loop for c in corais
      for g in gabaritos
      nconc (loop for i from 0 to 11
               nconc (prepara-context-exemplo-treinamento (transpose-segmentos c i)
                                                          (transpose-chords g i)))))

(defun gera-treina-context-tree (corais gabaritos)
  (setf *context-tree* (id3 (prepara-context-entrada-treinamento corais gabaritos)
                            *context-atributos*
                            *classes*)))

(defun aplica-context-tree (segmento)
  (let ((res (classify (make-example :values (prepara-context-segmento
                                              (safe-retorna-n-elementos segmento 4)))
                       *context-tree*)))
    (if (eq res '--)
        (make-melodic-note)
        (make-chord :fundamental (stringify res)))))

(defun exibe-context-tree (&rest args)
  (declare (ignore args))
  (print-tree *context-tree*))

(defun gera-gabarito-context-tree (coral)
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree::exibe-tree/ ~%" *decision-tree*)
  (butlast (maplist #'aplica-context-tree (cons nil (cons nil coral))) 2))


(defun treina-context-tree ()
  (with-system rameau:tempered
    (multiple-value-bind (corais gabaritos)
        (unzip *exemplos-de-treinamento*)
      (gera-treina-context-tree corais gabaritos))))
(treina-context-tree)

(register-algorithm "Context-tree" #'gera-gabarito-context-tree #'compara-gabarito-fundamental)

(defparameter *chord-classes* (mapcar #'string->symbol
                                      (mapcar #'stringify
                                              '(a  b  c  d  e  f  g  --
                                                a# b# c# d# e# f# g#
                                                ab bb cb db eb fb gb
                                                a7  b7  c7  d7  e7  f7  g7
                                                a#7 b#7 c#7 d#7 e#7 f#7 g#7
                                                ab7 bb7 cb7 db7 eb7 fb7 gb7
                                                a7+  b7+  c7+  d7+  e7+  f7+  g7+
                                                a#7+ b#7+ c#7+ d#7+ e#7+ f#7+ g#7+
                                                ab7+ bb7+ cb7+ db7+ eb7+ fb7+ gb7+
                                                am  bm  cm  dm  em  fm  gm
                                                a#m b#m c#m d#m e#m f#m g#m
                                                abm bbm cbm dbm ebm fbm gbm
                                                am7  bm7  cm7  dm7  em7  fm7  gm7
                                                a#m7 b#m7 c#m7 d#m7 e#m7 f#m7 g#m7
                                                abm7 bbm7 cbm7 dbm7 ebm7 fbm7 gbm7
                                                a°  b°  c°  d°  e°  f°  g°
                                                a#° b#° c#° d#° e#° f#° g#°
                                                ab° bb° cb° db° eb° fb° gb°
                                                a°7  b°7  c°7  d°7  e°7  f°7  g°7
                                                a#°7 b#°7 c#°7 d#°7 e#°7 f#°7 g#°7
                                                ab°7 bb°7 cb°7 db°7 eb°7 fb°7 gb°7
                                                aø  bø  cø  dø  eø  fø  gø
                                                a#ø b#ø c#ø d#ø e#ø f#ø g#ø
                                                abø bbø cbø dbø ebø fbø gbø
                                                ))))

(defparameter *chord-tree* nil)

(defun simplifica (acorde)
  (if (or (equal nil (chord-mode acorde))
          (equal "m" (chord-mode acorde))
          (equal "°" (chord-mode acorde))
          (equal "ø" (chord-mode acorde)))
      (string->symbol
       (stringify
        (make-chord :fundamental (chord-fundamental acorde)
                    :7th (if (equal (chord-mode acorde)
                                    "ø")
                             nil
                             (chord-7th acorde))
                    :mode (chord-mode acorde))))
      (string->symbol "--")))

(defun prepara-chord-exemplo-treinamento (coral gabarito)
  (loop for s in coral
     for g in gabarito
     collect (make-example :name "foo"
                           :class (if (chordp g) (simplifica g)
                                      (string->symbol "--"))
                           :values (prepara-segmento s))))

(defun prepara-chord-entrada-treinamento (corais gabaritos)
   (loop for c in corais
      for g in gabaritos
      nconc (loop for i from 0 to 11
               nconc (prepara-chord-exemplo-treinamento (transpose-segmentos c i)
                                                        (transpose-chords g i)))))

(defun treina-chord-tree (corais gabaritos)
  (setf *chord-tree* (id3 (prepara-chord-entrada-treinamento corais gabaritos)
                          *atributos*
                          *chord-classes*)))

(defun aplica-chord-tree (segmento)
  (let ((res (classify (make-example :values (prepara-segmento segmento)) *decision-tree*)))
    (aif (parse-chord res)
         it
         (make-melodic-note))))

(defun exibe-chord-tree (&rest args)
  (declare (ignore args))
  (print-tree *chord-tree*))

(defun gera-gabarito-chord-tree (coral)
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree::exibe-chord-tree/ ~%" *chord-tree*)
  (mapcar #'aplica-chord-tree coral))

(register-algorithm "Chord-tree" #'gera-gabarito-chord-tree #'compara-gabarito-modo-setima)

(defun faz-treina-chord-tree ()
  (with-system rameau:tempered
    (multiple-value-bind (corais gabaritos)
        (unzip *exemplos-de-treinamento*)
      (treina-chord-tree corais gabaritos))))

(faz-treina-chord-tree)

(defparameter *mode-tree* nil)

(defparameter *mode-classes* '(maj min maj7 maj7+ min7 ° °7 ø7 --))

(defun extrai-modo (acorde)
  (if (chordp acorde)
      (cond ((and (equal (chord-mode acorde) nil)
                  (equal (chord-7th acorde) nil))
             'maj)
            ((and (equal (chord-mode acorde) nil)
                  (equal (chord-7th acorde) "7"))
             'maj7)
            ((and (equal (chord-mode acorde) nil)
                  (equal (chord-7th acorde) "7+"))
             'maj7+)
            ((and (equal (chord-mode acorde) "m")
                  (equal (chord-7th acorde) nil))
             'min)
            ((and (equal (chord-mode acorde) "m")
                  (equal (chord-7th acorde) "7"))
             'min7)
            ((and (equal (chord-mode acorde) "°")
                  (equal (chord-7th acorde) nil))
             '°)
            ((and (equal (chord-mode acorde) "°")
                  (equal (chord-7th acorde) "7-"))
             '°7)
            ((equal (chord-mode acorde) "ø") 'ø7)
            (t '--))
      '--))

(defun prepara-transpoe-segmento (segmento)
  (let ((pitch (evento-pitch (first segmento))))
    (loop for s = segmento then (cdr s)
       for n in *nomes*
       for i = (if s (first s) i)
       collect (cons n (module (- (evento-pitch i) pitch))))))

(defun prepara-exemplo-treinamento-par (coral gabarito)
  (loop for s in coral
     for g in gabarito
     collect (make-example :name "foo"
                           :class (extrai-modo g)
                           :values (prepara-transpoe-segmento s))))

(defun prepara-entrada-treinamento-par (corais gabaritos)
   (loop for c in corais
      for g in gabaritos
      nconc (prepara-exemplo-treinamento-par c g)))

(defun treina-mode-tree (corais gabaritos)
  (setf *mode-tree* (id3 (prepara-entrada-treinamento-par corais gabaritos)
                         *atributos*
                         *mode-classes*)))

(defun extrai-modo-resultado (res)
  (case res
    (maj nil)
    (maj7 nil)
    (maj7+ nil)
    (min "m")
    (min7 "m")
    (°  "°")
    (°7 "°")
    (ø7 "ø")))

(defun extrai-setima-resultado (res)
  (case res
    (maj nil)
    (maj7 "7")
    (maj7+ "7+")
    (min nil)
    (min7 "7")
    (°  nil)
    (°7 "7-")
    (ø7 "7")))

(defun aplica-mode-tree (segmento)
  (let ((fundamental (classify (make-example :values (prepara-segmento segmento)) *decision-tree*)))
    (if (eq fundamental '--)
        (make-melodic-note)
        (let* ((tonica (stringify fundamental))
               (res (classify (make-example :values (prepara-transpoe-segmento segmento))
                              *mode-tree*))
               (modo (extrai-modo-resultado res))
               (setima (extrai-setima-resultado res)))
          (if (eq '-- res)
              (make-melodic-note)
              (make-chord :fundamental tonica
                          :mode modo
                          :7th setima))))))
                                             
          
          

(defun exibe-mode-tree (&rest args)
  (declare (ignore args))
  (print-tree *mode-tree*))

(defun gera-gabarito-mode-tree (coral)
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree::exibe-mode-tree/ ~%" *mode-tree*)
  (mapcar #'aplica-mode-tree coral))

(defun faz-treina-mode-tree ()
  (with-system rameau:tempered
    (multiple-value-bind (corais gabaritos)
        (unzip *exemplos-de-treinamento*)
      (treina-mode-tree corais gabaritos))))

(faz-treina-mode-tree)

(register-algorithm "Mode-tree" #'gera-gabarito-mode-tree #'compara-gabarito-modo-setima)