(in-package #:rameau-test)

(defsuite commands "Tests for the commands file")
(in-suite commands)

(test get-command-by-name
  (is (equalp (command-name (get-command-by-name "analysis")) "analysis"))
  (is (/= 0 (count-subseq (command-name (get-command-by-name "anal")) "analysis"))))

(test make-default-options
  (is (equalp 'arguments-table (type-of (make-default-arguments (get-command-by-name "anal"))))))

(test arg
  (is (equalp 7.1 (arg :paper-width (make-default-arguments (get-command-by-name "anal"))))))

(test process-option-list
  (is (equalp (process-option-list '("foo=bar" "baz")) '((:foo bar) (:baz t)))))

(test parse-file-name
  (is (pathnames-equal-p
       (translate-logical-pathname "rameau:music;chorales-bach;001.ly")
       (first (parse-file-name "chor:001"
                               (make-default-arguments (get-command-by-name "anal")))))))

