(asdf:defsystem :cl-utils
  :depends-on (:arnesi :alexandria :iterate :cl-ppcre :cl-fad :fiveAm)
  :serial t
  :components ((:file "export-symbols")
               (:file "cl-utils")
               (:file "fixtures")
               (:file "tests")))
