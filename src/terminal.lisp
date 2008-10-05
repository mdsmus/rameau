(in-package :rameau)

(defparameter *colors*
  '(("black"       "0;30")
    ("blue"        "0;34")
    ("green"       "0;32")
    ("cyan"        "0;36")
    ("red"         "0;31")
    ("purple"      "0;35")
    ("brown"       "0;33")
    ("light gray"  "0;37")
    ("dark gray"     "1;30")
    ("light blue"    "1;34")
    ("light green"   "1;32")
    ("light cyan"    "1;36")
    ("light red"     "1;31")
    ("light purple"  "1;35")
    ("yellow"        "1;33")
    ("white"         "1;37")))

(defun print-color-terminal (result comparison options)
  "Print @var{result} on a terminal with colors."
  (let ((column (concat "~" (arg :column-chord-size options) "a"))
        (color (if comparison 21 (get-item (arg :wrong-answer-color options) *colors* #'equalp)))
        (string "~a[~am")
        (sep (arg :column-separator options)))
    (if (arg :no-color options)
        (format t (concat column sep) result)
        (progn
          (format t (concat string column) (code-char #x1b) color result)
          (format t (concat "~a[0m" sep) (code-char #x1b))))))

(defun inc-bool-list (bool-list num-list)
  "Increment each element of @var{num-list} by 1 if the corresponding
element of @var{bool-list} is true."
  (mapcar #'+ (mapcar #'(lambda (x) (if x 1 0)) bool-list) num-list))

(defun print-line-term (options number note dur &optional answer)
  "Print one line of terminal output."
  (let ((sep (arg :column-separator options)))
    (format t (concat "~&~"
                      (arg :column-number-size options)
                      "a~@[" sep "~"
                      (arg :column-notes-size options)
                      "a~]~@[" sep "~"
                      (arg :column-dur-size options)
                      "a~]~@[" sep "~"
                      (arg :column-chord-size options)
                      "a~]" sep)
            number
            (when (arg :show-notes options) note)
            (when (arg :show-dur options) dur)
            (when answer answer))))

(defun hline-size (number-algorithms options &optional no-answer)
  "The size of a horizontal line of output."
  (+ (* (parse-integer (arg :column-chord-size options)) number-algorithms)
     number-algorithms
     (1+ (parse-integer (arg :column-number-size options)))
     (if (arg :show-notes options)
         (1+ (parse-integer (arg :column-notes-size options)))
         0)
     (if no-answer
         0
         (1+ (parse-integer (arg :column-chord-size options))))
     (if (arg :show-dur options)
         (1+ (parse-integer (arg :column-dur-size options)))
         0)))

(defun print-chord-column (options text)
  "Print a column with a chord."
  (format t (concat "~" (arg :column-chord-size options) "a" (arg :column-separator options))
          text))

(defun print-footer-term (text size-line number-algorithms options)
  "Print a terminal output footer."
  (let ((footer-size (- size-line
                        (1+ (length text))
                        number-algorithms
                        (* number-algorithms (parse-integer (arg :column-chord-size options))))))
    (format t (concat "~&" text (repeat-string footer-size " ") (arg :column-separator options)) "~%")))

(defun print-hline-term (size)
  "Print a horizontal line with size @var{size}."
  (format t "~&~a" (repeat-string size "-")))
