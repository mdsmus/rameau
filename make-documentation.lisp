(defun clean-up (string)
  (cl-ppcre:regex-replace-all "#" string "$\\sharp$"))

(with-open-file (stream "/home/kroger/src/rameau/docs/musiclib.tex" :direction :output :if-exists :supersede)
  (let ((functions '(get-notes get-system-module get-module
                     get-system-intervals get-accidentals get-sharp
                     get-flat get-interval-name get-interval-quantity
                     )))
    (loop for function in functions do
         (format stream "\\function{~(~a~)}" function)
         (format stream "{~a}~%~%" (clean-up (documentation function 'function))))))