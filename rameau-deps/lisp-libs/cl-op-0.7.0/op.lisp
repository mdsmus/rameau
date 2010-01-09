(in-package :cl-op)
  
(defun starts-with (list head)
  "Does LIST start with HEAD?"
  (and (consp list) (eql (first list) head))) 

(defun walk (function form &key fold (cont #'values))
  "Walk FORM applying FUNCTION to each node. Uses CPS."
  (if form
      (funcall function (first form) fold
               (lambda (node &optional fold)
                 (walk function (rest form) :fold fold 
                       :cont (lambda (result &optional fold) 
                               (funcall cont (cons node result) fold)))))
      (funcall cont form fold)))
      
(defmacro defwalk (name arguments &body body)
  (let* ((node (gensym)) (fold (gensym)) (cont (gensym))
         (documentation (when (and (rest body) (stringp (first body)))
                              (list (first body))))
         (body (if documentation (rest body) body)))
    `(defun ,name (,node &optional ,fold (,cont #'values))
       ,@documentation
       (walk (lambda ,arguments ,@body) ,node :fold ,fold :cont ,cont))))
      
(defun rnotany (predicate tree &key (recur-if #'consp))
  "Recursive NOTANY."
  (if (funcall recur-if tree) 
      (every (lambda (tree) (rnotany predicate tree :recur-if recur-if)) tree)
      (not (funcall predicate tree))))
            
(defun recurp (form)
  "Is FORM non-terminal?"
  (not (or (atom form) 
           (member (first form) '(quote op op*))
           (and (starts-with form 'function) (symbolp (second form))))))
            
(defun simple-slot-p (object)
  "Is OBJECT a simple slot designator?"
  (eq object (intern "_")))

(defun rest-slot-p (object)
  "Is OBJECT a rest slot designator?"
  (eq object (intern "__")))
  
(defun slotp (object)
  "Is OBJECT a slot designator?"
  (or (simple-slot-p object) (rest-slot-p object)))
    
(defwalk slots-to-arguments (subform arguments cont)
  "Assign names to slots."
  (cond ((slotp subform) 
         (let ((argname (gensym "OP-")))
           (funcall cont argname (if (rest-slot-p subform)
                                     (list* argname '&rest arguments)
                                     (cons argname arguments)))))
        ((recurp subform) (slots-to-arguments subform arguments cont))
        (t (funcall cont subform arguments))))        

(defun liftablep (form)
  "Can FORM be evaluated early?"
  (and (recurp form) (rnotany #'slotp form :recur-if #'recurp)))

(defun special-form-p (form)
  "Is FORM a special form?"
  (and (consp form) (special-operator-p (first form))))
 
(defun recur-lift-p (form)
  "Does FORM contain subforms that could be evaluated early?"
  (or (and (recurp form) (not (special-form-p form)))
      (starts-with form 'progn)
      (starts-with form 'block)
      (and (starts-with form 'setq) (= (length form) 3))))
 
(defwalk lift-invariants (subform bindings cont)
  "Bind subforms suitable for early evaluation."
  (declare (special *environment*))
  (let ((expansion (macroexpand subform *environment*)))
    (cond ((liftablep expansion) 
           (let ((bind (or (find subform bindings :test #'equal :key #'second)
                           (list (gensym) subform))))
             (funcall cont (first bind) (adjoin bind bindings :test #'equal))))
          ((recur-lift-p expansion) (lift-invariants expansion bindings cont))
          ((starts-with expansion 'the) 
           (lift-invariants (third expansion) bindings 
               (lambda (form bindings)
                 (funcall cont `(,@(subseq expansion 0 2) ,form) bindings))))
          (t (funcall cont subform bindings)))))

(defmacro op* (&rest args)
  "Make an anonymous function with implicit arguments. Defer evaluation."
  (multiple-value-bind (form slots) (slots-to-arguments args)
    `(lambda ,(reverse slots) ,form)))
            
(defmacro op (&rest args &environment *environment*)
  "Make an anonymous function with implicit arguments."
  (declare (special *environment*))
  (multiple-value-bind (args invariants) (lift-invariants args)
    (if invariants 
        `(let ,invariants (op* ,@args)) 
        `(op* ,@args))))
