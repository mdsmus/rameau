
(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :machine-learning))

(defpackage :rameau-tree
  (:use #:cl
        #:arnesi
        #:rameau
        #:machine-learning))

(in-package :rameau-tree)


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



(defparameter *chord-classes* (mapcar #'string->symbol
                                      (mapcar #'stringify
                                              '(a  b  c  d  e  f  g  —
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
                                                aø7  bø7  cø7  dø7  eø7  fø7  gø7
                                                a#ø7 b#ø7 c#ø7 d#ø7 e#ø7 f#ø7 g#ø7
                                                abø7 bbø7 cbø7 dbø7 ebø7 fbø7 gbø7
                                                a!  b!  c!  d!  e!  f!  g!
                                                a#! b#! c#! d#! e#! f#! g#!
                                                ab! bb! cb! db! eb! fb! gb!
                                                a!7  b!7  c!7  d!7  e!7  f!7  g!7
                                                a#!7 b#!7 c#!7 d#!7 e#!7 f#!7 g#!7
                                                ab!7 bb!7 cb!7 db!7 eb!7 fb!7 gb!7
                                                a+  b+  c+  d+  e+  f+  g+
                                                a#+ b#+ c#+ d#+ e#+ f#+ g#+
                                                ab+ bb+ cb+ db+ eb+ fb+ gb+
                                                a+7+  b+7+  c+7+  d+7+  e+7+  f+7+  g+7+
                                                a#+7+ b#+7+ c#+7+ d#+7+ e#+7+ f#+7+ g#+7+
                                                ab+7+ bb+7+ cb+7+ db+7+ eb+7+ fb+7+ gb+7+
                                                ))))

(defparameter *chord-tree* nil)

(defun simplifica (acorde)
  (if (or (equal nil (chord-mode acorde))
          (equal "m" (chord-mode acorde))
          (equal "°" (chord-mode acorde))
          (equal "!" (chord-mode acorde))
          (equal "+" (chord-mode acorde))
          (equal "ø" (chord-mode acorde)))
      (string->symbol
       (stringify
        (make-chord :fundamental (chord-fundamental acorde)
                    :7th (chord-7th acorde)
                    :mode (chord-mode acorde))))
      (string->symbol "—")))

(defun prepara-chord-exemplo-treinamento (coral gabarito)
  (loop for s in coral
     for g in gabarito
     collect (make-example :name "foo"
                           :class (if (chordp g) (simplifica g)
                                      (string->symbol "—"))
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
  (let ((res (classify (make-example :values (prepara-segmento segmento)) *chord-tree*)))
    (aif (parse-chord res)
         it
         (make-melodic-note))))

(defun exibe-chord-tree (&rest args)
  (declare (ignore args))
  (print-tree *chord-tree*))

(defun gera-gabarito-chord-tree (coral)
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree::exibe-chord-tree/ ~%" *chord-tree*)
  (coloca-inversoes coral (mapcar #'aplica-chord-tree (temperado coral))))

(register-algorithm "Simple-tree" #'gera-gabarito-chord-tree #'compara-gabarito-tonal)

(defun faz-treina-chord-tree ()
  (with-system rameau:tempered
    (multiple-value-bind (corais gabaritos)
        (unzip *exemplos-de-treinamento*)
      (treina-chord-tree corais gabaritos))))

(faz-treina-chord-tree)

