;;;;
;;;; OpenGL Bindings for CMUCL
;;;; =========================
;;;;
;;;; written in 2002 by Timo Tossavainen
;;;;
;;;; The bindings are quite complete for GL version 1.2.1
;;;; TODO: GL 1.3 version
;;;; TODO: ARB extensions
;;;; TODO: code to check GL version, load OpenGL extensions,
;;;;       something like *features* for checking extensions.
;;;; TODO: change gl-type to plain type
;;;;
;;;; Section references to OpenGL 1.3 specification
;;;; (The GL specification is available as PDF from www.opengl.org)
;;;;
;;;;
;;;; Heavily modified to work with UFFI by Matthew Danish
;;;;
;;;;
;;;; This code is based on:
;;;;
;;;; Mesa 3-D graphics library
;;;; Version:  3.4
;;;;
;;;; Copyright (C) 1999-2000  Brian Paul   All Rights Reserved.
;;;;
;;;; Permission is hereby granted, free of charge, to any person
;;;; obtaining a copy of this software and associated documentation
;;;; files (the "Software"), to deal in the Software without
;;;; restriction, including without limitation the rights to use,
;;;; copy, modify, merge, publish, distribute, sublicense, and/or sell
;;;; copies of the Software, and to permit persons to whom the
;;;; Software is furnished to do so, subject to the following
;;;; conditions:
;;;;
;;;; The above copyright notice and this permission notice shall be
;;;; included in all copies or substantial portions of the Software.
;;;;
;;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
;;;; OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;;; NONINFRINGEMENT.  IN NO EVENT SHALL BRIAN PAUL BE LIABLE FOR ANY
;;;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
;;;; CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;;;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;;;; SOFTWARE.

