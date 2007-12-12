
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

;;;; $Id: nile_compile-tools.lisp,v 1.18 1999/09/28 11:02:43 slink Exp $

;;;; nile_compile-tools
;;;; 
;;;; Defines a couple of tools to use at compile-time,
;;;; such as pre- and post-compilation garbage collection
;;;; etc.
;;;; 
;;;; Also sets some platform-dependend parameters

(defpackage nile_compile-tools
  (:use common-lisp)
  (:export gc-pre-compile
	   gc-post-compile
	   my-tenure
	   my-tenuring
	   my-command-line-argument
	   my-command-line-argument-count
	   generate-app
	   *prefer-row-major-aref*
	   *protect-act-fun*
	   ))

(in-package :nile_compile-tools)

(defparameter *prefer-row-major-aref* nil)
(defparameter *protect-act-fun* t)

;;;
#+allegro
(defmacro allegro-generate-app-m ()
  '(defun generate-app (name fasls start-func)
    (setf excl:*restart-app-function* start-func)
    (excl:generate-application name (format nil "~a/" name) fasls
     ;;			     :runtime :standard 
     :include-compiler nil
     :include-clim nil
     :include-composer nil
     :include-debugger nil
     :include-devel-env nil
     :include-tpl nil
     :include-xcw nil
     :print-startup-message nil
     )))
#-allegro
(defmacro allegro-generate-app-m ()
  nil)

;;; defaults for system dependencies
(defmacro default-gc-pre-compile-m ()
  '(defun gc-pre-compile ()
    nil))
(defmacro default-gc-post-compile-m ()
  '(defun gc-post-compile ()
    nil))
(defmacro default-my-tenure-m ()
  '(defun my-tenure ()
    nil))
(defmacro default-my-tenuring-m ()
  '(defmacro my-tenuring (&body body)
    `(progn ,@body)))
(defmacro default-generate-app-m ()
  '(defun generate-app (name fasls start-func)
    (declare (ignore name fasls start-func))
    (error "generate-app not supported for this system")))
(defmacro default-command-line-arg-m ()
  '(progn
    (defun my-command-line-argument (n)
      (declare (ignore n))
      (error "command line arguments not supported for this system"))
    (defun my-command-line-argument-count ()
      (error "command line arguments not supported for this system"))))

(default-my-tenure-m)
(default-my-tenuring-m)
(default-gc-pre-compile-m)
(default-gc-post-compile-m)

(defmacro default-dependencies-m ()
  '(progn
    (default-gc-pre-compile-m)
    (default-gc-post-compile-m)
    (default-my-tenure-m)
    (default-my-tenuring-m)
    (default-command-line-arg-m)
    (setf *prefer-row-major-aref* nil)
    (setf *protect-act-fun* t)
    (default-generate-app-m)))


#+allegro
(defmacro allegro-tenuring-m ()
  '(defmacro my-tenuring (&body body)
    `(excl::tenuring ,@body)))
#-allegro
(defmacro allegro-tenuring-m ()
  nil)

;;; Allegro Linux X86
#+allegro
(defmacro allegro-5-linux-dependencies-m ()
  '(progn
    (defun gc-pre-compile ()
      (format t "** GC pre-compile~%")
      ;; set to free memory
      (setf (sys:gsgc-switch :use-remap) t)
      (sys:resize-areas :new (* 20 1024 1024) :expand t :verbose t
       :global-gc t)
      ;;
      ;; Now set better parameters for compile:
      ;; tenure late, don't do global GCs
      (setf (sys:gsgc-switch :use-remap) nil)
      ;;	(setf (sys:gsgc-switch :print) t)
      ;;	(setf (sys:gsgc-switch :stats) t)
      (setf (sys:gsgc-parameter :generation-spread) 20)
      ;; get more space
      (setf (sys:gsgc-parameter :free-percent-new) 1)
      (setf (sys:gsgc-parameter :expansion-free-percent-new) 1)
      (setf (sys:gsgc-parameter :free-bytes-new-pages) (* 4 1024 1024)))
    (defun gc-post-compile ()
      (format t "** GC post-compile~%")
      (setf (sys:gsgc-parameter :generation-spread) 4)
      (setf (sys:gsgc-switch :use-remap) t)
      (setf (sys:gsgc-parameter :free-percent-new) 25)
      (setf (sys:gsgc-parameter :expansion-free-percent-new) 35)
      (setf (sys:gsgc-parameter :free-bytes-new-pages) 1048576)
      (setf (sys:gsgc-switch :print) nil)
      (setf (sys:gsgc-switch :stats) nil)
      (excl:gc t)
      ;; then resize
      (sys:resize-areas :new (* 10 1024 1024)))
    (defun my-tenure ()
      (format t "** Tenure~%")
      (setf (sys:gsgc-switch :use-remap) t)
      (excl:gc :tenure)
      (setf (sys:gsgc-switch :use-remap) nil))
    (defun my-command-line-argument (n)
      (sys:command-line-argument n))
    (defun my-command-line-argument-count ()
      (sys:command-line-argument-count))
    (setf *prefer-row-major-aref* nil)
    (setf *protect-act-fun* t)
    (allegro-generate-app-m)
    (allegro-tenuring-m)))
