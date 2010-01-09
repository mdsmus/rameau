(in-package #:cl-containers)
  
(defmethod make-container ((classes list) &rest args)
  (let ((name (find-or-create-class 'abstract-container classes))) 
    (apply #'make-instance name args)))

(add-parameter->dynamic-class
 :iterator :transform 'transforming-iterator-mixin)

(add-parameter->dynamic-class
 :iterator :filter 'filtered-iterator-mixin)

(add-parameter->dynamic-class
 :iterator :unique 'unique-value-iterator-mixin)

(add-parameter->dynamic-class
 :iterator :circular 'circular-iterator-mixin)

#+(or)
;;?? Gary King 2005-07-18: didn't work??
(add-dynamic-class-for-parameters :generator 'arithmetic-sequence-generator
                                    nil '(:start :by))

(add-parameter->dynamic-class
 :generator :start 'arithmetic-sequence-generator)
(add-parameter->dynamic-class
 :generator :by 'arithmetic-sequence-generator)

(add-parameter->dynamic-class
 :generator :transform 'transforming-iterator-mixin)
(add-parameter->dynamic-class
 :generator :filter 'filtered-iterator-mixin)
(add-parameter->dynamic-class
 :generator :unique 'unique-value-iterator-mixin)
(add-parameter->dynamic-class
 :generator :end 'finite-arithmetic-sequence-generator)

(defmethod existing-subclass ((class-type (eql :iterator)) class-list)
  (find-existing-subclass 'abstract-generator class-list))

(defmethod existing-subclass ((class-type (eql :generator)) class-list)
  (find-existing-subclass 'abstract-generator class-list))


