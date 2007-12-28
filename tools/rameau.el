(defconst rameau-version 0)

(require 'cl)
(require 'slime)
(require 'snippet)

(defvar rameau-mode-map (make-sparse-keymap)
  "Keymap for the Redshank minor mode.")

(define-minor-mode rameau-mode
    "Minor mode for editing and refactoring (Common) Lisp code."
  :lighter " Rameau")

(defun rameau-new-test-snippet (function)
  (newline 2)
  (snippet-insert (concat "(define-test " function "\n"
                          "$>(assert-equal $${resultado} (" function " $${argumentos})$.))")))

(defun rameau-new-test-existing-file (file function)
  (find-file file)
  (beginning-of-buffer)
  (if (word-search-forward (concat "(define-test " function) nil t)
      (princ 1)
      (progn
        (goto-char (point-max))
        (rameau-new-test-snippet function))))
      
(defun rameau-new-test-new-file (file function package)
  (find-file file)
  (let ((buffer (get-buffer (buffer-name))))
    (when package
      (princ (concat "(in-package " package ")") buffer)
      (newline))
    (princ "(use-package :lisp-unit)" buffer)
    (rameau-new-test-snippet function)
    (save-buffer)))

(defun rameau-new-test ()
  (interactive)
  (let ((buffer (get-buffer (buffer-name))))
    (end-of-defun)
    (backward-char)
    (beginning-of-defun)
    (forward-whitespace 1)
    (let ((function (thing-at-point 'symbol)))
      (end-of-line)
      (newline-and-indent)
      (snippet-insert "(assert-equal $${resultado} (" function " $${argumentos}))"))))

(define-key slime-mode-map [(alt control u)] 'rameau-cria-teste-defun)
(define-key slime-mode-map [(control return)] 'rameau-new-test)

(defvar *rameau-ultimo-tipo* "")

(defun rameau-declare-value-snippet (type)
  (setf *rameau-ultimo-tipo* type)
  (snippet-insert (concat "(the " type " "))
  (forward-sexp)
  (snippet-insert ")"))

(defun rameau-declare-value ()
  (interactive)
  (let ((type (read-from-minibuffer (concat "Tipo [" *rameau-ultimo-tipo* "]: "))))
    (rameau-declare-value-snippet 
     (if (string= "" type)
         *rameau-ultimo-tipo*
         type))))

(define-key slime-mode-map [(control c) (control d) (control v)] 'rameau-declare-value)

(defun rameau-declare-snippet (ignore type values)
  (snippet-insert "(declare ")
  (unless (string= ignore "")
    (snippet-insert (concat "(ignore " ignore ")"))
    (newline-and-indent))
  (unless (string= type "")
    (snippet-insert (concat "(" type " " values ")")))
  (snippet-insert ")")
  (newline-and-indent))

(defun rameau-declare ()
  (interactive)
  (let* ((ignore (read-from-minibuffer "Ignore: "))
         (type (read-from-minibuffer "Type: "))
         (values (unless (string= type "") (read-from-minibuffer "Valores: "))))
    (rameau-declare-snippet ignore type values)))

(define-key slime-mode-map [(control c) (control d) (control e)] 'rameau-declare)

(defun rameau-get-defun-name ()
  (beginning-of-defun)
  (forward-whitespace 1)
  (thing-at-point 'symbol))

(defun rameau-test-filename ()
  (let ((file (buffer-file-name)))
    (concat (file-name-directory file)
            "test-"
            (file-name-nondirectory file))))

(defun rameau-cria-teste-defun ()
  (interactive)
  (let ((function (rameau-get-defun-name))
        (file (rameau-test-filename))
        (buffer (file-name-nondirectory (rameau-test-filename))))
    (save-excursion
      (if (search-backward "(in-package" nil t)
          (progn
            (forward-whitespace 1)
            (setq package (thing-at-point 'sexp)))
          (setq package nil))
      (if (file-exists-p file)
          (rameau-new-test-existing-file file function)
          (rameau-new-test-new-file file function package)))))

;; TODO: terminar
(defun rameau-run-test ()
  (interactive)
  (let ((test-name (rameau-get-defun-name)))
    (if (word-search-forward (concat "(define-test " function) nil t)
        (princ 1)
        (progn
          (goto-char (point-max))
          (rameau-new-test-snippet function)))))
      
(defun rameau-new-test-new-file (file function package)
  (find-file file)
  (let ((buffer (get-buffer (buffer-name))))
    (when package
      (princ (concat "(in-package " package) buffer)
      (newline))
    (princ "(use-package :lisp-unit)" buffer)
    (rameau-new-test-snippet function)
    (save-buffer)))

(defun rameau-new-test ()
  (interactive)
  (let ((buffer (get-buffer (buffer-name))))
    (end-of-defun)
    (backward-char)
    (beginning-of-defun)
    (forward-whitespace 1)
    (let ((function (thing-at-point 'symbol)))
      (end-of-line)
      (newline-and-indent)
      (snippet-insert (concat "(assert-equal $${resultado} (" function " $${argumentos}))")))))

(defun rameau-get-defun-name ()
  (beginning-of-defun)
  (forward-whitespace 1)
  (thing-at-point 'symbol))

(defun rameau-test-filename ()
  (let ((file (buffer-file-name)))
    (concat (file-name-directory file)
            "test-"
            (file-name-nondirectory file))))

(defun rameau-get-package ()
  (beginning-of-buffer)
  (if (search-forward "(in-package" nil t)
      (progn
        (forward-whitespace 1)
        (thing-at-point 'sexp))))

(defun rameau-show-test ()
  (interactive)
  (save-excursion
    (let ((function (rameau-get-defun-name))
          (file (buffer-file-name))
          (test-file (rameau-test-filename))
          (buffer (file-name-nondirectory (rameau-test-filename))))
      (if (search "test-" (buffer-file-name))
          (princ "você já está no arquivo de teste!")
          (let ((package (rameau-get-package)))
            (if (file-exists-p test-file)
                (progn
                  (find-file test-file)
                  (beginning-of-buffer)
                  (if (word-search-forward (concat "(define-test " function) nil t)
                      (progn
                        (beginning-of-defun)
                        (copy-sexp-as-kill-nomark))
                      (push "função não tem teste" kill-ring)))
                (princ "não existe arquivo de teste :-("))))
      (find-file file)
      (princ (first kill-ring)))))

(defun rameau-cria-teste-defun ()
  (interactive)
  (save-excursion
    (let ((function (rameau-get-defun-name))
          (file (rameau-test-filename))
          (buffer (file-name-nondirectory (rameau-test-filename))))
      (if (search "test-" (buffer-file-name))
          (princ "você já está no arquivo de teste!")
          (let ((package (rameau-get-package)))
            (if (file-exists-p file)
                (rameau-new-test-existing-file file function)
                (rameau-new-test-new-file file function package)))))))

;; para funcionar tem que estar in-package
(defun rameau-run-test ()
  (interactive)
  (save-excursion
    (let ((test-name (rameau-get-defun-name))
          (package (rameau-get-package)))
      (slime-eval '(cl:use-package :lisp-unit))
      (slime-eval-defun)
      (slime-switch-to-output-buffer)
      (goto-char slime-repl-input-start-mark)
      (insert (concat "(run-tests " test-name ")"))
      (slime-repl-return))))

(define-key slime-mode-map [(alt control u)] 'rameau-cria-teste-defun)
(define-key slime-mode-map [(alt control r)] 'rameau-run-test)
(define-key slime-mode-map [(alt control s)] 'rameau-show-test)
(define-key slime-mode-map [(control return)] 'rameau-new-test)

(provide 'rameau)
