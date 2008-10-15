(asdf:defsystem :analyze-source-code
  :depends-on (:split-sequence :cl-ppcre)
  :components ((:file "analyze-source-code")))