#-allegro
(defmacro allegro-5-linux-dependencies-m ()
  nil)

;; Allegro SunOs
#+allegro
(defmacro allegro-5-sunos-dependencies-m ()
  '(progn
    (defun gc-pre-compile ()
      (sys:resize-areas :new (* 20 1024 1024) :expand t :verbose t
       :global-gc t)
      (setf (sys:gsgc-parameter :generation-spread) 20))
    (defun gc-post-compile ()
      (sys:resize-areas :new (* 5 1024 1024) :expand t :verbose t
       :global-gc t)
      (setf (sys:gsgc-parameter :generation-spread) 4))
    (defun my-tenure ()
      nil)
    (defun my-command-line-argument (n)
      (sys:command-line-argument n))
    (defun my-command-line-argument-count ()
      (sys:command-line-argument-count))
    (setf *prefer-row-major-aref* nil)
    (setf *protect-act-fun* t)
    (allegro-generate-app-m)
    (allegro-tenuring-m)))
#-allegro
(defmacro allegro-5-sunos-dependencies-m ()
  nil)

#+python
(defmacro cmu-dependencies-m ()
  '(progn
    ;; (default-gc-pre-compile-m)
    (defun gc-pre-compile ()
      (setf extensions:*bytes-consed-between-gcs*
	(* 10 1024 1024)))
    ;; (default-gc-post-compile-m)
    (defun gc-post-compile ()
      (setf extensions:*bytes-consed-between-gcs*
	(* 2 1024 1024)))
    (defun my-tenure ()
      (extensions:gc))
    (defun my-command-line-argument (n)
      (nth n extensions:*command-line-strings*))
    (defun my-command-line-argument-count ()
      (length extensions:*command-line-strings*))
    (setf *prefer-row-major-aref* t)
    (setf *protect-act-fun* t)
    (default-my-tenuring-m)
    (default-generate-app-m)))
#-python
(defmacro cmu-dependencies-m ()
  nil)
;;

;;; define system dependencies
(let* ((impl-type (lisp-implementation-type))
       (impl-type-firstword (subseq impl-type 0 (position #\space impl-type)))
       (impl-vers (lisp-implementation-version))
       (impl-vers-firstword (subseq impl-vers 0 (position #\space impl-vers)))
       (soft-type (software-type)))
  (cond
   ((string-equal "allegro" impl-type-firstword)
    (cond
     ((string>= impl-vers-firstword "5.0")
      (cond
       ((string-equal soft-type "linux")
	(format t "** This is Allegro >5.0 on Linux~%")
	;; ACL 5.0 Linux
	(allegro-5-linux-dependencies-m))
       ((string-equal soft-type "SunOS")
	;; Allegro >5.0 SunOs
	(format t "** This is Allegro >5.0 on SunOS~%")
	(allegro-5-sunos-dependencies-m))
       (t ;; Allegro >5.0 other OS
	(format t "** This is Allegro >5.0 on <Unknown OS>~%")
	(default-dependencies-m))))
     (t ;; Allegro V ???
      (format t "** This is an unknown version of Allegro CL~%")
      (default-dependencies-m))))
   ((string-equal "cmu" impl-type-firstword)
    ;; CMU on whatever
    (format t "** This is CMU-CL~%")
    (cmu-dependencies-m))))


