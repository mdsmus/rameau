
(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :machine-learning))

(defpackage :rameau-tree-enarm
  (:use #:cl
        #:arnesi
        #:rameau
        #:machine-learning))

(in-package :rameau-tree-enarm)


(defparameter *decision-tree* nil)

(defparameter *classes* (cons '— (mapcar #'string->symbol
                                         (loop for i from 0 to 95
                                            collect (print-note (code->note i))))))

(defparameter *atributos* (list
                           (cons 'pitch1 (loop for i from 0 to 95 collect i))
                           (cons 'pitch2 (loop for i from 0 to 95 collect i))
                           (cons 'pitch3 (loop for i from 0 to 95 collect i))
                           (cons 'pitch4 (loop for i from 0 to 95 collect i))
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
                                      '—)
                           :values (prepara-segmento s))))

(defun prepara-entrada-treinamento (corais gabaritos)
   (loop for c in corais
      for g in gabaritos
      nconc (loop for i in *notas-interessantes-tonal*
               nconc (prepara-exemplo-treinamento (transpose-segmentos c i)
                                                  (transpose-chords g i)))))

(defun treina-decision-tree (corais gabaritos)
  (setf *decision-tree* (id3 (prepara-entrada-treinamento corais gabaritos)
                             *atributos*
                             *classes*)))

(defun aplica-decision-tree (segmento)
  (let ((res (classify (make-example :values (prepara-segmento segmento)) *decision-tree*)))
    (if (eq res '—)
        (make-melodic-note)
        (make-chord :fundamental (stringify res)))))

(defun exibe-tree (&rest args)
  (declare (ignore args))
  (print-tree *decision-tree*))

(defun gera-gabarito-decision-tree (coral)
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree-enarm::exibe-tree/ ~%" *decision-tree*)
  (mapcar #'aplica-decision-tree coral))

;(register-algorithm "Simple-tree" #'gera-gabarito-decision-tree #'compara-gabarito-fundamental)

(defun treina-tree ()
    (multiple-value-bind (corais gabaritos)
        (unzip *exemplos-de-treinamento*)
      (treina-decision-tree corais gabaritos)))

(treina-tree)


(defparameter *chords*
  (loop for modo in '(nil "m" "+" "°" "ø" "!")
     append
       (loop for setima in '(nil "7" "7-" "7+")
          append
            (loop for fundamental from 0 to 95 collect
                 (make-chord :fundamental (print-note (code->note fundamental))
                             :mode modo
                             :7th setima)))))

(defparameter *chord-classes* (mapcar #'string->symbol (mapcar #'stringify (cons '— *chords*))))


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
      nconc (loop for i in *notas-interessantes-tonal*
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
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree-enarm::exibe-chord-tree/ ~%" *chord-tree*)
  (coloca-inversoes coral (mapcar #'aplica-chord-tree coral)))

(register-algorithm "E-Chord-tree" #'gera-gabarito-chord-tree #'compara-gabarito-modo-setima)

(defun faz-treina-chord-tree ()
  (multiple-value-bind (corais gabaritos)
      (unzip *exemplos-de-treinamento*)
    (treina-chord-tree corais gabaritos)))

(faz-treina-chord-tree)

(defparameter *mode-tree* nil)

(defparameter *mode-classes* '(maj min maj7 maj7+ min7 ° °7 ø7 — ! +))

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
            ((equal (chord-mode acorde) "!") '!)
            ((equal (chord-mode acorde) "+") '+)
            (t '—))
      '—))

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
    (ø7 "ø")
    (! "!")
    (+ "+")))

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
    (if (eq fundamental '—)
        (make-melodic-note)
        (let* ((tonica (stringify fundamental))
               (res (classify (make-example :values (prepara-transpoe-segmento segmento))
                              *mode-tree*))
               (modo (extrai-modo-resultado res))
               (setima (extrai-setima-resultado res)))
          (if (eq '— res)
              (make-melodic-note)
              (make-chord :fundamental tonica
                          :mode modo
                          :7th setima))))))
                                             
          
          

(defun exibe-mode-tree (&rest args)
  (declare (ignore args))
  (print-tree *mode-tree*))

(defun gera-gabarito-mode-tree (coral)
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree-enarm::exibe-mode-tree/ ~%" *mode-tree*)
  (coloca-inversoes coral (mapcar #'aplica-mode-tree coral)))

(defun faz-treina-mode-tree ()
  (multiple-value-bind (corais gabaritos)
      (unzip *exemplos-de-treinamento*)
    (treina-mode-tree corais gabaritos)))

(faz-treina-mode-tree)

(register-algorithm "E-Mode-tree" #'gera-gabarito-mode-tree #'compara-gabarito-modo-setima)