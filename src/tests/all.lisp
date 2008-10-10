(in-package #:rameau-test)

(def-suite all :description "All rameau tests")

(def-fixture create-tmp-dir (tmpdir)
  (let ((dir (make-pathname :directory `(:absolute "tmp" ,tmpdir))))
    (unwind-protect
         (progn
           (ensure-directories-exist dir)
           (&body))
      (cl-fad:delete-directory-and-files dir :if-does-not-exist :ignore))))