(defpackage #:opengl
  (:use #:common-lisp #:sdl-gl-uffi-macros)
  (:nicknames #:gl)
  (:shadow #:byte #:float #:boolean)
  (:export #:opengl #:glu #:openglstub)
  (:documentation "OpenGL graphics API binding"))

(in-package #:opengl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (def-library-properties opengl ("libGL" "opengl32")
    :module opengl)

  (def-library-properties glu ("libGLU" "glu32")
    :module glu)
  
  (def-library-properties glstub ()
    :depends-on (opengl glu)
    :module openglstub)

  (load-defined-foreign-library 'glstub)

  (in-module opengl))

(declaim (inline rotate-f translate-f tex-coord-2f vertex-3f))
;;;
;;; OpenGL primitive types
;;; ======================

;;; Section 2.3 table 2.2

(export '(enum boolean bitfield byte short int ubyte ushort uint
          sizei float clampf double clampd))

(def-foreign-type enum     (unsigned-byte 32))
(def-foreign-type bool     (unsigned-byte 8))
(def-foreign-type boolean  (unsigned-byte 8))
(def-foreign-type bitfield (unsigned-byte 32))
(def-foreign-type byte     (signed-byte 8))
(def-foreign-type short    (signed-byte 16))
(def-foreign-type int      (signed-byte 32))
(def-foreign-type ubyte    (unsigned-byte 8))
(def-foreign-type ushort   (unsigned-byte 16))
(def-foreign-type uint     (unsigned-byte 32))
(def-foreign-type sizei    (signed-byte 32))
(def-foreign-type float    single-float)
(def-foreign-type clampf   single-float)
(def-foreign-type double   double-float)
(def-foreign-type clampd   double-float)
(def-foreign-type void*    (* t))

;;;
;;; OpenGL symbolic constants
;;; =========================

;; GL Version

(def-foreign-constant +version-1-1+                        1)
(def-foreign-constant +version-1-2+                        1) 

;; Boolean

(def-foreign-constant +false+                            #x0) 
(def-foreign-constant +true+                             #x1) 

;; Types

(def-foreign-constant +byte+                          #x1400) 
(def-foreign-constant +unsigned-byte+                 #x1401) 
(def-foreign-constant +short+                         #x1402) 
(def-foreign-constant +unsigned-short+                #x1403) 
(def-foreign-constant +int+                           #x1404) 
(def-foreign-constant +unsigned-int+                  #x1405) 
(def-foreign-constant +float+                         #x1406) 
(def-foreign-constant +double+                        #x140a) 
(def-foreign-constant +2-bytes+                       #x1407) 
(def-foreign-constant +3-bytes+                       #x1408) 
(def-foreign-constant +4-bytes+                       #x1409) 

;; Primitives

(def-foreign-constant +points+                        #x0000) 
(def-foreign-constant +lines+                         #x0001) 
(def-foreign-constant +line-loop+                     #x0002) 
(def-foreign-constant +line-strip+                    #x0003) 
(def-foreign-constant +triangles+                     #x0004) 
(def-foreign-constant +triangle-strip+                #x0005) 
(def-foreign-constant +triangle-fan+                  #x0006) 
(def-foreign-constant +quads+                         #x0007) 
(def-foreign-constant +quad-strip+                    #x0008) 
(def-foreign-constant +polygon+                       #x0009) 

;; Arrays

(def-foreign-constant +vertex-array+                  #x8074) 
(def-foreign-constant +normal-array+                  #x8075) 
(def-foreign-constant +color-array+                   #x8076) 
(def-foreign-constant +index-array+                   #x8077) 
(def-foreign-constant +texture-coord-array+           #x8078) 
(def-foreign-constant +edge-flag-array+               #x8079) 
(def-foreign-constant +vertex-array-size+             #x807a) 
(def-foreign-constant +vertex-array-type+             #x807b) 
(def-foreign-constant +vertex-array-stride+           #x807c) 
(def-foreign-constant +normal-array-type+             #x807e) 
(def-foreign-constant +normal-array-stride+           #x807f) 
(def-foreign-constant +color-array-size+              #x8081) 
(def-foreign-constant +color-array-type+              #x8082) 
(def-foreign-constant +color-array-stride+            #x8083) 
(def-foreign-constant +index-array-type+              #x8085) 
(def-foreign-constant +index-array-stride+            #x8086) 
(def-foreign-constant +texture-coord-array-size+      #x8088) 
(def-foreign-constant +texture-coord-array-type+      #x8089) 
(def-foreign-constant +texture-coord-array-stride+    #x808a) 
(def-foreign-constant +edge-flag-array-stride+        #x808c) 
(def-foreign-constant +vertex-array-pointer+          #x808e) 
(def-foreign-constant +normal-array-pointer+          #x808f) 
(def-foreign-constant +color-array-pointer+           #x8090) 
(def-foreign-constant +index-array-pointer+           #x8091) 
(def-foreign-constant +texture-coord-array-pointer+   #x8092) 
(def-foreign-constant +edge-flag-array-pointer+       #x8093) 

;; Array formats

(def-foreign-constant +v2f+                           #x2a20) 
(def-foreign-constant +v3f+                           #x2a21) 
(def-foreign-constant +c4ub-v2f+                      #x2a22) 
(def-foreign-constant +c4ub-v3f+                      #x2a23) 
(def-foreign-constant +c3f-v3f+                       #x2a24) 
(def-foreign-constant +n3f-v3f+                       #x2a25) 
(def-foreign-constant +c4f-n3f-v3f+                   #x2a26) 
(def-foreign-constant +t2f-v3f+                       #x2a27) 
(def-foreign-constant +t4f-v4f+                       #x2a28) 
(def-foreign-constant +t2f-c4ub-v3f+                  #x2a29) 
(def-foreign-constant +t2f-c3f-v3f+                   #x2a2a) 
(def-foreign-constant +t2f-n3f-v3f+                   #x2a2b) 
(def-foreign-constant +t2f-c4f-n3f-v3f+               #x2a2c) 
(def-foreign-constant +t4f-c4f-n3f-v4f+               #x2a2d) 

;; Matrices

(def-foreign-constant +matrix-mode+                   #x0ba0) 
(def-foreign-constant +modelview+                     #x1700) 
(def-foreign-constant +projection+                    #x1701) 
(def-foreign-constant +texture+                       #x1702) 

;; Points

(def-foreign-constant +point-smooth+                  #x0b10) 
(def-foreign-constant +point-size+                    #x0b11) 
(def-foreign-constant +point-size-granularity+        #x0b13) 
(def-foreign-constant +point-size-range+              #x0b12) 

;; Lines

(def-foreign-constant +line-smooth+                   #x0b20) 
(def-foreign-constant +line-stipple+                  #x0b24) 
(def-foreign-constant +line-stipple-pattern+          #x0b25) 
(def-foreign-constant +line-stipple-repeat+           #x0b26) 
(def-foreign-constant +line-width+                    #x0b21) 
(def-foreign-constant +line-width-granularity+        #x0b23) 
(def-foreign-constant +line-width-range+              #x0b22) 

;; Polygons

(def-foreign-constant +point+                         #x1b00) 
(def-foreign-constant +line+                          #x1b01) 
(def-foreign-constant +fill+                          #x1b02) 
(def-foreign-constant +cw+                            #x0900) 
(def-foreign-constant +ccw+                           #x0901) 
(def-foreign-constant +front+                         #x0404) 
(def-foreign-constant +back+                          #x0405) 
(def-foreign-constant +polygon-mode+                  #x0b40) 
(def-foreign-constant +polygon-smooth+                #x0b41) 
(def-foreign-constant +polygon-stipple+               #x0b42) 
(def-foreign-constant +edge-flag+                     #x0b43) 
(def-foreign-constant +cull-face+                     #x0b44) 
(def-foreign-constant +cull-face-mode+                #x0b45) 
(def-foreign-constant +front-face+                    #x0b46) 
(def-foreign-constant +polygon-offset-factor+         #x8038) 
(def-foreign-constant +polygon-offset-units+          #x2a00) 
(def-foreign-constant +polygon-offset-point+          #x2a01) 
(def-foreign-constant +polygon-offset-line+           #x2a02) 
(def-foreign-constant +polygon-offset-fill+           #x8037) 

;; Display Lists

(def-foreign-constant +compile+                       #x1300) 
(def-foreign-constant +compile-and-execute+           #x1301) 
(def-foreign-constant +list-base+                     #x0b32) 
(def-foreign-constant +list-index+                    #x0b33) 
(def-foreign-constant +list-mode+                     #x0b30) 

;; Depth Buffer

(def-foreign-constant +never+                         #x0200) 
(def-foreign-constant +less+                          #x0201) 
(def-foreign-constant +equal+                         #x0202) 
(def-foreign-constant +lequal+                        #x0203) 
(def-foreign-constant +greater+                       #x0204) 
(def-foreign-constant +notequal+                      #x0205) 
(def-foreign-constant +gequal+                        #x0206) 
(def-foreign-constant +always+                        #x0207) 
(def-foreign-constant +depth-test+                    #x0b71) 
(def-foreign-constant +depth-bits+                    #x0d56) 
(def-foreign-constant +depth-clear-value+             #x0b73) 
(def-foreign-constant +depth-func+                    #x0b74) 
(def-foreign-constant +depth-range+                   #x0b70) 
(def-foreign-constant +depth-writemask+               #x0b72) 
(def-foreign-constant +depth-component+               #x1902) 

;; Lighting

(def-foreign-constant +lighting+                      #x0b50) 
(def-foreign-constant +light0+                        #x4000) 
(def-foreign-constant +light1+                        #x4001) 
(def-foreign-constant +light2+                        #x4002) 
(def-foreign-constant +light3+                        #x4003) 
(def-foreign-constant +light4+                        #x4004) 
(def-foreign-constant +light5+                        #x4005) 
(def-foreign-constant +light6+                        #x4006) 
(def-foreign-constant +light7+                        #x4007) 
(def-foreign-constant +spot-exponent+                 #x1205) 
(def-foreign-constant +spot-cutoff+                   #x1206) 
(def-foreign-constant +constant-attenuation+          #x1207) 
(def-foreign-constant +linear-attenuation+            #x1208) 
(def-foreign-constant +quadratic-attenuation+         #x1209) 
(def-foreign-constant +ambient+                       #x1200) 
(def-foreign-constant +diffuse+                       #x1201) 
(def-foreign-constant +specular+                      #x1202) 
(def-foreign-constant +shininess+                     #x1601) 
(def-foreign-constant +emission+                      #x1600) 
(def-foreign-constant +position+                      #x1203) 
(def-foreign-constant +spot-direction+                #x1204) 
(def-foreign-constant +ambient-and-diffuse+           #x1602) 
(def-foreign-constant +color-indexes+                 #x1603) 
(def-foreign-constant +light-model-two-side+          #x0b52) 
(def-foreign-constant +light-model-local-viewer+      #x0b51) 
(def-foreign-constant +light-model-ambient+           #x0b53) 
(def-foreign-constant +front-and-back+                #x0408) 
(def-foreign-constant +shade-model+                   #x0b54) 
(def-foreign-constant +flat+                          #x1d00) 
(def-foreign-constant +smooth+                        #x1d01) 
(def-foreign-constant +color-material+                #x0b57) 
(def-foreign-constant +color-material-face+           #x0b55) 
(def-foreign-constant +color-material-parameter+      #x0b56) 
(def-foreign-constant +normalize+                     #x0ba1) 

;; Clipping planes

(def-foreign-constant +clip-plane0+                   #x3000) 
(def-foreign-constant +clip-plane1+                   #x3001) 
(def-foreign-constant +clip-plane2+                   #x3002) 
(def-foreign-constant +clip-plane3+                   #x3003) 
(def-foreign-constant +clip-plane4+                   #x3004) 
(def-foreign-constant +clip-plane5+                   #x3005) 

;; Accumulation buffer

(def-foreign-constant +accum-red-bits+                #x0d58) 
(def-foreign-constant +accum-green-bits+              #x0d59) 
(def-foreign-constant +accum-blue-bits+               #x0d5a) 
(def-foreign-constant +accum-alpha-bits+              #x0d5b) 
(def-foreign-constant +accum-clear-value+             #x0b80) 
(def-foreign-constant +accum+                         #x0100) 
(def-foreign-constant +add+                           #x0104) 
(def-foreign-constant +load+                          #x0101) 
(def-foreign-constant +mult+                          #x0103) 
(def-foreign-constant +return+                        #x0102) 

;; Alpha Testing

(def-foreign-constant +alpha-test+                    #x0bc0) 
(def-foreign-constant +alpha-test-ref+                #x0bc2) 
(def-foreign-constant +alpha-test-func+               #x0bc1) 

;; Blending

(def-foreign-constant +blend+                         #x0be2) 
(def-foreign-constant +blend-src+                     #x0be1) 
(def-foreign-constant +blend-dst+                     #x0be0) 
(def-foreign-constant +zero+                             #x0) 
(def-foreign-constant +one+                              #x1) 
(def-foreign-constant +src-color+                     #x0300) 
(def-foreign-constant +one-minus-src-color+           #x0301) 
(def-foreign-constant +dst-color+                     #x0306) 
(def-foreign-constant +one-minus-dst-color+           #x0307) 
(def-foreign-constant +src-alpha+                     #x0302) 
(def-foreign-constant +one-minus-src-alpha+           #x0303) 
(def-foreign-constant +dst-alpha+                     #x0304) 
(def-foreign-constant +one-minus-dst-alpha+           #x0305) 
(def-foreign-constant +src-alpha-saturate+            #x0308) 
(def-foreign-constant +constant-color+                #x8001) 
(def-foreign-constant +one-minus-constant-color+      #x8002) 
(def-foreign-constant +constant-alpha+                #x8003) 
(def-foreign-constant +one-minus-constant-alpha+      #x8004) 

;; Render mode

(def-foreign-constant +feedback+                      #x1c01) 
(def-foreign-constant +render+                        #x1c00) 
(def-foreign-constant +select+                        #x1c02) 

;; Feedback

(def-foreign-constant +2d+                            #x0600) 
(def-foreign-constant +3d+                            #x0601) 
(def-foreign-constant +3d-color+                      #x0602) 
(def-foreign-constant +3d-color-texture+              #x0603) 
(def-foreign-constant +4d-color-texture+              #x0604) 
(def-foreign-constant +point-token+                   #x0701) 
(def-foreign-constant +line-token+                    #x0702) 
(def-foreign-constant +line-reset-token+              #x0707) 
(def-foreign-constant +polygon-token+                 #x0703) 
(def-foreign-constant +bitmap-token+                  #x0704) 
(def-foreign-constant +draw-pixel-token+              #x0705) 
(def-foreign-constant +copy-pixel-token+              #x0706) 
(def-foreign-constant +pass-through-token+            #x0700) 
(def-foreign-constant +feedback-buffer-pointer+       #x0df0) 
(def-foreign-constant +feedback-buffer-size+          #x0df1) 
(def-foreign-constant +feedback-buffer-type+          #x0df2) 

;; Selection

(def-foreign-constant +selection-buffer-pointer+      #x0df3) 
(def-foreign-constant +selection-buffer-size+         #x0df4) 

;; Fog

(def-foreign-constant +fog+                           #x0b60) 
(def-foreign-constant +fog-mode+                      #x0b65) 
(def-foreign-constant +fog-density+                   #x0b62) 
(def-foreign-constant +fog-color+                     #x0b66) 
(def-foreign-constant +fog-index+                     #x0b61) 
(def-foreign-constant +fog-start+                     #x0b63) 
(def-foreign-constant +fog-end+                       #x0b64) 
(def-foreign-constant +linear+                        #x2601) 
(def-foreign-constant +exp+                           #x0800) 
(def-foreign-constant +exp2+                          #x0801) 

;; Logic operations

(def-foreign-constant +logic-op+                      #x0bf1) 
(def-foreign-constant +index-logic-op+                #x0bf1) 
(def-foreign-constant +color-logic-op+                #x0bf2) 
(def-foreign-constant +logic-op-mode+                 #x0bf0) 
(def-foreign-constant +clear+                         #x1500) 
(def-foreign-constant +set+                           #x150f) 
(def-foreign-constant +copy+                          #x1503) 
(def-foreign-constant +copy-inverted+                 #x150c) 
(def-foreign-constant +noop+                          #x1505) 
(def-foreign-constant +invert+                        #x150a) 
(def-foreign-constant +and+                           #x1501) 
(def-foreign-constant +nand+                          #x150e) 
(def-foreign-constant +or+                            #x1507) 
(def-foreign-constant +nor+                           #x1508) 
(def-foreign-constant +xor+                           #x1506) 
(def-foreign-constant +equiv+                         #x1509) 
(def-foreign-constant +and-reverse+                   #x1502) 
(def-foreign-constant +and-inverted+                  #x1504) 
(def-foreign-constant +or-reverse+                    #x150b) 
(def-foreign-constant +or-inverted+                   #x150d) 

;; Stencil

(def-foreign-constant +stencil-test+                  #x0b90) 
(def-foreign-constant +stencil-writemask+             #x0b98) 
(def-foreign-constant +stencil-bits+                  #x0d57) 
(def-foreign-constant +stencil-func+                  #x0b92) 
(def-foreign-constant +stencil-value-mask+            #x0b93) 
(def-foreign-constant +stencil-ref+                   #x0b97) 
(def-foreign-constant +stencil-fail+                  #x0b94) 
(def-foreign-constant +stencil-pass-depth-pass+       #x0b96) 
(def-foreign-constant +stencil-pass-depth-fail+       #x0b95) 
(def-foreign-constant +stencil-clear-value+           #x0b91) 
(def-foreign-constant +stencil-index+                 #x1901) 
(def-foreign-constant +keep+                          #x1e00) 
(def-foreign-constant +replace+                       #x1e01) 
(def-foreign-constant +incr+                          #x1e02) 
(def-foreign-constant +decr+                          #x1e03) 

;; Buffers, Pixel Drawing/Reading

(def-foreign-constant +none+                             #x0) 
(def-foreign-constant +left+                          #x0406) 
(def-foreign-constant +right+                         #x0407) 
(def-foreign-constant +front-left+                    #x0400) 
(def-foreign-constant +front-right+                   #x0401) 
(def-foreign-constant +back-left+                     #x0402) 
(def-foreign-constant +back-right+                    #x0403) 
(def-foreign-constant +aux0+                          #x0409) 
(def-foreign-constant +aux1+                          #x040a) 
(def-foreign-constant +aux2+                          #x040b) 
(def-foreign-constant +aux3+                          #x040c) 
(def-foreign-constant +color-index+                   #x1900) 
(def-foreign-constant +red+                           #x1903) 
(def-foreign-constant +green+                         #x1904) 
(def-foreign-constant +blue+                          #x1905) 
(def-foreign-constant +alpha+                         #x1906) 
(def-foreign-constant +luminance+                     #x1909) 
(def-foreign-constant +luminance-alpha+               #x190a) 
(def-foreign-constant +alpha-bits+                    #x0d55) 
(def-foreign-constant +red-bits+                      #x0d52) 
(def-foreign-constant +green-bits+                    #x0d53) 
(def-foreign-constant +blue-bits+                     #x0d54) 
(def-foreign-constant +index-bits+                    #x0d51) 
(def-foreign-constant +subpixel-bits+                 #x0d50) 
(def-foreign-constant +aux-buffers+                   #x0c00) 
(def-foreign-constant +read-buffer+                   #x0c02) 
(def-foreign-constant +draw-buffer+                   #x0c01) 
(def-foreign-constant +doublebuffer+                  #x0c32) 
(def-foreign-constant +stereo+                        #x0c33) 
(def-foreign-constant +bitmap+                        #x1a00) 
(def-foreign-constant +color+                         #x1800) 
(def-foreign-constant +depth+                         #x1801) 
(def-foreign-constant +stencil+                       #x1802) 
(def-foreign-constant +dither+                        #x0bd0) 
(def-foreign-constant +rgb+                           #x1907) 
(def-foreign-constant +rgba+                          #x1908) 

;; Implementation Limits

(def-foreign-constant +max-list-nesting+              #x0b31) 
(def-foreign-constant +max-attrib-stack-depth+        #x0d35) 
(def-foreign-constant +max-modelview-stack-depth+     #x0d36) 
(def-foreign-constant +max-name-stack-depth+          #x0d37) 
(def-foreign-constant +max-projection-stack-depth+    #x0d38) 
(def-foreign-constant +max-texture-stack-depth+       #x0d39) 
(def-foreign-constant +max-eval-order+                #x0d30) 
(def-foreign-constant +max-lights+                    #x0d31) 
(def-foreign-constant +max-clip-planes+               #x0d32) 
(def-foreign-constant +max-texture-size+              #x0d33) 
(def-foreign-constant +max-pixel-map-table+           #x0d34) 
(def-foreign-constant +max-viewport-dims+             #x0d3a) 
(def-foreign-constant +max-client-attrib-stack-depth+ #x0d3b) 

;; Gets

(def-foreign-constant +attrib-stack-depth+            #x0bb0) 
(def-foreign-constant +client-attrib-stack-depth+     #x0bb1) 
(def-foreign-constant +color-clear-value+             #x0c22) 
(def-foreign-constant +color-writemask+               #x0c23) 
(def-foreign-constant +current-index+                 #x0b01) 
(def-foreign-constant +current-color+                 #x0b00) 
(def-foreign-constant +current-normal+                #x0b02) 
(def-foreign-constant +current-raster-color+          #x0b04) 
(def-foreign-constant +current-raster-distance+       #x0b09) 
(def-foreign-constant +current-raster-index+          #x0b05) 
(def-foreign-constant +current-raster-position+       #x0b07) 
(def-foreign-constant +current-raster-texture-coords+ #x0b06) 
(def-foreign-constant +current-raster-position-valid+ #x0b08) 
(def-foreign-constant +current-texture-coords+        #x0b03) 
(def-foreign-constant +index-clear-value+             #x0c20) 
(def-foreign-constant +index-mode+                    #x0c30) 
(def-foreign-constant +index-writemask+               #x0c21) 
(def-foreign-constant +modelview-matrix+              #x0ba6) 
(def-foreign-constant +modelview-stack-depth+         #x0ba3) 
(def-foreign-constant +name-stack-depth+              #x0d70) 
(def-foreign-constant +projection-matrix+             #x0ba7) 
(def-foreign-constant +projection-stack-depth+        #x0ba4) 
(def-foreign-constant +render-mode+                   #x0c40) 
(def-foreign-constant +rgba-mode+                     #x0c31) 
(def-foreign-constant +texture-matrix+                #x0ba8) 
(def-foreign-constant +texture-stack-depth+           #x0ba5) 
(def-foreign-constant +viewport+                      #x0ba2) 

;; GL Evaluators

(def-foreign-constant +auto-normal+                   #x0d80) 
(def-foreign-constant +map1-color-4+                  #x0d90) 
(def-foreign-constant +map1-grid-domain+              #x0dd0) 
(def-foreign-constant +map1-grid-segments+            #x0dd1) 
(def-foreign-constant +map1-index+                    #x0d91) 
(def-foreign-constant +map1-normal+                   #x0d92) 
(def-foreign-constant +map1-texture-coord-1+          #x0d93) 
(def-foreign-constant +map1-texture-coord-2+          #x0d94) 
(def-foreign-constant +map1-texture-coord-3+          #x0d95) 
(def-foreign-constant +map1-texture-coord-4+          #x0d96) 
(def-foreign-constant +map1-vertex-3+                 #x0d97) 
(def-foreign-constant +map1-vertex-4+                 #x0d98) 
(def-foreign-constant +map2-color-4+                  #x0db0) 
(def-foreign-constant +map2-grid-domain+              #x0dd2) 
(def-foreign-constant +map2-grid-segments+            #x0dd3) 
(def-foreign-constant +map2-index+                    #x0db1) 
(def-foreign-constant +map2-normal+                   #x0db2) 
(def-foreign-constant +map2-texture-coord-1+          #x0db3) 
(def-foreign-constant +map2-texture-coord-2+          #x0db4) 
(def-foreign-constant +map2-texture-coord-3+          #x0db5) 
(def-foreign-constant +map2-texture-coord-4+          #x0db6) 
(def-foreign-constant +map2-vertex-3+                 #x0db7) 
(def-foreign-constant +map2-vertex-4+                 #x0db8) 
(def-foreign-constant +coeff+                         #x0a00) 
(def-foreign-constant +domain+                        #x0a02) 
(def-foreign-constant +order+                         #x0a01) 

;; Hints

(def-foreign-constant +fog-hint+                      #x0c54) 
(def-foreign-constant +line-smooth-hint+              #x0c52) 
(def-foreign-constant +perspective-correction-hint+   #x0c50) 
(def-foreign-constant +point-smooth-hint+             #x0c51) 
(def-foreign-constant +polygon-smooth-hint+           #x0c53) 
(def-foreign-constant +dont-care+                     #x1100) 
(def-foreign-constant +fastest+                       #x1101) 
(def-foreign-constant +nicest+                        #x1102) 

;; Scissor box

(def-foreign-constant +scissor-test+                  #x0c11) 
(def-foreign-constant +scissor-box+                   #x0c10) 

;; Pixel Mode / Transfer

(def-foreign-constant +map-color+                     #x0d10) 
(def-foreign-constant +map-stencil+                   #x0d11) 
(def-foreign-constant +index-shift+                   #x0d12) 
(def-foreign-constant +index-offset+                  #x0d13) 
(def-foreign-constant +red-scale+                     #x0d14) 
(def-foreign-constant +red-bias+                      #x0d15) 
(def-foreign-constant +green-scale+                   #x0d18) 
(def-foreign-constant +green-bias+                    #x0d19) 
(def-foreign-constant +blue-scale+                    #x0d1a) 
(def-foreign-constant +blue-bias+                     #x0d1b) 
(def-foreign-constant +alpha-scale+                   #x0d1c) 
(def-foreign-constant +alpha-bias+                    #x0d1d) 
(def-foreign-constant +depth-scale+                   #x0d1e) 
(def-foreign-constant +depth-bias+                    #x0d1f) 
(def-foreign-constant +pixel-map-s-to-s-size+         #x0cb1) 
(def-foreign-constant +pixel-map-i-to-i-size+         #x0cb0) 
(def-foreign-constant +pixel-map-i-to-r-size+         #x0cb2) 
(def-foreign-constant +pixel-map-i-to-g-size+         #x0cb3) 
(def-foreign-constant +pixel-map-i-to-b-size+         #x0cb4) 
(def-foreign-constant +pixel-map-i-to-a-size+         #x0cb5) 
(def-foreign-constant +pixel-map-r-to-r-size+         #x0cb6) 
(def-foreign-constant +pixel-map-g-to-g-size+         #x0cb7) 
(def-foreign-constant +pixel-map-b-to-b-size+         #x0cb8) 
(def-foreign-constant +pixel-map-a-to-a-size+         #x0cb9) 
(def-foreign-constant +pixel-map-s-to-s+              #x0c71) 
(def-foreign-constant +pixel-map-i-to-i+              #x0c70) 
(def-foreign-constant +pixel-map-i-to-r+              #x0c72) 
(def-foreign-constant +pixel-map-i-to-g+              #x0c73) 
(def-foreign-constant +pixel-map-i-to-b+              #x0c74) 
(def-foreign-constant +pixel-map-i-to-a+              #x0c75) 
(def-foreign-constant +pixel-map-r-to-r+              #x0c76) 
(def-foreign-constant +pixel-map-g-to-g+              #x0c77) 
(def-foreign-constant +pixel-map-b-to-b+              #x0c78) 
(def-foreign-constant +pixel-map-a-to-a+              #x0c79) 
(def-foreign-constant +pack-alignment+                #x0d05) 
(def-foreign-constant +pack-lsb-first+                #x0d01) 
(def-foreign-constant +pack-row-length+               #x0d02) 
(def-foreign-constant +pack-skip-pixels+              #x0d04) 
(def-foreign-constant +pack-skip-rows+                #x0d03) 
(def-foreign-constant +pack-swap-bytes+               #x0d00) 
(def-foreign-constant +unpack-alignment+              #x0cf5) 
(def-foreign-constant +unpack-lsb-first+              #x0cf1) 
(def-foreign-constant +unpack-row-length+             #x0cf2) 
(def-foreign-constant +unpack-skip-pixels+            #x0cf4) 
(def-foreign-constant +unpack-skip-rows+              #x0cf3) 
(def-foreign-constant +unpack-swap-bytes+             #x0cf0) 
(def-foreign-constant +zoom-x+                        #x0d16) 
(def-foreign-constant +zoom-y+                        #x0d17) 

;; Texture Mapping

(def-foreign-constant +texture-env+                   #x2300) 
(def-foreign-constant +texture-env-mode+              #x2200) 
(def-foreign-constant +texture-1d+                    #x0de0) 
(def-foreign-constant +texture-2d+                    #x0de1) 
(def-foreign-constant +texture-wrap-s+                #x2802) 
(def-foreign-constant +texture-wrap-t+                #x2803) 
(def-foreign-constant +texture-mag-filter+            #x2800) 
(def-foreign-constant +texture-min-filter+            #x2801) 
(def-foreign-constant +texture-env-color+             #x2201) 
(def-foreign-constant +texture-gen-s+                 #x0c60) 
(def-foreign-constant +texture-gen-t+                 #x0c61) 
(def-foreign-constant +texture-gen-mode+              #x2500) 
(def-foreign-constant +texture-border-color+          #x1004) 
(def-foreign-constant +texture-width+                 #x1000) 
(def-foreign-constant +texture-height+                #x1001) 
(def-foreign-constant +texture-border+                #x1005) 
(def-foreign-constant +texture-components+            #x1003) 
(def-foreign-constant +texture-red-size+              #x805c) 
(def-foreign-constant +texture-green-size+            #x805d) 
(def-foreign-constant +texture-blue-size+             #x805e) 
(def-foreign-constant +texture-alpha-size+            #x805f) 
(def-foreign-constant +texture-luminance-size+        #x8060) 
(def-foreign-constant +texture-intensity-size+        #x8061) 
(def-foreign-constant +nearest-mipmap-nearest+        #x2700) 
(def-foreign-constant +nearest-mipmap-linear+         #x2702) 
(def-foreign-constant +linear-mipmap-nearest+         #x2701) 
(def-foreign-constant +linear-mipmap-linear+          #x2703) 
(def-foreign-constant +object-linear+                 #x2401) 
(def-foreign-constant +object-plane+                  #x2501) 
(def-foreign-constant +eye-linear+                    #x2400) 
(def-foreign-constant +eye-plane+                     #x2502) 
(def-foreign-constant +sphere-map+                    #x2402) 
(def-foreign-constant +decal+                         #x2101) 
(def-foreign-constant +modulate+                      #x2100) 
(def-foreign-constant +nearest+                       #x2600) 
(def-foreign-constant +repeat+                        #x2901) 
(def-foreign-constant +clamp+                         #x2900) 
(def-foreign-constant +s+                             #x2000) 
(def-foreign-constant +t+                             #x2001) 
(def-foreign-constant +r+                             #x2002) 
(def-foreign-constant +q+                             #x2003) 
(def-foreign-constant +texture-gen-r+                 #x0c62) 
(def-foreign-constant +texture-gen-q+                 #x0c63) 

;; GL 1.1 Texturing

(def-foreign-constant +proxy-texture-1d+              #x8063) 
(def-foreign-constant +proxy-texture-2d+              #x8064) 
(def-foreign-constant +texture-priority+              #x8066) 
(def-foreign-constant +texture-resident+              #x8067) 
(def-foreign-constant +texture-binding-1d+            #x8068) 
(def-foreign-constant +texture-binding-2d+            #x8069) 
(def-foreign-constant +texture-internal-format+       #x1003) 
(def-foreign-constant +pack-skip-images+              #x806b) 
(def-foreign-constant +pack-image-height+             #x806c) 
(def-foreign-constant +unpack-skip-images+            #x806d) 
(def-foreign-constant +unpack-image-height+           #x806e) 
(def-foreign-constant +texture-3d+                    #x806f) 
(def-foreign-constant +proxy-texture-3d+              #x8070) 
(def-foreign-constant +texture-depth+                 #x8071) 
(def-foreign-constant +texture-wrap-r+                #x8072) 
(def-foreign-constant +max-3d-texture-size+           #x8073) 
(def-foreign-constant +texture-binding-3d+            #x806a) 

;; Internal texture formats (GL 1.1)
(def-foreign-constant +alpha4+                        #x803b) 
(def-foreign-constant +alpha8+                        #x803c) 
(def-foreign-constant +alpha12+                       #x803d) 
(def-foreign-constant +alpha16+                       #x803e) 
(def-foreign-constant +luminance4+                    #x803f) 
(def-foreign-constant +luminance8+                    #x8040) 
(def-foreign-constant +luminance12+                   #x8041) 
(def-foreign-constant +luminance16+                   #x8042) 
(def-foreign-constant +luminance4-alpha4+             #x8043) 
(def-foreign-constant +luminance6-alpha2+             #x8044) 
(def-foreign-constant +luminance8-alpha8+             #x8045) 
(def-foreign-constant +luminance12-alpha4+            #x8046) 
(def-foreign-constant +luminance12-alpha12+           #x8047) 
(def-foreign-constant +luminance16-alpha16+           #x8048) 
(def-foreign-constant +intensity+                     #x8049) 
(def-foreign-constant +intensity4+                    #x804a) 
(def-foreign-constant +intensity8+                    #x804b) 
(def-foreign-constant +intensity12+                   #x804c) 
(def-foreign-constant +intensity16+                   #x804d) 
(def-foreign-constant +r3-g3-b2+                      #x2a10) 
(def-foreign-constant +rgb4+                          #x804f) 
(def-foreign-constant +rgb5+                          #x8050) 
(def-foreign-constant +rgb8+                          #x8051) 
(def-foreign-constant +rgb10+                         #x8052) 
(def-foreign-constant +rgb12+                         #x8053) 
(def-foreign-constant +rgb16+                         #x8054) 
(def-foreign-constant +rgba2+                         #x8055) 
(def-foreign-constant +rgba4+                         #x8056) 
(def-foreign-constant +rgb5-a1+                       #x8057) 
(def-foreign-constant +rgba8+                         #x8058) 
(def-foreign-constant +rgb10-a2+                      #x8059) 
(def-foreign-constant +rgba12+                        #x805a) 
(def-foreign-constant +rgba16+                        #x805b) 

;; Utility

(def-foreign-constant +vendor+                        #x1f00) 
(def-foreign-constant +renderer+                      #x1f01) 
(def-foreign-constant +version+                       #x1f02) 
(def-foreign-constant +extensions+                    #x1f03) 

;; Errors

(def-foreign-constant +no-error+                         #x0) 
(def-foreign-constant +invalid-value+                 #x0501) 
(def-foreign-constant +invalid-enum+                  #x0500) 
(def-foreign-constant +invalid-operation+             #x0502) 
(def-foreign-constant +stack-overflow+                #x0503) 
(def-foreign-constant +stack-underflow+               #x0504) 
(def-foreign-constant +out-of-memory+                 #x0505) 

;; OpenGL 1.2

(def-foreign-constant +rescale-normal+                #x803a) 
(def-foreign-constant +clamp-to-edge+                 #x812f) 
(def-foreign-constant +max-elements-vertices+         #x80e8) 
(def-foreign-constant +max-elements-indices+          #x80e9) 
(def-foreign-constant +bgr+                           #x80e0) 
(def-foreign-constant +bgra+                          #x80e1) 
(def-foreign-constant +unsigned-byte-3-3-2+           #x8032) 
(def-foreign-constant +unsigned-byte-2-3-3-rev+       #x8362) 
(def-foreign-constant +unsigned-short-5-6-5+          #x8363) 
(def-foreign-constant +unsigned-short-5-6-5-rev+      #x8364) 
(def-foreign-constant +unsigned-short-4-4-4-4+        #x8033) 
(def-foreign-constant +unsigned-short-4-4-4-4-rev+    #x8365) 
(def-foreign-constant +unsigned-short-5-5-5-1+        #x8034) 
(def-foreign-constant +unsigned-short-1-5-5-5-rev+    #x8366) 
(def-foreign-constant +unsigned-int-8-8-8-8+          #x8035) 
(def-foreign-constant +unsigned-int-8-8-8-8-rev+      #x8367) 
(def-foreign-constant +unsigned-int-10-10-10-2+       #x8036) 
(def-foreign-constant +unsigned-int-2-10-10-10-rev+   #x8368) 
(def-foreign-constant +light-model-color-control+     #x81f8) 
(def-foreign-constant +single-color+                  #x81f9) 
(def-foreign-constant +separate-specular-color+       #x81fa) 
(def-foreign-constant +texture-min-lod+               #x813a) 
(def-foreign-constant +texture-max-lod+               #x813b) 
(def-foreign-constant +texture-base-level+            #x813c) 
(def-foreign-constant +texture-max-level+             #x813d) 
(def-foreign-constant +smooth-point-size-range+       #x0b12) 
(def-foreign-constant +smooth-point-size-granularity+ #x0b13) 
(def-foreign-constant +smooth-line-width-range+       #x0b22) 
(def-foreign-constant +smooth-line-width-granularity+ #x0b23) 
(def-foreign-constant +aliased-point-size-range+      #x846d) 
(def-foreign-constant +aliased-line-width-range+      #x846e) 

;; OpenGL 1.2 Imaging subset
;; GL_EXT_color_table
(def-foreign-constant +color-table+                   #x80d0) 
(def-foreign-constant +post-convolution-color-table+  #x80d1) 
(def-foreign-constant +post-color-matrix-color-table+ #x80d2) 
(def-foreign-constant +proxy-color-table+             #x80d3) 
(def-foreign-constant +proxy-post-convolution-color-table+  #x80d4) 
(def-foreign-constant +proxy-post-color-matrix-color-table+ #x80d5) 
(def-foreign-constant +color-table-scale+             #x80d6) 
(def-foreign-constant +color-table-bias+              #x80d7) 
(def-foreign-constant +color-table-format+            #x80d8) 
(def-foreign-constant +color-table-width+             #x80d9) 
(def-foreign-constant +color-table-red-size+          #x80da) 
(def-foreign-constant +color-table-green-size+        #x80db) 
(def-foreign-constant +color-table-blue-size+         #x80dc) 
(def-foreign-constant +color-table-alpha-size+        #x80dd) 
(def-foreign-constant +color-table-luminance-size+    #x80de) 
(def-foreign-constant +color-table-intensity-size+    #x80df) 
;; GL_EXT_convolution and GL_HP_convolution
(def-foreign-constant +convolution-1d+                #x8010) 
(def-foreign-constant +convolution-2d+                #x8011) 
(def-foreign-constant +separable-2d+                  #x8012) 
(def-foreign-constant +convolution-border-mode+       #x8013) 
(def-foreign-constant +convolution-filter-scale+      #x8014) 
(def-foreign-constant +convolution-filter-bias+       #x8015) 
(def-foreign-constant +reduce+                        #x8016) 
(def-foreign-constant +convolution-format+            #x8017) 
(def-foreign-constant +convolution-width+             #x8018) 
(def-foreign-constant +convolution-height+            #x8019) 
(def-foreign-constant +max-convolution-width+         #x801a) 
(def-foreign-constant +max-convolution-height+        #x801b) 
(def-foreign-constant +post-convolution-red-scale+    #x801c) 
(def-foreign-constant +post-convolution-green-scale+  #x801d) 
(def-foreign-constant +post-convolution-blue-scale+   #x801e) 
(def-foreign-constant +post-convolution-alpha-scale+  #x801f) 
(def-foreign-constant +post-convolution-red-bias+     #x8020) 
(def-foreign-constant +post-convolution-green-bias+   #x8021) 
(def-foreign-constant +post-convolution-blue-bias+    #x8022) 
(def-foreign-constant +post-convolution-alpha-bias+   #x8023) 
(def-foreign-constant +constant-border+               #x8151) 
(def-foreign-constant +replicate-border+              #x8153) 
(def-foreign-constant +convolution-border-color+      #x8154) 
;; GL_SGI_color_matrix
(def-foreign-constant +color-matrix+                  #x80b1) 
(def-foreign-constant +color-matrix-stack-depth+      #x80b2) 
(def-foreign-constant +max-color-matrix-stack-depth+  #x80b3) 
(def-foreign-constant +post-color-matrix-red-scale+   #x80b4) 
(def-foreign-constant +post-color-matrix-green-scale+ #x80b5) 
(def-foreign-constant +post-color-matrix-blue-scale+  #x80b6) 
(def-foreign-constant +post-color-matrix-alpha-scale+ #x80b7) 
(def-foreign-constant +post-color-matrix-red-bias+    #x80b8) 
(def-foreign-constant +post-color-matrix-green-bias+  #x80b9) 
(def-foreign-constant +post-color-matrix-blue-bias+   #x80ba) 
(def-foreign-constant +post-color-matrix-alpha-bias+  #x80bb) 
;; GL_EXT_histogram
(def-foreign-constant +histogram+                     #x8024) 
(def-foreign-constant +proxy-histogram+               #x8025) 
(def-foreign-constant +histogram-width+               #x8026) 
(def-foreign-constant +histogram-format+              #x8027) 
(def-foreign-constant +histogram-red-size+            #x8028) 
(def-foreign-constant +histogram-green-size+          #x8029) 
(def-foreign-constant +histogram-blue-size+           #x802a) 
(def-foreign-constant +histogram-alpha-size+          #x802b) 
(def-foreign-constant +histogram-luminance-size+      #x802c) 
(def-foreign-constant +histogram-sink+                #x802d) 
(def-foreign-constant +minmax+                        #x802e) 
(def-foreign-constant +minmax-format+                 #x802f) 
(def-foreign-constant +minmax-sink+                   #x8030) 
(def-foreign-constant +table-too-large+               #x8031) 
;; GL_EXT_blend_color, GL_EXT_blend_minmax
(def-foreign-constant +blend-equation+                #x8009) 
(def-foreign-constant +min+                           #x8007) 
(def-foreign-constant +max+                           #x8008) 
(def-foreign-constant +func-add+                      #x8006) 
(def-foreign-constant +func-subtract+                 #x800a) 
(def-foreign-constant +func-reverse-subtract+         #x800b) 

;; glPush/PopAttrib bits

(def-foreign-constant +current-bit+               #x00000001) 
(def-foreign-constant +point-bit+                 #x00000002) 
(def-foreign-constant +line-bit+                  #x00000004) 
(def-foreign-constant +polygon-bit+               #x00000008) 
(def-foreign-constant +polygon-stipple-bit+       #x00000010) 
(def-foreign-constant +pixel-mode-bit+            #x00000020) 
(def-foreign-constant +lighting-bit+              #x00000040) 
(def-foreign-constant +fog-bit+                   #x00000080) 
(def-foreign-constant +depth-buffer-bit+          #x00000100) 
(def-foreign-constant +accum-buffer-bit+          #x00000200) 
(def-foreign-constant +stencil-buffer-bit+        #x00000400) 
(def-foreign-constant +viewport-bit+              #x00000800) 
(def-foreign-constant +transform-bit+             #x00001000) 
(def-foreign-constant +enable-bit+                #x00002000) 
(def-foreign-constant +color-buffer-bit+          #x00004000) 
(def-foreign-constant +hint-bit+                  #x00008000) 
(def-foreign-constant +eval-bit+                  #x00010000) 
(def-foreign-constant +list-bit+                  #x00020000) 
(def-foreign-constant +texture-bit+               #x00040000) 
(def-foreign-constant +scissor-bit+               #x00080000) 
(def-foreign-constant +all-attrib-bits+           #x000fffff) 
(def-foreign-constant +client-pixel-store-bit+    #x00000001) 
(def-foreign-constant +client-vertex-array-bit+   #x00000002) 
(def-foreign-constant +client-all-attrib-bits+    #xffffffff) 

;; ARB Multitexturing extension

(def-foreign-constant +arb-multitexture+                   1) 
(def-foreign-constant +texture0-arb+                  #x84c0) 
(def-foreign-constant +texture1-arb+                  #x84c1) 
(def-foreign-constant +texture2-arb+                  #x84c2) 
(def-foreign-constant +texture3-arb+                  #x84c3) 
(def-foreign-constant +texture4-arb+                  #x84c4) 
(def-foreign-constant +texture5-arb+                  #x84c5) 
(def-foreign-constant +texture6-arb+                  #x84c6) 
(def-foreign-constant +texture7-arb+                  #x84c7) 
(def-foreign-constant +texture8-arb+                  #x84c8) 
(def-foreign-constant +texture9-arb+                  #x84c9) 
(def-foreign-constant +texture10-arb+                 #x84ca) 
(def-foreign-constant +texture11-arb+                 #x84cb) 
(def-foreign-constant +texture12-arb+                 #x84cc) 
(def-foreign-constant +texture13-arb+                 #x84cd) 
(def-foreign-constant +texture14-arb+                 #x84ce) 
(def-foreign-constant +texture15-arb+                 #x84cf) 
(def-foreign-constant +texture16-arb+                 #x84d0) 
(def-foreign-constant +texture17-arb+                 #x84d1) 
(def-foreign-constant +texture18-arb+                 #x84d2) 
(def-foreign-constant +texture19-arb+                 #x84d3) 
(def-foreign-constant +texture20-arb+                 #x84d4) 
(def-foreign-constant +texture21-arb+                 #x84d5) 
(def-foreign-constant +texture22-arb+                 #x84d6) 
(def-foreign-constant +texture23-arb+                 #x84d7) 
(def-foreign-constant +texture24-arb+                 #x84d8) 
(def-foreign-constant +texture25-arb+                 #x84d9) 
(def-foreign-constant +texture26-arb+                 #x84da) 
(def-foreign-constant +texture27-arb+                 #x84db) 
(def-foreign-constant +texture28-arb+                 #x84dc) 
(def-foreign-constant +texture29-arb+                 #x84dd) 
(def-foreign-constant +texture30-arb+                 #x84de) 
(def-foreign-constant +texture31-arb+                 #x84df) 
(def-foreign-constant +active-texture-arb+            #x84e0) 
(def-foreign-constant +client-active-texture-arb+     #x84e1) 
(def-foreign-constant +max-texture-units-arb+         #x84e2) 

;;; Misc extensions

(def-foreign-constant +ext-abgr+                           1) 
(def-foreign-constant +abgr-ext+                      #x8000) 
(def-foreign-constant +ext-blend-color+                    1) 
(def-foreign-constant +constant-color-ext+            #x8001) 
(def-foreign-constant +one-minus-constant-color-ext+  #x8002) 
(def-foreign-constant +constant-alpha-ext+            #x8003) 
(def-foreign-constant +one-minus-constant-alpha-ext+  #x8004) 
(def-foreign-constant +blend-color-ext+               #x8005) 
(def-foreign-constant +ext-polygon-offset+                 1) 
(def-foreign-constant +polygon-offset-ext+            #x8037) 
(def-foreign-constant +polygon-offset-factor-ext+     #x8038) 
(def-foreign-constant +polygon-offset-bias-ext+       #x8039) 
(def-foreign-constant +ext-texture3d+                      1) 
(def-foreign-constant +pack-skip-images-ext+          #x806b) 
(def-foreign-constant +pack-image-height-ext+         #x806c) 
(def-foreign-constant +unpack-skip-images-ext+        #x806d) 
(def-foreign-constant +unpack-image-height-ext+       #x806e) 
(def-foreign-constant +texture-3d-ext+                #x806f) 
(def-foreign-constant +proxy-texture-3d-ext+          #x8070) 
(def-foreign-constant +texture-depth-ext+             #x8071) 
(def-foreign-constant +texture-wrap-r-ext+            #x8072) 
(def-foreign-constant +max-3d-texture-size-ext+       #x8073) 
(def-foreign-constant +texture-3d-binding-ext+        #x806a) 
(def-foreign-constant +ext-texture-object+                 1) 
(def-foreign-constant +texture-priority-ext+          #x8066) 
(def-foreign-constant +texture-resident-ext+          #x8067) 
(def-foreign-constant +texture-1d-binding-ext+        #x8068) 
(def-foreign-constant +texture-2d-binding-ext+        #x8069) 
(def-foreign-constant +ext-rescale-normal+                 1) 
(def-foreign-constant +rescale-normal-ext+            #x803a) 
(def-foreign-constant +ext-vertex-array+                   1) 
(def-foreign-constant +vertex-array-ext+              #x8074) 
(def-foreign-constant +normal-array-ext+              #x8075) 
(def-foreign-constant +color-array-ext+               #x8076) 
(def-foreign-constant +index-array-ext+               #x8077) 
(def-foreign-constant +texture-coord-array-ext+       #x8078) 
(def-foreign-constant +edge-flag-array-ext+           #x8079) 
(def-foreign-constant +vertex-array-size-ext+         #x807a) 
(def-foreign-constant +vertex-array-type-ext+         #x807b) 
(def-foreign-constant +vertex-array-stride-ext+       #x807c) 
(def-foreign-constant +vertex-array-count-ext+        #x807d) 
(def-foreign-constant +normal-array-type-ext+         #x807e) 
(def-foreign-constant +normal-array-stride-ext+       #x807f) 
(def-foreign-constant +normal-array-count-ext+        #x8080) 
(def-foreign-constant +color-array-size-ext+          #x8081) 
(def-foreign-constant +color-array-type-ext+          #x8082) 
(def-foreign-constant +color-array-stride-ext+        #x8083) 
(def-foreign-constant +color-array-count-ext+         #x8084) 
(def-foreign-constant +index-array-type-ext+          #x8085) 
(def-foreign-constant +index-array-stride-ext+        #x8086) 
(def-foreign-constant +index-array-count-ext+         #x8087) 
(def-foreign-constant +texture-coord-array-size-ext+  #x8088) 
(def-foreign-constant +texture-coord-array-type-ext+  #x8089) 
(def-foreign-constant +texture-coord-array-stride-ext+ #x808a) 
(def-foreign-constant +texture-coord-array-count-ext+ #x808b) 
(def-foreign-constant +edge-flag-array-stride-ext+    #x808c) 
(def-foreign-constant +edge-flag-array-count-ext+     #x808d) 
(def-foreign-constant +vertex-array-pointer-ext+      #x808e) 
(def-foreign-constant +normal-array-pointer-ext+      #x808f) 
(def-foreign-constant +color-array-pointer-ext+       #x8090) 
(def-foreign-constant +index-array-pointer-ext+       #x8091) 
(def-foreign-constant +texture-coord-array-pointer-ext+ #x8092) 
(def-foreign-constant +edge-flag-array-pointer-ext+   #x8093) 
(def-foreign-constant +sgis-texture-edge-clamp+            1) 
(def-foreign-constant +clamp-to-edge-sgis+            #x812f) 
(def-foreign-constant +ext-blend-minmax+                   1) 
(def-foreign-constant +func-add-ext+                  #x8006) 
(def-foreign-constant +min-ext+                       #x8007) 
(def-foreign-constant +max-ext+                       #x8008) 
(def-foreign-constant +blend-equation-ext+            #x8009) 
(def-foreign-constant +ext-blend-subtract+                 1) 
(def-foreign-constant +func-subtract-ext+             #x800a) 
(def-foreign-constant +func-reverse-subtract-ext+     #x800b) 
(def-foreign-constant +ext-blend-logic-op+                 1) 
(def-foreign-constant +ext-point-parameters+               1) 
(def-foreign-constant +point-size-min-ext+            #x8126) 
(def-foreign-constant +point-size-max-ext+            #x8127) 
(def-foreign-constant +point-fade-threshold-size-ext+ #x8128) 
(def-foreign-constant +distance-attenuation-ext+      #x8129) 
(def-foreign-constant +ext-paletted-texture+               1) 
(def-foreign-constant +table-too-large-ext+           #x8031) 
(def-foreign-constant +color-table-format-ext+        #x80d8) 
(def-foreign-constant +color-table-width-ext+         #x80d9) 
(def-foreign-constant +color-table-red-size-ext+      #x80da) 
(def-foreign-constant +color-table-green-size-ext+    #x80db) 
(def-foreign-constant +color-table-blue-size-ext+     #x80dc) 
(def-foreign-constant +color-table-alpha-size-ext+    #x80dd) 
(def-foreign-constant +color-table-luminance-size-ext+ #x80de) 
(def-foreign-constant +color-table-intensity-size-ext+ #x80df) 
(def-foreign-constant +texture-index-size-ext+        #x80ed) 
(def-foreign-constant +color-index1-ext+              #x80e2) 
(def-foreign-constant +color-index2-ext+              #x80e3) 
(def-foreign-constant +color-index4-ext+              #x80e4) 
(def-foreign-constant +color-index8-ext+              #x80e5) 
(def-foreign-constant +color-index12-ext+             #x80e6) 
(def-foreign-constant +color-index16-ext+             #x80e7) 
(def-foreign-constant +ext-clip-volume-hint+               1) 
(def-foreign-constant +clip-volume-clipping-hint-ext+ #x80f0) 
(def-foreign-constant +ext-compiled-vertex-array+          1) 
(def-foreign-constant +array-element-lock-first-ext+  #x81a8) 
(def-foreign-constant +array-element-lock-count-ext+  #x81a9) 
(def-foreign-constant +hp-occlusion-test+                  1) 
(def-foreign-constant +occlusion-test-hp+             #x8165) 
(def-foreign-constant +occlusion-test-result-hp+      #x8166) 
(def-foreign-constant +ext-shared-texture-palette+         1) 
(def-foreign-constant +shared-texture-palette-ext+    #x81fb) 
(def-foreign-constant +ext-stencil-wrap+                   1) 
(def-foreign-constant +incr-wrap-ext+                 #x8507) 
(def-foreign-constant +decr-wrap-ext+                 #x8508) 
(def-foreign-constant +nv-texgen-reflection+               1) 
(def-foreign-constant +normal-map-nv+                 #x8511) 
(def-foreign-constant +reflection-map-nv+             #x8512) 
(def-foreign-constant +ext-texture-env-add+                1) 
(def-foreign-constant +mesa-window-pos+                    1) 
(def-foreign-constant +mesa-resize-buffers+                1)

;;;
;;; OpenGL functions
;;; ================

;;
;; Misc
;; ====

(def-foreign-routine ("glClearIndex" clear-index) void
  (c single-float))

(def-foreign-routine ("glClearColor" clear-color) void
  (red   clampf)
  (green clampf)
  (blue  clampf)
  (alpha clampf))

(def-foreign-routine ("glClear" clear) void
  (mask bitfield))

(def-foreign-routine ("glIndexMask" index-mask) void
  (mask uint))

(def-foreign-routine ("glColorMask" color-mask) void
  (red   boolean)
  (green boolean)
  (blue  boolean)
  (alpha boolean))

(def-foreign-routine ("glAlphaFunc" alpha-func) void
  (func enum)
  (ref  clampf))

(def-foreign-routine ("glBlendFunc" blend-func) void
  (sfactor enum)
  (dfactor enum))

(def-foreign-routine ("glLogicOp" logic-op) void
  (opcode  enum))

(def-foreign-routine ("glCullFace" cull-face) void
  (mode enum))

(def-foreign-routine ("glFrontFace" front-face) void
  (mode enum))

(def-foreign-routine ("glPointSize" point-size) void
  (size single-float))

(def-foreign-routine ("glLineWidth" line-width) void
  (width single-float))

(def-foreign-routine ("glLineStipple" line-stipple) void
  (factor int)
  (pattern ushort))

(def-foreign-routine ("glPolygonMode" polygon-mode) void
  (face enum)
  (mode enum))

(def-foreign-routine ("glPolygonOffset" polygon-offset) void
  (factor single-float)
  (units  single-float))

(def-foreign-routine ("glPolygonStipple" polygon-stipple) void
  (mask (* ubyte))) ; const 32x32 array of bytes

(def-foreign-routine ("glGetPolygonStipple" get-polygon-stipple) void
  (mask (* ubyte))) ; 32x32 array of bytes

(def-foreign-routine ("glEdgeFlag" edge-flag) void
  (flag boolean))

(def-foreign-routine ("glEdgeFlagv" edge-flagv) void
  (flag (* boolean))) ; const

(def-foreign-routine ("glScissor" scissor) void
  (x      int)
  (y      int)
  (width  sizei)
  (height sizei))

(def-foreign-routine ("glClipPlane" clip-plane) void
  (plane enum)
  (equation (* double))) ; const 

(def-foreign-routine ("glGetClipPlane" get-clip-plane) void
  (plane enum)
  (equation (* double)))

(def-foreign-routine ("glDrawBuffer" draw-buffer) void
  (mode enum))

(def-foreign-routine ("glReadBuffer" read-buffer) void
  (mode enum))

(def-foreign-routine ("glEnable" enable) void
  (cap enum))

(def-foreign-routine ("glDisable" disable) void
  (cap enum))

(def-foreign-routine ("glIsEnabled" is-enabled) boolean
  (cap enum))

(def-foreign-routine ("glEnableClientState" enable-client-state) void
  (cap enum))

(def-foreign-routine ("glDisableClientState" disable-client-state) void
  (cap enum))

(def-foreign-routine ("glGetBooleanv" get-booleanv) void
  (pname  enum)
  (params (* boolean)))

(def-foreign-routine ("glGetDoublev" get-doublev) void
  (pname enum)
  (params (* double)))

(def-foreign-routine ("glGetFloatv" get-floatv) void
  (pname enum)
  (parame (* single-float)))

(def-foreign-routine ("glGetIntegerv" get-integerv) void
  (pname  enum)
  (params (* int)))

(def-foreign-routine ("glPushAttrib" push-attrib) void
  (mask bitfield))

(def-foreign-routine ("glPopAttrib" pop-attrib) void)

(def-foreign-routine ("glPushClientAttrib" push-client-attrib) void
  (mask bitfield))

(def-foreign-routine ("glPopClientAttrib" pop-client-attrib) void)

(def-foreign-routine ("glRenderMode" render-mode) int
  (mode enum))

(def-foreign-routine ("glGetError" get-error) enum)

;; maybe the return-type should be const ubyte*, but we'll be more lispy
(def-foreign-routine ("glGetString" get-string) c-string
  (name enum)) 

(def-foreign-routine ("glFinish" finish) void)

(def-foreign-routine ("glFlush" flush) void)

(def-foreign-routine ("glHint" hint) void
  (target enum)
  (mode   enum))

;;
;; Depth Buffer
;; ============

(def-foreign-routine ("glClearDepth" clear-depth) void
  (depth clampd))

(def-foreign-routine ("glDepthFunc" depth-func) void
  (func enum))

(def-foreign-routine ("glDepthMask" depth-mask) void
  (flag boolean))

(def-foreign-routine ("glDepthRange" depth-range) void
  (near-val clampd)
  (far-val  clampd))

;;
;; Accumulation Buffer
;; ===================

(def-foreign-routine ("glClearAccum" clear-accum) void
  (red   single-float)
  (green single-float)
  (blue  single-float)
  (alpha single-float))

(def-foreign-routine ("glAccum" accum) void
  (op    enum)
  (value single-float))

;;
;; Transformation
;; ==============

(def-foreign-routine ("glMatrixMode" matrix-mode) void
  (mode enum))

(def-foreign-routine ("glOrtho" ortho) void
  (leftv     double)
  (rightv    double)
  (bottomv   double)
  (topv      double)
  (near-val double)
  (far-val  double))

(def-foreign-routine ("glFrustum" frustum) void
  (leftv     double)
  (rightv    double)
  (bottomv   double)
  (topv      double)
  (near-val double)
  (far-val  double))

(def-foreign-routine ("glViewport" viewport) void
  (x      int)
  (y      int)
  (width  sizei)
  (height sizei))

(def-foreign-routine ("glPushMatrix" push-matrix) void)

(def-foreign-routine ("glPopMatrix" pop-matrix) void)

(def-foreign-routine ("glLoadIdentity" load-identity) void)

(def-foreign-routine ("glLoadMatrixd" load-matrix-d) void
  (m (* double))) ; const

(def-foreign-routine ("glLoadMatrixf" load-matrix-f) void
  (m (* single-float))) ; const

(def-foreign-routine ("glMultMatrixd" mult-matrix-d) void
  (m (* double))) ; const

(def-foreign-routine ("glMultMatrixf" mult-matrix-f) void
  (m (* single-float))) ; const

(def-foreign-routine ("glRotated" rotate-d) void
  (angle double)
  (x     double)
  (y     double)
  (z     double))

(def-foreign-routine ("glRotatef" rotate-f) void
  (angle single-float)
  (x     single-float)
  (y     single-float)
  (z     single-float))

(def-foreign-routine ("glScaled" scale-d) void
  (x double)
  (y double)
  (z double))

(def-foreign-routine ("glScalef" scale-f) void
  (x single-float)
  (y single-float)
  (z single-float))

(def-foreign-routine ("glTranslated" translate-d) void
  (x double)
  (y double)
  (z double))

(def-foreign-routine ("glTranslatef" translate-f) void
  (x single-float)
  (y single-float)
  (z single-float))

;;
;; Display Lists
;; =============

(def-foreign-routine ("glIsList" is-list) boolean
  (list uint))

(def-foreign-routine ("glDeleteLists" delete-lists) void
  (list  uint)
  (range sizei))

(def-foreign-routine ("glGenLists" gen-lists) uint
  (range sizei))

(def-foreign-routine ("glNewList" new-list) void
  (list uint)
  (mode enum))

(def-foreign-routine ("glEndList" end-list) void)

(def-foreign-routine ("glCallList" call-list) void
  (list uint))

(def-foreign-routine ("glCallLists" call-lists) void
  (n     sizei)
  (type  enum)
  (lists void*)) ; was (const GLvoid *lists)

(def-foreign-routine ("glListBase" list-base) void
  (base uint))

;;
;; Drawing Functions
;; =================

(def-foreign-routine ("glBegin" begin) void
  (mode enum))

(def-foreign-routine ("glEnd" end) void)

(def-foreign-routine ("glVertex2d" vertex-2d) void
  (x double)
  (y double))

(def-foreign-routine ("glVertex2f" vertex-2f) void
  (x single-float)
  (y single-float))

(def-foreign-routine ("glVertex2i" vertex-2i) void
  (x int)
  (y int))

(def-foreign-routine ("glVertex2s" vertex-2s) void
  (x short)
  (y short))

(def-foreign-routine ("glVertex3d" vertex-3d) void
  (x double)
  (y double)
  (z double))

(def-foreign-routine ("glVertex3f" vertex-3f) void
  (x single-float)
  (y single-float)
  (z single-float))

(def-foreign-routine ("glVertex3i" vertex-3i) void
  (x int)
  (y int)
  (z int))

(def-foreign-routine ("glVertex3s" vertex-3s) void
  (x short)
  (y short)
  (z short))

(def-foreign-routine ("glVertex4d" vertex-4d) void
  (x double)
  (y double)
  (z double)
  (w double))

(def-foreign-routine ("glVertex4f" vertex-4f) void
  (x single-float)
  (y single-float)
  (z single-float)
  (w single-float))

(def-foreign-routine ("glVertex4i" vertex-4i) void
  (x int)
  (y int)
  (z int)
  (w int))

(def-foreign-routine ("glVertex4s" vertex-4s) void
  (x short)
  (y short)
  (z short)
  (w short))

(def-foreign-routine ("glVertex2dv" vertex-2dv) void
  (v (* double))) ; const

(def-foreign-routine ("glVertex2fv" vertex-2fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glVertex2iv" vertex-2iv) void
  (v (* int))) ; const

(def-foreign-routine ("glVertex2sv" vertex-2sv) void
  (v (* short))) ; const

(def-foreign-routine ("glVertex3dv" vertex-3dv) void
  (v (* double))) ; const

(def-foreign-routine ("glVertex3fv" vertex-3fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glVertex3iv" vertex-3iv) void
  (v (* int))) ; const

(def-foreign-routine ("glVertex3sv" vertex-3sv) void
  (v (* short))) ; const

(def-foreign-routine ("glVertex4dv" vertex-4dv) void
  (v (* double))) ; const

(def-foreign-routine ("glVertex4fv" vertex-4fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glVertex4iv" vertex-4iv) void
  (v (* int))) ; const

(def-foreign-routine ("glVertex4sv" vertex-4sv) void
  (v (* short))) ; const

(def-foreign-routine ("glNormal3b" normal-3b) void
  (nx byte)
  (ny byte)
  (nz byte))

(def-foreign-routine ("glNormal3d" normal-3d) void
  (nx double)
  (ny double)
  (nz double))

(def-foreign-routine ("glNormal3f" normal-3f) void
  (nx single-float)
  (ny single-float)
  (nz single-float))

(def-foreign-routine ("glNormal3i" normal-3i) void
  (nx int)
  (ny int)
  (nz int))

(def-foreign-routine ("glNormal3s" normal-3s) void
  (nx short)
  (ny short)
  (nz short))

(def-foreign-routine ("glNormal3bv" normal-3bv) void
  (v (* byte))) ; const

(def-foreign-routine ("glNormal3dv" normal-3dv) void
  (v (* double))) ; const

(def-foreign-routine ("glNormal3fv" normal-3fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glNormal3iv" normal-3iv) void
  (v (* int))) ; const

(def-foreign-routine ("glNormal3sv" normal-3sv) void
  (v (* short))) ; const

(def-foreign-routine ("glIndexd" index-d) void
  (c double))

(def-foreign-routine ("glIndexf" index-f) void
  (c single-float))

(def-foreign-routine ("glIndexi" index-i) void
  (c int))

(def-foreign-routine ("glIndexs" index-s) void
  (c short))

(def-foreign-routine ("glIndexub" index-ub) void
  (c ubyte))

(def-foreign-routine ("glIndexdv" index-dv) void
  (x (* double))) ; const

(def-foreign-routine ("glIndexfv" index-fv) void
  (x (* single-float))) ; const

(def-foreign-routine ("glIndexiv" index-iv) void
  (x (* int))) ; const

(def-foreign-routine ("glIndexsv" index-sv) void
  (x (* short))) ; const

(def-foreign-routine ("glIndexubv" index-ubv) void
  (x (* ubyte))) ; const

(def-foreign-routine ("glColor3b" color-3b) void
  (red   byte)
  (green byte)
  (blue  byte))

(def-foreign-routine ("glColor3d" color-3d) void
  (red   double)
  (green double)
  (blue  double))

(def-foreign-routine ("glColor3f" color-3f) void
  (red   single-float)
  (green single-float)
  (blue  single-float))

(def-foreign-routine ("glColor3i" color-3i) void
  (red   int)
  (green int)
  (blue  int))

(def-foreign-routine ("glColor3s" color-3s) void
  (red   short)
  (green short)
  (blue  short))

(def-foreign-routine ("glColor3ub" color-3ub) void
  (red   ubyte)
  (green ubyte)
  (blue  ubyte))

(def-foreign-routine ("glColor3ui" color-3ui) void
  (red   uint)
  (green uint)
  (blue  uint))

(def-foreign-routine ("glColor3us" color-3us) void
  (red   ushort)
  (green ushort)
  (blue  ushort))

(def-foreign-routine ("glColor4b" color-4b) void
  (red   byte)
  (green byte)
  (blue  byte)
  (alpha byte))

(def-foreign-routine ("glColor4d" color-4d) void
  (red   double)
  (green double)
  (blue  double)
  (alpha double))

(def-foreign-routine ("glColor4f" color-4f) void
  (red   single-float)
  (green single-float)
  (blue  single-float)
  (alpha single-float))

(def-foreign-routine ("glColor4i" color-4i) void
  (red   int)
  (green int)
  (blue  int)
  (alpha int))

(def-foreign-routine ("glColor4s" color-4s) void
  (red   short)
  (green short)
  (blue  short)
  (alpha short))

(def-foreign-routine ("glColor4ub" color-4ub) void
  (red   ubyte)
  (green ubyte)
  (blue  ubyte)
  (alpha ubyte))

(def-foreign-routine ("glColor4ui" color-4ui) void
  (red   uint)
  (green uint)
  (blue  uint)
  (alpha uint))

(def-foreign-routine ("glColor4us" color-4us) void
  (red   ushort)
  (green ushort)
  (blue  ushort)
  (alpha ushort))

(def-foreign-routine ("glColor3bv" color-3bv) void
  (v (* byte))) ; const

(def-foreign-routine ("glColor3dv" color-3dv) void
  (v (* double))) ; const

(def-foreign-routine ("glColor3fv" color-3fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glColor3iv" color-3iv) void
  (v (* int))) ; const

(def-foreign-routine ("glColor3sv" color-3sv) void
  (v (* short))) ; const

(def-foreign-routine ("glColor3ubv" color-3ubv) void
  (v (* ubyte))) ; const

(def-foreign-routine ("glColor3uiv" color-3uiv) void
  (v (* uint))) ; const

(def-foreign-routine ("glColor3usv" color-3usv) void
  (v (* ushort))) ; const

(def-foreign-routine ("glColor4bv" color-4bv) void
  (v (* byte))) ; const

(def-foreign-routine ("glColor4dv" color-4dv) void
  (v (* double))) ; const

(def-foreign-routine ("glColor4fv" color-4fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glColor4iv" color-4iv) void
  (v (* int))) ; const

(def-foreign-routine ("glColor4sv" color-4sv) void
  (v (* short))) ; const

(def-foreign-routine ("glColor4ubv" color-4ubv) void
  (v (* ubyte))) ; const

(def-foreign-routine ("glColor4uiv" color-4uiv) void
  (v (* uint))) ; const

(def-foreign-routine ("glColor4usv" color-4usv) void
  (v (* ushort))) ; const

(def-foreign-routine ("glTexCoord1d" tex-coord-1d) void
  (s double))

(def-foreign-routine ("glTexCoord1f" tex-coord-1f) void
  (s single-float))

(def-foreign-routine ("glTexCoord1i" tex-coord-1i) void
  (s int))

(def-foreign-routine ("glTexCoord1s" tex-coord-1s) void
  (s short))

(def-foreign-routine ("glTexCoord2d" tex-coord-2d) void
  (s double)
  (u double))

(def-foreign-routine ("glTexCoord2f" tex-coord-2f) void
  (s single-float)
  (u single-float))

(def-foreign-routine ("glTexCoord2i" tex-coord-2i) void
  (s int)
  (u int))

(def-foreign-routine ("glTexCoord2s" tex-coord-2s) void
  (s short)
  (u short))

(def-foreign-routine ("glTexCoord3d" tex-coord-3d) void
  (s double)
  (u double)
  (r double))

(def-foreign-routine ("glTexCoord3f" tex-coord-3f) void
  (s single-float)
  (u single-float)
  (r single-float))

(def-foreign-routine ("glTexCoord3i" tex-coord-3i) void
  (s int)
  (u int)
  (r int))

(def-foreign-routine ("glTexCoord3s" tex-coord-3s) void
  (s short)
  (u short)
  (r short))

(def-foreign-routine ("glTexCoord4d" tex-coord-4d) void
  (s double)
  (u double)
  (r double)
  (q double))

(def-foreign-routine ("glTexCoord4f" tex-coord-4f) void
  (s single-float)
  (u single-float)
  (r single-float)
  (q single-float))

(def-foreign-routine ("glTexCoord4i" tex-coord-4i) void
  (s int)
  (u int)
  (r int)
  (q int))

(def-foreign-routine ("glTexCoord4s" tex-coord-4s) void
  (s short)
  (u short)
  (r short)
  (q short))

(def-foreign-routine ("glTexCoord1dv" tex-coord-1dv) void
  (v (* double))) ; const

(def-foreign-routine ("glTexCoord1fv" tex-coord-1fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glTexCoord1iv" tex-coord-1iv) void
  (v (* int))) ; const

(def-foreign-routine ("glTexCoord1sv" tex-coord-1sv) void
  (v (* short))) ; const

(def-foreign-routine ("glTexCoord2dv" tex-coord-2dv) void
  (v (* double))) ; const

(def-foreign-routine ("glTexCoord2fv" tex-coord-2fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glTexCoord2iv" tex-coord-2iv) void
  (v (* int))) ; const

(def-foreign-routine ("glTexCoord2sv" tex-coord-2sv) void
  (v (* short))) ; const

(def-foreign-routine ("glTexCoord3dv" tex-coord-3dv) void
  (v (* double))) ; const

(def-foreign-routine ("glTexCoord3fv" tex-coord-3fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glTexCoord3iv" tex-coord-3iv) void
  (v (* int))) ; const

(def-foreign-routine ("glTexCoord3sv" tex-coord-3sv) void
  (v (* short))) ; const

(def-foreign-routine ("glTexCoord4dv" tex-coord-4dv) void
  (v (* double))) ; const

(def-foreign-routine ("glTexCoord4fv" tex-coord-4fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glTexCoord4iv" tex-coord-4iv) void
  (v (* int))) ; const

(def-foreign-routine ("glTexCoord4sv" tex-coord-4sv) void
  (v (* short))) ; const

(def-foreign-routine ("glRasterPos2d" raster-pos-2d) void
  (x double)
  (y double))

(def-foreign-routine ("glRasterPos2f" raster-pos-2f) void
  (x single-float)
  (y single-float))

(def-foreign-routine ("glRasterPos2i" raster-pos-2i) void
  (x int)
  (y int))

(def-foreign-routine ("glRasterPos2s" raster-pos-2s) void
  (x short)
  (y short))

(def-foreign-routine ("glRasterPos3d" raster-pos-3d) void
  (x double)
  (y double)
  (z double))

(def-foreign-routine ("glRasterPos3f" raster-pos-3f) void
  (x single-float)
  (y single-float)
  (z single-float))

(def-foreign-routine ("glRasterPos3i" raster-pos-3i) void
  (x int)
  (y int)
  (z int))

(def-foreign-routine ("glRasterPos3s" raster-pos-3s) void
  (x short)
  (y short)
  (z short))

(def-foreign-routine ("glRasterPos4d" raster-pos-4d) void
  (x double)
  (y double)
  (z double)
  (w double))

(def-foreign-routine ("glRasterPos4f" raster-pos-4f) void
  (x single-float)
  (y single-float)
  (z single-float)
  (w single-float))

(def-foreign-routine ("glRasterPos4i" raster-pos-4i) void
  (x int)
  (y int)
  (z int)
  (w int))

(def-foreign-routine ("glRasterPos4s" raster-pos-4s) void
  (x short)
  (y short)
  (z short)
  (w short))

(def-foreign-routine ("glRasterPos2dv" raster-pos-2dv) void
  (v (* double))) ; const

(def-foreign-routine ("glRasterPos2fv" raster-pos-2fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glRasterPos2iv" raster-pos-2iv) void
  (v (* int))) ; const

(def-foreign-routine ("glRasterPos2sv" raster-pos-2sv) void
  (v (* short))) ; const

(def-foreign-routine ("glRasterPos3dv" raster-pos-3dv) void
  (v (* double))) ; const

(def-foreign-routine ("glRasterPos3fv" raster-pos-3fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glRasterPos3iv" raster-pos-3iv) void
  (v (* int))) ; const

(def-foreign-routine ("glRasterPos3sv" raster-pos-3sv) void
  (v (* short))) ; const

(def-foreign-routine ("glRasterPos4dv" raster-pos-4dv) void
  (v (* double))) ; const

(def-foreign-routine ("glRasterPos4fv" raster-pos-4fv) void
  (v (* single-float))) ; const

(def-foreign-routine ("glRasterPos4iv" raster-pos-4iv) void
  (v (* int))) ; const

(def-foreign-routine ("glRasterPos4sv" raster-pos-4sv) void
  (v (* short))) ; const

(def-foreign-routine ("glRectd" rect-d) void
  (x1 double)
  (y1 double)
  (x2 double)
  (y2 double))

(def-foreign-routine ("glRectf" rect-f) void
  (x1 single-float)
  (y1 single-float)
  (x2 single-float)
  (y2 single-float))

(def-foreign-routine ("glRecti" rect-i) void
  (x1 int)
  (y1 int)
  (x2 int)
  (y2 int))

(def-foreign-routine ("glRects" rect-s) void
  (x1 short)
  (y1 short)
  (x2 short)
  (y2 short))

(def-foreign-routine ("glRectdv" rect-dv) void
  (v1 (* double))  ; const
  (v2 (* double))) ; const

(def-foreign-routine ("glRectfv" rect-fv) void
  (v1 (* single-float))  ; const
  (v2 (* single-float))) ; const

(def-foreign-routine ("glRectiv" rect-iv) void
  (v1 (* int))  ; const
  (v2 (* int))) ; const

(def-foreign-routine ("glRectsv" rect-sv) void
  (v1 (* short))  ; const
  (v2 (* short))) ; const

;;
;; Vertex Arrays (1.1)
;; ===================

(def-foreign-routine ("glVertexPointer" vertex-pointer) void
  (size   int)
  (type   enum)
  (stride sizei)
  (ptr    void*)) ; const

(def-foreign-routine ("glNormalPointer" normal-pointer) void
  (type   enum)
  (stride sizei)
  (ptr    void*)) ; const

(def-foreign-routine ("glColorPointer" color-pointer) void
  (size   int)
  (type   enum)
  (stride sizei)
  (ptr    void*)) ;const

(def-foreign-routine ("glIndexPointer" index-pointer) void
  (type   enum)
  (stride sizei)
  (ptr    void*)) ; const

(def-foreign-routine ("glTexCoordPointer" tex-coord-pointer) void
  (size   int)
  (type   enum)
  (stride sizei)
  (ptr    void*)) ; const

(def-foreign-routine ("glEdgeFlagPointer" edge-flag-pointer) void
  (stride sizei)
  (ptr    void*)) ; const

(def-foreign-routine ("glGetPointerv" get-pointerv) void
  (pname  enum)
  (params (* void*)))

(def-foreign-routine ("glArrayElement" array-element) void
  (i int))

(def-foreign-routine ("glDrawArrays" draw-arrays) void
  (mode enum)
  (first int)
  (count sizei))

(def-foreign-routine ("glDrawElements" draw-elements) void
  (mode    enum)
  (count   sizei)
  (type    enum)
  (indices void*)) ;const

(def-foreign-routine ("glInterleavedArrays" interleaved-arrays) void
  (format  enum)
  (stride  sizei)
  (pointer void*)) ; const

;;
;; Lighting
;; ========

(def-foreign-routine ("glShadeModel" shade-model) void
  (mode enum))

(def-foreign-routine ("glLightf" light-f) void
  (light enum)
  (pname enum)
  (param single-float))

(def-foreign-routine ("glLighti" light-i) void
  (light enum)
  (pname enum)
  (param int))

(def-foreign-routine ("glLightfv" light-fv) void
  (light  enum)
  (pname  enum)
  (params (* single-float))) ; const

(def-foreign-routine ("glLightiv" light-iv) void
  (light  enum)
  (pname  enum)
  (params (* int))) ; const

(def-foreign-routine ("glGetLightfv" get-light-fv) void
  (light  enum)
  (pname  enum)
  (params (* single-float)))

(def-foreign-routine ("glGetLightiv" get-light-iv) void
  (light  enum)
  (pname  enum)
  (params (* int)))

(def-foreign-routine ("glLightModelf" light-model-f) void
  (pname enum)
  (param single-float))

(def-foreign-routine ("glLightModeli" light-model-i) void
  (pname enum)
  (param int))

(def-foreign-routine ("glLightModelfv" light-model-fv) void
  (pname  enum)
  (params (* single-float))) ; const

(def-foreign-routine ("glLightModeliv" light-model-iv) void
  (pname  enum)
  (params (* int))) ; const

(def-foreign-routine ("glMaterialf" material-f) void
  (face  enum)
  (pname enum)
  (param single-float))

(def-foreign-routine ("glMateriali" material-i) void
  (face  enum)
  (pname enum)
  (param int))

(def-foreign-routine ("glMaterialfv" material-fv) void
  (face   enum)
  (pname  enum)
  (params (* single-float))) ;const


(def-foreign-routine ("glMaterialiv" material-iv) void
  (face   enum)
  (pname  enum)
  (params (* int))) ;const

(def-foreign-routine ("glGetMaterialfv" get-material-fv) void
  (face   enum)
  (pname  enum)
  (params (* single-float)))

(def-foreign-routine ("glGetMaterialiv" get-material-iv) void
  (face   enum)
  (pname  enum)
  (params (* int)))

(def-foreign-routine ("glColorMaterial" color-material) void
  (face enum)
  (mode enum))

;;
;; Pixel Zoom
;; ==========

(def-foreign-routine ("glPixelZoom" pixel-zoom) void
  (xfactor single-float)
  (yfactor single-float))

(def-foreign-routine ("glPixelStoref" pixel-store-f) void
  (pname enum)
  (param single-float))

(def-foreign-routine ("glPixelStorei" pixel-store-i) void
  (pname enum)
  (param int))

(def-foreign-routine ("glPixelTransferf" pixel-transfer-f) void
  (pname enum)
  (param single-float))

(def-foreign-routine ("glPixelTransferi" pixel-transfer-i) void
  (pname enum)
  (param int))

(def-foreign-routine ("glPixelMapfv" pixel-map-fv) void
  (map     enum)
  (mapsize int)
  (values  (* single-float))) ; const

(def-foreign-routine ("glPixelMapuiv" pixel-map-uiv) void
  (map     enum)
  (mapsize int)
  (values  (* uint))) ; const

(def-foreign-routine ("glPixelMapusv" pixel-map-usv) void
  (map     enum)
  (mapsize int)
  (values  (* ushort))) ; const

(def-foreign-routine ("glGetPixelMapfv" get-pixel-map-fv) void
  (map    enum)
  (values (* single-float)))

(def-foreign-routine ("glGetPixelMapuiv" get-pixel-map-uiv) void
  (map    enum)
  (values (* uint)))

(def-foreign-routine ("glGetPixelMapusv" get-pixel-map-usv) void
  (map    enum)
  (values (* ushort)))

(def-foreign-routine ("glBitmap" bitmap) void
  (width  sizei)
  (height sizei)
  (xorig  single-float)
  (yorig  single-float)
  (xmove  single-float)
  (ymove  single-float)
  (bmap (* ubyte))) ;const

(def-foreign-routine ("glReadPixels" read-pixels) void
  (x      int)
  (y      int)
  (width  sizei)
  (height sizei)
  (format enum)
  (type   enum)
  (pixels void*))

(def-foreign-routine ("glDrawPixels" draw-pixels) void
  (width  sizei)
  (height sizei)
  (format enum)
  (type   enum)
  (pixels void*)) ; const

(def-foreign-routine ("glCopyPixels" copy-pixels) void
  (x      int)
  (y      int)
  (width  sizei)
  (height sizei)
  (type   enum))

;;
;; Stenciling
;; ==========

(def-foreign-routine ("glStencilFunc" stencil-func) void
  (func enum)
  (ref  int)
  (mask uint))

(def-foreign-routine ("glStencilMask" stencil-mask) void
  (mask uint))

(def-foreign-routine ("glStencilOp" stencil-op) void
  (fail  enum)
  (zfail enum)
  (zpass enum))

(def-foreign-routine ("glClearStencil" clear-stencil) void
  (s int))

;;
;; Texture Mapping
;; ===============

(def-foreign-routine ("glTexGend" tex-gen-d) void
  (coord enum)
  (pname enum)
  (param double))

(def-foreign-routine ("glTexGenf" tex-gen-f) void
  (coord enum)
  (pname enum)
  (param single-float))

(def-foreign-routine ("glTexGeni" tex-gen-i) void
  (coord enum)
  (pname enum)
  (param int))

(def-foreign-routine ("glTexGendv" tex-gen-dv) void
  (coord  enum)
  (pname  enum)
  (params (* double))) ;const

(def-foreign-routine ("glTexGenfv" tex-gen-fv) void
  (coord  enum)
  (pname  enum)
  (params (* single-float))) ;const

(def-foreign-routine ("glTexGeniv" tex-gen-iv) void
  (coord  enum)
  (pname  enum)
  (params (* int))) ;const

(def-foreign-routine ("glGetTexGendv" get-tex-gen-dv) void
  (coord  enum)
  (pname  enum)
  (params (* double))) 

(def-foreign-routine ("glGetTexGenfv" get-tex-gen-fv) void
  (coord  enum)
  (pname  enum)
  (params (* single-float)))

(def-foreign-routine ("glGetTexGeniv" get-tex-gen-iv) void
  (coord  enum)
  (pname  enum)
  (params (* int)))

(def-foreign-routine ("glTexEnvf" tex-env-f) void
  (target enum)
  (pname  enum)
  (param  single-float))

(def-foreign-routine ("glTexEnvi" tex-env-i) void
  (target enum)
  (pname  enum)
  (param  int))

(def-foreign-routine ("glTexEnvfv" tex-env-fv) void
  (target enum)
  (pname  enum)
  (params (* single-float))) ;const

(def-foreign-routine ("glTexEnviv" tex-env-iv) void
  (target enum)
  (pname  enum)
  (params (* int))) ;const

(def-foreign-routine ("glGetTexEnvfv" get-tex-env-fv) void
  (target enum)
  (pname  enum)
  (params (* single-float)))

(def-foreign-routine ("glGetTexEnvfv" get-tex-env-iv) void
  (target enum)
  (pname  enum)
  (params (* int)))

(def-foreign-routine ("glTexParameterf" tex-parameter-f) void
  (target enum)
  (pname  enum)
  (param  single-float))

(def-foreign-routine ("glTexParameteri" tex-parameter-i) void
  (target enum)
  (pname  enum)
  (param  int))

(def-foreign-routine ("glTexParameterfv" tex-parameter-fv) void
  (target enum)
  (pname  enum)
  (params (* single-float))) ;const

(def-foreign-routine ("glTexParameteriv" tex-parameter-iv) void
  (target enum)
  (pname  enum)
  (params (* int))) ;const

(def-foreign-routine ("glGetTexParameterfv" get-tex-parameter-fv) void
  (target enum)
  (pname  enum)
  (params (* single-float)))

(def-foreign-routine ("glGetTexParameteriv" get-tex-parameter-iv) void
  (target enum)
  (pname  enum)
  (params (* int)))

(def-foreign-routine ("glGetTexLevelParameterfv" get-tex-level-parameter-fv) void
  (target enum)
  (level int)
  (pname enum)
  (params (* single-float)))

(def-foreign-routine ("glGetTexLevelParameteriv" get-tex-level-parameter-iv) void
  (target enum)
  (level int)
  (pname enum)
  (params (* int)))

(def-foreign-routine ("glTexImage1D" tex-image-1d) void
  (target          enum)
  (level           int)
  (internal-format int)
  (width           sizei)
  (border          int)
  (format          enum)
  (type            enum)
  (pixels          void*)) ; const

(def-foreign-routine ("glTexImage2D" tex-image-2d) void
  (target          enum)
  (level           int)
  (internal-format int)
  (width           sizei)
  (height          sizei)
  (border          int)
  (format          enum)
  (type            enum)
  (pixels          void*)) ; const

(def-foreign-routine ("glGetTexImage" get-tex-image) void
  (target enum)
  (level  int)
  (format enum)
  (type   enum)
  (pixels void*))

;;
;; Texturing (GL 1.1)
;; ==================

(def-foreign-routine ("glGenTextures" gen-textures) void
  (n sizei)
  (textures (* uint)))

(def-foreign-routine ("glDeleteTextures" delete-textures) void
  (n        sizei)
  (textures (* uint)))

(def-foreign-routine ("glBindTexture" bind-texture) void
  (target  enum)
  (texture uint))

(def-foreign-routine ("glPrioritizeTextures" prioritize-textures) void
  (n          sizei)
  (textures   (* uint)) ;const
  (priorities (* clampf))) ;const

(def-foreign-routine ("glAreTexturesResident" are-textures-resident) boolean
  (n          sizei)
  (textures   (* uint)) ; const
  (residences (* boolean)))

(def-foreign-routine ("glIsTexture" is-texture) boolean
  (texture uint))

(def-foreign-routine ("glTexSubImage1D" tex-sub-image-1d) void
  (target  enum)
  (level   int)
  (xoffset int)
  (width   sizei)
  (format  enum)
  (type    enum)
  (pixels  void*)) ;const

(def-foreign-routine ("glTexSubImage2D" tex-sub-image-2d) void
  (target  enum)
  (level   int)
  (xoffset int)
  (yoffset int)
  (width   sizei)
  (height  sizei)
  (format  enum)
  (type    enum)
  (pixels  void*)) ; const

(def-foreign-routine ("glCopyTexImage1D" copy-tex-image-1d) void
  (target          enum)
  (level           int)
  (internal-format enum)
  (x               int)
  (y               int)
  (width           sizei)
  (border          int))

(def-foreign-routine ("glCopyTexImage2D" copy-tex-image-2d) void
  (target          enum)
  (level           int)
  (internal-format enum)
  (x               int)
  (y               int)
  (width           sizei)
  (height          sizei)
  (border          int))

(def-foreign-routine ("glCopyTexSubImage1D" copy-tex-sub-image-1d) void
  (target  enum)
  (level   int)
  (xoffset int)
  (x       int)
  (y       int)
  (width   sizei))

(def-foreign-routine ("glCopyTexSubImage2D" copy-tex-sub-image-2d) void
  (target  enum)
  (level   int)
  (xoffset int)
  (yoffset int)
  (x       int)
  (y       int)
  (width   sizei)
  (height  sizei))

;;
;; Evaluators
;; ==========

(def-foreign-routine ("glMap1d" map-1d) void
  (target enum)
  (u1     double)
  (u2     double)
  (stride int)
  (order  int)
  (points (* double))) ; const

(def-foreign-routine ("glMap1f" map-1f) void
  (target enum)
  (u1     single-float)
  (u2     single-float)
  (stride int)
  (order  int)
  (points (* single-float))) ; const

(def-foreign-routine ("glMap2d" map-2d) void
  (target  enum)
  (u1      double)
  (u2      double)
  (ustride int)
  (uorder  int)
  (v1      double)
  (v2      double)
  (vstride int)
  (vorder  int)
  (points  (* double))) ;const

(def-foreign-routine ("glMap2f" map-2f) void
  (target  enum)
  (u1      single-float)
  (u2      single-float)
  (ustride int)
  (uorder  int)
  (v1      single-float)
  (v2      single-float)
  (vstride int)
  (vorder  int)
  (points  (* single-float))) ;const

(def-foreign-routine ("glGetMapdv" get-map-dv) void
  (target enum)
  (query  enum)
  (v      (* double)))

(def-foreign-routine ("glGetMapfv" get-map-fv) void
  (target enum)
  (query  enum)
  (v      (* single-float)))

(def-foreign-routine ("glGetMapiv" get-map-iv) void
  (target enum)
  (query  enum)
  (v      (* int)))

(def-foreign-routine ("glEvalCoord1d" eval-coord-1d) void
  (u double))

(def-foreign-routine ("glEvalCoord1f" eval-coord-1f) void
  (u single-float))

(def-foreign-routine ("glEvalCoord1dv" eval-coord-1dv) void
  (u (* double))) ;const

(def-foreign-routine ("glEvalCoord1fv" eval-coord-1fv) void
  (u (* single-float))) ;const

(def-foreign-routine ("glEvalCoord2d" eval-coord-2d) void
  (u double)
  (v double))

(def-foreign-routine ("glEvalCoord2f" eval-coord-2f) void
  (u single-float)
  (v single-float))

(def-foreign-routine ("glEvalCoord2dv" eval-coord-2dv) void
  (u (* double))) ;const

(def-foreign-routine ("glEvalCoord2fv" eval-coord-2fv) void
  (u (* single-float))) ;const


(def-foreign-routine ("glMapGrid1d" map-grid-1d) void
  (un int)
  (u1 double)
  (u2 double))

(def-foreign-routine ("glMapGrid1f" map-grid-1f) void
  (un int)
  (u1 single-float)
  (u2 single-float))

(def-foreign-routine ("glMapGrid2d" map-grid-2d) void
  (un int)
  (u1 double)
  (u2 double)
  (vn int)
  (v1 double)
  (v2 double))

(def-foreign-routine ("glMapGrid2f" map-grid-2f) void
  (un int)
  (u1 single-float)
  (u2 single-float)
  (vn int)
  (v1 single-float)
  (v2 single-float))

(def-foreign-routine ("glEvalPoint1" eval-point-1) void
  (i int))

(def-foreign-routine ("glEvalPoint2" eval-point-2) void
  (i int)
  (j int))

(def-foreign-routine ("glEvalMesh1" eval-mesh-1) void
  (mode enum)
  (i1 int)
  (i2 int))

(def-foreign-routine ("glEvalMesh2" eval-mesh-2) void
  (mode enum)
  (i1   int)
  (i2   int)
  (j1   int)
  (j2   int))

;;
;; Fog
;; ===

(def-foreign-routine ("glFogf" fog-f) void
  (pname enum)
  (param single-float))

(def-foreign-routine ("glFogi" fog-i) void
  (pname enum)
  (param int))

(def-foreign-routine ("glFogfv" fog-fv) void
  (pname  enum)
  (params (* single-float))) ; const

(def-foreign-routine ("glFogiv" fog-iv) void
  (pname enum)
  (params (* int))) ; const

;;
;; Selection and Feedback
;; ======================

(def-foreign-routine ("glFeedbackBuffer" feedback-buffer) void
  (size sizei)
  (type enum)
  (buffer (* single-float)))

(def-foreign-routine ("glPassThrough" pass-through) void
  (token single-float))

(def-foreign-routine ("glSelectBuffer" select-buffer) void
  (size   sizei)
  (buffer (* uint)))

(def-foreign-routine ("glInitNames" init-names) void)

(def-foreign-routine ("glLoadName" load-name) void
  (name uint))

(def-foreign-routine ("glPushName" push-name) void
  (name uint))

(def-foreign-routine ("glPopName" pop-name) void)

;;
;; GL 1.2 Functions
;; ================

(def-foreign-routine ("glDrawRangeElements" draw-range-elements) void
  (mode  enum)
  (start uint)
  (end   uint)
  (count sizei)
  (type  enum)
  (indices void*)) ;const

(def-foreign-routine ("glTexImage3D" tex-image-3d) void
  (target          enum)
  (level           int)
  (internal-format int)
  (width           sizei)
  (height          sizei)
  (depth           sizei)
  (border          int)
  (format          enum)
  (type            enum)
  (pixels          void*)) ; const

(def-foreign-routine ("glTexSubImage3D" tex-sub-image-3d) void
  (target  enum)
  (level   int)
  (xoffset int)
  (yoffset int)
  (zoffset int)
  (width   sizei)
  (height  sizei)
  (depth   sizei)
  (format  enum)
  (type    enum)
  (pixels  void*)) ; const

(def-foreign-routine ("glCopyTexSubImage3D" copy-tex-sub-image-3d) void
  (target  enum)
  (level   int)
  (xoffset int)
  (yoffset int)
  (zoffset int)
  (x       int)
  (y       int)
  (width   sizei)
  (height  sizei))

;;
;; 1.2 Imaging Extension
;; =====================

(def-foreign-routine ("glColorTable" color-table) void
  (target          enum)
  (internal-format enum)
  (width           sizei)
  (format          enum)
  (type            enum)
  (table           void*)) ;const

(def-foreign-routine ("glColorSubTable" color-sub-table) void
  (target enum)
  (start  sizei)
  (count  sizei)
  (format enum)
  (type   enum)
  (data   void*)) ;const

(def-foreign-routine ("glColorTableParameteriv" color-table-parameter-iv) void
  (target enum)
  (pname  enum)
  (params (* int))) ;const

(def-foreign-routine ("glColorTableParameterfv" color-table-parameter-fv) void
  (target enum)
  (pname  enum)
  (params (* single-float))) ; const

(def-foreign-routine ("glCopyColorSubTable" copy-color-sub-table) void
  (target enum)
  (start  sizei)
  (x      int)
  (y      int)
  (width  sizei))

(def-foreign-routine ("glCopyColorTable" copy-color-table) void
  (target          enum)
  (internal-format enum)
  (x               int)
  (y               int)
  (width           sizei))

(def-foreign-routine ("glGetColorTable" get-color-table) void
  (target enum)
  (format enum)
  (type   enum)
  (table  void*))

(def-foreign-routine ("glGetColorTableParameterfv" get-color-table-parameter-fv) void
  (target enum)
  (pname  enum)
  (params (* single-float)))

(def-foreign-routine ("glGetColorTableParameteriv" get-color-table-parameter-iv) void
  (target enum)
  (pname  enum)
  (params int))

(def-foreign-routine ("glBlendEquation" blend-equation) void
  (mode enum))

(def-foreign-routine ("glBlendColor" blend-color) void
  (red   clampf)
  (green clampf)
  (blue  clampf)
  (alpha clampf))

(def-foreign-routine ("glHistogram" histogram) void
  (target          enum)
  (width           sizei)
  (internal-format enum)
  (sink            boolean))

(def-foreign-routine ("glResetHistogram" reset-histogram) void
  (target enum))

(def-foreign-routine ("glGetHistogram" get-histogram) void
  (target enum)
  (reset  boolean)
  (format enum)
  (type   enum)
  (values void*))

(def-foreign-routine ("glGetHistogramParameterfv" get-histogram-parameter-fv) void
  (target enum)
  (pname  enum)
  (params (* single-float)))

(def-foreign-routine ("glGetHistogramParameteriv" get-histogram-parameter-iv) void
  (target enum)
  (pname  enum)
  (params (* int)))

(def-foreign-routine ("glMinmax" minmax) void
  (target          enum)
  (internal-format enum)
  (sink            boolean))

(def-foreign-routine ("glResetMinmax" reset-minmax) void
  (target enum))

(def-foreign-routine ("glGetMinmax" get-minmax) void
  (target enum)
  (reset  boolean)
  (format enum)
  (types  enum)
  (values void*))

(def-foreign-routine ("glGetMinmaxParameterfv" get-minmax-parameter-fv) void
  (target enum)
  (pname  enum)
  (params (* single-float)))

(def-foreign-routine ("glGetMinmaxParameteriv" get-minmax-parameter-iv) void
  (target enum)
  (pname  enum)
  (params (* int)))

(def-foreign-routine ("glConvolutionFilter1D" convolution-filter-1d) void
  (target enum)
  (internal-format enum)
  (width sizei)
  (format enum)
  (type enum)
  (image void*)) ;const

(def-foreign-routine ("glConvolutionFilter2D" convolution-filter-2d) void
  (target enum)
  (internal-format enum)
  (width sizei)
  (height sizei)
  (format enum)
  (type enum)
  (image void*)) ;const

(def-foreign-routine ("glConvolutionParameterf" convolution-parameter-f) void
  (target enum)
  (pname enum)
  (params single-float))

(def-foreign-routine ("glConvolutionParameterfv" convolution-parameter-fv) void
  (target  enum)
  (pname enum)
  (params (* single-float)))

(def-foreign-routine ("glConvolutionParameteri" convolution-parameter-i) void
  (target enum)
  (pname  enum)
  (params int))

(def-foreign-routine ("glConvolutionParameteriv" convolution-parameter-iv) void
  (target enum)
  (pname enum)
  (params (* int))) ;const

(def-foreign-routine ("glCopyConvolutionFilter1D" copy-convolution-filter-1d) void
  (target enum)
  (internal-format enum)
  (x int)
  (y int)
  (width sizei))

(def-foreign-routine ("glCopyConvolutionFilter2D" copy-convolution-filter-2d) void
  (target enum)
  (internal-format enum)
  (x int)
  (y int)
  (width sizei)
  (height sizei))

(def-foreign-routine ("glGetConvolutionFilter" get-convolution-filter) void
  (target enum)
  (format enum)
  (type enum)
  (image void*))

(def-foreign-routine ("glGetConvolutionParameterfv" get-convolution-parameter-fv) void
  (target enum)
  (pname enum)
  (params (* single-float)))

(def-foreign-routine ("glGetConvolutionParameteriv" get-convolution-parameter-iv) void
  (target enum)
  (pname enum)
  (params (* int)))

(def-foreign-routine ("glSeparableFilter2D" separable-filter-2d) void
  (target enum)
  (internal-format enum)
  (width sizei)
  (height sizei)
  (format enum)
  (type enum)
  (row void*) ;const
  (column void*)) ; const

(def-foreign-routine ("glGetSeparableFilter" get-separable-filter) void
  (target enum)
  (format enum)
  (type enum)
  (row void*)
  (column void*)
  (span void*))

(provide :opengl)
