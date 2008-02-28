;; Implementação do algoritmo de pardo.

(defpackage :rameau-pardo
  (:use #:rameau #:cl #:it.bese.arnesi))

(in-package #:rameau-pardo)

(deftemplates *pardo-templates* 
  ((nil nil) (0 4 7))
  ((nil "7") (0 4 7 10))
  (("m" nil) (0 3 7))
  (("°" "7-") (0 3 6 9))
  (("ø" "7") (0 3 6 10))
  (("°" nil) (0 3 6))
  )


(defstruct nota-pardo
  (root)
  (resultado)
  (template)
  (gabarito)
  (segmento))

(defun group-and-count (segment)
  "Agrupa as notas de mesmo pitch e conta quantas ocorrem no segmento"
  (when segment
    (let ((nota (first segment)))
      (cons (list nota (count nota segment))
            (group-and-count (pula nota segment))))))

(defun segment-to-template (segment)
  "Converte um segmento em um formato pronto para ser comparado com um template."
  (let* ((segment (pitches segment))
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

(defun da-nota-modificada (template segmento nota)
  (let ((note-symb (string->symbol (print-note nota 'latin))))
    (make-nota-pardo :root note-symb
                     :template template
                     :resultado (avalia-template
                                 (set-transpose
                                  template
                                  (inverse-code->note nota))
                                 segmento)
                     :segmento segmento)))

(defun avalia-segmento-notas (template segmento notas)
  (loop for nota in notas collect (da-nota-modificada template segmento nota)))

(defun root-weight (res)
  (let* ((root-note (stringify (nota-pardo-root res)))
         (weight (assoc-item (note->code root-note)
                             (nota-pardo-segmento res))))
    (or weight 0)))


(defun template-prob (nota)
  (let ((template (rest (nota-pardo-gabarito nota))))
    (length
     (member-if (lambda (x)
                  (equal (car x) template))
                *pardo-templates*))))

(defun dim7? (notas)
  (every (lambda (x)
           (equal "°" (stringify (second (nota-pardo-gabarito x)))))
         notas))

(defun dim7-res (segmento proximo)
  (let* ((proxima-tonica (nota-pardo-root proximo))
         (cod (module
               (+ (note->code (stringify proxima-tonica))
                  (code->interval '(7 maj)))))
         (nota (print-note (code->note cod) 'latin)))
    (or (find-if
         (lambda (x)
           (equal nota (stringify (nota-pardo-root x))))
              segmento)
        (first segmento))))

(defun desempata-pardo (segmento resto)
  (let* ((proximo (first resto))
         (max-root (max-predicado #'root-weight segmento)))
    (cons 
     (if (= (length max-root) 1)
         (car max-root)
         (let ((temp-prob (max-predicado #'template-prob max-root)))
           (if (= (length temp-prob) 1)
               (car temp-prob)
               (if (dim7? segmento)
                   (dim7-res segmento proximo)
                   (car max-root)))))
     resto)))



(defun avalia-segmento (template segmento)
  "Gera as notas de um segmento comparado com todas as transposições de
   um template."
  (let ((resultados
         (max-predicado (lambda (x)
                          (nota-pardo-resultado x))
                        (avalia-segmento-notas (second template)
                                               segmento
                                               (mapcar #'code->note *notas-interessantes-tonal*)))))
    (dolist (r resultados)
      (setf (nota-pardo-gabarito r) (cons (stringify (nota-pardo-root r))
                                          (first template))))
    resultados))

(defun pardo (segmento &optional (templates *pardo-templates*))
  (max-predicado (lambda (x) (nota-pardo-resultado x))
                 (reduce #'append
                         (mapcar
                          (lambda (x) (avalia-segmento
                                       x
                                       (segment-to-template segmento)))
                          templates))))

(defun pardo->chord (pardo)
  (let ((pardo (nota-pardo-gabarito pardo)))
    (make-chord :fundamental (first pardo)
                :mode (second pardo)
                :7th (third pardo))))

(defun gera-gabarito-pardo (segmentos)
  (with-system tempered
    (mapcar #'pardo->chord
            (reduce #'desempata-pardo (mapcar #'pardo (temperado segmentos))
                    :from-end t :initial-value nil))))
     

(register-algorithm "Simple-Pardo-Birmingham" #'gera-gabarito-pardo #'compara-gabarito-tonal)

(deftemplates *incf-pardo-templates* 
  ((nil nil) (0 28 55))
  ((nil "7") (0 28 55 82))
  (("m" nil) (0 27 55))
  (("m" "7") (0 27 55 82))
  (("°" "7-") (0 27 54 81))
  (("ø" "7") (0 27 54 82))
  (("°" nil) (0 27 54))
  ((nil "7+") (0 28 55 83))
  (("+" nil) (0 28 56))
  (("!" nil) (0 55)) 
  )

(defun incf-pardo (segmento)
  (pardo segmento *incf-pardo-templates*))

(defun gera-gabarito-incf-pardo (segmentos)
  (coloca-inversoes
   segmentos
   (mapcar #'pardo->chord
           (reduce #'desempata-pardo (mapcar #'incf-pardo segmentos)
                   :from-end t :initial-value nil))))

(register-algorithm "e-Pardo-Birmingham" #'gera-gabarito-incf-pardo #'compara-gabarito-tonal)
