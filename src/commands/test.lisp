(in-package :rameau)

;;; the functions in this file are defined with cl:defun because
;;; rameau-test must use cl:defun and cl:defmacro

;;; Tests
(defun print-condition (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun print-ok/no-list (list options)
  (destructuring-bind (ok no) list
    (let* ((s2 (length no))
           (no-string
            (cond ((zerop (arg :max-print-error options)) no)
                  ((> s2 (arg :max-print-error options))
                   (format nil
                           "~a ..."
                           (subseq no 0 (arg :max-print-error options))))
                  (t no))))
      (format t "  [OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) s2 no-string))))

(defun parse-verbose (files)
  (dolist (file files)
    (handler-case (parse-file file)
      (serious-condition (expr) (print-condition 'no file expr))
      (:no-error (&rest rest) (print-condition 'ok file rest)))))

(defun parse-summary (files)
  (let (ok no)
    (dolist (file files)
      (handler-case (parse-file file)
        (serious-condition (expr)
          (declare (ignore expr))
          (push (pathname-name file) no))
        (:no-error (&rest rest)
          (declare (ignore rest))
          (push (pathname-name file) ok))))
    (list (reverse ok) (reverse no))))

(defun regression (options)
  (if (arg :verbose options)
      (parse-verbose (arg :files options))
      (print-ok/no-list (parse-summary (arg :files options)) options)))

(defun unit (options)
  (let* ((args (arg :unit options))
         (arguments (if (and (equal args '("all"))
                             (arg :verbose options))
                        '(all)
                        args)))
    (iter (for test1 in arguments)
          (for test-name = (intern (string-upcase test1) :rameau-test))
          (format t "TEST: ~a~%" test-name)
          (fiveam:run! test-name))))

(defun rameau-test (options)
  ;; This function can't be named 'test' in order not to conflict with
  ;; the function in fiveAM.
  (when (arg :unit options) (unit options))
  (when (arg :regression options) (regression options)))

(register-command :name "test"
                  :action #'rameau-test
                  :options '(("-u" "unit" "run the unit tests" ("all") type-list)
                             ("-r" "regression" ""))
                  :documentation "Run unit and regression tests.")
