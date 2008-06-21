(asdf:defsystem :rameau-web
  :name "rameau-web"
  :version "0.0"
  :author "Alexandre Passos e Pedro Kroger"
  :depends-on (:rameau :hunchentoot :cl-who :md5 :cl-fad :cl-base64)
  :components ((:file "web")))
