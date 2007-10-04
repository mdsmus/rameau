(require 'abbrev)

(define-abbrev-table 'pop-mode-abbrev-table '(
    ("cis" "c#" nil 1)
    ("ces" "cb" nil 1)
    ("dis" "d#" nil 1)
    ("des" "db" nil 1)
    ("eis" "e#" nil 1)
    ("ees" "eb" nil 1)
    ("fis" "f#" nil 1)
    ("fes" "fb" nil 1)
    ("gis" "g#" nil 1)
    ("ges" "gb" nil 1)
    ("ais" "a#" nil 1)
    ("aes" "ab" nil 1)
    ("bis" "b#" nil 1)
    ("bes" "bb" nil 1)
    ))

(add-hook 'pop-mode-hook (lambda () (abbrev-mode 1)))

(defcustom pop-mode-hook nil
  "Normal hook run when entering Text mode and many related modes."
  :type 'hook
  :options '(turn-on-auto-fill turn-on-flyspell)
  :group 'data)

(defvar pop-mode-variant nil
  "Non-nil if this buffer's major mode is a variant of Text mode.
Use (derived-mode-p 'pop-mode) instead.")

(defvar pop-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\" ".   " st)
    (modify-syntax-entry ?\\ ".   " st)
    (modify-syntax-entry ?/ ".   " st)
    (modify-syntax-entry ?m ".   " st)
    (modify-syntax-entry ?7 ".   " st)
    (modify-syntax-entry ?o ".   " st)
    ;; We add `p' so that M-c on 'hello' leads to 'Hello' rather than 'hello'.
    (modify-syntax-entry ?' "w p" st)
    st)
  "Syntax table used while in `pop-mode'.")

(defvar pop-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\e\t" 'ispell-complete-word)
    (define-key map (kbd "A-m") 'pop-mel)
    map)
  "Keymap for `pop-mode'.
Many other modes, such as `mail-mode', `outline-mode' and `indented-pop-mode',
inherit all the commands defined in this map.")

(define-derived-mode pop-mode nil "Pop"
  "Major mode for editing text written for humans to read.
In this mode, paragraphs are delimited only by blank or white lines.
You can thus get the full benefit of adaptive filling
 (see the variable `adaptive-fill-mode').
\\{pop-mode-map}
Turning on Text mode runs the normal hook `pop-mode-hook'."
  (make-local-variable 'pop-mode-variant)
  (setq pop-mode-variant t)
  (set (make-local-variable 'require-final-newline)
       mode-require-final-newline)
  (set (make-local-variable 'indent-line-function) 'indent-relative)
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(pop-font-lock-keywords t))) 

(defvar pop-mode-map
  (let ((pop-mode-map (make-sparse-keymap)))
    (define-key pop-mode-map "C-j" 'newline-and-indent)
    (define-key pop-mode-map "A-m" 'pop-mel)
    pop-mode-map)
  "Keymap for POP major mode")

(defconst pop-font-lock-keywords
  (list
   '("\\[.*\\]" . font-lock-variable-name-face)
   '("\\('\\w*'\\)" . font-lock-variable-name-face))
  "Minimal highlighting expressions for pop mode")

(defun pop-mel ()
  (interactive)
  (let ((buffer (get-buffer (buffer-name)))
        (notas (read-from-minibuffer "notas melódicas: ")))
    (princ (concat "[" notas "] ") buffer)))

(provide 'pop)