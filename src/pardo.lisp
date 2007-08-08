;; Implementa��o do algoritmo de pardo.


(defparameter *interval-names* '(tonic diminished-second second minor-third major-third fourth
                                 diminished-fifth fifth minor-sixth major-sixth
                                 minor-seventh major-seventh))
(defparameter *tonal-intervals* '(0 13 14 27 28 41 54 55 56 68 69 82 83))
(defparameter *tempered-intervals* '(0 1 2 3 4 5 6 7 8 9 10 11))


(defun interval-number (interval codification)
  (nth (position interval *interval-names*) codification))

(defvar *templates* ())

(defun defchord (name intervals &optional (codification *tonal-intervals*))
  (push (cons name (mapcar (lambda (x)
                             (interval-number x codification))
                           intervals))
        *templates*))

(defun defchords (chords)
  (mapcar (lambda (x)
            (defchord (first x) (second x)))
          chords))

(defchords '(((maj 0) (tonic major-third fifth))
             ((min 0) (tonic minor-third fifth))
             ((maj 0 7) (tonic major-third fifth minor-seventh))))

(defun pula (elemento lista)
  "Pula as ocorr�ncias iniciais de elemento lista"
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

(defun avalia-template (template segmento)
  "Compara as notas de um template com as de um segmento e gera a nota.
   Seguindo o artigo de pardo, a nota S = P - (M + N), onde P � a soma
   dos pesos das notas existentes no segmento e no template, M � a soma
   dos pesos das notas existentes no segmento e n�o no template e n � o
   n�mero de notas no template n�o encontradas no segmento. O valor m�nimo
   � 0 - Mmax - Nmax, onde Mmax � a soma dos pesos das notas do segmento e
   Nmax � o n�mero de notas no template. Essa fun��o come�a com esse valor
   m�nimo e vai aumentando-o a cada evid�ncia positiva."
  (let ((score (- 0
                  (reduce #'+
                          (mapcar #'rest segmento))
                  (length template)))
        (encontrados 0))
    (dolist (nota segmento)
      (when (member (first nota) template)
        (setf score (+ score
                       (* 2 (second nota))
                       1))
        (incf encontrados)))
    (+ score encontrados)))

(defun transpoe (template nota &optional (modificador 0) (codification *tonal*))
  (mapcar (lambda (x) (+ x (note-number nota) modificador)) template))

(defun da-nota-modificada (template segmento nota modificador)
  (cons (avalia-template (transpoe template nota x) segmento)
        nota))
  

(defun avalia-segmento-notas (template segmento notas &optional resultado)
  (if notas
      (let* ((nota (first notas))
             (acumula (append
                       (mapcar 
                        (lambda (x)
                          (da-nota-modificada template segmento nota x))
                        '(-1 0 1))
                       resultado)))
        (avalia-segmento-notas template segmento (rest notas) acumula))
      resultado))


(defun avalia-segmento (template segmento)
  "Gera as notas de um segmento comparado com todas as transposi��es de
   um template."
  (cons (car template)
        (avalia-segmento-notas (second template)
                               segmento
                               *notes-names*)))


;(transpoe '(0 14 69) 'c)