(in-package :rameau)

;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *rameau-path*
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
		       #+cmu (first (ext:search-list "default:"))
		       #+clisp (ext:default-directory))))

(defun rameau-args ()
  (let ((sbcl-args #+sbcl sb-ext:*posix-argv*)
        (cmu-args #+cmu extensions:*command-line-strings*)
        (clisp-args #+clisp *args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args (1+ (position "cmurameau" cmu-args :test #'string=))))
          (clisp-args clisp-args)
          (t (error "algum problema com argumentos")))))
  
(defun rameau-profile ()
  #+sbcl(progn
         (setf sb-profile::*print-functions-not-called* nil)
         (sb-profile:profile "RAMEAU")
         (sb-profile:profile "RAMEAU-PARDO")
         (sb-profile:profile "RAMEAU-KNN")
         (sb-profile:profile "GENOSLIB"))
  #+cmu (progn
          (profile:profile-all :package "RAMEAU")
          (profile:profile-all :package "RAMEAU-PARDO")
          (profile:profile-all :package "RAMEAU-KNN")
          (profile:profile-all :package "GENOSLIB")))

(defun rameau-report ()
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(defun rameau-quit ()
  #+clisp(ext:exit)
  #+sbcl(quit))

(defun getenv (string)
  #+sbcl(sb-ext:posix-getenv string)
  #+cmu(cdr (assoc (intern string :keyword) ext:*environment-list*))
  #+clisp(ext:getenv string))

(defun remove-comma-if-needed (text)
  (if (= 1 (count-subseq "pt" (getenv "LANG")))
      (substitute #\, #\. text)
      text))
  
(defun unicode-term (f)
  (or (null f)
      (eq (stream-external-format f) nil)
      (eq (stream-external-format f) #+sbcl :utf-8 #-sbcl :default)))

(defun read-user-config ()
  (aif (cl-fad:file-exists-p (concat (getenv "HOME") "/.rameaurc"))
       (loop for (var value) in (read-file-as-sexp it) do (set var value))))

(read-user-config)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *lily-dir-list*
  '(("corais" "corais/")
    ("kostka" "literatura/kostka-payne/")
    ("sonatas" "literatura/beethoven-sonatas/")
    ("exemplos" "exemplos/")
    ("regressao" "regressao/")
    ("lily" "regressao-lily/")
    ("corais-include" "literatura/bach-corais/")
    ("exemplos-include" "literatura/exemplos/")))

(defparameter *gabarito-dir-list*
  '(("corais" "gabaritos/bach-corais/")
    ("exemplos" "gabaritos/exemplos/")))


(defun files-range (list)
  (loop for x from (parse-integer (first list)) to (parse-integer (second list))
     collect (cond ((< x 10)  (format nil "00~a" x))
                   ((< x 100) (format nil "0~a" x))
                   (t (format nil "~a" x)))))

(defun first-string (string list)
  (let ((tmp (loop for s in list do
                  (if (string= (subseq s 0 1) string)
                      (return s)))))
    (if tmp tmp string)))

(defun processa-gabarito (file item)
  "Transforma um gabarito de texto em sexp."
  (let* ((*package* (find-package :rameau))
         (nome-pop (concat *rameau-path*
                           (get-item item *gabarito-dir-list* #'equal)
                           (add-pop-ext (pathname-name file)))))
    (when (cl-fad:file-exists-p nome-pop)
      (read-chords (read-file-as-sexp nome-pop)))))

(defun processa-files (item f &optional (ext ".ly"))
  (let* ((path (concat *rameau-path* (get-item item *lily-dir-list*  #'equal)))
         (file-name (format nil "~a" (first f)))
         (files (if (search ".." file-name)
                    (files-range (cl-ppcre:split "\\.\\." file-name))
                    f)))
    (if files
        (mapcar (lambda (file) (concat path file ext)) files)
        (remove-if #'(lambda (x) (search "coral" x))
                   (mapcar (lambda (file) (format nil "~a" file))
                           (directory (concat path "*" ext)))))))

(defparameter *exemplos-de-treinamento*
  (nconc (loop for f in (nconc (processa-files "corais" '("1..6"))
                               (processa-files "corais" '("162")))
            for g = (processa-gabarito f "corais")
            collect (list (segmentos-minimos (parse-file f)) g))
         (loop for f in (nconc (processa-files "exemplos" '("023"))
                               (processa-files "exemplos" '("024"))
                               (processa-files "exemplos" '("025")))
            for g = (processa-gabarito f "exemplos")
            collect (list (segmentos-minimos (parse-file f)) g))))

(defun current-git-branch ()
  "Diz o branch atual no git, útil pra poder guardar redes separadas para branches separados."
  (if (cl-fad:file-exists-p (concat *rameau-path* ".git/head-name"))
      (let ((a (file-string (concat *rameau-path* ".git/head-name"))))
        (subseq a 0 (1- (length a))))
      ""))

(defun extrai-feature-list (segmento diff)
  (let ((segmento (mapcar2 (lambda (x) (module (- x diff))) #'evento-pitch segmento))
        (n (length segmento))
        (feature-list (repeat-list (get-module) 0)))
    (loop for nota in segmento
       do (incf (nth nota feature-list) (/ 1 n)))
    feature-list))

(defun extrai-diff (segmento)
  (let ((segmento (sorted segmento #'compara-notas)))
    (evento-pitch (first segmento))))

