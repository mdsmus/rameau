(in-package #:cl-markdown)

(defun markdown-many (pairs &rest args 
		      &key format additional-extensions render-extensions
		      &allow-other-keys)
  "Markdown-many processes several documents simultaneously as if it
was processing one large document. Its chief purpose is to make it easy to 
create inter-document links. Markdown-many takes as input

* `pairs` - a list of lists where each sublist contains the markdown
file to be processed as `input` in its first element and the name of 
the file to be produced as the `output`.
* `:format` - a keyword argument specifying the kind of output document
to produce
* `:additional-extensions` - a list of extensions that should be active
both while parsing and rendering.
* `:render-extensions` - a list of extensions that should be active
during rendering.

Here is an example: suppose document-1.md contains

    # Document-1

    See [document-2][] for details.

and document-2.md contains

    # Document 2

    [Document-1][] provides an overview.

Getting these links to work using only Markdown will require added explicit
reference link information that will be tied to the file _names_. Markdown-many,
on the other hand, will automatically combine the link information and
processes it automatically.
"
  (let ((main-document (make-instance 'multi-document))
	(docs nil))
    (setf docs
	  (loop for datum in pairs collect
	       (bind (((source destination &rest doc-args) datum))
		 (format t "~&Parsing: ~s~%" source)
		 (list (apply #'markdown source
			      :document-class 'child-document
			      :parent main-document
			      :format :none (merge-arguments args doc-args))
		       destination))))
    ;; transfer information from docs to the parent
    (loop for (doc destination) in docs do
	   (transfer-document-data main-document doc destination))
    ;; render 'em
    (loop for (doc destination) in docs do
	 (format t "~&Rendering: ~s" destination)
	 (let ((*current-document* doc)
	       (*render-active-functions*
		(mapcar #'canonize-command
			(or render-extensions
			    (if additional-extensions
				`(,@additional-extensions
				  ,@*render-active-functions*)
				*render-active-functions*)))))
	   (render-to-stream doc format destination)))
    (setf (children main-document) (mapcar #'first docs))
    (values main-document docs)))

(defun merge-arguments (args-1 args-2)
  (let ((result args-1))
    (map-window-over-elements 
     args-2 2 2 
     (lambda (pair)
       (bind (((key value) pair)
	      (present (getf result key)))
	 (setf (getf result key) 
	       (if present
		   (append (ensure-list present) (ensure-list value))
		   value)))))
    result))

#+(or)
(merge-arguments '(:a (1) :b (2)) '(:c (3) :a (2))) 

#+(or)
(defun _render-one (doc)
  (let ((*current-document* doc)
	(*render-active-functions*
	 (mapcar #'canonize-command
		 `(cl-markdown::docs cl-markdown::docs-index
				     cl-markdown::today cl-markdown::now
				     cl-markdown::glossary
				     ,@*render-active-functions*))))
    (render-to-stream doc :html #p"/tmp/one.html")))

#+(or)
(untrace markdown)
    
#+(or)
(compile 'markdown-many)

#+(or)
(cl-markdown:markdown-many 
 `((,(system-relative-pathname 'cl-markdown "dev/md1.md") 
     ,(system-relative-pathname 'cl-markdown "dev/md1.html")) 
   (,(system-relative-pathname 'cl-markdown "dev/md2.md") 
     ,(system-relative-pathname 'cl-markdown "dev/md2.html")))
 :format :html)

(defun transfer-document-data (parent child destination)
  (transfer-link-info parent child destination)
  (transfer-selected-properties 
   parent child 
   (set-difference (collect-keys (properties child))
		   (list :footnote :style-sheet :style-sheets :title)))
  (transfer-document-metadata parent child))

(defun transfer-document-metadata (parent child)
  (iterate-key-value 
   (metadata child)
   (lambda (key value)
;     (print (list :p (item-at-1 (metadata parent) key)
;		  :c value))
     (aif (item-at-1 (metadata parent) key)
	  (setf (item-at-1 (metadata parent) key) (merge-entries it value))
	  (setf (item-at-1 (metadata parent) key) value)))))


(defun transfer-selected-properties (parent child properties)
  (let ((*current-document* parent))
    (iterate-elements 
     properties
     (lambda (property)
       (when (item-at-1 (properties child) property)
	 (setf (document-property property) 
	       (first (item-at-1 (properties child) property))))))))

(defun transfer-link-info (parent child destination)
  (let ((*current-document* parent))
    (iterate-key-value
     (link-info child)
     (lambda (id info)
       (setf (item-at (link-info parent) id)
	     (transfer-1-link-info info parent child destination))))))

(defgeneric transfer-1-link-info (info parent child destination))

(defmethod transfer-1-link-info ((info link-info) parent child destination)
  (declare (ignore parent child))
  (make-instance 'link-info
                 :id (id info)
		 :url (if (relative-url-p (url info))
			  (format nil "~@[~a~]~@[.~a~]~a" 
				  (pathname-name destination)
				  (pathname-type destination)
				  (url info))
			  (url info))
		 :title (title info)
		 :properties (properties info)))

(defun relative-url-p (url)
  ;; FIXME -- look at the spec...
  (not 
   (or (starts-with url "http:")
       (starts-with url "mailto:")
       (starts-with url "file:"))))
 
(defmethod transfer-1-link-info ((info extended-link-info)
			       parent child destination)
  (declare (ignore parent child destination))
  (make-instance 'extended-link-info
                 :id (id info)
		 :kind (kind info)
		 :contents (contents info)))


;;;


;; A slightly horrid hack that is good enough for indices but 
;; completely untested
(defgeneric ugly-create-from-template (thing)
  )

(defmethod ugly-create-from-template ((thing standard-object))
  (make-instance (class-of thing)))

(defgeneric merge-entries (a b)
  (:documentation "Returns a new container C \(of the same type as `a`\)
such that C contains every *entry* in a and b. C may share structure with
`a` and `b`."))

(defmethod merge-entries :around ((a t) (b t))
;  (print (list :me a b))
  (call-next-method))

(defmethod merge-entries ((a null) (b t))
  b)

(defmethod merge-entries ((a null) (b iteratable-container-mixin))
  (error "not implemented"))

(defmethod merge-entries ((a null) (b key-value-iteratable-container-mixin))
  (merge-using-key-value (ugly-create-from-template b) b))

(defmethod merge-entries ((a t) (b t))
  (cond ((and (key-value-iteratable-p a)
	      (key-value-iteratable-p b))
	 #+(or)
	 (merge-key-value-via-iteration a b)
	 (error "not implemented"))
	((and (iteratable-p a)
	      (iteratable-p b))
	 (merge-elements-via-iteration a b))
	(t
	 ;; FIXME - drop b?
	 a)))

(defmethod merge-entries ((a list) (b t))
  (append a (list b)))

(defmethod merge-entries ((a list) (b list))
  (merge-elements-via-iteration a b))

(defmethod merge-entries ((a iteratable-container-mixin)
			  (b iteratable-container-mixin))
  (merge-elements-via-iteration a b))

(defmethod merge-entries 
    ((a key-value-iteratable-container-mixin)
     (b key-value-iteratable-container-mixin))
  (let ((new (ugly-create-from-template a)))
    (merge-using-key-value new a)
    (merge-using-key-value new b)
    new))

(defun merge-elements-via-iteration (a b)
  (let ((new (ugly-create-from-template a)))
    (iterate-elements a (lambda (elt) (insert-item new elt)))
    (iterate-elements b (lambda (elt) (insert-item new elt)))
    new))

(defun merge-using-key-value (a b)
  (iterate-key-value b (lambda (key value) 
			 (let ((existing (item-at a key)))
			   (setf (item-at a key) 
				 (if existing
				     (merge-entries existing value)
				     value)))))
  a)
