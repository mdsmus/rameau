(asdf:defsystem :rameau-tests
  :name "rameau-tests"
  :version "0.2"
  :author "Alexandre Passos e Pedro Kroger"
  :serial t
  :depends-on (:lisp-unit :rameau)
  :components (
               (:file "packages")
               (:file "musiclib-test")
               (:file "parser-test")
               ;;(:file "formato-test")
               ;;(:file "segmento-test")
               ;;(:file "pardo-test")
               ))
