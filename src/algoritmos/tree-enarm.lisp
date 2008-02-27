
(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :machine-learning))

(defpackage :rameau-tree-enarm
  (:use #:cl
        #:arnesi
        #:rameau
        #:machine-learning))

(in-package :rameau-tree-enarm)



(defparameter *atributos* (list
                           (cons 'pitch1 (loop for i from 0 to 95 collect i))
                           (cons 'pitch2 (loop for i from 0 to 95 collect i))
                           (cons 'pitch3 (loop for i from 0 to 95 collect i))
                           (cons 'pitch4 (loop for i from 0 to 95 collect i))
                            ))

(defparameter *nomes* '(pitch1 pitch2 pitch3 pitch4))

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

(defun prepara-segmento (segmento)
  (loop for nota in segmento
     for n in *nomes* collect (cons n (evento-pitch nota))))

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

(register-algorithm "E-Simple-tree" #'gera-gabarito-chord-tree #'compara-gabarito-modo-setima)

(defun faz-treina-chord-tree ()
  (multiple-value-bind (corais gabaritos)
      (unzip *exemplos-de-treinamento*)
    (treina-chord-tree corais gabaritos)))

(faz-treina-chord-tree)
