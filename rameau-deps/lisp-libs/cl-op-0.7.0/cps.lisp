(defun walk (function form &optional accumulator (cont #'values))
  "Walk FORM applying FUNCTION to each node."
  (if form
      (funcall function (first form) accumulator 
               (lambda (node accumulator)
                 (walk function (rest form) accumulator
                       (lambda (result accumulator) 
                         (funcall cont (cons node result) accumulator)))))
      (funcall cont form accumulator)))

(defun replace-all (new old tree)
  (labels ((rec (node acc c)
           (cond ((eql node old) (funcall c new (1+ acc)))
                 ((consp node) (walk #'rec node acc (lambda (r a) (funcall c (list* 'bar r) a))))
                 (t (funcall c node acc)))))
  (walk #'rec tree 0)))
  
(print (multiple-value-list (replace-all 'foo 2 '(1 2 (2 3 (2 7 3) (2 1 0) 2 ((0 2)))))))