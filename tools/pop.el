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
    ("ao" "a°" nil 1)
    ("bo" "b°" nil 1)
    ("co" "c°" nil 1)
    ("do" "d°" nil 1)
    ("eo" "e°" nil 1)
    ("fo" "f°" nil 1)
    ("go" "g°" nil 1)
    ("a#o" "a#°" nil 1)
    ("b#o" "b#°" nil 1)
    ("c#o" "c#°" nil 1)
    ("d#o" "d#°" nil 1)
    ("e#o" "e#°" nil 1)
    ("f#o" "f#°" nil 1)
    ("g#o" "g#°" nil 1)
    ("abo" "ab°" nil 1)
    ("bbo" "bb°" nil 1)
    ("cbo" "cb°" nil 1)
    ("dbo" "db°" nil 1)
    ("ebo" "eb°" nil 1)
    ("fbo" "fb°" nil 1)
    ("gbo" "gb°" nil 1)
    ("aiso" "a#°" nil 1)
    ("biso" "b#°" nil 1)
    ("ciso" "c#°" nil 1)
    ("diso" "d#°" nil 1)
    ("eiso" "e#°" nil 1)
    ("fiso" "f#°" nil 1)
    ("giso" "g#°" nil 1)
    ("aeso" "ab°" nil 1)
    ("eseo" "eb°" nil 1)
    ("ceso" "cb°" nil 1)
    ("deso" "db°" nil 1)
    ("eeso" "eb°" nil 1)
    ("feso" "fb°" nil 1)
    ("geso" "gb°" nil 1)
    ("ah" "aø" nil 1)
    ("bh" "bø" nil 1)
    ("ch" "cø" nil 1)
    ("dh" "dø" nil 1)
    ("eh" "eø" nil 1)
    ("fh" "fø" nil 1)
    ("gh" "gø" nil 1)
    ("a#h" "a#ø" nil 1)
    ("b#h" "b#ø" nil 1)
    ("c#h" "c#ø" nil 1)
    ("d#h" "d#ø" nil 1)
    ("e#h" "e#ø" nil 1)
    ("f#h" "f#ø" nil 1)
    ("g#h" "g#ø" nil 1)
    ("abh" "abø" nil 1)
    ("bbh" "bbø" nil 1)
    ("cbh" "cbø" nil 1)
    ("dbh" "dbø" nil 1)
    ("ebh" "ebø" nil 1)
    ("fbh" "fbø" nil 1)
    ("gbh" "gbø" nil 1)
    ("aish" "a#ø" nil 1)
    ("bish" "b#ø" nil 1)
    ("cish" "c#ø" nil 1)
    ("dish" "d#ø" nil 1)
    ("eish" "e#ø" nil 1)
    ("fish" "f#ø" nil 1)
    ("gish" "g#ø" nil 1)
    ("aesh" "abø" nil 1)
    ("eseh" "ebø" nil 1)
    ("cesh" "cbø" nil 1)
    ("desh" "dbø" nil 1)
    ("eesh" "ebø" nil 1)
    ("fesh" "fbø" nil 1)
    ("gesh" "gbø" nil 1)
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
    ;;(modify-syntax-entry ?o ".   " st)
    ;; We add `p' so that M-c on 'hello' leads to 'Hello' rather than 'hello'.
    (modify-syntax-entry ?' "w p" st)
    st)
  "Syntax table used while in `pop-mode'.")

(defvar pop-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\e\t" 'ispell-complete-word)
    (define-key map (kbd "C-c C-c") 'pop-mel)
    (define-key map (kbd "C-c C-s") 'pop-mel-simple)
    (define-key map [tab] 'pop-forward-whitespace)
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

(defconst pop-font-lock-keywords
  (list
   '("\\[.*\\]" . font-lock-variable-name-face)
   '("\\('\\w*'\\)" . font-lock-variable-name-face))
  "Minimal highlighting expressions for pop mode")

(defun pop-forward-whitespace ()
  (interactive)
  (let ((buffer (get-buffer (buffer-name))))
    (abbrev-prefix-mark)
    (backward-delete-char-untabify 1)
    (forward-whitespace 1)))

(defun pop-mel ()
  (interactive)
  (let ((buffer (get-buffer (buffer-name)))
        (notas (read-from-minibuffer "notas melódicas: ")))
    (princ (concat "[" notas "] ") buffer)))

(defun pop-mel-simple ()
  (interactive)
  (let ((buffer (get-buffer (buffer-name))))
    (princ "[] " buffer)
    (backward-char 2)))
  


(provide 'pop)
