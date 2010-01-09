(in-package :cl-op.hof)

(defun flip (function)
  "Switch the first two arguments of FUNCTION."
  (lambda (x y &rest arguments) (apply function y x arguments)))
  
(defun disjoin (&rest predicates)
  "OR predicate combinator."
  (lambda (&rest arguments) 
    (some (lambda (predicate) (apply predicate arguments)) predicates)))
    
(defun conjoin (&rest predicates)
  "AND predicate combinator."
  (lambda (&rest arguments) 
    (every (lambda (predicate) (apply predicate arguments)) predicates)))

(defun compose (&rest functions)
  "Compose FUNCTIONS."
  (lambda (&rest arguments)
    (reduce #'funcall (butlast functions) :from-end t
            :initial-value (apply (first (last functions)) arguments))))

(defmacro generator (&body body)
  "Make a generator function."
  (let ((arguments (gensym)))
    `(lambda (&rest ,arguments) (declare (ignore ,arguments)) ,@body)))
