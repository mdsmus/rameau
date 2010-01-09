;;;; -*- Mode: Lisp -*-

(in-package #:asdf)

(defsystem sdl-demos
    :components ((:module :examples
                          :components
                          ((:file "sdl-test")
                           (:file "example1")
                           (:file "data")
                           (:file "2d-test"
                                  :depends-on ("data"))
                           (:module :nehe
                                    :depends-on ("data")
                                    :components
                                    ((:file "package")
                                     (:file "tut01"
                                            :depends-on ("package"))
                                     (:file "tut02"
                                            :depends-on ("package"))
                                     (:file "tut03"
                                            :depends-on ("package"))
                                     (:file "tut04"
                                            :depends-on ("package"))
                                     (:file "tut05"
                                            :depends-on ("package"))
                                     (:file "tut06"
                                            :depends-on ("package"))
                                     (:file "tut07"
                                            :depends-on ("package"))
                                     (:file "tut08"
                                            :depends-on ("package"))
                                     (:file "tut09"
                                            :depends-on ("package"))
                                     (:file "tut10"
                                            :depends-on ("package"))
                                     (:file "tut11"
                                            :depends-on ("package"))
                                     (:file "tut16"
                                            :depends-on ("package"))
                                     (:file "torus"
                                            :depends-on ("package"))
                                     (:file "solar-system"
                                            :depends-on ("package"))
                                     (:file "vertex-array"
                                            :depends-on ("package"))
                                     (:file "lighting"
                                            :depends-on ("package")))))))
    :depends-on (sdl opengl))