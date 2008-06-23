(defpackage :rameau-web
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :rameau-options :cl :cl-ppcre :lisp-unit :iterate :rameau-options  :genoslib :cl-who :hunchentoot :md5 :rameau-lily))

(in-package :rameau-web)


(enable-sharp-l-syntax)

(defparameter *results* (make-hash-table :test #'equal))
(setf *catch-errors-p* nil)
(defparameter *data* nil)

(defparameter *rameau-web-dir* (concat *rameau-path* "web/"))

(defmacro standard-page ((&key title) &body body)
  `(with-html-output-to-string (*standard-output* nil :prologue t :indent t)
	   (:html :xmlns "http://www.w3.org/1999/xhtml"
            :xml\:lang "en" 
            :lang "en"
            (:head 
             (:meta :http-equiv "Content-Type" 
                    :content    "text/html;charset=utf-8")
             (:title ,title)
             (:script :type "text/javascript" "

function show_algorithms() {
 var alg = document.getElementById('algorithms')
 if (alg.style.display == \"none\")
   alg.style.display = \"block\";
 else
   alg.style.display = \"none\";
}

function habilita_text() {
 document.getElementById('lily').disabled = false;
 document.getElementById('chorale').disabled = true;
}

function habilita_chor() {
 document.getElementById('lily').disabled = true;
 document.getElementById('chorale').disabled = false;
}

function toggle_visible(el) {
 if (el.style.display == \"block\")
   el.style.display = \"none\";
 else
   el.style.display = \"block\";
}
")
             (:style :type "text/css"
                     "
h1 {
 color: #228822;
 font-weight: bold;
 text-decoration: none; 
}

h2 {
 color: #222288;
 font-weight: normal;
 font-size: 10pt;
}

a {
 color: #223399;
 text-decoration: none;
}

a.hover {
 color: #229922;
}

ul {
 padding-left: 0.5em; 
}

li {
 list-style-type: none;
 color: #223399;
}

body {
 font-family: sans-serif;
}

textarea {
 font-family: mono;
 font-size: 10pt;
 width: 70%;
 height: 20em;
}

textarea.inv {
 display:none;
}

div.algorithms {
 background: #aaccdd;
 width: 20em;
 float:center;
 border: medium dotted #000000;
 display: none;
}

div.nav {
 background: #aaaaaa;
 padding-left: 1em;
 border: medium dotted #000000;
 height: 100%;
 width: 120pt;
}

div.content {
 margin-left: 120pt;
}

"))
            (:body
             (:div :id "title" :align "center"
                   (:p (:h1 "Rameau - Automated Harmonic Analysis")))
             (:div :id "main"
                   (:div :id "nav" :style "float: left" :class "nav"
                         (:p (:i (:h1 "Rameau")))
                         (:p (:h2 (:a :href "/rameau/index.htm" "Rameau Web Home")))
                         (:p (:h2 "Genos"))
                         (:ul (:li (:a :href "http://wiki.genos.mus.br" "Genos wiki"))
                              (:li (:a :href "http://bugs.genos.mus.br" "Genos bugs"))
                              (:li (:a :href "http://git.genos.mus.br" "Genos git"))))
                   (:div :id "content" :class "content" ,@body))))))

(defun an-form (text)
  (with-html-output-to-string (*standard-output* nil :prologue t :indent t)
    (:form :action "/analysis" :method "post"
           (:center
            
            (:p (:input :type "radio" :name "escolha" :value "textbox" :onchange "habilita_text()" :checked "")
                (:label :for "escolha-1"
                        "Enter the lilypond code for the score..."))
            (:div :id "coral"
                  (:textarea :name "lily" :id "lily"
                             (fmt "~a" text)))
           (:center
            (:p (:input :type "radio" :name "escolha" :value "chor" :onchange "habilita_chor()")
                (:label :for "escolha-2" "...or choose one of Bach's 371 Chorales"))
            (:select :name "chorale" :disabled "" :id "chorale"
                     (iter (for f in (parse-file-name "chor:1..371" (make-instance 'arguments)))
                           (let ((name (pathname-name f)))
                             (htm (:option :value name (fmt "~a" name))))))
            (:div :id "submit"
                  (:input :type "submit" :value "Analyze")))
            (:a :href "javascript:void(0)" :onClick "show_algorithms();"
                "Choose Algorithms")
            (:div :align "left" :id "algorithms" :class "algorithms"
                  (iter (for alg in (filter-algorithms nil))
                        (htm (:p (:input :type "checkbox" :checked "true"
                                         :name (algorithm-name alg)
                                         :id (algorithm-name alg))
                                 (:label :for (algorithm-name alg) (fmt "~a" (algorithm-name alg)))))))
            ))))


(defun rameau-web ()
  (standard-page (:title "Rameau")
    (fmt "~a"(an-form "
\\score {
  {
    % Welcome to rameau web.
    <c e g> <d a f> <g b d> <c e g> % Your music here
  }
 \\layout {}
 \\midi {}
}

"))))

(push (create-prefix-dispatcher "/rameau/index.htm" 'rameau-web) *dispatch-table*)

(defun make-md5 (string)
  (setf *data* string)
  (reduce #'concat
          (iter (for i in-vector (md5sum-sequence string))
                (collect (format nil "~(~x~)" i)))))

(defun get-params-alg ()
  (iter (for alg in (filter-algorithms nil))
        (when (parameter (algorithm-name alg))
          (collect alg))))

(defun get-chorale-string (n)
  (cond ((< 0 n 10) (format nil "00~a" n))
        ((< n 100) (format nil "0~a" n))
        (t (format nil "~a" n))))

(defun get-params-code ()
  (aif (parameter "lily")
       (format nil "~a" it)
       (awhen (parameter "chorale")
         (let* ((n (or (parse-integer it :junk-allowed t) 1))
                (c (get-chorale-string n)))
           (file-string (concat *rameau-path* "music/chorales-bach/" c ".ly"))))))

(defun grab-possible-answer-sheet ()
  (awhen (parse-integer (or (parameter "chorale") ""):junk-allowed t)
    (new-parse-answer-sheet (get-chorale-string it) "chor")))

(defun do-analysis ()
  (let ((code (get-params-code)))
    (unless (or (null code) (zerop (length code)))
      (let* ((md5 (make-md5 code)))
        (unless (gethash md5 *results*)
          (let* ((options (make-instance 'arguments))
                 (options (progn
                            (default-arguments options)
                            (set-algorithms (get-params-alg) options)
                            options))
                 (ast (get-ast-string code))
                 (notes (get-parsed-notes ast))
                 (segments (sonorities notes))
                 (full-path (concat *rameau-web-dir* md5 ".ly"))
                 (analysis (make-analysis :segments segments
                                          :results (mapcar #L(funcall (algorithm-classify !1) segments options)
                                                           (get-algorithms options))
                                          :answer-sheet (grab-possible-answer-sheet)
                                          :file-name md5
                                          :number-algorithms (length (get-algorithms options))
                                          :algorithms (get-algorithms options)
                                          :notes (mapcar #'list-events segments)
                                          :ast ast
                                          :full-path full-path
                                          :dur (durations segments))))
            (setf (gethash md5 *results*)
                  analysis)
            (set-png t options)
            (set-lily t options)
            (with-open-file (f full-path :direction :output :if-exists :supersede)
              (format f "~a" code))
            (analysis-lily options analysis)))
        (redirect (format nil "/show-analysis?analysis=~a&chorale=~a" md5 (or (parameter "chorale") "")))))))

(push (create-prefix-dispatcher "/analysis" 'do-analysis) *dispatch-table*)

(defun list-pngs (md5)
  (iter (for file in (cl-fad:list-directory (concat *rameau-path* "analysis/")))
        (when (and (/= 0 (count-subseq md5 (pathname-name file)))
                   (/= 0 (count-subseq "png" (pathname-type file))))
          (collect  file))))

(defun show-png ()
  (setf (content-type) "image/png")
  (let ((n (parse-integer (parameter "n")))
        (md5 (format nil "~a" (parameter "md5"))))
    (when (gethash md5 *results*)
      (format t "~a" md5)
      (binary-file-string (nth n (list-pngs md5))))))

(push (create-prefix-dispatcher "/image" 'show-png) *dispatch-table*)

(defun show-analysis ()
  (let* ((md5 (format nil "~a" (parameter "analysis")))
         (anal (gethash md5 *results*)))
    (when anal
      (setf *data* (parameter "analysis"))
      (standard-page (:title "Analysis results")
        (:center (:h1 "Analysis results")
                 (iter (for i from 0)
                       (for file in (list-pngs md5))
                       (htm (:img :src (format nil "/image?md5=~a&n=~a" md5 i))))
                 (iter (for r in (analysis-results anal))
                       (for a in (analysis-algorithms anal))
                       (htm (:div :class "gabarito"
                                  (:a :href "javascript: void(0);"
                                      :onclick (format nil "toggle_visible(document.getElementById(\"~a\"));"
                                                       (algorithm-name a))
                                      (fmt "Gabarito de ~a" (algorithm-name a)))
                                  (:textarea :class "inv"
                                             :id (algorithm-name a)
                                             (fmt "~{~a ~}" r))))))
        (fmt "~a" (an-form (file-string (concat (analysis-full-path anal)))))))))


(push (create-prefix-dispatcher "/show-analysis" 'show-analysis) *dispatch-table*)

(defun show-results ()
  (iter (for (k v) in-hashtable *results*)
        (format t "~a: ~a~%" k (type-of k))))

(defun start-rameau-web ()
  (start-server :port 4242))
