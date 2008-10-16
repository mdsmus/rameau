(in-package #:rameau-test)

(def-suite all :description "All rameau tests")

(def-fixture create-tmp-dir (tmpdir)
  (let ((dir (make-pathname :directory `(:absolute "tmp" ,tmpdir))))
    (unwind-protect
         (progn
           (ensure-directories-exist dir)
           (&body))
      (genoslib:delete-directory-and-files dir :if-does-not-exist :ignore))))

(def-fixture logical-pathname-translations ()
  (let ((default-translations (logical-pathname-translations "rameau")))
    (unwind-protect
         (progn
           (setf (logical-pathname-translations "rameau")
                 '(("**;*.*.*" "/tmp/rameau/**/")))
           (&body))
      (setf (logical-pathname-translations "rameau")
            default-translations))))
