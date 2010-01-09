#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Documentation

;;; Project title: rtm-lisp-api

;;; Author: Edgar Gonçalves (edgar.goncalves@gmail.com)

;;; Summary: "Remember The Milk" API Kit for Common Lisp

;;; Created in Apr 13 2008

;;; Description
This API Kit allows easy access to the exposed interfaces of Remember The
Milk (provided that you have your own API Key).
It is intended to be used in either desktop or web-based applications.
Note that this project is intended solely as a programming library, not
providing any kind of user interface. You can, however, test all methods from
within any Common Lisp interpreter.


;;; About the documentation
To see the Remember the Milk documentation for each api call, use its
name (e.g., rtm.test.echo) and add it in the end of the documentation URL, like
http://www.rememberthemilk.com/services/api/methods/rtm.test.echo.rtm You will
find a description, the authentication and arguments requirements, as well as
error codes and an example response.

;;; TODO:
- The output of every call could be an object instead of an alist.
- The errors should be listed properly, with continuable errors.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Package initialization

(in-package :rtm-lisp-api)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Configurable variables:

(defvar rtm-api-key "123456"
  "API key to be used in your application only.")

(defvar rtm-api-shared-secret "BANANAS"
  "Shared secret to be used in your application only.")

(defvar rtm-api-endpoint "http://api.rememberthemilk.com/services/rest/"
  "Server URI to call RTM methods.")

