;; Implementação do algoritmo de pardo.


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
  "Pula as ocorrências iniciais de elemento lista"
  (if (equal elemento (first lista))
      (pula elemento (rest lista))
      lista))

(defun group-and-count (segment)
  "Agrupa as notas de mesmo pitch e conta quantas ocorrem no segmento"
  (when segment
    (let ((nota (first segment)))
      (cons (list nota (count nota segment))
            (group-and-count (pula nota segment))))))

(defun segment-to-template (segment)
  "Converte um segmento em um formato pronto para ser comparado com um template."
  (let* ((segment (mapcar #'evento-pitch segment))
         (segment (sort segment #'<)))
    (group-and-count segment)))

(defun avalia-template (template segmento)
  "Compara as notas de um template com as de um segmento e gera a nota.
   Seguindo o artigo de pardo, a nota S = P - (M + N), onde P é a soma
   dos pesos das notas existentes no segmento e no template, M é a soma
   dos pesos das notas existentes no segmento e não no template e n é o
   número de notas no template não encontradas no segmento. O valor mínimo
   é 0 - Mmax - Nmax, onde Mmax é a soma dos pesos das notas do segmento e
   Nmax é o número de notas no template. Essa função começa com esse valor
   mínimo e vai aumentando-o a cada evidência positiva."
  (let ((score (- 0
                  (reduce #'+
                          (mapcar #'second segmento))
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
  (mapcar (lambda (x) (mod (+ x
                              (note-number nota codification)
                              modificador)
                          96))
          template))

(defun da-nota-modificada (template segmento nota modificador)
  (cons (avalia-template (transpoe template nota (first modificador)) segmento)
        (intern
         (string-upcase
          (concatenate 'string (string nota) (second modificador))))))
  

(defun avalia-segmento-notas (template segmento notas &optional resultado)
  (if notas
      (let* ((nota (first notas))
             (acumula (append
                       (mapcar 
                        (lambda (x)
                          (da-nota-modificada template segmento nota x))
                        '((-1 "es") (0 "") (1 "is")))
                       resultado)))
        (avalia-segmento-notas template segmento (rest notas) acumula))
      resultado))

(defun max-par-lista (lista)
  "retorna o maior par de uma lista de pares"
  (let ((maior (first lista))
        (maior-valor (first (first lista))))
    (dolist (par lista)
      (when (> (first par) maior-valor)
            (setf maior-valor (first par))
            (setf maior par)))
    maior))


(defun avalia-segmento (template segmento)
  "Gera as notas de um segmento comparado com todas as transposições de
   um template."
  (let ((resultado (max-par-lista (avalia-segmento-notas (rest template)
                                                         segmento
                                                         *notes-names*))))
    (cons (first resultado)
          (cons (cons (rest resultado) (first template))
                nil))))

(defun pardo (segmento)
  (max-par-lista (mapcar
                  (lambda (x) (avalia-segmento
                               x
                               (segment-to-template segmento)))
                  *templates*)))

(defun gera-gabarito-pardo (musica)
  (mapcar (lambda (x) (second (pardo x))) (segmentos-minimos musica)))

(defun gabarito->sexp (file)
  "Transforma um gabarito de texto em sexp."
  (read-from-string (format nil "(~a)" (file-string file))))

(defun le-gabarito (gabarito)
  "Abre um arquivo gabarito e lê"
  (gabarito->sexp (concatenate 'string *main-dir* "exemplos/" gabarito ".gab")))

(defun corrige-exemplo (exemplo &optional (metodo #'gera-gabarito-pardo))
  "Corrige e compara o resultado de um exemplo com o gabarito"
  (let ((resultado (gera-gabarito-pardo
                    (parse-file (concatenate 'string
                                             *main-dir*
                                             "exemplos/"
                                             exemplo
                                             ".ly"))))
        (gabarito (le-gabarito exemplo)))
    (assert-equal resultado gabarito)))

(gera-gabarito-pardo
   (list (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 83 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
         (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
         (make-evento :PITCH 14 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
         (make-evento :PITCH 55 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)
         (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 1/2)
         (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
         (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
         (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)))


;(transpoe '(0 14 69) '#\d)
;(da-nota-modificada '(0 14 69) '((95  1) (13  1) (68  1)) #\c -1)
;(avalia-segmento '((maj 0) 0 14 69) '((95  1) (13  1) (68  1)))
;(pardo '((95  1) (13  1) (68  1)))
;*templates*
;(pardo '((0 1) (28 2) (55 3)))
;(corrige-exemplo "ex001")
;(parse-file "/home/top/programas/analise-harmonica/exemplos/ex001.ly")

