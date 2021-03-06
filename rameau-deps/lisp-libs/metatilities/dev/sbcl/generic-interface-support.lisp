#|

Author: Gary Warren King

|#

(in-package #:metatilities)


;;; ---------------------------------------------------------------------------
;;; choose-file-question
;;; ---------------------------------------------------------------------------

(defmethod choose-file-question* ((interface (eql :SBCL)) &rest args)
  (declare (ignore args))
  (format *query-io* "E")
  (loop
    (let ((value (prompt-for 'string "nter existing file name: ")))
      (when (probe-file value)
        (return value))
      (format *query-io* "~%File '~A' cannot be found. Please e" value))))

;;; ---------------------------------------------------------------------------

(defmethod choose-new-file-question* ((interface (eql :SBCL)) &rest args)
  (declare (ignore args))
  (prompt-for 'string "Enter file name: "))

;;; ---------------------------------------------------------------------------

(defmethod choose-directory-question* ((interface (eql :SBCL)) &rest args)
  (declare (ignore args))
  (prompt-for 'string "Enter directory name: "))

;;; ---------------------------------------------------------------------------
;;; choose-item-question*
;;; ---------------------------------------------------------------------------

;;?? Gary King 2005-11-16: needs implementation
#|
(defparameter %table-cell-string-stream 
  (make-string-output-stream))

;;; ---------------------------------------------------------------------------

(defun %table-cell-contents-string-new (item print-function)
  (funcall print-function item %table-cell-string-stream)
  (get-output-stream-string %table-cell-string-stream))
  
;;; ---------------------------------------------------------------------------

(defmethod choose-item-question* ((interface (eql :SBCL)) list &rest args 
                                  &key (title "Select item:")
                                  (table-print-function #'princ) &allow-other-keys)
  (declare (ignore args))
  (loop 
    (format t "~&~A:" title)
    (loop for item in list
          for index from 0 do
          (format t "~&~2d. ~2d~%" index 
                  (%table-cell-contents-string-new item table-print-function)))
    (format t "~&Enter a number (-1 to cancel): ")
    (let ((num (parse-integer (princ-to-string (read)) :junk-allowed t)))
      (cond ((not (numberp num))
             (format t "~&Please enter a number.~%"))
            ((minusp num)
             (return :cancel))
            ((>= num (length list))
             (format t "~&Please enter a number between 0 and than ~d.~%" 
                     (1- (length list))))
            (t
             (return (list (nth num list))))))))
|#


;;; ---------------------------------------------------------------------------
;;; inspect-thing
;;; ---------------------------------------------------------------------------

(defmethod inspect-thing* ((interface (eql :SBCL)) thing &rest args)
  (declare (ignore args))
  (cl-user::inspect thing))


;;; ***************************************************************************
;;; *                              End of File                                *
;;; ***************************************************************************
  