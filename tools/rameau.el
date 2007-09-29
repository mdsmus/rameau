(defconst rameau-version 0)

(require 'cl)
(require 'slime)
(require 'skeleton)

(defvar rameau-mode-map (make-sparse-keymap)
  "Keymap for the Redshank minor mode.")

(define-minor-mode rameau-mode
  "Minor mode for editing and refactoring (Common) Lisp code."
  :lighter " Rameau")

(define-skeleton lisp-unit-skeleton
    "Insere um esqueleto para uma nova unidade de teste."
  nil
  \n >
  "(define-test foo"
  \n >
  "(assert-equal "_" (foo "_ ")))")

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

;;; cria teste lisp
(defun rameau-new-test-existing-file (file function)
  ;; procura por teste function
  ;; se nao existir new-test-new-file
  (rameau-new-test-new-file file))

(defun rameau-new-test-new-file (file function package)
  (find-file file)
  (let ((buffer (get-buffer (buffer-name))))
    (princ (concat "(in-package " package) buffer)
    (newline)
    (princ "(use-package #:lisp-unit)" buffer)
    (newline 2)
    (snippet-insert "(define-test foo
    (assert-equal $${resultado} (foo $${argumentos})))")))

;;     (princ (concat "(define-test " function) buffer)
;;     (newline-and-indent)
;;     (princ (concat "(assert-equal  (" function " _)))") buffer)
;;     (search-backward "-equal")
;;     (forward-char 7)))

(defun rameau-next-par ()
  (interactive)
  (search-forward "_")
  (backward-delete-char 1))

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

;;       (princ (concat "(assert-equal  (" function " _))") buffer)
;;       (search-backward "-equal")
;;       (forward-char 7))))

(define-key slime-mode-map [(alt control u)] 'rameau-cria-teste-defun)
(define-key slime-mode-map [(control tab)] 'rameau-next-par)
(define-key slime-mode-map [(control return)] 'rameau-new-test)

(defun rameau-cria-teste-defun ()
  (interactive)
  (beginning-of-defun)
  (forward-whitespace 1)
  (let* ((function (thing-at-point 'symbol))
         (all-file (buffer-file-name))
         (dir (file-name-directory all-file))
         (file (file-name-nondirectory all-file))
         (rameau-test-file (concat dir "test-" file)))
    (search-backward "(in-package")
    (forward-whitespace 1)
    (let ((package (thing-at-point 'sexp)))
      (if (file-exists-p rameau-test-file)
          (rameau-new-test-existing-file rameau-test-file function)
          (rameau-new-test-new-file rameau-test-file function package)))))

;; cria fuinção find-test
;; cria-função goto-test
;; cria função run-test

(defun rameau-mel ()
  (interactive)
  (let ((buffer (get-buffer (buffer-name)))
        (notas (read-from-minibuffer "notas melódicas: ")))
    (princ (concat "[" notas "] ") buffer)))

(global-set-key [(alt m)] 'mel)

(provide 'rameau)
