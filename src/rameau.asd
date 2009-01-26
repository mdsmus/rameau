(asdf:defsystem :rameau
  :name "rameau"
  :version "5.0"
  :author "Alexandre Passos e Pedro Kroger"
  :depends-on (#+win32 :cl-cairo2-win
                       :alexandria
                       :arnesi
                       :cl-base64
                       :cl-cairo2
                       :cl-colors
                       :cl-fad
                       :cl-lily
                       :cl-music
                       :cl-ppcre
                       :cl-statistics
                       :cl-store
                       :cl-utils
                       :cl-who
                       :fann
                       :fiveam
                       :hunchentoot
                       :iterate
                       :machine-learning
                       :md5
                       :swank)
  :serial t
  :components ((:file "packages")
               #+sbcl(:file "sbcl")
               (:file "chords")
               (:file "chords-functional")
               (:file "rameau")
               (:file "register-commands")
               (:file "terminal")
               (:file "analysis")
               (:file "lily")
               (:file "musicology")
               (:file "main")
               (:module commands
                        :components ((:file "analysis-command")
                                     (:file "web")
                                     (:file "doc")
                                     (:file "stat")
                                     (:file "algorithms")
                                     (:file "musicology")
                                     (:file "test")
                                     (:file "setup")
                                     (:file "noisy-channel")
                                     (:file "debug")))
               (:module algorithms
                        :components ((:file "hmm")
                                     (:file "neural")
                                     (:file "pardo")
                                     (:file "knn")
                                     (:file "tree-enarm")
                                     (:file "fhmm")))
               (:module tests
                        :components ((:file "all")
                                     (:file "segment" :depends-on ("all"))
                                     (:file "commands" :depends-on ("all"))
                                     (:file "chords" :depends-on ("all"))
                                     (:file "rameau" :depends-on ("all"))))))
