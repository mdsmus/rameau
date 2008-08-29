(defpackage :kern2lily
  (:import-from #:arnesi "AIF" "IT" "LAST1")
  (:use #:cl #:rameau))

(in-package #:kern2lily)

;;(defparameter file "/home/kroger/src/rameau/literatura/bach-violin-partitas/partita-2-4.krn")
(defparameter file "/home/kroger/src/rameau/literatura/bach-violin-partitas/partita-3-6.krn")
;;(defparameter file "/home/kroger/src/rameau/literatura/bach-violin-partitas/partita-3-7.krn")

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

(defun kern-to-list (string d)
  (cl-ppcre:register-groups-bind (dur note acc) ("([0-9.]+)([abcdefgABCDEFG]+)(-|#)?" string)
    (values
     (format nil "~(~a~)~@[~a~]~@[~a~]~@[~a~]"
             (subseq note 0 1)
             (cl-ppcre:regex-replace-all "#" (cl-ppcre:regex-replace-all "-" acc "es") "is")
             (oitava note)
             (unless (equal dur d) dur))
     dur)))

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
        ((= (length string) 1) "")
        ((string= (subseq string 1 2) "k") (format nil "\\key ~(~a~) \\major" (processa-armadura string)))
        ((and (search "M" string) (not (search "MM" string))) (concat "\\time " (subseq string 2)))
        (t "")))

;; por enquanto ignora sinais de repetição
(defun gera-lily ()
  (with-open-file (stream "/tmp/da.ly" :direction :output :if-exists :supersede)
    (format stream "{~%")
    (let (primeiro-compasso dur)
      (loop
            for x in (read-kern-file file)
            for s = (char x 0) do
            (cond ((equal s #\*) (format stream "~a ~%" (processa-asterisco x)))
                  ((or (equal x "=1") (equal x "=1-"))
                   (setf primeiro-compasso t))
                  ((equal s #\=) (format stream "~%"))
                  (t (if primeiro-compasso
                         (multiple-value-bind (s d) (kern-to-list x dur)
                           (format stream "~a " s)
                           (setf dur d))
                         (multiple-value-bind (s d) (kern-to-list x dur)
                           (format stream "\\partial ~a ~a~%" d s)))))))
    (format stream "}~%") ))
;; =:|!|:
;; ==:|!
;; *-
