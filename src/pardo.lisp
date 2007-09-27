;; Implementação do algoritmo de pardo.
(in-package #:rameau)

(deftemplates *pardo-templates* 
  ((maj) (0 4 7))
  ((maj 7) (0 4 7 10))
  ((min) (0 3 7))
  ((dim 7-) (0 3 6 9))
  ((dim 7) (0 3 6 10))
  ((dim) (0 3 6))
  )

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

(defun transpoe (template nota)
  (mapcar (lambda (x) (mod (+ x
                              (position nota *tempered-system*))
                          12))
          template))

(defun da-nota-modificada (template segmento nota)
  (cons (avalia-template (transpoe template nota) segmento)
        (cons
         (string->symbol
          (print-note nota 'lily))
         segmento)))
  

(defun avalia-segmento-notas (template segmento notas &optional resultado)
  (if notas
      (let* ((nota (first notas))
             (acumula (cons
                       (da-nota-modificada template segmento nota)
                       resultado)))
        (avalia-segmento-notas template segmento (rest notas) acumula))
      resultado))

(defun root-weight (res)
  (let* ((res (first res))
         (root-note (note->code (string (first (first (second res))))))
         (weight (assoc root-note (rest (first (second res))))))
    (or (second weight) 0)))

(defun template-prob (nota)
  (let ((template (rest (second (first nota)))))
    (length
     (member-if (lambda (x)
               (equal (car x) template))
             *pardo-templates*))))

(defun dim7? (notas)
  nil)

(defun dim7-res (template)
  (first template))

(defun desempata-pardo (notas)
  (let ((max-root (max-predicado #'root-weight notas))
        (temp-prob (max-predicado #'template-prob notas))
        (res (when (dim7? notas)
               (dim7-res notas))))
    (cond ((= (length max-root) 1)
           (caar max-root))
          ((= (length temp-prob) 1)
           (caar temp-prob))
          (t (caaar max-root)))))

(defun avalia-segmento (template segmento)
  "Gera as notas de um segmento comparado com todas as transposições de
   um template."
  (let ((resultados
          (max-predicado #'first
                         (avalia-segmento-notas (second template)
                                                segmento
                                                *tempered-system*))))
    (mapcar
     (lambda (resultado)
       (cons (first resultado)
             (cons (cons (rest resultado) (first template))
                   nil)))
     resultados)))

(defun pardo (segmento)
  (desempata-pardo
   (max-predicado #'caar
                  (mapcar
                   (lambda (x) (avalia-segmento
                                x
                                (segment-to-template segmento)))
                   *pardo-templates*))))

(defun gera-gabarito-pardo (musica)
  (mapcar (lambda (x)
            (let ((res (second (pardo x))))
              (cons (first (first res))
                    (rest res))))
          (segmentos-minimos musica)))

(defun compara-gabarito-pardo-individual (resultado gabarito)
  (let ((nota (string (first resultado)))
        (nota-certa (string (first gabarito)))
        (acorde (rest resultado))
        (acorde-certo (cons (second gabarito)
                            (rest (rest (rest gabarito))))))
    (and (equal nota nota-certa)
         (equal (mapcar #'stringify acorde) (mapcar #'stringify acorde-certo)))))

(defun compara-gabarito-pardo (resultado gabarito)
  (if
   (and (null resultado)
        (null gabarito))
   t
   (and
    (let ((res (first resultado))
          (gab (first gabarito)))
      (if (atom (first gab))
          (compara-gabarito-pardo-individual res gab)
          (some (lambda (x)
                  (compara-gabarito-pardo-individual res x))
                gabarito)))
    (compara-gabarito-pardo (rest resultado) (rest gabarito)))))
                  
(defun corrige-exemplo (exemplo &optional (metodo #'gera-gabarito-pardo))
  "Corrige e compara o resultado de um exemplo com o gabarito"
  (let ((resultado (algoritmo-pardo (file-string
                                     (concat *main-dir* "exemplos/" exemplo ".ly"))))
        (gabarito (processa-gabarito (concat *main-dir* "exemplos/" exemplo ".gab"))))
    (compara-gabarito-pardo resultado gabarito)))

(defun algoritmo-pardo (string)
  (with-system tempered
    (gera-gabarito-pardo (parse-string string))))

(with-system tempered
  (gera-gabarito-pardo
   (list (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 7 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 4 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 11 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
         (make-evento :PITCH 7 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
         (make-evento :PITCH 2 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
         (make-evento :PITCH 7 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)
         (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 1/2)
         (make-evento :PITCH 7 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
         (make-evento :PITCH 4 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
         (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 1/2))))

(mapcar #'pardo
 (segmentos-minimos
  (list
   (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0 :PASSAGEM? NIL)
   (make-evento :PITCH 7 :OCTAVE 10 :DUR 1/4 :INICIO 0 :PASSAGEM? NIL)
   (make-evento :PITCH 4 :OCTAVE 9 :DUR 1/4 :INICIO 0 :PASSAGEM? NIL)
   (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0 :PASSAGEM? NIL)
   (make-evento :PITCH 2 :OCTAVE 10 :DUR 1/4 :INICIO 1/4 :PASSAGEM? NIL)
   (make-evento :PITCH 8 :OCTAVE 10 :DUR 1/4 :INICIO 1/4 :PASSAGEM? NIL)
   (make-evento :PITCH 5 :OCTAVE 9 :DUR 1/4 :INICIO 1/4 :PASSAGEM? NIL)
   (make-evento :PITCH 11 :OCTAVE 9 :DUR 1/4 :INICIO 1/4 :PASSAGEM? NIL)
   (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 1/2 :PASSAGEM? NIL)
   (make-evento :PITCH 7 :OCTAVE 10 :DUR 1/4 :INICIO 1/2 :PASSAGEM? NIL)
   (make-evento :PITCH 4 :OCTAVE 9 :DUR 1/4 :INICIO 1/2 :PASSAGEM? NIL)
   (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 1/2 :PASSAGEM? NIL))))

