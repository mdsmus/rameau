(asdf:defsystem :rameau-pkg
  :depends-on (:cl-utils :cl-music :arnesi :iterate :alexandria :cl-lily :cl-ppcre :cl-store :cl-fad
                         :cl-cairo2 #+win32 :cl-cairo2-win :cl-colors)
  :serial t
  :components ((:file "packages")
               #+sbcl(:file "sbcl")
               (:file "chords")
               (:file "chords-functional")
               (:file "rameau")
               (:file "commands")
               (:file "terminal")
               (:file "analysis")
               (:file "lily")
               (:file "main")
               ))
 
(asdf:defsystem :algorithms
  :depends-on (:rameau-pkg :cl-store :cl-cairo2 :cl-lily :fann :machine-learning :cl-fad)
  :components ((:module algorithms
                        :components ((:file "hmm")
                                     (:file "neural")
                                     (:file "pardo")
                                     (:file "knn")
                                     (:file "tree-enarm")
                                     (:file "fhmm")
                                     ))))

(asdf:defsystem :commands
  :depends-on (:rameau-pkg :cl-lily :cl-store :cl-who :algorithms :swank :fiveam
                           #-win32 :hunchentoot :md5 :cl-fad :cl-base64 :cl-store)
  :serial t
  :components ((:file "package-test")
               (:module commands
                        :serial t
                        :components ((:file "analysis-command")
                                     #-win32 (:file "web")
                                     (:file "doc")
                                     (:file "stat")
                                     (:file "algorithms")
                                     (:file "musicology")
                                     (:file "test")
                                     (:file "setup")
                                     ))))

(asdf:defsystem :rameau
    :name "rameau"
    :version "4.0"
    :author "Alexandre Passos e Pedro Kroger"
    :depends-on (:rameau-pkg :algorithms :commands)
    :serial t
    :components ((:file "package-test")
                 (:module tests
                          :serial t
                          :components ((:file "all")
                                       (:file "format")
                                       (:file "parser")
                                       (:file "segment")
                                       (:file "commands")
                                       (:file "chords")
                                       (:file "rameau")))))
