;;; File: decision-tree.lisp
;;; Last edited by smishra on Sat May  8 16:14:40 1999
;; Fonte: http://www-static.cc.gatech.edu/classes/cs3361_99_spring/projects/project3/decision-tree.lisp
(defpackage :machine-learning
  (:use #:cl #:arnesi)
  (:export #:make-example #:classify #:id3 #:print-tree))

(in-package :machine-learning)

(declaim (optimize (safety 3) (debug 3)))

;;; Credits:

#|

This file contains Decision tree learning code to accompany the
textbook "Machine Learning," Tom M. Mitchell, McGraw Hill, 1997.

Copyright 1998 Tom M. Mitchell.  This code may be freely distributed
and used for any non-commericial purpose, as long as this copyright
notice is retained.  The author assumes absolutely no responsibility
for any harm caused by bugs in the code.

|#

;;; Heavily modified version follows

;;;----------------------------------------
;;; Structures

(defstruct (data-set (:conc-name data-)
		     (:print-function (lambda (object stream ignore)
					(declare (ignore ignore))
					(print-unreadable-object (object stream)
					  (princ "Set " stream)
					  (princ (data-name object) stream)))))
  name
  attributes
  classes
  train-set
  test-set)

(defstruct example
  name
  class
  values)

(defstruct (attribute-split (:conc-name split-)
			    (:print-function (lambda (object stream ignore)
					       (declare (ignore ignore))
					       (print-unreadable-object (object stream)
						 (princ "Split on " stream)
						 (princ (split-attribute object) stream)))))
  attribute
  branches)

(defstruct (partition (:include attribute-split)
		      (:print-function (lambda (object stream ignore)
					       (declare (ignore ignore))
					       (print-unreadable-object (object stream)
						 (princ "Partition on " stream)
						 (princ (partition-attribute object) stream)))))
  examples
  )

(defstruct (node (:include attribute-split)
		 (:print-function (lambda (object stream ignore)
				    (declare (ignore ignore))
				    (print-unreadable-object (object stream)
				      (princ "Node; head=" stream)
				      (princ (node-attribute object) stream)))))
  )

(defstruct (branch (:print-function (lambda (object stream ignore)
				      (declare (ignore ignore))
				      (print-unreadable-object (object stream)
					(princ "Branch on " stream)
					(princ (branch-attribute object) stream)
					(princ #\= stream)
					(princ (branch-value object) stream)))))
  attribute
  value
  contents)

;;;----------------------------------------

;;;----------------------------------------
;;; General utility functions

(defun argmax (key object &rest more-objects)
  "Picks the argument that returns the largest value on the application of
KEY. Returns the argument and the value."
  (loop with best-object = object
        and best-score = (funcall key object)
        for other-object in more-objects
        for other-score = (funcall key other-object)
        when (> other-score best-score)
          do (setq best-score other-score
                   best-object other-object)
        finally (return (values best-object best-score))))

(defun argmin (key object &rest more-objects)
  "Picks the argument that returns the smallest value on the application of
KEY. Returns the argument and the value."
  (loop with best-object = object
        and best-score = (funcall key object)
        for other-object in more-objects
        for other-score = (funcall key other-object)
        when (< other-score best-score)
          do (setq best-score other-score
                   best-object other-object)
        finally (return (values best-object best-score))))

;;;----------------------------------------

;;;----------------------------------------
;;; Example Operations

(defun count-classes (classes examples)
  "Return an association list of class counts"
  (let ((counts (mapcar #'(lambda (class) (cons class 0)) classes)))
    (dolist (example examples)
      (aif (assoc (example-class example) counts :test #'equal)
           (incf (cdr it))
           (format t "example ~s ~s ~%" (example-class example)  (nth 100 counts))))
    counts))

(defun most-common-class (examples classes)
  (car (apply #'argmax #'cdr (count-classes classes examples))))

(defun (setf attribute-value) (value attribute example)
  "Assign a value to an attribute of an example"
  (let ((attribute-record (assoc attribute (example-values example) :test #'equal)))
    (if attribute-record
	(setf (cdr attribute-record) value)
	(push (cons attribute value) (example-values example)))))

(defun attribute-value (attribute example)
  "Retrieve the value of attribute of example"
  (cdr (assoc attribute (example-values example))))

(defun print-example (example)
  "Print the description of example to the screen"
  (format t "~&Example ~A in Class ~A; Values: ~A"
	  (example-name example)
	  (example-class example)
	  (example-values example)))

;;;----------------------------------------

;;;----------------------------------------
;;; Tree Operations

;;; Tree Representation:
;;; A tree is a NODE.
;;; Each NODE predicts the most frequent CLASS.
;;; Each NODE branches on an ATTRIBUTE.
;;; Each BRANCH is described by an ATTRIBUTE, a VALUE, and some CONTENT.
;;; The CONTENT can be another NODE or a CLASS.

(defun partition-branch->node-branch (partition-branch predicted-class attributes classes)
  (let ((attribute (branch-attribute partition-branch))
	(contents (branch-contents partition-branch)))
    (make-branch :attribute attribute
		 :value (branch-value partition-branch)
		 :contents (if contents
			       (id3 contents (remove attribute attributes :key #'car) classes)
			       predicted-class))))

(defun make-subtree (partition attributes classes predicted-class)
  "Make a decision subtree from a given partition."
  (let ((attribute (partition-attribute partition)))
    (make-node :attribute attribute
	       :branches (loop for branch in (partition-branches partition)
			       collect (partition-branch->node-branch branch predicted-class
								      attributes classes)))))

(defun print-tree (tree &optional (level 0))
  "Print a decision tree in readable form."
  (let* ((node-indent (* 5 level))
	 (value-indent (+ node-indent 1)))
    (format t "~&~vTNode decision on ~A" node-indent (node-attribute tree))
    (loop for subtree in (node-branches tree)
	  do (format t "~&~vT= ~A" value-indent (branch-value subtree))
	  if (node-p (branch-contents subtree))
	    do (print-tree (branch-contents subtree) (1+ level))
	  else do (format t " => ~A" (branch-contents subtree)))))

;;;----------------------------------------

;;;----------------------------------------
;;; Partition Operations

;;; A PARTITION is like a NODE, with the difference that each BRANCH contains
;;; EXAMPLES rather than CLASSES or NODES.

(defun entropy (p-list)
  "Calculates the entropy of a probability distribution."
  (- (loop for p in p-list
	   when (> p 0)
	     sum (* p (log p 2)))))

(defun partition-entropy (partition classes)
  "returns the sum over possible values of attribute of the quantity
number-of-examples-with-this-value x sample-entropy-of-this-partition"
  (loop for branch in (partition-branches partition)
	for examples = (branch-contents branch)
	for branch-count = (length examples)
	when (> branch-count 0)
	  sum (* branch-count
		 (entropy (loop for class-count in (count-classes classes examples)
				collect (/ (cdr class-count) branch-count))))))

(defun partition-on-attribute (attribute-data examples)
  "Returns a partion of EXAMPLES according to their values for ATTRIBUTE."
  (let* ((attribute (car attribute-data))
         (branches (mapcar #'(lambda (value)
                               (make-branch :attribute attribute :value value :contents nil))
                           (cdr attribute-data))))
    (loop for example in examples
       for value = (attribute-value attribute example)
       do (let ((branch (find value branches :key #'branch-value)))
            (if branch
                (push example (branch-contents (find value branches :key #'branch-value)))
                (format t "coisa errada: ~a ~a ~a~%" value attribute example))))
    (make-partition :attribute attribute :branches branches :examples examples)))

(defun best-partition (attributes examples classes)
  "Select the best partition from the set of partitions for the attributes."
  (apply #'argmin
	 #'(lambda (partition)
	     (partition-entropy partition classes))
	 (loop for attribute in attributes
	       collect (partition-on-attribute attribute examples))))

;;;----------------------------------------

;;;----------------------------------------
;;; ID3

(defun id3 (examples attributes classes)
  "Classify EXAMPLES given a set of ATTRIBUTES and CLASSES. Returns a
decision tree that predicts a class."
  (cond ((null attributes)
         (most-common-class examples classes))
        ((let ((first-class (example-class (car examples))))
           (every #'(lambda (example) (eql (example-class example) first-class)) (cdr examples)))
         (example-class (car examples)))
        (t (make-subtree (best-partition attributes examples classes) attributes classes
                         (most-common-class examples classes)))))

(defun classify (example tree)
  "Classify an EXAMPLE into a CLASS based on the TREE."
  (let* ((branch (find (attribute-value (node-attribute tree) example) (node-branches tree)
		       :key #'branch-value))
	 (branch-contents (when branch (branch-contents branch))))
    (cond ;; ((null branch) (node-prediction tree))
      ((node-p branch-contents) (classify example (branch-contents branch)))
      (t branch-contents))))

;;;----------------------------------------

;;;----------------------------------------
;;; Top Level Operations

(defun test-id3 (set)
  "Construct a decision tree from the training set, and test it against
the examples in the test set."
  (let ((tree (id3 (data-train-set set) (data-attributes set) (data-classes set))))
    (loop for test-example in (data-test-set set)
	  for example-count from 1
	  count (eql (example-class test-example) (classify test-example tree)) into correct
	  finally (return (values correct example-count)))))

(defun print-id3 (set)
  "Construct and print a decision tree."
  (print-tree (id3 (data-train-set set) (data-attributes set) (data-classes set))))

;;;----------------------------------------