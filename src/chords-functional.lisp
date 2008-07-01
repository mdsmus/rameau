(in-package #:rameau)

;; Define a chord that is described based in its function to the
;; tonality.

(defparameter *roman-functions* '("i" "ii" "iii" "iv" "v" "vi" "vii"))

(defstruct fchord
  root 7th 9th 11th 13th bass inversion mode function center)

(defun parse-fchord (symbol &optional center)
  (let* ((function-string (symbol-name symbol))
	 (split-secondary (cl-ppcre:split "/" function-string))
	 (function (first split-secondary))
	 (center-function (second split-secondary)))
    (cl-ppcre:register-groups-bind (roman-function rest)
	("(iii|ii|i|iv|v|vi|vii|III|II|I|IV|V|VI|VII)(.*)?" function)
      (list roman-function (cl-ppcre:split "\\." rest) center-function))
))

(parse-fchord '|V7|)
(parse-fchord '|V7+|)
(parse-fchord '|V4+|)
(parse-fchord '|V6.5|)
(parse-fchord '|ii6.5|)
(parse-fchord '|V4.3/V|)

;;;    (make-fchord :root nil
;;; 		:bass nil
;;; 		:inversion nil
;;; 		:mode (if (upper-case-p (character fchord)) 'major 'minor)
;;; 		:function (1+ (position fchord *roman-functions* :test #'equalp))
;;; 		:center center)
;;(parse-fchord "I" "c")
;; bVII, bI

;;(read-file-as-sexp (concat *rameau-path* "answer-sheets/examples/001.fun") :preserve)