(defpackage :rameau-pardo
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use #:rameau #:cl #:cl-utils #:cl-music :cl-lily)
  (:documentation "Pardo and Birmingham's algorithm for chord labeling"))

(in-package #:rameau-pardo)

(enable-sharp-l-syntax)

(deftemplates *pardo-templates* 
  (("" "") (0 4 7))
  (("" "7") (0 4 7 10))
  (("m" "") (0 3 7))
  (("°" "7-") (0 3 6 9))
  (("ø" "7") (0 3 6 10))
  (("°" "") (0 3 6))
  )

(defstruct pardo-grade
  (root)
  (result)
  (template)
  (answer)
  (sonority))

(defun group-and-count (segment)
  "Agrupa as notas de mesmo pitch e conta quantas ocorrem no sonority"
  (when segment
    (let ((nota (first segment)))
      (cons (list nota (count nota segment))
            (group-and-count (skip-initial-element nota segment))))))

(defun segment-to-template (segment)
  "Converte um sonority em um formato pronto para ser comparado com um template."
  (let* ((segment (pitches segment))
         (segment (sort segment #'<)))
    (group-and-count segment)))

(defun score-template (template sonority)
  "Compara as notas de um template com as de um sonority e gera a nota.
   Seguindo o artigo de pardo, a nota S = P - (M + N), onde P é a soma
   dos pesos das notas existentes no sonority e no template, M é a soma
   dos pesos das notas existentes no sonority e não no template e n é o
   número de notas no template não encontradas no sonority. O valor mínimo
   é 0 - Mmax - Nmax, onde Mmax é a soma dos pesos das notas do sonority e
   Nmax é o número de notas no template. Essa função começa com esse valor
   mínimo e vai aumentando-o a cada evidência positiva."
  (let ((score (- 0
                  (reduce #'+
                          (mapcar #'second sonority))
                  (length template)))
        (encontrados 0))
    (dolist (nota sonority)
      (when (member (first nota) template)
        (setf score (+ score
                       (* 2 (second nota))
                       1))
        (incf encontrados)))
    (+ score encontrados)))

(defun final-score (template sonority nota)
  (let ((note-symb (make-keyword (print-note nota :latin))))
    (make-pardo-grade :root note-symb
                      :template template
                      :result (score-template
                               (set-transpose
                                template
                                (notename->code nota))
                               sonority)
                      :sonority sonority)))

(defun score-sonority-notes (template sonority notas)
  (loop for nota in notas collect (final-score template sonority nota)))

(defun root-weight (res)
  (let* ((root-note (stringify (pardo-grade-root res)))
         (weight (assoc-item (parse-note root-note)
                             (pardo-grade-sonority res))))
    (or weight 0)))

(defun template-prob (nota)
  (let ((template (rest (pardo-grade-answer nota))))
    (length
     (member-if (lambda (x)
                  (equal (car x) template))
                *pardo-templates*))))

(defun dim7? (notas)
  (every (lambda (x)
           (equal "°" (stringify (second (pardo-grade-answer x)))))
         notas))

(defun dim7-res (sonority proximo)
  (let* ((proxima-tonica (pardo-grade-root proximo))
         (cod (module
               (+ (parse-note (stringify proxima-tonica))
                  (code->interval '(7 :maj)))))
         (nota (print-note (code->notename cod) :latin)))
    (or (find-if
         (lambda (x)
           (equal nota (stringify (pardo-grade-root x))))
         sonority)
        (first sonority))))

(defun tie-break (sonority resto)
  (let* ((proximo (first resto))
         (max-root (mostn #'root-weight sonority)))
    (cons 
     (if (= (length max-root) 1)
         (car max-root)
         (let ((temp-prob (mostn #'template-prob max-root)))
           (if (= (length temp-prob) 1)
               (car temp-prob)
               (if (dim7? sonority)
                   (dim7-res sonority proximo)
                   (car max-root)))))
     resto)))

(defun score-sonority (template sonority)
  "Gera as notas de um sonority comparado com todas as transposições de
   um template."
  (let ((results
         (mostn (lambda (x)
                  (pardo-grade-result x))
                (score-sonority-notes (second template)
                                      sonority
                                      (mapcar #'code->notename
                                              *notas-interessantes-tonal*)))))
    (dolist (r results)
      (setf (pardo-grade-answer r) (cons (stringify (pardo-grade-root r))
                                         (first template))))
    results))

(defun pardo (sonority &optional (templates *pardo-templates*))
  (mostn (lambda (x) (pardo-grade-result x))
         (reduce #'append
                 (mapcar
                  (lambda (x) (score-sonority
                               x
                               (segment-to-template sonority)))
                  templates))))

(defun augmented-sixth-template? (template)
  (let ((modo (second template)))
    (or (equal modo "al")
        (equal modo "fr")
        (equal modo "it"))))

(defun pardo->chord (pardo)
  (let ((pardo (pardo-grade-answer pardo)))
    (if (augmented-sixth-template? pardo)
        (make-augmented-sixth :type (second pardo))
        (make-chord :root (first pardo)
                    :mode (second pardo)
                    :7th (third pardo)))))

(defun pardo-classify (sonoritys &rest ignore)
  (declare (ignore ignore))
  (with-system tempered
    (mapcar #'pardo->chord
            (reduce #'tie-break (mapcar #'pardo (temperado sonoritys))
                    :from-end t :initial-value nil))))

(defclass pardo (rameau-algorithm) ())

(defmethod perform-analysis (segments options (alg pardo))
  (pardo-classify segments options alg))

(add-algorithm (make-instance 'pardo
                              :name "S-PB"
                              :description "The original algorithm
                              decribed in Pardo and Birmingham's
                              papers."))

(deftemplates *incf-pardo-templates* 
  (("" "") (0 28 55))
  (("" "7") (0 28 55 82))
  (("m" "") (0 27 55))
  (("m" "7") (0 27 55 82))
  (("°" "7-") (0 27 54 81))
  (("ø" "7") (0 27 54 82))
  (("°" "") (0 27 54))
  (("" "7+") (0 28 55 83))
  (("+" "") (0 28 56))
  (("!" "") (0 55)) 
  (("al" "") (0 28 55 70))
  (("it" "") (0 28 70))
  (("fr" "") (0 28 42 70))
  )

(defun incf-pardo (sonority)
  (pardo sonority *incf-pardo-templates*))

(defun incf-pardo-classify (sonorities &rest ignore)
  (declare (ignore ignore))
  (add-inversions
   sonorities
   (mapcar #'pardo->chord
           (reduce #'tie-break (mapcar #'incf-pardo sonorities)
                   :from-end t :initial-value nil))))

(defclass es-pardo (rameau-algorithm) ())

(defmethod perform-analysis (segments options (alg es-pardo))
  (incf-pardo-classify segments options alg))

(defmethod functional-analysis (segments options (alg es-pardo))
  (let* ((analysis (incf-pardo-classify segments options alg))
         (first-chord (first analysis))
         (root (chord-root first-chord))
         (mode (if (or (equal (chord-mode first-chord) "") (null (chord-mode first-chord)))
                   :major
                   :minor))
         (key (make-tonal-key :center-pitch (parse-note root) :mode mode)))
    (mapcar #L(rameau::chord->fchord !1 key) analysis)))

(let ((es-pb (make-instance 'es-pardo
                              :name "ES-PB"
                              :description "Our extension of Pardo and
                              Birmingham's algorithm.")))
  (add-algorithm es-pb)
  (add-falgorithm es-pb))
