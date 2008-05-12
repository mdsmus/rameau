(in-package :rameau)

(enable-sharp-l-syntax)

(defun make-variable (name content)
  (concat name " = " content "

"))

(defun make-lily-list (content)
  (reduce #L(concat !1 "
" !2)
          content))

(defun make-lyrics (name)
  (format nil "\\new Lyrics \\lyricsto \"nowhere\" \\~a~%" (remove #\- name)))

(defun intervalo (s1 s2)
  "Retorna o intervalo entre dois segmentos."
  (if (null s2)
      0
      (- (event-start (first s2))
         (event-end (first s1)))))


(defun make-lily-sonorities (notes)
  (make-variable "sonorities" 
                 (concat " \\lyricmode {
 \\set Stanza = \"Sonority\""
                         (make-lily-list
                          (loop for x from 1
                             for s = notes then (rest s)
                             unless s return res
                             collect (format nil "\"~a\" " x) into res
                             unless (= 0 (intervalo (first s) (second s)))
                             collect "\" \" " into res))
                               
                         "}")))

(defun frac->dur-lily :private (dur)
  "Convert duration \\texttt{dur} to a lilypond-style duration"
  (let ((numer (numerator (abs dur)))
        (denom (denominator (abs dur))))
    (cond ((= numer 1) (format nil "~a" denom))
          ((= numer 3) (format nil "~a." (/ denom 2)))
          (t (error "duracao invalida")))))

(defun print-duracoes :private (segmento)
  (values (loop for s = segmento then (rest s)
            unless s return res
            collect (frac->dur-lily (event-dur (first (first s)))) into res
            unless (= 0 (intervalo (first s) (second s)))
            collect (frac->dur-lily (intervalo (first s) (second s))) into res)
          (when (< 0 (event-start (first (first segmento))))
            (let ((n (frac->dur-lily (abs (event-start (first (first segmento)))))))
              (if (listp n)
                  n
                  (list n))))))

(defun make-devnull-var (sonorities)
  (multiple-value-bind (durs first-rest) (print-duracoes sonorities)
        (make-variable "texto"
                       (if first-rest
                           (format nil "{~{s~a ~} ~{c~a ~}}~%~%" first-rest durs)
                           (format nil "{~{c~a ~}}~%~%" durs)))))

(defun make-devnull-voice ()
  "\\new Devnull = \"nowhere\" \\texto")

(defun print-compare-answer-sheet (analysis answer name)
  (make-variable (remove #\- name)
                 (concat " \\lyricmode {
 \\set stanza = \""
                         (substitute #\Space #\- name)
           "\"
"
           (make-lily-list
            (loop for al in analysis
               for an in answer
               collect (if (compare-answer-sheet al an)
                           (concat "\"" (format nil "~a" al) "\"")
                           (concat "\\markup { \\roman \\italic \\bold \""
                                   (format nil "~a" al)
                                   "\"}"))))
           "}
")))

(defun make-answer-sheet (answer)
  (make-variable "answer"
                 (concat "\\lyricmode {
  \\set stanza = \"Answer\" "
                         (make-lily-list (mapcar #L(format nil "\"~a\"" !1) answer))
                         "}

")))
                         


