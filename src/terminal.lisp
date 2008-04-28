(in-package :rameau-main)

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
  (let ((column (concat "~" (args-column-chord-size options) "a"))
        (color (if comparison 21 (get-item (args-wrong-answer-color options) *colors* #'equalp)))
        (string "~a[~am")
        (sep (args-column-separator options)))
    (if (args-no-color options)
        (format t (concat column sep) result)
        (progn
          (format t (concat string column) (code-char #x1b) color result)
          (format t (concat "~a[0m" sep) (code-char #x1b))))))

(defun inc-bool-list (bool-list num-list)
  (mapcar #'+ (mapcar #'(lambda (x) (if x 1 0)) bool-list) num-list))

(defun print-line-term (options number note dur &optional answer)
  (let ((sep (args-column-separator options)))
    (format t (concat "~&~"
                      (args-column-number-size options)
                      "a~@[" sep "~"
                      (args-column-notes-size options)
                      "a~]~@[" sep "~"
                      (args-column-dur-size options)
                      "a~]~@[" sep "~"
                      (args-column-chord-size options)
                      "a~]" sep)
            number
            (when (args-show-notes options) note)
            (when (args-show-dur options) dur)
            (when answer answer))))

(defun hline-size (number-algorithms options &optional no-answer)
  (+ (* (parse-integer (args-column-chord-size options)) number-algorithms)
     number-algorithms
     (1+ (parse-integer (args-column-number-size options)))
     (if (args-show-notes options)
         (1+ (parse-integer (args-column-notes-size options)))
         0)
     (if no-answer
         0
         (1+ (parse-integer (args-column-chord-size options))))
     (if (args-show-dur options)
         (1+ (parse-integer (args-column-dur-size options)))
         0)))

(defun print-chord-column (options text)
  (format t (concat "~" (args-column-chord-size options) "a" (args-column-separator options))
          text))

(defun print-footer-term (text size-line number-algorithms options)
  (let ((footer-size (- size-line
                        (1+ (length text))
                        number-algorithms
                        (* number-algorithms (parse-integer (args-column-chord-size options))))))
    (format t (concat "~&" text (repeat-string footer-size " ") (args-column-separator options)))))

(defun print-hline-term (size)
  (format t "~&~a" (repeat-string size "-")))

