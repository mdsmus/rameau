(defconst rameau-version 0)

(require 'cl)
(require 'slime)
(require 'yasnippet)

(defvar rameau-mode-map (make-sparse-keymap)
  "Keymap for the rameau minor mode.")

(define-minor-mode rameau-mode
    "Minor mode for editing and refactoring (Common) Lisp code."
  :lighter " Rameau")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Declaration

(defvar *rameau-ultimo-tipo* "")

(defun rameau-declare-value-snippet (type)
  (setf *rameau-ultimo-tipo* type)
  (insert-snippet (concat "(the " type " "))
  (forward-sexp)
  (insert-snippet ")"))

(defun rameau-declare-value ()
  (interactive)
  (let ((type (read-from-minibuffer (concat "Tipo [" *rameau-ultimo-tipo* "]: "))))
    (rameau-declare-value-snippet 
     (if (string= "" type)
         *rameau-ultimo-tipo*
         type))))

(defun rameau-declare-snippet (ignore type values)
  (insert-snippet "(declare ")
  (unless (string= ignore "")
    (insert-snippet (concat "(ignore " ignore ")"))
    (newline-and-indent))
  (unless (string= type "")
    (insert-snippet (concat "(" type " " values ")")))
  (insert-snippet ")")
  (newline-and-indent))

(defun rameau-declare ()
  (interactive)
  (let* ((ignore (read-from-minibuffer "Ignore: "))
         (type (read-from-minibuffer "Type: "))
         (values (unless (string= type "") (read-from-minibuffer "Valores: "))))
    (rameau-declare-snippet ignore type values)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tests

(defun insert-snippet (snippet)
  (yas/expand-snippet (point) (point) snippet))

(defun rameau-new-test-snippet (name)
  (newline 1)
  (insert-snippet (concat "(test "
                          name
                          "\n$>(is (${compare} ${result} ("
                          name
                          " ${args})))$0)\n")))

(defun rameau-new-test-existing-file (file function)
  (find-file file)
  (goto-char (point-min)) ; beginning-of-buffer
  (if (word-search-forward (concat "(test " function) nil t)
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
      (insert-snippet (concat "(is (${compara} ${resultado} ("
                              function
                              " ${argumentos})))")))))

(defun rameau-get-defun-name ()
  (beginning-of-defun)
  (forward-whitespace 1)
  (slime-symbol-name-at-point))

(defun rameau-test-filename ()
  (let ((file (buffer-file-name)))
    (concat (file-name-directory file)
            "tests/"
            (file-name-nondirectory file))))

(defun rameau-show-test ()
  (interactive)
  (save-excursion
    (let ((function (rameau-get-defun-name))
          (file (buffer-file-name))
          (test-file (rameau-test-filename))
          (buffer (file-name-nondirectory (rameau-test-filename))))
      (if (search "tests" (buffer-file-name))
          (princ "você já está no arquivo de teste!")
          (let ((package (slime-find-buffer-package)))
            (if (file-exists-p test-file)
                (progn
                  (find-file test-file)
                  (goto-char (point-min)) ;; beginning-of-buffer
                  (if (word-search-forward (concat "(test " function) nil t)
                      (progn
                        (beginning-of-defun)
                        (copy-sexp))
                      (push "função não tem teste" kill-ring)))
                (princ "não existe arquivo de teste :-("))))
      (find-file file)
      (princ (first kill-ring)))))

(defun copy-sexp ()
  "Copy the sexp under the cursor to the kill ring."
  (interactive)
  (save-excursion
    (let ((start (point)))
      (forward-sexp 1)
      (kill-ring-save start (point))
      (message (buffer-substring start (point))))))

(defun rameau-cria-teste-defun ()
  (interactive)
  (save-excursion
    (let ((function (rameau-get-defun-name))
          (file (rameau-test-filename))
          (buffer (file-name-nondirectory (rameau-test-filename))))
      (if (search "tests" (buffer-file-name))
          (princ "você já está no arquivo de teste!")
          (let ((package (slime-find-buffer-package)))
            (if (file-exists-p file)
                (rameau-new-test-existing-file file function)
                (rameau-new-test-new-file file function package)))))))

(defun rameau-run-test ()
  (interactive)
  (save-excursion
    (let ((test-name (rameau-get-defun-name))
          (package (slime-find-buffer-package)))
      (slime-switch-to-output-buffer)
      (slime-repl-send-string (format "(5am:run! '%s::%s)"
                                      (substring package 2)
                                      test-name)))))

(defun rameau-run-all-tests ()
  (interactive)
  (save-excursion
    (slime-switch-to-output-buffer)
    (slime-repl-send-string "(rameau:main \"test\")")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tickets

(defun open-ticket (ticket-number)
  (browse-url (concat "http://bugs.genos.mus.br/issues/show/" ticket-number)))

(defun rameau-ticket ()
  (interactive)
  (open-ticket (read-from-minibuffer "Ticket #:")))

(defun rameau-find-ticket ()
  (interactive)
  (search-forward "#")
  (open-ticket (thing-at-point 'word)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; keys

(define-key slime-mode-map [(control c) (control d) (control e)] 'rameau-declare)
(define-key slime-mode-map [(control c) (control d) (control v)] 'rameau-declare-value)
(define-key slime-mode-map [(alt control u)] 'rameau-cria-teste-defun)
(define-key slime-mode-map [(alt control r)] 'rameau-run-test)
(define-key slime-mode-map [(alt control a)] 'rameau-run-all-tests)
(define-key slime-mode-map [(alt control s)] 'rameau-show-test)
(define-key slime-mode-map [(control return)] 'rameau-new-test)

(provide 'rameau)
