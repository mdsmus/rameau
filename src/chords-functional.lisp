(in-package #:rameau)

;; Define a chord that is described based in its function to the
;; tonality.

(defparameter *roman-functions* '("i" "ii" "iii" "iv" "v" "vi" "vii"))

(defparameter *inversions-template*
  '(((7)   => nil 7)
    ((6)   => 1)
    ((6 4) => 2)
    ((6 5) => 1 7)
    ((4 3) => 2 7)
    ((4 2) => 3 7))
  "The format is ((<inversion 'code'>) => <inversion number> <7 if the
  chord has a seventh>.")

(defstruct fchord
  root 7th 9th 11th 13th bass inversion mode function center)

(defun match-inversion (inversion-list)
  (nthcdr 2 (assoc (mapcar #'parse-integer (sort inversion-list #'string>))
		     *inversions-template*
		     :test #'equalp)))

(defun %parse-fchord (symbol &optional center)
  (let* ((function-string (symbol-name symbol))
	 (split-secondary (cl-ppcre:split "/" function-string))
	 (function (first split-secondary))
	 (center-function (second split-secondary)))
    (cl-ppcre:register-groups-bind (roman-function rest)
	("(iii|ii|i|iv|v|vi|vii|III|II|I|IV|V|VI|VII)(.*)?" function)
      (destructuring-bind (&optional inversion 7th)
	  (match-inversion (cl-ppcre:split "\\." rest))
	(make-fchord :root nil
		     :bass nil
		     :7th 7th
		     :inversion inversion
		     :mode (if (upper-case-p (char roman-function 0)) 'major 'minor)
		     :function (1+ (position roman-function *roman-functions* :test #'equalp))
		     :center center)))))

(defun sublist-of-centers (list)
  ;; tem um bug quando repete proxima flag imediatamente: (@a foo @a bar)
  ;; entra em loop recursivo
  (labels ((next-flag (list)
	     (iter (for item in (rest list))
		   (unless (consp item)
		     (for x = (symbol-name item))
		     (print x)
		     (if (equal #\@ (aref x 0))
			 (return x)))))
           (pos (list flag)
	     (let ((pos (position flag list :test #'equalp)))
	       (aif pos pos 0))))
    (when list
      (aif (next-flag list)
	   (let ((p (pos list it)))
	     (cons (subseq list 0 p)
		   (sublist-of-centers (nthcdr p list))))
	   (list list)))))

;; (defun parse-fchord-list (list)
;;   (let ((center (first list))
;; 	)
;; ))

(sublist-of-centers (read-file-as-sexp (concat *rameau-path* "answer-sheets/examples/001.fun") :preserve))
