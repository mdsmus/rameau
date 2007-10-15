(in-package #:rameau)

(defparameter file "/home/kroger/doc/pesquisa/analise-harmonica/literatura/bach-violin-partitas/partita-2-4.krn")

(defun read-kern-file (file)
  (with-open-file (f file :direction :input)
    (loop for line = (read-line f nil)
       while line append
         (if (plusp (length line))
             (unless (char-equal (char line 0) #\!)
               (cl-ppcre:split #\Tab line))))))

(defun delete-all (itens string)
  (if (null itens)
      string
      (delete-all (rest itens)
                  (delete (first itens) string))))

(defun clean-kern-list (string)
  (delete-all '(#\[ #\] #\\ #\( #\) #\L #\J #\/) string))

(defun kern-to-list (string)
  (cl-ppcre:register-groups-bind (dur note acc) ("([0-9.]+)([abcdefgABCDEFG]+)(-|#)?" string)
    (format nil "~(~a~)~@[~a~]~@[~a~]~a" (subseq note 0 1)
            (cl-ppcre:regex-replace-all "#" (cl-ppcre:regex-replace-all "-" acc "es") "is")
            (oitava note) dur)))

(defun oitava (string)
  (let* ((char (char string 0))
         (n (count char string))
         (numbers (if (lower-case-p char) n (1- n)))
         (oct (if (lower-case-p char) "'" ",")))
    (repeat-string numbers oct)))

(defun processa-armadura (string)
  (cond ((search "-" string) (nth (count #\- string) *armadura-*))
        ((search "#" string) (nth (count #\# string) *armadura#*))))

(defparameter *armadura-* '(c f bes ees aes des ges ces))
(defparameter *armadura#* '(c g d a e b fis cis gis))

(defun processa-asterisco (string)
  (cond ((search "clefG" string) "\\clef violin")
        ((search "clefC" string) "\\clef alto")
        ((search "clefF" string) "\\clef bass")
        ((string= (subseq string 1 2) "k") (format nil "\\key ~(~a~) \\major" (processa-armadura string)))
        ((and (search "M" string) (not (search "MM" string))) (concat "\\time " (subseq string 2)))
        (t "")))

(defun gera-lily ()
  (with-open-file (stream "/tmp/da.ly" :direction :output :if-exists :supersede)
    (format stream "{~%")
    (loop for x in (read-kern-file file) do
         (let ((s (subseq x 0 1)))
           (cond ((string= s "*") (format stream "~a~%" (processa-asterisco x)))
                 ((string= s "=") 'foo)
                 (t (format stream "~a " (kern-to-list x))))))
    (format stream "}~%")))
