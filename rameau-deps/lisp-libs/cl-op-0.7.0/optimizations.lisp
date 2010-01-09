(in-package :cl-op)

(defwalk fill-slots (subform arguments cont)
  "Fill slots with coresponding elements in arguments."
  (cond ((simple-slot-p subform) 
         (funcall cont (first arguments) (rest arguments)))
        ((recurp subform) (fill-slots subform arguments cont))
        (t (funcall cont subform arguments))))       

(defwalk beta-reduce (subform fold cont)
  "Beta-reduction."
  (cond ((and (starts-with subform 'funcall) 
              (starts-with (second subform) 'op))
         (fill-slots (cdadr subform) (cddr subform) cont))
        ((recurp subform) (beta-reduce subform fold cont))
        (t (funcall cont subform))))
  
(define-compiler-macro op (&whole form &rest args)
  (let ((optimized-args (beta-reduce args)))
    (if (equal args optimized-args) 
        form 
        `(op ,@optimized-args))))