(defvar rtm-api-auth-endpoint "http://www.rememberthemilk.com/services/auth/"
  "Server URI to perform authentication.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Encryption

(defun md5 (string)
  "MD5 uses ironclad to encode `STRING' into an hexadecimal digest string." 
  (ironclad:byte-array-to-hex-string
   (ironclad:digest-sequence :md5 (ironclad:ascii-string-to-byte-array string))))

(defun flatten-alist-into-string (alist)
  "Produces a list of strings out of an `ALIST', with pairs of strings."
  (mapcar #'(lambda (x)
	      (concatenate 'string (car x) (cdr x)))
	  alist))

(defun compute-rtm-api-sig (parameters)
  "RTM signature creation algorithm. Produces a string code given an alist of
`PARAMETERS' (with pairs of strings). For more info see
http://www.rememberthemilk.com/services/api/authentication.rtm."
  (md5
   (apply #'concatenate 'string
	  (cons rtm-api-shared-secret
		(flatten-alist-into-string
		 (sort parameters
		       (lambda (x y)
			 (string< (car x) (car y)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Timelines - RTM transaction mechanism that allows undo operations.

;;;rtm.timelines.create
(defun rtm-api-timelines-create ()
  (cdr (assoc :timeline
	      (rtm-api-call-method "rtm.timelines.create" nil :with-authentication t))))

(defvar *current-timeline* nil)

(defmacro with-timeline (&body body)
  `(progn
     (unless *current-timeline*
       (setf *current-timeline* (rtm-api-timelines-create)))
     ,@body))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Transactions - RTM returns them in some method calls to allow undos.

(defvar *last-transaction* nil)

;;rtm.transactions.undo
(defun rtm-api-transactions-undo (&key (transaction-id *last-transaction*))
  "Undoes the effects of the method call that returned `TRANSACTION-ID'.
Can't be redone."
  (rtm-api-call-method "rtm.transactions.undo"
		       `(("transaction_id" . ,transaction-id))
		       :with-authentication t
		       :with-timeline t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; RTM Method call utility

(define-condition rtm-error ()
  ((code :accessor get-code :initarg :code)
   (message :accessor get-message :initarg :message)))

(defmethod print-object ((c rtm-error) stream)
  (format stream "RTM returned error with code ~a: ~a" (get-code c) (get-message c)))

(defun rtm-api-call-method (method &optional key-value-pairs &key with-timeline with-authentication (format "json"))
  "Calls `METHOD'.
 - Optionally passes pairs of strings in `KEY-VALUE-PAIRS' in the form
of (`PARAMETER' . `VALUE').
 - Keyword `WITH-TIMELINE', if not null, allows the method to be called within
the `*CURRENT-TIMELINE*'.
 - Keyword `WITH-AUTHENTICATION', if not null, allows the method call to be
authenticated with a valid `*RTM-API-TOKEN*'.
 - Keyword `FORMAT' is one of \"json\" (the default value) or \"rest\", and
specifies the server reply format."
  (declare (special *current-timeline* *rtm-api-token*))
  (let* ((parameters `(("api_key"    . ,rtm-api-key)
		       ("method"     . ,method)
		       ("format"     . ,format)
		       ,@(when with-timeline
			       (with-timeline
				 `(("timeline" . ,*current-timeline*))))
		       ,@(when with-authentication
			    `(("auth_token" . ,*rtm-api-token*)))
		       ,@key-value-pairs))
	 (api-sig (compute-rtm-api-sig parameters)))
    (multiple-value-bind (result)
	(http-request rtm-api-endpoint
		      :method :post
		      :parameters `(
				    ,@parameters
				    ("api_sig" . ,api-sig)))

      (let* ((response (json-bind (rsp) result rsp))
	     (stat (assoc :stat response)))
	(cond
	  ((string=  (cdr stat) "ok")
	   (rest response))
	  ((string=  (cdr stat) "fail")
	   (let ((err-info (cdr (assoc :err response))))
	     (error 'rtm-error
		    :code (cdr (assoc :code err-info))
		    :message (cdr (assoc :msg err-info))))))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Authenticating the application using a frob
(defvar *rtm-api-current-frob* "")

(defun rtm-api-invalid-frob-p (frob)
  (or (null frob)
      (string= "" frob)))

(defun rtm-api-get-frob ()
  (setf *rtm-api-current-frob* "")
  (setf *rtm-api-current-frob*
	(cdr (assoc :frob (rtm-api-call-method "rtm.auth.getFrob")))))

(defun rtm-api-build-auth-url (&key (perms "delete"))
  (let* ((frob (rtm-api-get-frob))
	 (parameters `(("api_key" . ,rtm-api-key)
		       ("perms"   . ,perms)
		       ("frob"    . ,frob)))
	 (api-sig (compute-rtm-api-sig parameters)))
    (format nil "~a?api_key=~a&perms=~a&frob=~a&api_sig=~a"
	    rtm-api-auth-endpoint
	    rtm-api-key
	    perms
	    frob
	    api-sig)))

(defvar *rtm-api-token* ""
  "Current token used for authenticate each method call.")
(defvar *rtm-api-perms* ""
  "Permissions for the current user (read, write or delete).")
(defvar *rtm-api-user* nil
  "Current user's details")

