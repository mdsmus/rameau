(asdf:defsystem :cl-lily
  :depends-on (:cl-utils :cl-music :arnesi :alexandria :iterate
               :yacc :lexer :cl-ppcre :cl-fad :fiveam)
  :serial t
  :components ((:file "format")
               (:file "segment")
               (:file "parser")
               (:file "parser-grammar")
               (:file "tests")))

