;;(add-to-list 'load-path "~/emacs/elisp/slime/")
;;(add-to-list 'load-path "~/src/rameau/tools")

;;(require 'slime)
(require 'gnus-art)

(setq indent-tabs-mode nil
      lisp-simple-loop-indentation 1
      lisp-loop-keyword-indentation 6
      lisp-loop-forms-indentation 6
      lisp-indent-function 'common-lisp-indent-function)

(defun clean-blank-lines ()
  (interactive)
  ;; twice because delete-blank-lines may leave a blank line
  (beginning-of-line)
  (delete-blank-lines)
  (beginning-of-line)
  (delete-blank-lines)
  (progn
    (article-remove-trailing-blank-lines)
    (article-strip-blank-lines)
    (article-strip-leading-blank-lines)
    (article-strip-multiple-blank-lines)))

(defun untabify-and-indent ()
  (interactive)
  (beginning-of-line)
  (untabify (point-min) (point-max))
  (mark-whole-buffer)
  (indent-region (point-min) (point-max)))

(defun rameau-style ()
  (interactive)
  (progn
    (clean-blank-lines)
    (untabify-and-indent)
    (save-buffer)))