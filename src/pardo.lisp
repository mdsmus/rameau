;; Implementação do algoritmo de pardo.


(defparameter *interval-names* '(tonic diminished-second second minor-third major-third fourth
                                 diminished-fifth fifth minor-sixth major-sixth
                                 minor-seventh major-seventh))
(defparameter *tonal-intervals* '(0 13 14 27 28 41 54 55 56 68 69 82 83))
(defparameter *tempered-intervals* '(0 1 2 3 4 5 6 7 8 9 10 11))


(defun interval-number (interval codification)
  (nth (position interval *interval-names*) codification))

(defvar *templates* (make-hash-table))

(defun defchord (name intervals &optional (codification *tonal-intervals*))
  (setf (gethash name *templates*) (mapcar (lambda (x)
                                             (interval-number x codification))
                                           intervals)))

(defun defchords (chords)
  (mapcar (lambda (x)
            (defchord (first x) (second x)))
          chords))

(defchords '(((maj 0) (tonic major-third fifth))
             ((min 0) (tonic minor-third fifth))
             ((maj 0 7) (tonic major-third fifth minor-seventh))))

(defun pula (elemento lista)
  "Pula as ocorrências iniciais de elemento lista"
  (if (equal elemento (first lista))
      (pula elemento (rest lista))
      lista))

(defun group-and-count (segment)
  "Agrupa as notas de mesmo pitch e conta quantas ocorrem no segmento"
  (when segment
    (let ((nota (first segment)))
      (cons (cons nota (count nota segment))
            (group-and-count (pula nota segment))))))

(defun segment-to-template (segment)
  "Converte um segmento em um formato pronto para ser comparado com um template."
  (let* ((segment (mapcar #'evento-pitch segment))
         (segment (sort segment #'<)))
    (group-and-count segment)))

