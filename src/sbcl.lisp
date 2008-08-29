(in-package "SB-PROFILE")
(defvar *print-functions-not-called* t)

(defun report ()
  "Report results from profiling. The results are approximately adjusted
for profiling overhead. The compensation may be rather inaccurate when
bignums are involved in runtime calculation, as in a very-long-running
Lisp process."
  (unless (boundp '*overhead*)
    (setf *overhead*
          (compute-overhead)))
  (let ((time-info-list ())
        (no-call-name-list ()))
    (loop for name being the hash-keys in *profiled-fun-name->info* using (hash-value pinfo) do
          (unless (eq (fdefinition name)
                      (profile-info-encapsulation-fun pinfo))
            (warn "Function ~S has been redefined, so times may be inaccurate.~@
               PROFILE it again to record calls to the new definition."
                  name))
          (multiple-value-bind (calls ticks consing profile)
              (funcall (profile-info-read-stats-fun pinfo))
            (if (zerop calls)
                (push name no-call-name-list)
                (push (make-time-info :name name
                                      :calls calls
                                      :seconds (compensate-time calls
                                                                ticks
                                                                profile)
                                      :consing consing)
                      time-info-list))))

    (setf time-info-list
          (sort time-info-list
                #'>=
                :key #'time-info-seconds))
    (print-profile-table time-info-list)

    (when (and no-call-name-list *print-functions-not-called*)
      (format *trace-output*
              "~%These functions were not called:~%~{~<~%~:; ~S~>~}~%"
              (sort no-call-name-list #'string<
                    :key (lambda (name)
                           (symbol-name (fun-name-block-name name))))))

    (values)))
