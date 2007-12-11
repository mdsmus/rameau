
;;;; The NILE Package - Neural Network Simulations in LISP and
;;;;                    simulations of language evolution
;;;; 
;;;; Copyright (C) 1999 Nils Goroll <slink@schokola.de>
;;;; 
;;;; This program is free software; you can redistribute it and/or
;;;; modify it under the terms of the GNU General Public License
;;;; as published by the Free Software Foundation; either version 2
;;;; of the License, or (at your option) any later version.
;;;; 
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;; 
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program; if not, write to the Free Software
;;;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
;;;; 
;;;; Contact: slink@schokola.de
;;;; Snailmail address should be available via
;;;; http://www.cityline.net/~slink/

;;;; $Id: nile_loader.lisp,v 1.7 1999/09/28 11:02:45 slink Exp $
;;;;
;;;;
;;;;
;;;; This is the loader
;;;;
;;;; It keeps itself compiled, such that (load "nile_loader") should
;;;; always load a compiled file. It does just provide one package,
;;;; nile_loader, and exports one function, load-and-compile.

(defvar *NILE-Version* "V0.2b")

(defpackage nile_loader
  (:use common-lisp)
  (:export load-and-compile
	   check-if-modified
	   gnunotice))

(in-package :nile_loader)

(defun check-if-modified ()
  (load-and-compile "nile_loader"))

#+python
(defmacro my-compile-file (&rest what)
  `(compile-file ,@what :byte-compile nil))

#-python
(defmacro my-compile-file (&rest what)
  `(compile-file ,@what))

(defun load-and-compile (&rest what)
  "Determines whether a package has been modified, assuming it
to be defined in a file of the same name. If it has been modified,
make sure the file is being compiled and loaded"
  (flet ((load-and-set-load-date (ctools ctools-fasl)
	   (and (load ctools-fasl)
		(set (or (find-symbol (symbol-name '*package-load-date*)
				      (find-package
				       (make-symbol
					(string-upcase ctools))))
			 (error (format t "*package-load-date* was not defined as parameter in ~a"
                      ctools)))
		     (get-universal-time))
		t)))
    (dolist (file what)
      (if (not (let* ((ctools file)
		      (ctools-lisp (format nil "~a.lisp" ctools))
		      (ctools-fasl (compile-file-pathname ctools-lisp))
		      (package (find-package
				(make-symbol
				 (string-upcase ctools))))
		      (package-load-date-symbol (and package
						     (find-symbol
						      (symbol-name
						       '*package-load-date*)
						      package)))
		      (package-load-date (and (boundp package-load-date-symbol)
					      (symbol-value package-load-date-symbol))))

		 (if (not (probe-file ctools-lisp))
		     (error (format t "Need file ~a..." ctools-lisp)))
		 
		 (if (probe-file ctools-fasl)
		     ;; fasl exists
		     (with-open-file (fasl ctools-fasl)
		       (with-open-file (lisp ctools-lisp)
			 (if (>= (file-write-date lisp) (file-write-date fasl))
			     ;; lisp is newer - compile
			     (and (my-compile-file ctools-lisp)
				  (load-and-set-load-date ctools ctools-fasl))
			   ;; fasl is up to date - load if not package
			   ;; is up to date
			   (if (and package-load-date
				    (>= package-load-date (file-write-date fasl)))
			       ;; fine
			       t
			     (load-and-set-load-date ctools ctools-fasl)))))
		   ;; fasl das not exist - compile and load
		   (and (my-compile-file ctools-lisp)
			(load-and-set-load-date ctools ctools-fasl)))))
	  (error "An error occured...")))
    t))


(defun gnunotice (&key (stream t))
  (format stream (concatenate 'string
                              "NILE ~a, Copyright (C) 1999 Nils Goroll.  "
                              "The NILE package comes with~%ABSOLUTELY NO "
                              "WARRANTY; for details see the GNU General Public"
                              " License~%(see file LICENCE of the distribution)~%~%")
          *NILE-Version*))
