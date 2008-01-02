(in-package :rameau)

;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun rameau-args ()
  (let ((sbcl-args #+sbcl sb-ext:*posix-argv*)
        (cmu-args #+cmu extensions:*command-line-strings*)
        (clisp-args #+clisp *args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args (1+ (position "cmurameau" cmu-args :test #'string=))))
          (clisp-args clisp-args)
          (t (error "algum problema com argumentos")))))

(defun rameau-path ()
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))

(defun rameau-profile ()
  #+sbcl(progn
         (setf sb-profile::*print-functions-not-called* nil)
         (sb-profile:profile "RAMEAU")
         (sb-profile:profile "RAMEAU-TEMPERLEY")
         (sb-profile:profile "RAMEAU-PARDO")
         (sb-profile:profile "GENOSLIB"))
  #+cmu (progn
          (profile:profile-all :package "RAMEAU")
          (profile:profile-all :package "RAMEAU-TEMPERLEY")
          (profile:profile-all :package "RAMEAU-PARDO")
          (profile:profile-all :package "GENOSLIB")))

(defun rameau-report ()
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(defun rameau-quit ()
  #+clisp(ext:exit)
  #+sbcl(quit))

(defun read-user-config ()
  (aif (cl-fad:file-exists-p (concat #+sbcl(sb-ext:posix-getenv "HOME") "/.rameaurc"))
       ;; TODO: checa se arquivo está vazio
       (with-open-file (s it)
         (read s))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *lily-dir-list*
  (aif (read-user-config)
       it
       '(("corais" "corais/")
         ("kostka" "literatura/kostka-payne/")
         ("sonatas" "literatura/beethoven-sonatas/")
         ("exemplos" "exemplos/")
         ("regressao" "regressao/")
         ("lily" "regressao-lily/")
         ("corais-include" "literatura/bach-corais/"))))

(defparameter *gabarito-dir-list*
  (aif (read-user-config)
       it
       '(("corais" "gabaritos/bach-corais/")
         ("exemplos" "gabaritos/exemplos/"))))

(defparameter *dados* '((teste ("unidade" "regressao" "lily"))
                        (analise ("corais" "kostka" "sonatas" "exemplos"))
                        (partitura ("corais"))
                        (comparatamanhos ("corais" "exemplos"))))



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
         (nome-pop (concat (rameau-path)
                           (get-item item *gabarito-dir-list* #'equal)
                           (add-pop-ext (pathname-name file)))))
    (when (cl-fad:file-exists-p nome-pop)
      (read-chords (read-file-as-sexp nome-pop)))))

(defun processa-files (item f &optional (ext ".ly"))
  (let* ((path (concat (rameau-path) (get-item item *lily-dir-list*  #'equal)))
         (file-name (format nil "~a" (first f)))
         (files (if (search ".." file-name)
                    (files-range (cl-ppcre:split "\\.\\." file-name))
                    f)))
    (if files
        (mapcar (lambda (file) (concat path file ext)) files)
        (remove-if #'(lambda (x) (search "coral" x))
                   (mapcar (lambda (file) (format nil "~a" file))
                           (directory (concat path "*" ext)))))))

