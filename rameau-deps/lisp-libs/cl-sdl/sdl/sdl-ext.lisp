;;;;
;;;; SDL-bindings' extensions
;;;; ======================== 
;;;;
;;;; written in 2002 by Timo Tossavainen (tt@cs.uta.fi)
;;;;
;;;; This file contains some extensions to the raw SDL-binding to make it
;;;; easier to initialize SDL, process SDL events and write an event loop
;;;; for a GUI program.
;;;;
;;;; Additional work done by: Matthew Danish <mrd@debian.org>
;;;;

(in-package #:sdl)

(export '(set-gl-attributes
          query-video-info
	  event-type
	  event-key-scancode event-key-symbol
	  event-key-modifiers event-key-unicode
	  event-mouse-button event-mouse-button-x  event-mouse-button-y
	  event-mouse-button-state event-mouse-button-point
	  event-mouse-motion-state event-mouse-motion-x event-mouse-motion-y
	  event-mouse-motion-xrel event-mouse-motion-yrel
	  event-mouse-motion-point event-mouse-motion-rel
	  mouse-left-button-down-p mouse-middle-button-down-p
	  mouse-right-button-down-p
	  event-joy-axis-joystick event-joy-axis
	  event-joy-axis-value event-joy-ball-joystick
	  event-joy-ball event-joy-ball-xrel
	  event-joy-ball-yrel event-joy-ball-rel
	  event-joy-hat-joystick event-joy-hat event-joy-hat-state
	  event-joy-button-joystick event-joy-button
	  event-joy-button-state	  
	  event-resize-width event-resize-height
	  event-active-state event-active-gain
	  event-loop
	  draw-pixel draw-rectangle
          must-lock-p
          show-bmp
          with-locked-surface))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (in-module sdlstub))

(defun set-gl-attributes (&key (red-size nil)
			       (green-size nil)
			       (blue-size nil)
			       (alpha-size nil)
			       (buffer-size nil)
			       (doublebuffer nil)
			       (depth-size nil)
			       (stencil-size nil)
			       (accum-red-size nil)
			       (accum-green-size nil)
			       (accum-blue-size nil)
			       (accum-alpha-size nil))
  (when red-size
    (gl-set-attribute +gl-red-size+ red-size))
  (when blue-size
    (gl-set-attribute +gl-blue-size+ blue-size))
  (when green-size
    (gl-set-attribute +gl-green-size+ green-size))
  (when alpha-size
    (gl-set-attribute +gl-alpha-size+ green-size))
  (when buffer-size
    (gl-set-attribute +gl-buffer-size+ buffer-size))
  (when doublebuffer
    (gl-set-attribute +gl-doublebuffer+ doublebuffer))
  (when depth-size
    (gl-set-attribute +gl-depth-size+ depth-size))
  (when stencil-size
    (gl-set-attribute +gl-stencil-size+ stencil-size))
  (when accum-red-size
    (gl-set-attribute +gl-accum-red-size+ accum-red-size))
  (when accum-green-size
    (gl-set-attribute +gl-accum-green-size+ accum-green-size))
  (when accum-blue-size
    (gl-set-attribute +gl-accum-blue-size+ accum-blue-size))
  (when accum-alpha-size
    (gl-set-attribute +gl-accum-alpha-size+ accum-alpha-size)))

(defparameter *video-info-table*
  '((:hw-available video-info-bits 1 0 boolean)
    (:wm-available video-info-bits 1 1 boolean)
    (:unused-bits-1 video-info-bits 6 2)
    (:unused-bits-2 video-info-bits 1 8)
    (:blit-hw video-info-bits 1 9 boolean)
    (:blit-hw-cc video-info-bits 1 10 boolean)
    (:blit-hw-a video-info-bits 1 11 boolean)
    (:blit-sw video-info-bits 1 12 boolean)
    (:blit-sw-cc video-info-bits 1 13 boolean)
    (:blit-sw-a video-info-bits 1 14 boolean)
    (:blit-fill video-info-bits 1 15 boolean)
    (:unused-bits-3 video-info-bits 16 16)
    (:video-mem video-mem 32 0)))

