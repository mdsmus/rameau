;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; GLU bindings

(defpackage #:glu
  (:use #:common-lisp #:sdl-gl-uffi-macros)
  (:export #:with-quadric)
  (:documentation "GLU bindings"))

(in-package #:glu)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (in-module gl:glu))

(def-foreign-constant +point+ 100010)
(def-foreign-constant +line+ 100011)
(def-foreign-constant +fill+ 100012)
(def-foreign-constant +silhouette+ 100013)

(def-foreign-constant +smooth+ 100000)
(def-foreign-constant +flat+ 100001)
(def-foreign-constant +none+ 100002)

(def-foreign-constant +outside+ 100020)
(def-foreign-constant +inside+ 100021)


(def-foreign-routine ("gluPerspective" perspective) void
  (fovy double)
  (aspect double)
  (znear double)
  (zfar double))

(def-foreign-routine ("gluBuild2DMipmaps" build-2d-mipmaps) gl:int
  (target gl:enum)
  (internal-format gl:int)
  (width gl:sizei)
  (height gl:sizei)
  (format gl:enum)
  (type gl:enum)
  (data (* void)))

(def-foreign-routine ("gluLookAt" look-at) void
  (eyex gl:double)
  (eyey gl:double)
  (eyez gl:double)
  (centerx gl:double)
  (centery gl:double)
  (centerz gl:double)
  (upx gl:double)
  (upy gl:double)
  (upz gl:double))

(def-foreign-routine ("gluNewQuadric" new-quadric) (* void))

(def-foreign-routine ("gluDeleteQuadric" delete-quadric) void
  (qobj (* void)))

(defmacro with-quadric ((name) &body body)
  `(let ((,name (new-quadric)))
    (unwind-protect (progn ,@body)
      (delete-quadric ,name))))

(def-foreign-routine ("gluQuadricDrawStyle" quadric-draw-style) void
  (qobj (* void))
  (drawstyle gl:enum))

(def-foreign-routine ("gluQuadricOrientation" quadric-orientation) void
  (qobj (* void))
  (orientation gl:enum))

(def-foreign-routine ("gluQuadricNormals" quadric-normals) void
  (qobj (* void))
  (normals gl:enum))

(def-foreign-routine ("gluQuadricTexture" quadric-texture) void
  (qobj (* void))
  (texture-coords gl:bool))

(def-foreign-routine ("gluSphere" sphere) void
  (qobj (* void))
  (radius gl:double)
  (slices gl:int)
  (stacks gl:int))

(def-foreign-routine ("gluCylinder" cylinder) void
  (qobj (* void))
  (base gl:double)
  (top gl:double)
  (height gl:double)
  (slices gl:int)
  (stacks gl:int))

(def-foreign-routine ("gluPartialDisk" partial-disk) void
  (qobj (* void))
  (inner gl:double)
  (outer gl:double)
  (slices gl:int)
  (loops gl:int)
  (start gl:double)
  (sweep gl:double))

(def-foreign-routine ("gluPickMatrix" pick-matrix) void
  (x gl:double)
  (y gl:double)
  (width gl:double)
  (height gl:double)
  (viewport (* gl:int)))
