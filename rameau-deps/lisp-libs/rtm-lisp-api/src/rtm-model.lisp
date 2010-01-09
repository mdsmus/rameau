(in-package :rtm-lisp-api)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utilities

(defun from-rtm-type (type value)
  (case type
    (bool (or (string= "0" value) value))
    (t value)))

(defun to-rtm-type (type value)
  (case type
    (bool (if value "1" "0"))
    (t value)))

(defun find-by-criteria (criteria criteria-selector bucket)
  (find criteria bucket :key criteria-selector :test #'string=))

(defun find-by-id (id-string bucket)
  (find-by-criteria id-string #'get-id bucket))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Object model for the RTM entities


;;; User information
(defclass rtm-user-info ()
  ((id             :accessor get-id             :initarg :id)
   (username       :accessor get-username       :initarg :username)
   (fullname       :accessor get-fullname       :initarg :fullname)
   (permissions    :accessor get-permissions    :initarg :permissions)
   (contacts       :accessor get-contacts       :initarg :contacts       :initform nil)
   (contact-groups :accessor get-contact-groups :initarg :contact-groups :initform nil)
   (locations      :accessor get-locations      :initarg :locations      :initform nil)
   (tasks          :accessor get-tasks          :initarg :tasks          :initform nil)
   (task-lists     :accessor get-task-lists     :initarg :task-lists     :initform nil)))

(defvar *rtm-user-info* nil)
(setf *rtm-user-info* (make-instance 'rtm-user-info))


(defclass rtm-object ()
  ((dirty :accessor is-dirty :initarg :dirty :initform nil)))

;; (defmethod shared-initialize :after ((instance rtm-object) slot-names &key &allow-other-keys)
;;   (declare (ignore initargs slot-names))
;;   (setf (is-dirty instance) nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Contacts
(defclass contact (rtm-object)
  ((id         :accessor get-id       :initarg :id)
   (username   :accessor get-username :initarg :username)
   (full-name  :accessor get-fullname :initarg :fullname)))

(defmethod rtm-delete-contact ((c contact))
  (rtm:rtm-api-contacts-delete (get-id c))
  (delete-if #'(lambda (x) (string= (get-id x) (get-id x)))
	     (get-contacts *rtm-user-info*)))

(defun rtm-add-contact (username-or-email)
  (let* ((alist (rtm:rtm-api-contacts-add username-or-email))
	 (new-contact 
	  (make-instance 'contact
			 :id (cdr (assoc :id alist))
			 :username (cdr (assoc :username alist))
			 :fullname (cdr (assoc :fullname alist)))))
    (pushnew new-contact
	     (get-contacts *rtm-user-info*)
	     :key #'get-id
	     :test #'string=)
    new-contact))

(defun list-contacts ()
  (let ((contacts (mapcar
		   #'(lambda (c)
		       (make-instance 'contact
				      :username   (cdr (assoc :username c))
				      :fullname   (cdr (assoc :fullname c))
				      :id (cdr (assoc :id c))))
		   (rtm:rtm-api-contacts-get-list))))
    (setf (get-contacts *rtm-user-info*)
	  contacts)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Groups (of contacts)
(defclass contact-group (rtm-object)
  ((id       :accessor get-id       :initarg :id)
   (name     :accessor get-name     :initarg :name)
   (contacts :accessor get-contacts :initarg :contacts :initform nil)))

(defmethod rtm-delete-contact-group ((g contact-group))
  (rtm:rtm-api-groups-delete (get-id g))
  (delete-if (lambda (x) (string= (get-id x) (get-id g)))
	     (get-contact-groups *rtm-user-info*)))

(defun rtm-add-contact-group (name)
  (let* ((alist (rtm:rtm-api-groups-add name))
	 (new-group
	  (make-instance 'contact-group
			 :id       (cdr (assoc :id alist))
			 :name     (cdr (assoc :name alist)))))
    (pushnew new-group
	     (get-contact-groups *rtm-user-info*)
	     :key #'get-id
	     :test #'string=)
    new-group))

(defmethod rtm-add-contact-to-group ((c contact) (g contact-group))
  (rtm:rtm-api-groups-add-contact (get-id g) (get-id c))
  (pushnew c (get-contacts g) :key #'get-id :test #'string=))

(defmethod rtm-remove-contact-from-group ((c contact) (g contact-group))
  (rtm:rtm-api-groups-remove-contact (get-id g) (get-id c))
  (delete-if (lambda (x) (string= (get-id x) (get-id c)))
	     (get-contacts g)))

(defun list-contact-groups ()
  "Fetches contacts, then fetches groups and sorts contacts into them."
  (unless (get-contacts *rtm-user-info*)
    (list-contacts))
  (let ((groups
	 (mapcar
	  #'(lambda (g)
	      (make-instance 'contact-group
			     :id       (cdr (assoc :id g))
			     :name     (cdr (assoc :name g))
			     :contacts (mapcar
					#'(lambda (c-alist)
					    (find-by-id (cdr (assoc :id (cdr c-alist)))
							(get-contacts *rtm-user-info*)))
					(cdr (assoc :contacts g)))))
	  (rtm:rtm-api-groups-get-list))))
    (setf (get-contact-groups *rtm-user-info*) groups)))

;;(list-contact-groups)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Lists (of tasks)
(defclass task-list (rtm-object)
  ((id         :accessor get-id         :initarg :id)
   (name       :accessor get-name       :initarg :name)
   (archived   :accessor is-archived    :initarg :archived)
   (smart      :accessor is-smart       :initarg :smart)
   (position   :accessor get-position   :initarg :position)
   (locked     :accessor is-locked      :initarg :locked)
   (deleted    :accessor get-deleted    :initarg :deleted)
   (sort-order :accessor get-sort-order :initarg :sort-order)
   (tasks      :accessor get-tasks      :initarg :tasks :initform nil)))

(defun rtm-add-task-list (name &optional filter)
  (let* ((alist (rtm:rtm-api-lists-add name (or filter "")))
	 (new-list
	  (make-instance 'task-list
			 :id       (cdr (assoc :id alist))
			 :name     (cdr (assoc :name alist))
			 :smart    (from-rtm-type 'bool (cdr (assoc :smart    alist)))
			 :deleted  (from-rtm-type 'bool (cdr (assoc :deleted  alist)))
			 :locked   (from-rtm-type 'bool (cdr (assoc :locked   alist)))
			 :position (from-rtm-type 'bool (cdr (assoc :position alist)))
			 :archived (from-rtm-type 'bool (cdr (assoc :archived alist))))))
    (pushnew new-list
	     (get-task-lists *rtm-user-info*)
	     :key #'get-id
	     :test #'string=)
    
    new-list))

(defmethod rtm-delete-task-list ((tl task-list))
  (rtm:rtm-api-lists-delete (get-id tl))
  (setf (get-deleted tl) t)
  (let ((x (delete-if (lambda (x) (string= (get-id x) (get-id tl)))
		      (get-task-lists *rtm-user-info*))))
    (declare (ignore x))
    (rtm-refresh-all-lists)))

(defmethod rtm-archive-task-list ((tl task-list))
  (rtm:rtm-api-lists-archive (get-id tl))
  (setf (is-archived tl) t))

(defmethod rtm-unarchive-task-list ((tl task-list))
  (rtm:rtm-api-lists-unarchive (get-id tl))
  (setf (is-archived tl) nil))

(defmethod rtm-set-default-task-list ((tl task-list))
  (rtm:rtm-api-lists-set-default-list (get-id tl)))

(defmethod rtm-change-task-list-name ((tl task-list) name)
  (rtm:rtm-api-lists-set-name (get-id tl) name)
  (setf (get-name tl) name)
  (rtm-refresh-all-lists))

(defun rtm-list-task-lists ()
  (let ((task-lists
	 (mapcar (lambda (l)
		   (make-instance 'task-list
				  :name       (cdr (assoc :name l))
				  :id         (cdr (assoc :id l))
				  :position   (cdr (assoc :position l))
				  :sort-order (cdr (assoc :sort_order l))
				  :archived   (from-rtm-type 'bool (cdr (assoc :archived l)))
				  :smart      (from-rtm-type 'bool (cdr (assoc :smart l)))
				  :locked     (from-rtm-type 'bool (cdr (assoc :locked l)))
				  :deleted    (from-rtm-type 'bool (cdr (assoc :deleted l)))
				  :tasks      nil))
		 (rtm:rtm-api-lists-get-list))))
    (setf (get-task-lists *rtm-user-info*) task-lists)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Locations
(defclass location (rtm-object)
  ((name      :accessor get-name      :initarg :name)
   (id        :accessor get-id        :initarg :id)
   (longitude :accessor get-longitude :initarg :longitude)
   (latitude  :accessor get-latitude  :initarg :latitude)
   (zoom      :accessor get-zoom      :initarg :zoom)
   (address   :accessor get-address   :initarg :address)
   (viewable  :accessor is-viewable   :initarg :viewable)))

(defun list-locations ()
  (let ((locations
	 (mapcar
	  #'(lambda (l)
	      (make-instance 'location
			     :id        (cdr (assoc :id l))
			     :name      (cdr (assoc :name l))
			     :longitude (cdr (assoc :longitude l))
			     :latitude  (cdr (assoc :latitude l))
			     :zoom      (cdr (assoc :zoom l))
			     :address   (cdr (assoc :address l))
			     :viewable  (from-rtm-type 'bool (cdr (assoc :viewable l)))))
	  (rtm:rtm-api-locations-get-list))))
    (setf (get-locations *rtm-user-info*) locations)))

;; (list-locations)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Task
(defclass task (rtm-object)
  ((list-id       :accessor get-list-id       :initarg :list-id)
   (taskseries-id :accessor get-taskseries-id :initarg :taskseries-id)
   (task-id       :accessor get-task-id       :initarg :task-id)
   (created       :accessor get-created       :initarg :created)
   (modified      :accessor get-modified      :initarg :modified)
   (name          :accessor get-name          :initarg :name)
   (source        :accessor get-source        :initarg :source)
   (url           :accessor get-url           :initarg :url)
   (location-id   :accessor get-location-id   :initarg :location-id)
   (tags          :accessor get-tags          :initarg :tags :initform nil)
   (recurrence    :accessor get-recurrence    :initarg :recurrence :initform '((:every) (:after)))
   (participants  :accessor get-participants  :initarg :participants :initform nil)
   (notes         :accessor get-notes         :initarg :notes :initform nil)
   (due           :accessor get-due           :initarg :due)
   (has-due-time  :accessor has-due-time      :initarg :has-due-time)
   (added         :accessor get-added         :initarg :added)
   (completed     :accessor get-completed     :initarg :completed)
   (deleted       :accessor get-deleted       :initarg :deleted)
   (priority      :accessor get-priority      :initarg :priority)
   (postponed     :accessor get-postponed     :initarg :postponed)
   (estimate      :accessor get-estimate      :initarg :estimate)))

(defun rtm-list-tasks-on-list (wanted-list &key filter last-sync)
  (apply
   #'append
   (mapcar
    #'(lambda (list)
	(mapcar
	 #'(lambda (taskseries)
	     (let* ((task         (cdr (assoc :task taskseries)))
		    (participants
		     (mapcar #'(lambda (c)
				 (let ((c (cdr c)))
				   (make-instance 'contact
						  :id       (cdr (assoc :id c))
						  :username (cdr (assoc :username c))
						  :fullname (cdr (assoc :fullname c)))))
			     (cdr (assoc :participants taskseries))))
		    (notes
		     (mapcar #'(lambda (n)
				 (let ((n (cdr n)))
				   (make-instance 'note
						  :id       (cdr (assoc :id n))
						  :created  (cdr (assoc :created n))
						  :modified (cdr (assoc :modified n))
						  :title    (cdr (assoc :title n))
						  :contents (cdr (assoc :$t n)))))
			     (cdr (assoc :notes taskseries))))
		    (tags
		     (mapcar #'(lambda (tag)
				 (cdr tag))
			     (cdr (assoc :tags taskseries))))
		    (recurrence
		     (let ((rrule (cdr (assoc :rrule taskseries))))
		     `((:every . ,(when (from-rtm-type 'bool
						       (cdr (assoc :every rrule)))
					(cdr (assoc :$t rrule))))
		       (:after . ,(when (from-rtm-type 'bool
						       (cdr (assoc :after rrule)))
					(cdr (assoc :$t rrule)))))))
		    (new-task
		     (make-instance 'task
				    :list-id       (cdr (assoc :id list))
				    :taskseries-id (cdr (assoc :id taskseries))
				    :task-id       (cdr (assoc :id task))
				    :created       (cdr (assoc :created taskseries))
				    :modified      (cdr (assoc :modified taskseries))
				    :name          (cdr (assoc :name taskseries))
				    :source        (cdr (assoc :source taskseries))
				    :url           (cdr (assoc :url taskseries))
				    :location-id   (cdr (assoc :location-id taskseries))
				    :tags          tags
				    :recurrence    recurrence
				    :participants  participants
				    :notes         notes
				    :due           (cdr (assoc :due task))
				    :has-due-time  (from-rtm-type
						    'bool
						    (cdr (assoc :has_due_time task)))
				    :added         (cdr (assoc :added task))
				    :completed     (cdr (assoc :completed task))
				    :deleted       (cdr (assoc :deleted task))
				    :priority      (cdr (assoc :priority task))
				    :postponed     (from-rtm-type 'bool
								  (cdr (assoc :postponed task)))
				    :estimate      (cdr (assoc :estimate task)))))
	       (mapcar #'(lambda (n) (setf (get-task n) new-task)) (get-notes new-task))
	       new-task))
	 (let ((taskseries (cdr (assoc :taskseries list))))
	   (if (atom (caar taskseries))
	       (list taskseries)
	       taskseries))))
    (rtm:rtm-api-tasks-get-list (get-id wanted-list)
				:filter filter
				:last-sync last-sync))))

(defun rtm-refresh-all-lists ()
  (dolist (l (reverse (get-task-lists *rtm-user-info*)))
    ;;(format t "RTM refreshing list ~a...~%" (get-name l))
    (rtm-list-tasks-on-list l)))

;;(rtm-refresh-all-lists)

(defmethod rtm-add-task ((list list) name &optional (parse-date-in-name-p nil))
  (let* ((alist (cdr (assoc :list
			    (rtm:rtm-api-tasks-add (get-id list) name parse-date-in-name-p))))
	 (taskseries (cdr (assoc :taskseries alist)))
	 (task (cdr (assoc :task taskseries)))
	 (new-task (make-instance 'task
				  :list-id       (cdr (assoc :id alist))
				  :taskseries-id (cdr (assoc :id taskseries))
				  :task-id       (cdr (assoc :id task))
				  :created       (cdr (assoc :created taskseries))
				  :modified      (cdr (assoc :modified taskseries))
				  :name          (cdr (assoc :name taskseries))
				  :source        (cdr (assoc :source taskseries))
				  :url           (cdr (assoc :url taskseries))
				  :location-id   (cdr (assoc :location-id taskseries))
				  :due           (cdr (assoc :due task))
				  :has-due-time  (from-rtm-type 'bool
								(cdr (assoc :has_due_time task)))
				  :added         (cdr (assoc :added task))
				  :completed     (cdr (assoc :completed task))
				  :deleted       (cdr (assoc :deleted task))
				  :priority      (cdr (assoc :priority task))
				  :postponed     (from-rtm-type 'bool
								(cdr (assoc :postponed task)))
				  :estimate      (cdr (assoc :estimate task)))))
    ;; To reflect smartlists, one should recalculate all lists again:
    (rtm-refresh-all-lists)
    (find-by-id (get-id new-task) (get-tasks list))))

(defmethod rtm-add-tags ((task task) tags)
  (rtm:rtm-api-tasks-add-tags (get-list-id task)
			      (get-taskseries-id task)
			      (get-task-id task)
			      tags)
  (setf (get-tags task)
	(append (get-tags task) tags)))

(defmethod rtm-remove-tags ((task task) tags)
  (rtm:rtm-api-tasks-remove-tags (get-list-id task)
				 (get-taskseries-id task)
				 (get-task-id task)
				 tags)
  (setf (get-tags task)
	(set-difference (get-tags task) tags)))

(defmethod rtm-change-task-tags ((task task) tags)
  (rtm:rtm-api-tasks-set-tags (get-list-id task)
			      (get-taskseries-id task)
			      (get-task-id task)
			      tags)
  (setf (get-tags task)
	tags)
  task)


(defmethod rtm-complete-task ((task task))
  (let ((result
	 (rtm:rtm-api-tasks-complete (get-list-id task)
				     (get-taskseries-id task)
				     (get-task-id task))))
    (setf (get-completed task)
	(cdr (assoc :completed
		    (cdr (assoc :task
				(cdr (assoc :taskseries
					    (cdr (assoc :list result)))))))))
    task))

(defmethod rtm-uncomplete-task ((task task))
  (rtm:rtm-api-tasks-uncomplete (get-list-id task)
				(get-taskseries-id task)
				(get-task-id task))
  (setf (get-completed task) nil)
  task)


(defmethod rtm-delete-task ((task task))
  (let ((result
	 (rtm:rtm-api-tasks-delete (get-list-id task)
				     (get-taskseries-id task)
				     (get-task-id task))))
    (setf (get-deleted task)
	(cdr (assoc :deleted
		    (cdr (assoc :task
				(cdr (assoc :taskseries
					    (cdr (assoc :list result)))))))))
    task))

(defmethod rtm-change-task-priority ((task task) move-up-p)
  (let ((result
	 (rtm:rtm-api-tasks-move-priority (get-list-id task)
					  (get-taskseries-id task)
					  (get-task-id task)
					  (if move-up-p "up" "down"))))
    (setf (get-priority task)
	(cdr (assoc :priority
		    (cdr (assoc :task
				(cdr (assoc :taskseries
					    (cdr (assoc :list result)))))))))))

(defmethod rtm-move-task-to-list ((task task) (list list))
  (rtm:rtm-api-tasks-move-to (get-list-id task)
			     (get-id list)
			     (get-taskseries-id task)
			     (get-task-id task))
  (let ((old-list (find-by-id (get-list-id task)
			      (get-task-lists *rtm-user-info*))))
    (setf (get-list-id task) (get-id list))
    (setf (get-tasks old-list)
	  (delete-if (lambda (x) (string= (get-id x) (get-id task)))
		     (get-tasks old-list)))
    (pushnew task (get-tasks list) :key #'get-id :test #'string=)))

(defmethod rtm-postpone-task ((task task))
  (let ((result
	 (rtm:rtm-api-tasks-postpone (get-list-id task)
				     (get-taskseries-id task)
				     (get-task-id task))))
    (setf (get-postponed task) t)
    (setf (get-due task)
	(cdr (assoc :due
		    (cdr (assoc :task
				(cdr (assoc :taskseries
					    (cdr (assoc :list result)))))))))
    task))

(defmethod rtm-change-task-due-date ((task task) due-date &optional has-due-time-p parse-p)
  (let ((result
	 (rtm:rtm-api-tasks-set-due-date (get-list-id task)
					 (get-taskseries-id task)
					 (get-task-id task)
					 due-date
					 (to-rtm-type 'bool has-due-time-p)
					 (to-rtm-type 'bool parse-p))))
    (setf (get-due task)
	(cdr (assoc :due
		    (cdr (assoc :task
				(cdr (assoc :taskseries
					    (cdr (assoc :list result)))))))))
    (setf (has-due-time task)
	  has-due-time-p)
    task))

(defmethod rtm-change-task-estimate ((task task) estimate)
  (let ((result
	 (rtm:rtm-api-tasks-set-estimate (get-list-id task)
					 (get-taskseries-id task)
					 (get-task-id task)
					 estimate)))
    (setf (get-estimate task)
	(cdr (assoc :estimate
		    (cdr (assoc :task
				(cdr (assoc :taskseries
					    (cdr (assoc :list result)))))))))
    task))

(defmethod rtm-change-task-location ((task task) (location location))
  (rtm:rtm-api-tasks-set-location (get-list-id task)
				  (get-taskseries-id task)
				  (get-task-id task)
				  (get-id location))
  (setf (get-location-id task)
	(get-id location))
  task)

(defmethod rtm-change-task-name ((task task) name)
  (rtm:rtm-api-tasks-set-name (get-list-id task)
			      (get-taskseries-id task)
			      (get-task-id task)
			      name)
  (setf (get-name task)
	name)
  task)

(defmethod rtm-change-task-priority ((task task) priority)
  (rtm:rtm-api-tasks-set-priority (get-list-id task)
				  (get-taskseries-id task)
				  (get-task-id task)
				  priority)
  (setf (get-priority task)
	priority)
  task)

(defmethod rtm-change-task-recurrence ((task task) recurrence)
  (let* ((result (rtm:rtm-api-tasks-set-recurrence (get-list-id task)
						  (get-taskseries-id task)
						  (get-task-id task)
						  recurrence))
	 (rrule (cdr (assoc :rrule
			    (cdr (assoc :taskseries
					(cdr (assoc :list result))))))))
    (setf (get-recurrence task)
	  `((:every . ,(when (from-rtm-type 'bool
					    (cdr (assoc :every rrule)))
			     (cdr (assoc :$t rrule))))
	    (:after . ,(when (from-rtm-type 'bool
					    (cdr (assoc :after rrule)))
			     (cdr (assoc :$t rrule)))))))
  task)

(defmethod rtm-change-task-url ((task task) url)
  (rtm:rtm-api-tasks-set-url (get-list-id task)
			     (get-taskseries-id task)
			     (get-task-id task)
			     url)
  (setf (get-url task)
	url)
  task)


;; TODO: make each *rtm-user-info* update save the last check time, and
;; TODO: only fetch recent changes.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Note
(defclass note (rtm-object)
  ((id       :accessor get-id       :initarg :id)
   (created  :accessor get-created  :initarg :created)
   (modified :accessor get-modified :initarg :modified)
   (task     :accessor get-task     :initarg :task)
   (title    :accessor get-title    :initarg :title)
   (contents :accessor get-contents :initarg :contents)))

(defmethod rtm-add-note-to-task ((task task) title text)
  (let ((alist (rtm:rtm-api-tasks-notes-add
		 (get-list-id task)
		 (get-taskseries-id task)
		 (get-task-id task)
		 title
		 text)))
    (let ((new-note (make-instance 'note
				   :id (cdr (assoc :id alist))
				   :created (cdr (assoc :created alist))
				   :modified (cdr (assoc :modified alist))
				   :task task
				   :title (cdr (assoc :title alist))
				   :contents (cdr (assoc :$T alist)))))
    (pushnew new-note (get-notes task) :key #'get-id :test #'string=)
    new-note)))

;; (rtm-list-task-lists)

;; (rtm-add-note-to-task (nth 0 (rtm-list-tasks-on-list (nth 4 (get-task-lists *rtm-user-info*))))
;; 	      "aaa" "eeee")

;; (rtm-delete-note (nth 0 (get-notes (nth 0 (rtm-list-tasks-on-list (nth 4 (get-task-lists *rtm-user-info*)))))))

;; (rtm-edit-note (nth 0 (get-notes (nth 0 (rtm-list-tasks-on-list (nth 4 (get-task-lists *rtm-user-info*))))))
;; 	       "yadda" "weeee!")


(defmethod rtm-delete-note ((n note))
  (when n
    (rtm:rtm-api-tasks-notes-delete (get-id n))
    (delete-if (lambda (x) (string= (get-id x) (get-id n)))
	       (get-notes (get-task n)))))

(defmethod rtm-edit-note ((n note) new-title new-text)
  (let ((alist (rtm:rtm-api-tasks-notes-edit (get-id n) new-title new-text)))
    (format t "~s~%" alist)    
    (setf (get-title    n) new-title
	  (get-contents n) new-text
	  (get-modified n) (cdr (assoc :modified alist)))
    n))

