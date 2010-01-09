;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; asdf-upgrade.lisp --- Upgrading ASDF-INSTALL packages.
;;;
;;; Copyright (C) 2005, James Bielman  <jamesjb@jamesjb.com>
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without
;;; restriction, including without limitation the rights to use, copy,
;;; modify, merge, publish, distribute, sublicense, and/or sell copies
;;; of the Software, and to permit persons to whom the Software is
;;; furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;; NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;;; DEALINGS IN THE SOFTWARE.
;;;

(in-package #:asdf-upgrade)

;;;# Collecting Information on Installed Packages
;;;
;;; Since there is no registry written by ASDF-INSTALL about the
;;; packages that have been installed, we have to grovel over the
;;; directories containing unpacked source trees and figure out what
;;; information we can.
;;;
;;; Rather than try to make use of package version information that
;;; could be in any format (and may not be present at all), this
;;; utility uses timestamps to determine if one version of a package
;;; is newer than the other.
;;;
;;; Using the modification time of the package directory is not
;;; correct.  It might work some of the time, especially if only one
;;; Lisp implementation is being used, or you compile under all Lisps
;;; at around the same time.  What we really need is a timestamp
;;; somewhere that is set once when the package is downloaded
;;; (preferably based on the timestamp of the tarball).

;;; Information collected about an installed ASDF package.  Instances
;;; of this class are passed to the function argument passed to
;;; MAP-INSTALLED-PACKAGES.
(defclass installed-package ()
  ((name
    ;; Name of the package, a string.
    :initform (error "A name is required.")
    :initarg :name
    :accessor name)
   (version
    ;; Version string of the package from its directory.
    :initform (error "A version is required.")
    :initarg :version
    :accessor version)
   (source-pathname
    ;; The pathname containing the unpacked source tree.
    :initform (error "A source pathname is required.")
    :initarg :source-pathname
    :accessor source-pathname)
   (installation-date
    ;; Approximate time the package was installed.
    :initform (error "An installation date is required.")
    :initarg :installation-date
    :accessor installation-date)))

;;; Print an INSTALLED-PACKAGE instance to STREAM for debugging.
(defmethod print-object ((package installed-package) stream)
  (print-unreadable-object (package stream :type t :identity nil)
    (format stream "~S version ~S" (name package) (version package))))

;;; Return two values, the subsequence of STRING before POSITION and
;;; the subsequence after it.
(defun split-at-separator (string position)
  (values (subseq string 0 position) (subseq string (1+ position))))

;;; Given a directory name containing a downloaded package, return the
;;; package name and version as multiple values.  The directory should
;;; conform to the <PACKAGENAME>_<VERSION> format, but many do not, so
;;; we guess and split at the last '-' and if the following character
;;; is numeric, use it as the version.
(defun package-name-and-version (name)
  (let ((separator (position #\_ name :from-end t)))
    (if separator
        (split-at-separator name separator)
        (let ((separator (position #\- name :from-end t)))
          (if (and separator (digit-char-p (char name (1+ separator))))
              (split-at-separator name separator)
              (values name "unknown"))))))

;;; Return the package name and version for a pathname containing an
;;; unpacked ASDF-INSTALLed package.  PATHNAME should be in directory
;;; form.
(defun package-directory-name-and-version (pathname)
  (unless (directory-pathname-p pathname)
    (error "Pathname ~S is not in directory form." pathname))
  (package-name-and-version (car (last (pathname-directory pathname)))))

;;; Return a list of all installed packages in the system by
;;; traversing ASDF-INSTALL:*LOCATIONS* and looking at the package
;;; directories.
(defun list-installed-packages ()
  (let (result)
    (dolist (loc (mapcar #'first asdf-install:*locations*))
      (dolist (dir (list-directory loc))
        (when (directory-exists-p dir)
          (multiple-value-bind (name version)
              (package-directory-name-and-version dir)
            (push (make-instance 'installed-package :name name
                                 :version version
                                 :source-pathname dir
                                 :installation-date (file-write-date dir))
                  result)))))
    (nreverse result)))

;;; Iterate over the directories containing installed systems and call
;;; FUNCTION passing an INSTALLED-PACKAGE instance for each package
;;; found in both the user and system ASDF-INSTALL directories.
;;; Returns the results of FUNCTION as a list in order like MAPCAR.
(defun map-installed-packages (function)
  (mapcar function (list-installed-packages)))

;;; Return a copy of PACKAGE-LIST keeping only the newest
;;; version of each package, as compared by installation date.
(defun newest-versions (package-list)
  (remove-duplicates
   (sort (copy-list package-list) #'> :key #'installation-date)
   :test #'equalp :key #'name :from-end t))

;;; Return a list of the newest versions of all installed packages.
(defun list-newest-installed-packages ()
  (newest-versions (list-installed-packages)))

;;; Map FUNCTION over the newest versions of all installed packages.
(defun map-newest-installed-packages (function)
  (mapcar function (list-newest-installed-packages)))

;;; Return the INSTALLED-PACKAGE instance for the newest version of
;;; the package NAME (as compared by installation time).  Returns nil
;;; if no package with that name is available.
(defun find-installed-package (name)
  (find name (list-newest-installed-packages) :test #'equalp :key #'name))

;;;# Upgrading Packages
;;;
;;; To determine if an installed package needs to be upgraded, we
;;; compare the timestamp of the most recently installed version with
;;; the last modification time of the tarball pointed to by the
;;; package's CLiki page.  There are some holes here if your system
;;; clock is really off, use a time server already!

;;; Return the last modification time of whatever version of PACKAGE
;;; is available from the link on its CLiki page.
(defun available-version-write-date (package)
  (page-write-date (package-tarball-url (name package))))

;;; Return true if PACKAGE could be upgraded based on the modification
;;; times of the local installation and the available tarball.
(defun upgrade-available-p (package)
  (> (available-version-write-date package) (installation-date package)))

;;; Perform an upgrade of PACKAGE using ASDF-INSTALL to download and
;;; install the new tarball.
(defun upgrade-package (package)
  (asdf-install:install (name package)))

;;; Return a string describing the available upgrade status of an
;;; installed package.
(defun upgrade-status (package)
  (handler-case
      (if (upgrade-available-p package)
          "Upgrade available"
          "Up to date")
    (http-error (c)
      (format nil "HTTP error ~D" (response-code c)))
    (package-unavailable-error ()
      "Package unavailable from CLiki")))

;;; Return the maximum length of the strings returned by applying
;;; FUNCTION to each element of LIST.
(defun maximize-string-length (list function)
  (loop for thing in list
        maximize (length (funcall function thing))))

;;; Print a report of installed packages and available upgrades.
(defun report ()
  (let* ((packages (list-newest-installed-packages))
         (name-len (maximize-string-length packages #'name))
         (version-len (maximize-string-length packages #'version)))
    (when (plusp (length packages))
      (format t "~vA ~vA ~A~%" name-len "Name"
              version-len "Version" "Upgrade Status")
      (format t "~A~%" (make-string 72 :initial-element #\-)))
    (dolist (package (sort (copy-list packages) #'string-lessp :key #'name))
      (with-simple-restart (continue "Continue processing packages.")
        (format t "~vA ~vA ~A~%"
                name-len (name package)
                version-len (version package)
                (upgrade-status package))))))

;;; Return two values---the list of packages that can be upgraded, and
;;; the list of packages that are uncertain due to errors.
(defun upgradable-and-broken-packages ()
  (let (upgradable broken)
    (format t "~&;; Checking available packages")
    (dolist (package (list-newest-installed-packages))
      (format t ".")
      (force-output)
      (handler-case
          (when (upgrade-available-p package)
            (push package upgradable))
        (broken-package-error ()
          (push package broken))))
    (format t "done~%")
    (values (nreverse upgradable) (nreverse broken))))

;;; Upgrade available packages.  This is the main user entry point,
;;; and is intentionally similar in interface to 'apt-get'.
(defun upgrade ()
  (multiple-value-bind (upgrade-list broken-list)
      (upgradable-and-broken-packages)
    (when (plusp (length upgrade-list))
      (format t ";; The following packages will be upgraded:~%")
      (format t ";;   ~{~<~%;;   ~1,72:;~A~>~^ ~}~%" (mapcar #'name upgrade-list))
      (format t ";; The following packages are broken and cannot be checked:~%")
      (format t ";;   ~{~<~%;;   ~1,72:;~A~>~^ ~}~%" (mapcar #'name broken-list))
      (format t ";; Do you want to continue [Y/n]? ")
      (force-output)
      (when (member (read-char *query-io*) '(#\y #\Return #\Newline))
        (apply #'asdf-install:install (mapcar #'name upgrade-list))))))

;;;# HTTP Interface
;;;
;;; This is all pretty gross as written.  I'd use TRIVIAL-HTTP but its
;;; homepage is a broken link.  So, for now, use the (primitive) HTTP
;;; client used by ASDF-INSTALL.  Once there is a simple HTTP client
;;; available via ASDF-INSTALL this will need to be rewritten.

;;; Base condition class for errors that indicate a package is broken.
(define-condition broken-package-error (error)
  ())

;;; Condition signalled on HTTP errors.
(define-condition http-error (broken-package-error)
  ((response-code
    ;; The response code from the HTTP server.
    :initform (error "A response code is required.")
    :initarg :response-code
    :reader response-code)
   (url
    ;; The offending URL that caused this error.
    :initform (error "A URL is required.")
    :initarg :url
    :reader url)))

;;; Print an HTTP-ERROR condition to STREAM.
(defmethod print-object ((c http-error) stream)
  (format stream "HTTP server returned error ~D for URL ~S."
          (response-code c) (url c)))

;;; Condition signalled when no PACKAGE tag is present on the CLiki
;;; page for an installed package.
(define-condition package-unavailable-error (broken-package-error)
  ((name
    ;; The name of the package that was unavailable.
    :initform (error "A package name is required.")
    :initarg :name
    :reader name)))

;; Print a PACKAGE-UNAVAILABLE-ERROR condition to STREAM.
(defmethod print-object ((c package-unavailable-error) stream)
  (format stream "No package is available for ~S." (name c)))

;;; Return true if STRING begins with PREFIX using TEST.
(defun string-prefix-p (string prefix &key (test #'equalp))
  (let ((pos (search prefix string :test test)))
    (and pos (= pos 0))))

;;; Concatenate a URL with a relative path, adding a slash if needed.
(defun urlconc (url relpath)
  (format nil "~A~A~A" url
          (if (eql (char url (1- (length url))) #\/) "" "/")
          relpath))

;;; Remove trailing carriage returns and line feeds from STRING.
(defun chop-string (string)
  (string-right-trim (list (code-char 13) (code-char 10)) string))

;;; Open a stream to an HTTP server for URL.  Redirects are handled,
;;; other responses return the response code, an association list of
;;; headers, and a stream for reading the page data.
(defun http-request (url &key (redirects t))
  (tagbody
   again
     (destructuring-bind (response headers stream)
         (asdf-install::url-connection url)
       (when (and redirects (member response '(301 302)))
         (setf url (cdr (assoc :location headers)))
         (close stream)
         (go again))
       (return-from http-request
         (values response headers stream)))))

;;; Bind RESPONSE, HEADERS, and STREAM to the return values of
;;; HTTP-REQUEST on URL and close STREAM upon exit of BODY.
(defmacro with-http-request ((response headers stream url &key (redirects t))
                             &body body)
  `(multiple-value-bind (,response ,headers ,stream)
       (http-request ,url :redirects ,redirects)
     (declare (ignorable ,response ,headers ,stream))
     (with-open-stream (,stream ,stream)
       ,@body)))

;;; Better version of PACKAGE-TARBALL-URL.
(defun package-tarball-url (package)
  (let ((url (format nil "http://www.cliki.net/~A?download" package)))
    (tagbody
     again
       (with-http-request (response headers stream url :redirects nil)
         (unless (= response 302)
           (error 'http-error :response-code response :url url))
         (let ((location (cdr (assoc :location headers))))
           ;; If the location is still a CLiki URL, follow it.
           (when (search "http://www.cliki.net/" location)
             (setf url location)
             (go again))
           (return-from package-tarball-url location))))))

;;; Return the last modification date of URL as a universal time.  It
;;; would be very nice to do a proper HTTP HEAD here instead of simply
;;; not reading the body.
(defun page-write-date (url)
  (with-http-request (response headers stream url)
      (unless (= response 200)
        (error 'http-error :response-code response :url url))
    (let ((timestring (cdr (assoc :last-modified headers))))
      (unless timestring
        (error "Last modification date for URL ~S is not available." url))
      (parse-time timestring
                  :patterns net.telent.date::*http-date-time-patterns*))))
