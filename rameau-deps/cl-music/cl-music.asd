(asdf:defsystem :cl-music
  :depends-on (:cl-utils :arnesi :alexandria :cl-ppcre :fiveAm)
  :components ((:file "cl-music")
               (:file "tests" :depends-on ("cl-music"))))