(defun rtm-api-get-token ()
  (let ((auth
	 (cdr
	  (assoc :auth
		 (rtm-api-call-method "rtm.auth.getToken"
				      `(("frob" . ,*rtm-api-current-frob*)))))))
    
    (setf *rtm-api-token* (cdr (assoc :token auth)))
    (setf *rtm-api-perms* (cdr (assoc :perms auth)))
    (setf *rtm-api-user*  (cdr (assoc :user auth)))))

#|
;;; Instructions:
;;; 1. Clean the frob, ask RTM for a new one, and then get the token.

;; 2. Open the url in a browser window to gain authorization (example for
;; OpenMCL):
; (ccl::run-program "open" (list (rtm-api-build-auth-url)))

;; Then call the next method to set our token in `*RTM-API-TOKEN*'.
;(rtm-api-get-token)
|#

;;;rtm.auth.checkToken
(defun rtm-api-check-token ()
  (let ((auth (cdr
	       (assoc :auth
		      (rtm-api-call-method "rtm.auth.checkToken"
					   `(("auth_token" . ,*rtm-api-token*)))))))
    (setf *rtm-api-token* (cdr (assoc :token auth)))
    (setf *rtm-api-perms* (cdr (assoc :perms auth)))
    (setf *rtm-api-user*  (cdr (assoc :user auth)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Contacts
;;;rtm.contacts.add
(defun rtm-api-contacts-add (contact-name)
  (rtm-api-call-method "rtm.contacts.add"
		       `(("contact" . ,contact-name))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.contacts.delete
(defun rtm-api-contacts-delete (contact-id)
  (rtm-api-call-method "rtm.contacts.delete"
		       `(("contact_id" . ,contact-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.contacts.getList
(defun rtm-api-contacts-get-list ()
  (cdr (assoc :contact
	      (cdr (assoc :contacts
			  (rtm-api-call-method "rtm.contacts.getList"
					       nil
					       :with-authentication t))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Groups

;;;rtm.groups.add
(defun rtm-api-groups-add (group-name)
  (rtm-api-call-method "rtm.groups.add"
		       `(("group" . ,group-name))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.groups.addContact
(defun rtm-api-groups-add-contact (group-id contact-id)
  (rtm-api-call-method "rtm.groups.addContact"
		       `(("group_id" . ,group-id)
			 ("contact_id" . ,contact-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.groups.delete
(defun rtm-api-groups-delete (group-id)
  (rtm-api-call-method "rtm.groups.delete"
		       `(("group_id" . ,group-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.groups.getList
(defun rtm-api-groups-get-list ()
  (cdr (assoc :group
	      (cdr (assoc :groups
			  (rtm-api-call-method "rtm.groups.getList"
					       nil
					       :with-authentication t))))))

;;;rtm.groups.removeContact
(defun rtm-api-groups-remove-contact (group-id contact-id)
  (rtm-api-call-method "rtm.groups.removeContact"
		       `(("group_id" . ,group-id)
			 ("contact_id" . ,contact-id))
		       :with-authentication t
		       :with-timeline t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Lists

;;;rtm.lists.add
(defun rtm-api-lists-add (list-name filter)
  (rtm-api-call-method "rtm.lists.add"
		       `(("name" . ,list-name)
			 ("filter" . ,filter))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.lists.archive
(defun rtm-api-lists-archive (list-id)
  (rtm-api-call-method "rtm.lists.archive"
		       `(("list_id" . ,list-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.lists.delete
(defun rtm-api-lists-delete (list-id)
  (rtm-api-call-method "rtm.lists.delete"
		       `(("list_id" . ,list-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.lists.getList
(defun rtm-api-lists-get-list ()
  (cdr (assoc :list
	      (cdr (assoc :lists
			  (rtm-api-call-method "rtm.lists.getList"
					       nil
					       :with-authentication t))))))


;;;rtm.lists.setDefaultList
(defun rtm-api-lists-set-default-list (list-id)
  (rtm-api-call-method "rtm.lists.setDefaultList"
		       `(("list_id" . ,list-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.lists.setName
(defun rtm-api-lists-set-name (list-id name)
  (rtm-api-call-method "rtm.lists.setName"
		       `(("list_id" . ,list-id)
			 ("name" . ,name))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.lists.unarchive
(defun rtm-api-lists-unarchive (list-id)
  (rtm-api-call-method "rtm.lists.unarchive"
		       `(("list_id" . ,list-id))
		       :with-authentication t
		       :with-timeline t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Locations

;;;rtm.locations.getList
(defun rtm-api-locations-get-list ()
  (cdr (assoc :location
	      (cdr (assoc :locations
			  (rtm-api-call-method "rtm.locations.getList"
					       nil
					       :with-authentication t
					       :with-timeline t))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Reflection

;;;rtm.reflection.getMethodInfo
(defun rtm-api-reflection-get-method-info (method-name)
  (rtm-api-call-method "rtm.reflection.getMethodInfo"
		       `(("method_name" . ,method-name))))

;;;rtm.reflection.getMethods
(defun rtm-api-reflection-get-methods ()
  (cdr (assoc :methods (rtm-api-call-method "rtm.reflection.getMethods" nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Settings

;;;rtm.settings.getList
(defun rtm-api-settings-get-list ()
  (cdr (assoc :settings
	      (rtm-api-call-method "rtm.settings.getList"
				   nil
				   :with-authentication t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Tasks

;;;rtm.tasks.add
(defun rtm-api-tasks-add (list-id name parse-date-in-name-p)
  (rtm-api-call-method "rtm.tasks.add"
		       `(("list_id" . ,list-id)
			 ("name"    . ,name)
			 ("parse"   . ,parse-date-in-name-p))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.addTags
(defun rtm-api-tasks-add-tags (list-id taskseries-id task-id tags)
  (when (listp tags) ;;we have a list of strings, we need a csv string
    (setf tags (format nil "~{~a~^,~}" tags)))
  (rtm-api-call-method "rtm.tasks.addTags"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("tags"          . ,tags))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.complete
(defun rtm-api-tasks-complete (list-id taskseries-id task-id)
  (rtm-api-call-method "rtm.tasks.complete"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.delete
(defun rtm-api-tasks-delete (list-id taskseries-id task-id)
  (rtm-api-call-method "rtm.tasks.delete"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.getList
(defun rtm-api-tasks-get-list (list-id &key filter last-sync)
  (let ((result
	 (cdr (assoc :list
		(cdr (assoc :tasks
			    (rtm-api-call-method "rtm.tasks.getList"
						 `(("list_id"       . ,list-id)
						   ,@(when filter
							   `(("filter" . ,filter)))
						   ,@(when last-sync
							   `(("last_sync" . ,last-sync))))
						 :with-authentication t
						 :with-timeline t)))))))
    ;; RTM returns a nested group or a single list, depending on the list-id:
    (if (atom (caar result))
	(list result)
	result)))

;;;rtm.tasks.movePriority
(defun rtm-api-tasks-move-priority (list-id taskseries-id task-id direction)
  (rtm-api-call-method "rtm.tasks.movePriority"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("direction"       . ,direction)
			 ("task_id"       . ,task-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.moveTo
(defun rtm-api-tasks-move-to (from-list-id to-list-id taskseries-id task-id)
  (rtm-api-call-method "rtm.tasks.moveTo"
		       `(("from_list_id"  . ,from-list-id)
			 ("to_list_id"    . ,to-list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.postpone
(defun rtm-api-tasks-postpone (list-id taskseries-id task-id)
  (rtm-api-call-method "rtm.tasks.postpone"
		       `(("list_id"  . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.removeTags
(defun rtm-api-tasks-remove-tags (list-id taskseries-id task-id tags)
  (when (listp tags) ;;we have a list of strings, we need a csv string
    (setf tags (format nil "~{~a~^,~}" tags)))
  (rtm-api-call-method "rtm.tasks.removeTags"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("tags"          . ,tags))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.setDueDate
(defun rtm-api-tasks-set-due-date (list-id taskseries-id task-id &optional (due "") (has-due-time "") (parse ""))
  (rtm-api-call-method "rtm.tasks.setDueDate"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("due"           . ,due)
			 ("has_due_time"  . ,has-due-time)
			 ("parse"         . ,parse))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.setEstimate
(defun rtm-api-tasks-set-estimate (list-id taskseries-id task-id &optional (estimate ""))
  (rtm-api-call-method "rtm.tasks.setEstimate"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("estimate"      . ,estimate))
		       :with-authentication t
		       :with-timeline t))


;;;rtm.tasks.setLocation
(defun rtm-api-tasks-set-location (list-id taskseries-id task-id &optional (location-id ""))
  (rtm-api-call-method "rtm.tasks.setLocation"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("location_id"   . ,location-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.setName
(defun rtm-api-tasks-set-name (list-id taskseries-id task-id name)
  (rtm-api-call-method "rtm.tasks.setName"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("name"          . ,name))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.setPriority
(defun rtm-api-tasks-set-priority (list-id taskseries-id task-id &optional (priority ""))
  (rtm-api-call-method "rtm.tasks.setPriority"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("priority"      . ,priority))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.setRecurrence
(defun rtm-api-tasks-set-recurrence (list-id taskseries-id task-id &optional (repeat ""))
  (rtm-api-call-method "rtm.tasks.setRecurrence"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("repeat"        . ,repeat))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.setTags
(defun rtm-api-tasks-set-tags (list-id taskseries-id task-id &optional tags)
  (when (listp tags) ;;we have a list of strings, we need a csv string
    (setf tags (format nil "~{~a~^,~}" tags)))
  (rtm-api-call-method "rtm.tasks.setTags"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("tags"          . ,tags))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.setURL
(defun rtm-api-tasks-set-url (list-id taskseries-id task-id url)
  (rtm-api-call-method "rtm.tasks.setURL"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id)
			 ("url"           . ,url))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.uncomplete
(defun rtm-api-tasks-uncomplete (list-id taskseries-id task-id)
  (rtm-api-call-method "rtm.tasks.uncomplete"
		       `(("list_id"       . ,list-id)
			 ("taskseries_id" . ,taskseries-id)
			 ("task_id"       . ,task-id))
		       :with-authentication t
		       :with-timeline t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Tasks.notes

;;;rtm.tasks.notes.add
(defun rtm-api-tasks-notes-add (list-id taskseries-id task-id note-title note-text)
  (cdr (assoc :note
	      (rtm-api-call-method "rtm.tasks.notes.add"
				   `(("list_id" . ,list-id)
				     ("taskseries_id" . ,taskseries-id)
				     ("task_id" . ,task-id)
				     ("note_title" . ,note-title)
				     ("note_text" . ,note-text))
				   :with-authentication t
				   :with-timeline t))))

;;;rtm.tasks.notes.delete
(defun rtm-api-tasks-notes-delete (note-id)
  (rtm-api-call-method "rtm.tasks.notes.delete"
		       `(("note_id" . ,note-id))
		       :with-authentication t
		       :with-timeline t))

;;;rtm.tasks.notes.edit
(defun rtm-api-tasks-notes-edit (note-id note-title note-text)
  (rtm-api-call-method "rtm.tasks.notes.edit"
		       `(("note_id" . ,note-id)
			 ("note_title" . ,note-title)
			 ("note_text" . ,note-text))
		       :with-authentication t
		       :with-timeline t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Test

;;;rtm.test.echo
(defun rtm-api-test-echo (name value)
  (rtm-api-call-method "rtm.test.echo" `((,name . ,value))))

;;;rtm.test.login
(defun rtm-api-test-login ()
  (rtm-api-call-method "rtm.test.login" nil :with-authentication t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Time

;;;rtm.time.convert
(defun rtm-api-time-convert (to-timezone &key (from-timezone "UTC") (time "now"))
  (rtm-api-call-method "rtm.time.convert"
		       `(("to_timezone" . ,to-timezone)
			 ("from_timezone" . ,from-timezone)
			 ("time" . ,time))))

;;;rtm.time.parse
(defun rtm-api-time-parse (text &key timezone date-format)
  (rtm-api-call-method "rtm.time.parse"
		       `(("text" . ,text)
			 ,@(when timezone
				 `(("timezone" . ,timezone)))
			 ,@(when date-format
				 `(("dateformat" . ,date-format))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Timezones

;;;rtm.timezones.getList
(defun rtm-api-timezones-get-list ()
  (cdr (assoc :timezones
	      (rtm-api-call-method "rtm.timezones.getList"))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
The MIT License

Copyright (c) 2008 Edgar Gonçalves

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
|#
