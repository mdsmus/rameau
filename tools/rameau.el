(defconst rameau-version 0)

(require 'cl)
(require 'slime)
(require 'snippet)

(defvar rameau-mode-map (make-sparse-keymap)
  "Keymap for the Redshank minor mode.")

(define-minor-mode rameau-mode
    "Minor mode for editing and refactoring (Common) Lisp code."
  :lighter " Rameau")

;;; find ticket
(defun rameau-find-ticket ()
  (interactive)
  (beginning-of-buffer)
  (re-search-forward "#[0-9]+")
  (search-backward "#")
  (forward-char)
  (let ((string (thing-at-point 'symbol)))
    (princ string)
    (browse-url-mozilla-new-tab (concat "http://www.genos.mus.br/bugs/ticket/" string))))

(defun rameau-email-open-link ()
  (interactive)
  (gnus-summary-select-article-buffer)
  (beginning-of-buffer)
  (re-search-forward "http://")
  (let ((string (thing-at-point 'url)))
    (princ string)
    (browse-url-mozilla-new-tab string)))

;;(define-key gnus-summary-mode-map [(alt o)] 'rameau-email-open-link)

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
      (snippet-insert "(assert-equal $${resultado} (foo $${argumentos}))"))))

(define-key slime-mode-map [(alt control u)] 'rameau-cria-teste-defun)
(define-key slime-mode-map [(alt control r)] 'rameau-run-test)
(define-key slime-mode-map [(control return)] 'rameau-new-test)

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

(defun rameau-cria-teste-defun ()
  (interactive)
  (save-excursion
    (let ((function (rameau-get-defun-name))
          (file (rameau-test-filename))
          (buffer (file-name-nondirectory (rameau-test-filename))))
      (if (search "test" file)
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

(provide 'rameau)
