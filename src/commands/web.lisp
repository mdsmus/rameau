(defpackage :rameau-web
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl :cl-ppcre :lisp-unit :iterate :genoslib :cl-who :hunchentoot :md5 :cl-store)
  (:export #:start-rameau-web)
  (:documentation "The web interface for \\texttt{rameau}"))

(in-package :rameau-web)

(enable-sharp-l-syntax)

(setf *catch-errors-p* nil)
(defparameter *data* nil)

(defparameter *rameau-web-dir* (concat *rameau-path* "web/"))
(defparameter *results* (if (cl-fad:file-exists-p (concat *rameau-web-dir* "cache.store"))
                            (restore (concat *rameau-web-dir* "cache.store"))
                            (make-hash-table :test #'equal)))

(defmacro standard-page ((&key title) &body body)
  `(with-html-output-to-string (*standard-output* nil :prologue t :indent t)
     (:html :xmlns "http://www.w3.org/1999/xhtml"
            :xml\:lang "en" 
            :lang "en"
            (:head 
             (:meta :http-equiv "Content-Type" 
                    :content    "text/html;charset=utf-8")
             (:title ,title)
             (:link :rel "icon"
                    :type "image/gif"
                    :href "/favicon.ico")
             (:script :type "text/javascript" :src "/scripts.js")
             (:link :rel "stylesheet" :href "/style.css"))
            (:body :align "right"
                   (:div :id "title" :align "center"
                         (:p (:h1 "Rameau - Automated Harmonic Analysis")))
                   (:div :id "main"
                         (:div :id "nav"  :class "nav"
                               (:p (:h2 (:a :href "/rameau/index.html" "Perform Analysis"))
                                   " | "
                                   (:h2 (:a :href "/rameau/results.htm" "Browse Results"))))
                         (:div :id "content" :class "content" ,@body))))))

(defun an-form ()
  (with-html-output-to-string (*standard-output* nil :prologue t :indent t)
    (:form :action "/analysis" :method "post" :class "analise" :id "analise"
           (:p (:input :type "radio" :name "escolha" :value "input" :onchange "habilita_input()" :checked "")
               (:label :for "escolha-1"
                       "Enter the notes for each voice..."))
           (:div :id "coral" :style "max-width: 40em;" :class "coralbox"
                 (:p (:label :for "key" "Key:")
                     (:select :name "key" :id "key"                              (:option :value "" "")
                              (iter (for root in '("c" "d" "e" "f" "g" "a" "b"))
                                    (iter (for suffix in '("is" "es" ""))
                                          (iter (for mode in '("major" "minor"))
                                                (htm (:option :value (format nil
                                                                             "~a~a \\~a"
                                                                             root
                                                                             suffix
                                                                             mode)
                                                              (fmt "~a~a ~a"
                                                                   (string-upcase root)
                                                                   (cond ((equal "is" suffix) "#")
                                                                         ((equal "es" suffix) "b")
                                                                         (t ""))
                                                                   mode))))))))
                 (:p (:label :for "sig" "Time:")
                     (:select :name "sig" :id "sig"
                              (:option :value "" "")
                              (iter (for sig in '("3/4" "4/4" "6/8" "9/8" "12/8" "3/2" "1/2" "2/4" "4/1"))
                                    (htm (:option :value sig (str sig))))))
                 (:p (:label :for "soprano" "Soprano:")
                     (:input :id "soprano" :type "text" :name "soprano"))
                 (:p (:label :for "alto" "Alto:")
                     (:input :id "alto" :type "text" :name "alto"))
                 (:p (:label :for "tenor" "Tenor:")
                     (:input :id "tenor" :type "text" :name "tenor"))
                 (:p (:label :for "bass" "Bass:")
                     (:input :id "bass" :type "text" :name "bass"))
                 (:div :style "clear: both"))
           (:p (:input :type "radio" :name "escolha" :value "chor" :onchange "habilita_chor()")
               (:label :for "escolha-2" "...or choose one of Bach's 371 Chorales")
               (:select :name "chorale" :id "chorale"  :disabled t
                        (iter (for f in (parse-file-name "chor:1..371" (make-default-arguments)))
                              (let ((name (pathname-name f)))
                                (htm (:option :value name (str name)))))))
           ;; FIXME: space should be defined in the css file
           (:br)
           (:p (:label :for "answer" "Answer:")
               (:input :id "answer" :type "text" :name "answer"))
           ;; FIXME: space should be defined in the css file
           (:br)
           (:div :id "submit"
                 (:input :type "submit" :value "Analyze"))
           ;; FIXME: space should be defined in the css file
           (:br)
           (:a :href "javascript:void(0)" :onClick "toggle_visible(document.getElementById(\"algorithms\"));"
               "Choose Algorithms")
           (:div :align "center" :id "algorithms" :class "algorithms"
                 (:a :class "closebutton"
                     :href "javascript:void(0)" :onClick "toggle_visible(document.getElementById(\"algorithms\"));"
                     "X")
                 (iter (for alg in (filter-algorithms nil *algorithms*))
                       (htm (:p (:input :type "checkbox" 
                                        :checked (/= 0 (count-subseq "Net" (alg-name alg)))
                                        :name (alg-name alg)
                                        :id (alg-name alg))
                                (:label :for (alg-name alg) (fmt "<b>~a</b>:<i>~a</i>"
                                                                 (alg-name alg)
                                                                 (alg-description alg))))))
                 (:div :align "center"
                       (:a :href "javascript: void(0)" :onClick "toggle_visible(document.getElementById(\"algorithms\"));"
                           "Close")))
           )))

(defun rameau-web ()
  (standard-page (:title "Rameau")
                 (str (an-form))))

(push (create-prefix-dispatcher "/rameau/index.html" 'rameau-web) *dispatch-table*)

(defun favicon ()
  (setf (content-type) "image/gif")
  (binary-file-string (concat *rameau-web-dir* "static/favicon.ico")))

(push (create-prefix-dispatcher "/favicon.ico" 'favicon) *dispatch-table*)

(defun logo-genos ()
  (setf (content-type) "image/png")
  (binary-file-string (concat *rameau-web-dir* "static/genos.png")))

(push (create-prefix-dispatcher "/genos.png" 'logo-genos) *dispatch-table*)

(defun logo-grande ()
  (setf (content-type) "image/png")
  (binary-file-string (concat *rameau-web-dir* "static/background.png")))

(push (create-prefix-dispatcher "/rameau/background.png" 'logo-grande) *dispatch-table*)

(defun style-sheet ()
  (setf (content-type) "text/css")
  (binary-file-string (concat *rameau-web-dir* "static/style.css")))

(push (create-prefix-dispatcher "/style.css" 'style-sheet) *dispatch-table*)

(defun javascript ()
  (setf (content-type) "application/javascript")
  (binary-file-string (concat *rameau-web-dir* "static/scripts.js")))

(push (create-prefix-dispatcher "/scripts.js" 'javascript) *dispatch-table*)

(defun make-md5 (string)
  (setf *data* string)
  (reduce #'concat
          (iter (for i in-vector (md5sum-sequence string))
                (collect (format nil "~(~x~)" i)))))

(defun get-params-alg ()
  (iter (for alg in (mapcar #'load-alg (filter-algorithms nil *algorithms*)))
        (when (parameter (alg-name alg))
          (collect alg))))

(defun get-chorale-string (n)
  (cond ((< 0 n 10) (format nil "00~a" n))
        ((< n 100) (format nil "0~a" n))
        (t (format nil "~a" n))))

(defun get-params-code ()
  (cond ((equal "input" (format nil "~a" (parameter "escolha")))
         (format nil "

global = {
 \\time ~a
 \\key ~a
}

soprano = \\relative c'' {
  ~a
}

alto = \\relative c' {
  ~a 
}

tenor = \\relative c' {
  ~a
}

baixo = \\relative c {
  ~a
}

\\score {
  <<
    \\new StaffGroup <<
      \\override StaffGroup.SystemStartBracket #'style = #'line 
      \\new Staff {
        <<
         \\global
          \\new Voice = \"soprano\" { \\voiceOne \\soprano }
          \\new Voice = \"alto\" { \\voiceTwo \\alto }
        >>
      }
      \\new Staff {
        <<
          \\global
          \\clef \"bass\"
          \\new Voice = \"tenor\" {\\voiceOne \\tenor }
          \\new Voice = \"baixo\" { \\voiceTwo \\baixo \\bar \"|.\"}
        >>
      }
    >>
  >>
  \\layout {}
  \\midi {}
}

"
                 (parameter "sig")
                 (parameter "key")
                 (parameter "soprano")
                 (parameter "alto")
                 (parameter "tenor")
                 (parameter "bass")))
        (t
         (let* ((n (or (parse-integer (or (parameter "chorale") "") :junk-allowed t) 1))
                (c (get-chorale-string n)))
           (file-string (concat *rameau-path* "music/chorales-bach/" c ".ly"))))))

(defun grab-possible-answer-sheet ()
  (let ((an (parameter "answer")))
    (if (and an (/= 0 (length an)))
        (read-chords (read-from-string (format nil "(~a)" an)))
        (awhen (parse-integer (or (parameter "chorale") ""):junk-allowed t)
          (new-parse-answer-sheet (get-chorale-string it) "chor")))))

(defun do-analysis ()
  (let ((code (get-params-code))
        (algs (get-params-alg)))
    (if (or (null code) (zerop (length code)))
        (format t "Erro: ~a||||||~a"
                code algs)
        (progn
          (let* ((md5 (make-md5 (concat code (format nil "~a" algs)))))
            (if (gethash md5 *results*)
                (format t "Erro: ~a||||||~a"
                        code algs)
                (progn
                  (let* ((options (make-default-arguments))
                         (options (progn (setf (arg :algorithms options) algs)
                                         options))
                         (ast (get-ast-string code))
                         (notes (get-parsed-notes ast))
                         (segments (sonorities notes))
                         (full-path (concat *rameau-web-dir* md5 ".ly"))
                         (analysis (make-analysis :segments segments
                                                  :results (mapcar #L(perform-analysis segments options !1)
                                                                   (arg :algorithms options))
                                                  :answer-sheet (grab-possible-answer-sheet)
                                                  :file-name md5
                                                  :number-algorithms (length (arg :algorithms options))
                                                  :algorithms (arg :algorithms options)
                                                  :notes (mapcar #'list-events segments)
                                                  :ast ast
                                                  :title (aif (parameter "chorale")
                                                              (format nil "Chorale ~a" it)
                                                              (format nil "Custom ~a" md5))
                                                  :full-path full-path
                                                  :dur (durations segments))))
                    (setf (gethash md5 *results*) analysis
                          (arg :png options) t
                          (arg :lily options) t)
                    (cl-store:store *results* (concat *rameau-web-dir* "cache.store"))
                    (with-open-file (f full-path :direction :output :if-exists :supersede)
                      (format f "~a" code))
                    (rameau-analysis::analysis-lily options analysis))))
            (redirect (format nil "/show-analysis?analysis=~a&chorale=~a" md5 (or (parameter "chorale") ""))))))))

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
      (binary-file-string (nth n (list-pngs md5))))))

(push (create-prefix-dispatcher "/image" 'show-png) *dispatch-table*)

(defun show-analysis ()
  (let* ((md5 (format nil "~a" (parameter "analysis")))
         (anal (gethash md5 *results*)))
    (when anal
      (setf *data* (parameter "analysis"))
      (standard-page (:title "Analysis results")
                     (:center :class "results"
                              (:h1 "Analysis results")
                              (iter (for i from 0)
                                    (for file in (list-pngs md5))
                                    (htm (:img :src (format nil "/image?md5=~a&n=~a" md5 i))))
                              (iter (for r in (analysis-results anal))
                                    (for a in (analysis-algorithms anal))
                                    (htm (:div :class "gabarito"
                                               (:a :href "javascript: void(0);"
                                                   :onclick (format nil "toggle_visible(document.getElementById(\"~a\"));"
                                                                    (alg-name a))
                                                   (fmt "Gabarito de ~a" (alg-name a)))
                                               (:div :class "inv"
                                                     :id (alg-name a)
                                                     (fmt "~{~a ~}" r))))))))))

(push (create-prefix-dispatcher "/show-analysis" 'show-analysis) *dispatch-table*)

(defun show-results ()
  (standard-page (:title "Browse Results")
                 (:div :class "browse-results"
                       (iter (for (k v) in-hashtable *results*)
                             (htm (:div :align "right" :class "cache" 
                                        (:div :align "center" (str (analysis-title v)))
                                        (:p :style "float:center"
                                            (:a :href (format nil "/show-analysis?analysis=~a"  k)
                                                "View"))
                                        (:p :style "float:right"
                                            (:a :href (format nil "/rameau/clear-cache?page=~a" k)
                                                "Clear from cache"))
                                        (:p :style "clear: both;" :align "center"
                                            (:b "Algorithms:")
                                            (iter (for alg in (analysis-algorithms v))
                                                  (htm (:i (str (alg-name alg)))))))))
                       (:div :style "clear: center"))))

(push (create-prefix-dispatcher "/rameau/results.htm" 'show-results) *dispatch-table*)

(defun clear-cache ()
  (awhen (parameter "page")
    (let ((page (format nil "~a" it)))
      (remhash page *results*)
      (cl-store:store *results* (concat *rameau-web-dir* "cache.store")))
    (redirect "/rameau/results.htm")))

(push (create-prefix-dispatcher "/rameau/clear-cache" 'clear-cache) *dispatch-table*)

(defun start-rameau-web (port)
  "Start the web server for \\texttt{rameau}."
  (start-server :port port))

;;(start-rameau-web)


(defcommand web (options &rest ignore)
  (("" "port" "define the port number for rameau web" 4242 type-integer))
  "Start rameau's web interface"
  (declare (ignore ignore))
  (let ((port (arg :port options)))
    (format t "Starting rameau web on port ~a.~%" port)
    (write-line "Open http://localhost:4242/rameau/index.html on your browser")
    (rameau-web::start-rameau-web port))
  (loop))
