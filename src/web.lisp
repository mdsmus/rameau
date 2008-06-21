(defpackage :rameau-web
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :rameau-main :cl :cl-ppcre :lisp-unit :iterate :rameau-options  :genoslib :cl-who :hunchentoot :md5))

(in-package :rameau-web)

(enable-sharp-l-syntax)

(defparameter *results* (make-hash-table :test #'equal))
(setf *catch-errors-p* nil)
(defparameter *data* nil)

(defparameter *rameau-web-dir* (concat *rameau-path* "web/"))

(defmacro standard-page ((&key title) &body body)
  `(with-html-output-to-string (*standard-output* nil :prologue t :indent t)
	   (:html :xmlns "http://www.w3.org/1999/xhtml"
            :xml\:lang "en" 
            :lang "en"
            (:head 
             (:meta :http-equiv "Content-Type" 
                    :content    "text/html;charset=utf-8")
             (:title ,title)
             (:link :type "text/css" 
                    :rel "stylesheet"
                    :href "/retro.css"))
            (:body 
             ,@body))))

(defun rameau-web ()
  (standard-page (:title "Rameau")
                 (:h1 "Rameau - Automated harmonic analysis")
                 (:form :action "/analysis" :method "post"
                        (:p "Enter the lilypond code for the score")
                        (:textarea :name "lily")
                        (:input :type "submit" :value "Analyze"))))

(push (create-prefix-dispatcher "/rameau/index.htm" 'rameau-web) *dispatch-table*)

(defun make-md5 (string)
  (setf *data* string)
  (reduce #'concat
          (iter (for i in-vector (md5sum-sequence string))
                (collect (format nil "~(~x~)" i)))))



(defun do-analysis ()
  (let ((code (format nil "~a" (parameter "lily"))))
    (unless (or (null code) (zerop (length code)))
      (let* ((md5 (make-md5 code)))
        (unless (gethash md5 *results*)
          (let* ((options (make-instance 'arguments))
                 (options (progn
                            (set-algorithms (filter-algorithms '("knn")) options)
                            options))
                 (ast (get-ast-string code))
                 (notes (get-parsed-notes ast))
                 (segments (sonorities notes))
                 (full-path (concat *rameau-web-dir* md5 ".ly"))
                 (analysis (make-analysis :segments segments
                                          :results (mapcar #L(funcall (algorithm-classify !1) segments options)
                                                           (get-algorithms options))
                                          :answer-sheet nil 
                                          :file-name md5
                                          :number-algorithms (length (get-algorithms options))
                                          :notes (mapcar #'list-events segments)
                                          :ast ast
                                          :full-path full-path
                                          :dur (durations segments))))
            (setf (gethash md5 *results*)
            analysis)
            (set-png t options)
            (set-lily t options)
            (with-open-file (f full-path :direction :output :if-exists :supersede)
            (format f "~a" code))
            (analysis-lily options analysis))
          (redirect (format nil "/show-analysis?analysis=~a" md5)))))))

(push (create-prefix-dispatcher "/analysis" 'do-analysis) *dispatch-table*)

(defun list-pngs (md5)
  (iter (for file in (cl-fad:list-directory (concat *rameau-path* "analysis/")))
        (when (and (cl-ppcre:scan md5 (pathname-name file)) (cl-ppcre:scan "png" (pathname-type file)))
          (collect  file))))

(defun show-png ()
  (setf (content-type) "image/png")
  (let ((n (parse-integer (parameter "n")))
        (md5 (format nil "~a" (parameter "md5"))))
    (format t "~a" md5)
    (binary-file-string (nth n (list-pngs md5)))))

(push (create-prefix-dispatcher "/image" 'show-png) *dispatch-table*)

(defun show-analysis ()
  (let* ((md5 (format nil "~a" (parameter "analysis")))
         (anal (gethash md5 *results*)))
    (when anal
      (setf *data* (parameter "analysis"))
      (standard-page (:title "Analysis results")
        (:p (fmt "Musica ~a" md5))
        (iter (for i from 0)
              (for file in (list-pngs md5))
              (htm (:img :src (format nil "/image?md5=~a&n=~a" md5 i))))))))


(push (create-prefix-dispatcher "/show-analysis" 'show-analysis) *dispatch-table*)

(defun show-results ()
  (iter (for (k v) in-hashtable *results*)
        (format t "~a: ~a~%" k (type-of k))))

(defun start-rameau-web ()
  (start-server :port 4242))