(defmacro query-video-info (&rest flags)
  (let ((video-info (gensym "VIDEOINFO"))
        (data (gensym "DATA")))
    `(let ((,video-info (sdl:get-video-info)))
      (values
       ,@(loop for flag in flags 
               for info = (assoc flag *video-info-table*)
               when info collect
               `(let ((,data (ldb (byte ,(third info)
                                        ,(fourth info))
                                  (slot ,video-info video-info ,(second info)))))
                 ,(if (eql (fifth info) 'boolean)
                      `(= ,data +true+)
                      data)))))))

;;;
;;; Event handling utilities
;;; ========================
;;;
;;; These macros are mostly shorter forms for typical accesses of
;;; the fields of the SDL event structure
;;;

(defmacro def-accessor (name args &body body)
  `(progn (declaim (inline ,name))
    (defun ,name ,args ,@body)
    (export '(,name))))

(def-accessor event-type (event)
  (slot event event type))

(defmacro event-slot (event slot)
  `(slot-ptr ,event event ,slot))
(export '(event-slot))

;; Keyboard Events

(def-accessor event-keysym (event)
  (slot-ptr (event-slot event key)
            keyboard-event keysym))

(def-accessor event-key-scancode (event)
  (slot (event-keysym event) keysym scancode))

(def-accessor event-key-symbol (event)
  (slot (event-keysym event) keysym sym))

(def-accessor event-key-modifiers (event)
  (slot (event-keysym event) keysym mod))

(def-accessor event-key-unicode (event)
  (slot (event-keysym event) keysym unicode))

;; Mouse Events  

(def-accessor event-button (event)
  (event-slot event button))

(def-accessor event-mouse-button (event)
  (slot (event-button event) mouse-button-event button))

(def-accessor event-mouse-button-x (event)
  (slot (event-button event) mouse-button-event x))

(def-accessor event-mouse-button-y (event)
  (slot (event-button event) mouse-button-event y))

(def-accessor event-mouse-button-state (event)
  (slot (event-button event) mouse-button-event state))

(def-accessor event-mouse-button-point (event)
  (values (event-mouse-button-x event)
	  (event-mouse-button-y event)))

(def-accessor event-motion (event)
  (event-slot event motion))

(def-accessor event-mouse-motion-state (event)
  (slot (event-motion event) mouse-motion-event state))

(def-accessor event-mouse-motion-x (event)
  (slot (event-motion event) mouse-motion-event x))

(def-accessor event-mouse-motion-y (event)
  (slot (event-motion event) mouse-motion-event y))

(def-accessor event-mouse-motion-xrel (event)
  (slot (event-motion event) mouse-motion-event xrel))

(def-accessor event-mouse-motion-yrel (event)
  (slot (event-motion event) mouse-motion-event yrel))


(def-accessor mouse-left-button-down-p (event)
  (/= 0 (logand #b1 (event-mouse-motion-state event))))

(def-accessor mouse-middle-button-down-p (event)
  (/= 0 (logand #b10 (event-mouse-motion-state event))))

(def-accessor mouse-right-button-down-p (event)
  (/= 0 (logand #b100 (event-mouse-motion-state event))))

(def-accessor event-mouse-motion-point (event)
  (values (event-mouse-motion-x event)
	  (event-mouse-motion-y event)))

(def-accessor event-mouse-motion-rel (event)
  (values (event-mouse-motion-xrel event)
	  (event-mouse-motion-yrel event)))

;; Joystick Events

(def-accessor event-jaxis (event)
  (event-slot event jaxis))

(def-accessor event-joy-axis-joystick (event)
  (slot (event-jaxis event) joy-axis-event which))

(def-accessor event-joy-axis (event)
  (slot (event-jaxis event) joy-axis-event axis))

(def-accessor event-joy-axis-value (event)
  (slot (event-jaxis event) joy-axis-event value))


(def-accessor event-jball (event)
  (event-slot event jball))

(def-accessor event-joy-ball-joystick (event)
  (slot (event-jball event) joy-ball-event which))

(def-accessor event-joy-ball (event)
  (slot (event-jball event) joy-ball-event ball))

(def-accessor event-joy-ball-xrel (event)
  (slot (event-jball event) joy-ball-event xrel))

(def-accessor event-joy-ball-yrel (event)
  (slot (event-jball event) joy-ball-event yrel))

(def-accessor event-joy-ball-rel (event)
  (values (event-joy-ball-xrel event)
	  (event-joy-ball-yrel event)))


(def-accessor event-jhat (event)
  (event-slot event jhat))

(def-accessor event-joy-hat-joystick (event)
  (slot (event-jhat event) joy-hat-event which))

(def-accessor event-joy-hat (event)
  (slot (event-jhat event) joy-hat-event hat))

(def-accessor event-joy-hat-state (event)
  (slot (event-jhat event) joy-hat-event state))


(def-accessor event-jbutton (event)
  (event-slot event jbutton))

(def-accessor event-joy-button-joystick (event)
  (slot (event-jbutton event) joy-button-event which))

(def-accessor event-joy-button (event)
  (slot (event-jbutton event) joy-button-event button))

(def-accessor event-joy-button-state (event)
  (slot (event-jbutton event) joy-button-event state))

;; Resize

(def-accessor event-resize-width (event)
  (slot (event-slot event resize) resize-event w))

(def-accessor event-resize-height (event)
  (slot (event-slot event resize) resize-event h))

;; Activate

(def-accessor event-active-state (event)
  (slot (event-slot event active) active-event state))

(def-accessor event-active-gain (event)
  (slot (event-slot event active) active-event gain))

;;;
;;; Event loop macro
;;; ================
;;;
;;; A macro for creating a CLX-style event-loop for SDL programs.
;;; Expansion binds any symbols with given print names regardless of
;;; package to event fields.
;;;
;;; TODO: clean up expander code
;;; TODO: get rid of read-time evaluations of msg ids (somehow ?)

;; Generic bind-list expander

(defun expand-bind-list (binds list)
  (when list
    `(,(let ((bind (find-if #'(lambda (x)
                                (equal (symbol-name (first x))
                                       (symbol-name (first list))))
			    binds)))
	 (when bind
	   (cons (first list) (rest bind))))
      ,@(expand-bind-list binds (rest list)))))

;; Expanders for various event handlers

(defun expand-key-event (event code)
  `(let ,(expand-bind-list
	  `((scan-code (event-key-scancode  ,event))
	    (key       (event-key-symbol    ,event))
	    (mod       (event-key-modifiers ,event))
	    (unicode   (event-key-unicode   ,event)))
	  (first code))
     ,@(rest code)))

(defun expand-mouse-motion (event code)
  `(let ,(expand-bind-list
	  `((x         (event-mouse-motion-x     ,event))
	    (y         (event-mouse-motion-y     ,event))
	    (xrel      (event-mouse-motion-xrel  ,event))
	    (yrel      (event-mouse-motion-yrel  ,event))
	    (state     (event-mouse-motion-state ,event)))
	  (first code))
     ,@(rest code)))

(defun expand-mouse-button (event code)
  `(let ,(expand-bind-list
	  `((x         (event-mouse-button-x     ,event))
	    (y         (event-mouse-motion-y     ,event))
	    (button    (case (event-mouse-button ,event)
			 (,#.sdl:+button-left+   :left)
			 (,#.sdl:+button-middle+ :middle)
			 (,#.sdl:+button-right+  :right))))
	  (first code))
     ,@(rest code)))

(defun expand-joy-axis-motion (event code)
  `(let ,(expand-bind-list
	  `((joystick  (event-joy-axis-joystick   ,event))
	    (axis      (event-joy-axis            ,event))
	    (value     (event-joy-axis-value      ,event)))
	  (first code))
     ,@(rest code)))

(defun expand-joy-ball-motion (event code)
  `(let ,(expand-bind-list
	  `((joystick  (event-joy-ball-joystick   ,event))
	    (ball      (event-joy-ball            ,event))
	    (xrel      (event-joy-ball-xrel       ,event))
	    (yrel      (event-joy-ball-yrel       ,event)))
	  (first code))
     ,@(rest code)))

(defun expand-joy-hat-motion (event code)
  `(let ,(expand-bind-list
	  `((joystick  (event-joy-hat-joystick    ,event))
	    (hat       (event-joy-hat             ,event))
	    (state     (case (event-joy-hat-state ,event)
                         (,#.sdl:+hat-centered+  :centered)
                         (,#.sdl:+hat-up+        :up)
                         (,#.sdl:+hat-right+     :right)
                         (,#.sdl:+hat-down+      :down)
                         (,#.sdl:+hat-left+      :left)
                         (,#.sdl:+hat-rightup+   :rightup)
                         (,#.sdl:+hat-rightdown+ :rightdown)
                         (,#.sdl:+hat-leftup+    :leftup)
                         (,#.sdl:+hat-leftdown+  :leftdown))))
	  (first code))
     ,@(rest code)))

(defun expand-joy-button (event code)
  `(let ,(expand-bind-list
	  `((joystick  (event-joy-button-joystick ,event))
	    (button    (event-joy-button          ,event)))
	  (first code))
     ,@(rest code)))

(defun expand-resize (event code)
  `(let ,(expand-bind-list
	  `((width  (event-resize-width ,event))
	    (height (event-resize-height ,event)))
	  (first code))
     ,@(rest code)))

(defun expand-active (event code)
  `(let ,(expand-bind-list
	  `((type (case (event-active-state ,event)
		    (,#.sdl:+app-mouse-focus+ :mouse)
		    (,#.sdl:+app-input-focus+ :input)
		    (,#.sdl:+app-active+      :app)))
	    (gain (= 1 (event-active-state ,event))))
	  (first code))
     ,@(rest code)))

(defun expand-no-binds (event code)
  (declare (ignore event))
  (rest code))

(defun expand-events (event-sym event-list)
  (when event-list
    (if (eq (caar event-list) :idle) ; skip idle
	(expand-events event-sym (rest event-list))
      `(,(case (caar event-list) ; add variable bindings eventually
	   (:active            `(,#.sdl:+active-event+
				 ,(expand-active event-sym
						 (cdar event-list))))
	   (:key-up            `(,#.sdl:+key-up+
				 ,(expand-key-event event-sym
						    (cdar event-list))))
	   (:key-down          `(,#.sdl:+key-down+
				 ,(expand-key-event event-sym
						    (cdar event-list))))
	   (:mouse-motion      `(,#.sdl:+mouse-motion+
				 ,(expand-mouse-motion event-sym
						       (cdar event-list))))
	   (:mouse-button-up   `(,#.sdl:+mouse-button-up+
				 ,(expand-mouse-button event-sym
						       (cdar event-list))))
	   (:mouse-button-down `(,#.sdl:+mouse-button-down+
			         ,(expand-mouse-button event-sym
						       (cdar event-list))))
	   (:joy-axis-motion   `(,#.sdl:+joy-axis-motion+
				 ,(expand-joy-axis-motion event-sym
							 (cdar event-list))))
	   (:joy-ball-motion   `(,#.sdl:+joy-ball-motion+
				 ,(expand-joy-ball-motion event-sym
							 (cdar event-list))))
	   (:joy-hat-motion    `(,#.sdl:+joy-hat-motion+
				 ,(expand-joy-hat-motion event-sym
							 (cdar event-list))))
	   (:joy-button-up     `(,#.sdl:+joy-button-up+
				 ,(expand-joy-button event-sym
						    (cdar event-list))))
	   (:joy-button-down   `(,#.sdl:+joy-button-down+
				 ,(expand-joy-button event-sym
						     (cdar event-list))))
	   (:quit              `(,#.sdl:+quit+
				 ,@(expand-no-binds event-sym
						    (cdar event-list))))
	   (:sys-wm-event      `(,#.sdl:+sys-wm-event+ ,@(cdar event-list)))
	   (:resize            `(,#.sdl:+video-resize+
				 ,(expand-resize event-sym
						  (cdar event-list))))
	   (:expose            `(,#.sdl:+video-expose+
				 ,@(expand-no-binds event-sym
						     (cdar event-list))))
	   (:user              `(,#.sdl:+user-event+ ,@(cdar event-list))))
	,@(expand-events event-sym (rest event-list))))))

(defun expand-idle (args)
  (let ((idle-event (find ':idle args :key #'car)))
    (when idle-event
      `(progn ,@(cddr idle-event)))))

(defmacro event-loop (&rest event-list)
  "SDL event loop macro. Event types and parameters are
      :active             (type gain)
      :key-up             (scan-code key mod unicode)
      :key-down           (scan-code key mod unicode)
      :mouse-motion       (x y xrel yrel state)
      :mouse-button-up    (x y button) 
      :mouse-button-down  (x y button) 
      :joy-axis-motion    (joystick axis value)
      :joy-ball-motion    (joystick ball xrel yrel)
      :joy-hat-motion     (joystick hat state)
      :joy-button-up      (joystick button)
      :joy-button-down    (joystick button)
      :quit               ()
      :sys-wm-event       N/A
      :resize             (width height)
      :expose             ()
      :user               ()
      :idle               ()
  Example: (sdl:event-loop
           (:mouse-button-up (x y)
              (format t \"button pressed at (~A, ~A)~%\" x y))
           (:quit
              (return)))."
  (with-gensyms (event)
    `(with-foreign-objects ((,event sdl:event))
      (loop
       (if (= (sdl:poll-event ,event) 1)
           (case (event-type ,event)
             ,@(expand-events event event-list))
	   ,(expand-idle event-list))))))


;;;; Pixel drawing

(declaim (inline must-lock-p bytes-per-pixel get-color-from-r/g/b))

;;; #define SDL_MUSTLOCK(surface)	\
;;;  (surface->offset ||		\
;;;  ((surface->flags & (SDL_HWSURFACE|SDL_ASYNCBLIT|SDL_RLEACCEL)) != 0))

(def-foreign-type surface-ptr (:struct-pointer surface))

(declaim (inline must-lock-p))
(defun must-lock-p (surface)
  (declare (optimize (speed 3) (safety 0))
	   (type surface-ptr surface))
  (or (/= 0 (the (unsigned-byte 16)
	      (slot surface surface offset)))
      (/= 0 (logand (the (unsigned-byte 32)
		      (slot surface surface flags))
		    (logior +hwsurface+
			    +asyncblit+
			    +rleaccel+)))))

#+nil
(defun bytes-per-pixel (surface)
  (declare (optimize (speed 3) (safety 0))
	   (type surface-ptr surface))
  (slot (slot-ptr surface surface format)
        pixel-format bytes-per-pixel))

#+nil
(def-foreign-type pixel-format-ptr (:struct-pointer pixel-format))

#+nil
(defun get-color-from-r/g/b (surface r g b)
  (declare (optimize (speed 3) (safety 0))
	   (type surface-ptr surface))
  (the (unsigned-byte 32)
    (map-rgb (the pixel-format-ptr
	       (slot surface surface format))
	     r g b)))

#+nil ;; old and broken now. use the wrapper's version instead.
(defun draw-pixel (surface x y r g b &key (update nil) (lock t))
  (declare (optimize (speed 1) (safety 3) (debug 3))
	   (type (unsigned-byte 16) x y)
	   (type (unsigned-byte 8) r g b)
	   (type boolean update lock)
	   (type surface-ptr surface))
  (let ((color (get-color-from-r/g/b surface r g b))
	(pixels (slot surface 'surface 'pixels))
	(pitch (slot surface 'surface 'pitch)))
    (declare (type (unsigned-byte 16) pitch)
	     (type (unsigned-byte 32) color))
    (when (and lock (must-lock-p surface))
      (when (< (lock-surface surface) 0)
	(return-from draw-pixel nil)))
    (case (bytes-per-pixel surface)
      (1 ; 8bpp
       #+nil
       (setf (deref-array pixels
                          '(* (unsigned-byte 8))
                          (+ (* pitch y) x))
             color))
      (2 ; 15 or 16bpp
       (let ((bufp (cast-pointer pixels (* (unsigned-byte 16)))))
         (setf (deref-array bufp
                            '(* (unsigned-byte 16))
                            (+ (ash (* y pitch) -1)
                               x))
               color))
       #+nil
       (setf (deref-array (the (* (alien:unsigned 16)) pixels)
                          '(* (unsigned-byte 16))
                          (+ (ash (* y pitch) -1)
                             x))
             color))
      (3 ; 24bpp
       #+nil
       (let ((bufp (alien:cast pixels (* (alien:unsigned 8))))
	     (offset (+ (the (unsigned-byte 24)
			  (* y pitch))
			(the (unsigned-byte 24)
			  (* 3 x)))))
	 ;; assume little endian until we can test it?
	 ;; no one uses 24bpp anyway
	 (cond (t ;(little-endian-p)
		(setf (alien:deref bufp offset)
		      color)
		(setf (alien:deref bufp (1+ offset))
		      (ash color -8))
		(setf (alien:deref bufp (+ 2 offset))
		      (ash color -16))))
	 ;; see http://www.libsdl.org/intro/usingvideo.html
	 ))
      (4 ; 32bpp
       #+nil
       (let ((bufp (alien:cast pixels (* (alien:unsigned 32)))))
	 (setf (alien:deref bufp
			    (+ (ash (* y pitch) -2) x))
	       color))))
    (when (and lock (must-lock-p surface))
      (unlock-surface surface))
    (when update
      (update-rect surface x y 1 1)))
  t)

(declaim (inline faster-draw-pixel draw-pixel))

(def-foreign-routine ("faster_draw_pixel" faster-draw-pixel)
    void
  (surface (:struct-pointer surface))
  (x (unsigned-byte 16))
  (y (unsigned-byte 16))
  (color (unsigned-byte 32)))

(def-foreign-routine ("draw_pixel" draw-pixel) void
  (surface (:struct-pointer surface))
  (x (unsigned-byte 16))
  (y (unsigned-byte 16))
  (r (unsigned-byte 8))
  (g (unsigned-byte 8))
  (b (unsigned-byte 8)))

(declaim (inline get-pixel))
(def-foreign-routine ("get_pixel" get-pixel) (unsigned-byte 32)
  (surface (:struct-pointer surface))
  (x (unsigned-byte 16))
  (y (unsigned-byte 16)))

#+nil
(defun draw-rectangle2 (surface x y w h r g b)
  (declare (optimize (speed 3) (safety 0))
	   (type (unsigned-byte 16) x y w h)
	   (type (unsigned-byte 8) r g b)
	   (type surface-ptr surface))
  (let ((color (get-color-from-r/g/b surface r g b)))
    (declare (type (unsigned-byte 32) color))
    (with-foreign-objects ((rect rect))
      (setf (slot rect rect x) x)
      (setf (slot rect rect y) y)
      (setf (slot rect rect w) w)
      (setf (slot rect rect h) h)
      (= 0 (fill-rect surface rect color)))))


(def-foreign-routine ("draw_rectangle" draw-rectangle) void
  (surface (:struct-pointer surface))
  (x (unsigned-byte 16))
  (y (unsigned-byte 16))
  (w (unsigned-byte 16))
  (h (unsigned-byte 16))
  (r (unsigned-byte 8))
  (g (unsigned-byte 8))
  (b (unsigned-byte 8)))

#+nil
(def-foreign-routine ("show_bmp" show-bmp) void
  (file c-string)
  (surface (:struct-pointer surface))
  (x (unsigned-byte 16))
  (y (unsigned-byte 16)))

(defun show-bmp (file surface x y)
  (let (bmp)
    (unwind-protect
         (progn
           (setf bmp (sdl:load-bmp file))
           (unless (sgum:null-pointer-p bmp)
             (sgum:with-foreign-objects ((rect sdl:rect))
               (setf (sdl:rect-x rect) x
                     (sdl:rect-y rect) y)
               (sdl:blit-surface bmp sgum:+null-pointer+ surface rect)
               (sdl:update-rect surface
                                x y
                                (sdl:surface-w bmp)
                                (sdl:surface-h bmp)))))
      (unless (or (null bmp)
                  (sgum:null-pointer-p bmp))
        (sdl:free-surface bmp)))))


(def-foreign-routine ("draw_line" draw-line)
    void
  (surface (:struct-pointer surface))
  (x1 (unsigned-byte 16))
  (y1 (unsigned-byte 16))
  (x2 (unsigned-byte 16))
  (y2 (unsigned-byte 16))
  (r (unsigned-byte 8))
  (g (unsigned-byte 8))
  (b (unsigned-byte 8)))

(def-foreign-routine ("draw_circle" draw-circle)
    void
  (surface (:struct-pointer surface))
  (x (unsigned-byte 16))
  (y (unsigned-byte 16))
  (radius (unsigned-byte 16))
  (r (unsigned-byte 8))
  (g (unsigned-byte 8))
  (b (unsigned-byte 8)))

(def-foreign-routine ("draw_filled_circle" draw-filled-circle)
    void
  (surface (:struct-pointer surface))
  (x (unsigned-byte 16))
  (y (unsigned-byte 16))
  (radius (unsigned-byte 16))
  (r (unsigned-byte 8))
  (g (unsigned-byte 8))
  (b (unsigned-byte 8)))

(def-foreign-routine ("draw_filled_circle_with_border"
                      draw-filled-circle-with-border)
    void
  (surface (:struct-pointer surface))
  (x (unsigned-byte 16))
  (y (unsigned-byte 16))
  (radius (unsigned-byte 16))
  (r (unsigned-byte 8))
  (g (unsigned-byte 8))
  (b (unsigned-byte 8))
  (br (unsigned-byte 8))
  (bg (unsigned-byte 8))
  (bb (unsigned-byte 8)))

(def-foreign-routine ("draw_filled_rectangle" draw-filled-rectangle)
    void
  (surface (:struct-pointer surface))
  (x (unsigned-byte 16))
  (y (unsigned-byte 16))
  (w (unsigned-byte 16))
  (h (unsigned-byte 16))
  (r (unsigned-byte 8))
  (g (unsigned-byte 8))
  (b (unsigned-byte 8)))

(def-foreign-routine ("draw_triangle" draw-triangle)
    void
  (surface (:struct-pointer surface))
  (x1 (unsigned-byte 16))
  (y1 (unsigned-byte 16))
  (x2 (unsigned-byte 16))
  (y2 (unsigned-byte 16))
  (x3 (unsigned-byte 16))
  (y3 (unsigned-byte 16))
  (r (unsigned-byte 8))
  (g (unsigned-byte 8))
  (b (unsigned-byte 8)))

(def-foreign-routine ("draw_filled_triangle" draw-filled-triangle)
    void
  (surface (:struct-pointer surface))
  (x1 (unsigned-byte 16))
  (y1 (unsigned-byte 16))
  (x2 (unsigned-byte 16))
  (y2 (unsigned-byte 16))
  (x3 (unsigned-byte 16))
  (y3 (unsigned-byte 16))
  (r (unsigned-byte 8))
  (g (unsigned-byte 8))
  (b (unsigned-byte 8)))

(def-foreign-struct vraster
    (top (* uint16))
  (bottom (* uint16))
  (length uint16)
  (surface-height uint16))

(def-foreign-struct-accessors (vraster)
    top bottom length surface-height)

(def-foreign-type vraster* (:struct-pointer vraster))

(def-foreign-routine ("make_vraster" make-vraster)
    vraster*
  (surface (:struct-pointer surface)))

(def-foreign-routine ("free_vraster" free-vraster)
    void
  (buffer vraster*))

(def-foreign-routine ("vraster_line" vraster-line)
    void
  (buffer vraster*)
  (x1 uint16)
  (y1 uint16)
  (x2 uint16)
  (y2 uint16))

(def-foreign-routine ("fill_vraster" fill-vraster)
    void
  (surface (:struct-pointer surface))
  (buffer vraster*)
  (r uint8)
  (g uint8)
  (b uint8))


(defmacro with-locked-surface ((var &optional surface) &body body)
  `(let (,@(when surface `(,var ,surface)))
     (unwind-protect 
         (progn (when (must-lock-p ,var)
                  (lock-surface ,var))
                ,@body)
       (when (must-lock-p ,var)
         (unlock-surface ,var)))))
