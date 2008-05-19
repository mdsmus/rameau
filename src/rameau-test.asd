(asdf:defsystem :rameau-test
    :depends-on (:rameau)
    :components ((:module tests
                          :components ((:file "packages")
                                       (:file "utils")
                                       (:file "musiclib")
                                       (:file "formato")
                                       (:file "parser")
                                       (:file "segment")
                                       (:file "chords")
                                       (:file "tools")
                                       (:file "main")))))
