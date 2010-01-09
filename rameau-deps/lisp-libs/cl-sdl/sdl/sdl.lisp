;;;;
;;;; Minimal SDL binding for CMUCL
;;;; =============================
;;;;
;;;; written in 2002 by Timo Tossavainen (tt@cs.uta.fi)
;;;;
;;;; This file contains about enough of SDL to open an OpenGL window and
;;;; handle events. The original goal is to make a system where one can
;;;; easily program OpenGL programs in CMU Common Lisp. This binding will
;;;; be expanded eventually.
;;;;
;;;;
;;;; Further modifications done by: Matthew Danish <mrd@debian.org>
;;;;

(defpackage #:sdl
  (:use #:common-lisp #:sdl-gl-uffi-macros)
  (:export #:sdl #:sdlstub)
  (:documentation "Simple DirectMedia Layer binding"))

(in-package #:sdl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (def-library-properties sdl ("SDL" "libSDL" "libSDL-1.1")
    :module sdl)
  
  (def-library-properties sdlstub ("sdlstub")
    :module sdlstub)

  (load-defined-foreign-library 'sdlstub)
  (load-defined-foreign-library 'sdl)
  
  (in-module sdl))

;;;
;;; SDL symbolic constants
;;; ======================

;; Byte-order

(def-foreign-constant +lil-endian+ 1234)
(def-foreign-constant +big-endian+ 4321)

;; Init constants for SDL subsystems

(def-foreign-constant +init-timer+       #x00000001)
(def-foreign-constant +init-audio+       #x00000010)
(def-foreign-constant +init-video+       #x00000020)
(def-foreign-constant +init-cdrom+       #x00000100)
(def-foreign-constant +init-joystick+    #x00000200)
(def-foreign-constant +init-noparachute+ #x00100000)
(def-foreign-constant +init-eventthread+ #x01000000)
(def-foreign-constant +init-everything+  #x0000FFFF)

;; Surface def-foreign-constants

(def-foreign-constant +swsurface+   #x00000000) ; For CreateRGBSurface
(def-foreign-constant +hwsurface+   #x00000001)
(def-foreign-constant +asyncblit+   #x00000004)
(def-foreign-constant +anyformat+   #x10000000) ; For SetVideoMode
(def-foreign-constant +hwpalette+   #x20000000)
(def-foreign-constant +doublebuf+   #x40000000)
(def-foreign-constant +fullscreen+  #x80000000)
(def-foreign-constant +opengl+      #x00000002)
(def-foreign-constant +openglblit+  #x0000000A)
(def-foreign-constant +resizable+   #x00000010)
(def-foreign-constant +noframe+     #x00000020)
(def-foreign-constant +hwaccel+     #x00000100) ; Internal (read-only)
(def-foreign-constant +srccolorkey+ #x00001000)
(def-foreign-constant +rleaccelok+  #x00002000)
(def-foreign-constant +rleaccel+    #x00004000)
(def-foreign-constant +srcalpha+    #x00010000)
(def-foreign-constant +prealloc+    #x01000000)

;; GL attributes (SDL_GLattr)

(def-foreign-constant +gl-red-size+          0)
(def-foreign-constant +gl-green-size+        1)
(def-foreign-constant +gl-blue-size+         2)
(def-foreign-constant +gl-alpha-size+        3)
(def-foreign-constant +gl-buffer-size+       4)
(def-foreign-constant +gl-doublebuffer+      5)
(def-foreign-constant +gl-depth-size+        6)
(def-foreign-constant +gl-stencil-size+      7)
(def-foreign-constant +gl-accum-red-size+    8)
(def-foreign-constant +gl-accum-green-size+  9)
(def-foreign-constant +gl-accum-blue-size+  10)
(def-foreign-constant +gl-accum-alpha-size+ 11)

;; SDL event type constants

(def-foreign-constant +no-event+ 0)
(def-foreign-constant +active-event+ 1)
(def-foreign-constant +key-down+ 2)
(def-foreign-constant +key-up+ 3)
(def-foreign-constant +mouse-motion+ 4)
(def-foreign-constant +mouse-button-down+ 5)
(def-foreign-constant +mouse-button-up+ 6)
(def-foreign-constant +joy-axis-motion+ 7)
(def-foreign-constant +joy-ball-motion+ 8)
(def-foreign-constant +joy-hat-motion+ 9)
(def-foreign-constant +joy-button-down+ 10)
(def-foreign-constant +joy-button-up+ 11)
(def-foreign-constant +quit+ 12)
(def-foreign-constant +sys-wm-event+ 13)
(def-foreign-constant +event-reserved-a+ 14)
(def-foreign-constant +event-reserved-b+ 15)
(def-foreign-constant +video-resize+ 16)
(def-foreign-constant +video-expose+ 17)
(def-foreign-constant +event-reserved-2+ 18)
(def-foreign-constant +event-reserved-3+ 19)
(def-foreign-constant +event-reserved-4+ 20)
(def-foreign-constant +event-reserved-5+ 21)
(def-foreign-constant +event-reserved-6+ 22)
(def-foreign-constant +event-reserved-7+ 23)
(def-foreign-constant +user-event+ 24)
(def-foreign-constant +num-events+ 32)

;; Event actions

(def-foreign-constant +add-event+  0)
(def-foreign-constant +peek-event+ 1)
(def-foreign-constant +get-event+  2)

;; Input Grabbing modes

(def-foreign-constant +grab-query+ -1)
(def-foreign-constant +grab-off+    0)
(def-foreign-constant +grab-on+     1)

;; Keyboard/Mouse state enum

(def-foreign-constant +pressed+     1)
(def-foreign-constant +released+    0)

;; Mouse button enum

(def-foreign-constant +button-left+   1)
(def-foreign-constant +button-middle+ 2)
(def-foreign-constant +button-right+  3)

;; Joystick hat enum

(def-foreign-constant +hat-centered+  0)
(def-foreign-constant +hat-up+        1)
(def-foreign-constant +hat-right+     2)
(def-foreign-constant +hat-down+      4)
(def-foreign-constant +hat-left+      8)
(def-foreign-constant +hat-rightup+   (logior +hat-right+ +hat-up+))
(def-foreign-constant +hat-rightdown+ (logior +hat-right+ +hat-down+))
(def-foreign-constant +hat-leftup+    (logior +hat-left+  +hat-up+))
(def-foreign-constant +hat-leftdown+  (logior +hat-left+  +hat-down+))

;; Activate state

(def-foreign-constant +app-mouse-focus+ 1)
(def-foreign-constant +app-input-focus+ 2)
(def-foreign-constant +app-active+      4)

;; SDL boolean type

(def-foreign-constant +false+ 0)
(def-foreign-constant +true+  1)

;; Audio

(def-foreign-constant +audio-u8+ #x0008)
(def-foreign-constant +audio-s8+ #x8008)
(def-foreign-constant +audio-u16lsb+ #x0010)
(def-foreign-constant +audio-s16lsb+ #x8010)
(def-foreign-constant +audio-u16msb+ #x1010)
(def-foreign-constant +audio-s16msb+ #x9010)
(def-foreign-constant +audio-u16+ +audio-u16lsb+)
(def-foreign-constant +audio-s16+ +audio-s16lsb+)

;; CD

(eval-when (:compile-toplevel :load-toplevel :execute)
  (ignore-errors (def-foreign-constant +max-tracks+ 99)))

(def-foreign-constant +audio-track+ #x00)
(def-foreign-constant +data-track+ #x04)

(def-foreign-constant +trayempty+ 0)
(def-foreign-constant +stopped+ 1)
(def-foreign-constant +playing+ 2)
(def-foreign-constant +paused+ 3)
(def-foreign-constant +error+ -1)

;;;
;;; SDL primitive types
;;; ===================

(def-foreign-type uint8  (unsigned-byte 8))
(def-foreign-type sint8  (signed-byte 8))
(def-foreign-type uint16 (unsigned-byte 16))
(def-foreign-type sint16 (signed-byte 16))
(def-foreign-type uint32 (unsigned-byte 32))
(def-foreign-type sint32 (signed-byte 32))
(def-foreign-type rwops* (* void))
(def-foreign-type bool (unsigned-byte 8)) ; a good enough approximation, I hope
(def-foreign-type eventaction int)
(def-foreign-type kmod int)
(def-foreign-type key int)
(def-foreign-type cd-status int)

;;;
;;; SDL structures
;;; ==============

;; Video

(def-foreign-struct rect
  (x sint16)
  (y sint16)
  (w uint16)
  (h uint16))

(def-foreign-struct-accessors (rect)
    x y w h)

(def-foreign-struct color
  (r uint8)
  (g uint8)
  (b uint8)
  (unused uint8))

(def-foreign-struct-accessors (color)
    r g b)

(def-foreign-struct palette
  (ncolors int)
  (colors (:struct-pointer color)))

(def-foreign-struct pixel-format
  (palette (:struct-pointer palette))
  (bits-per-pixel uint8)
  (bytes-per-pixel uint8)
  (r-loss uint8)
  (g-loss uint8)
  (b-loss uint8)
  (a-loss uint8)
  (r-shift uint8)
  (g-shift uint8)
  (b-shift uint8)
  (a-shift uint8)
  (r-mask uint32)
  (g-mask uint32)
  (b-mask uint32)
  (a-mask uint32)
  (color-key uint32)
  (alpha uint8))

(def-foreign-struct-accessors (pixel-format)
    palette bits-per-pixel bytes-per-pixel
    r-loss g-loss b-loss a-loss
    r-shift g-shift b-shift a-shift
    r-mask g-mask b-mask a-mask
    color-key alpha)

(def-foreign-struct surface
  (flags  uint32)
  (format (:struct-pointer pixel-format))
  (w      int)
  (h      int)
  (pitch uint16)
  (pixels :pointer-void)
  (offset int)
  (hwdata :pointer-void) ; internally struct (opaque pointer)
  (clip-rect (:struct rect))
  (unused uint32)
  (locked uint32)
  (map    :pointer-void) ; internally struct (opaque pointer)
  (format-version unsigned-int)
  (ref-count int))

(def-foreign-struct-accessors (surface)
    w h pixels format flags pitch offset locked format-version)

(def-foreign-struct video-info
  (video-info-bits uint32)
  (video-mem uint32)
  (vfmt (:struct-pointer pixel-format)))

(def-foreign-struct-accessors (video-info)
    vfmt video-mem)

;; overlay    

;; Event

(def-foreign-struct cursor
    (area (:struct rect))
  (hot-x sint16)
  (hot-y sint16)
  (data (* uint8))
  (mask (* uint8))
  (save (:array uint8 2))
  (wm-cursor (* void)))

(def-foreign-struct keysym
  (scancode uint8)
  (sym      int) ;; probably 
  (mod      int) ;; ---"----
  (unicode  uint16))

(def-foreign-struct active-event
  (type uint8)
  (gain uint8)
  (state uint8))

(def-foreign-struct keyboard-event
  (type  uint8) ; event type
  (which uint8) ; device index
  (state uint8) ; pressed or released
  (keysym (:struct keysym)))

(def-foreign-struct mouse-motion-event
  (type  uint8)
  (which uint8)
  (state uint8)
  (x     uint16)
  (y     uint16)
  (xrel  sint16)
  (yrel  sint16))

(def-foreign-struct mouse-button-event
  (type   uint8)
  (which  uint8)
  (button uint8)
  (state  uint8)
  (x      uint16)
  (y      uint16))

(def-foreign-struct joy-axis-event
  (type  uint8)
  (which uint8)
  (axis  uint8)
  (value sint16))

(def-foreign-struct joy-ball-event
  (type  uint8)
  (which  uint8)
  (ball   uint8)
  (xrel   sint16)
  (yrel   sint16))

(def-foreign-struct joy-hat-event
  (type   uint8)
  (which  uint8)
  (hat    uint8)
  (state  uint8))

(def-foreign-struct joy-button-event
  (type uint8)
  (which uint8)
  (button uint8)
  (state  uint8))

(def-foreign-struct resize-event
  (type uint8)
  (w    int)
  (h    int))

(def-foreign-struct expose-event
  (type uint8))

(def-foreign-struct quit-event
  (type uint8))

(def-foreign-struct user-event
  (type uint8)
  (code int)
  (data-1 :pointer-void)
  (data-2 :pointer-void))

(def-foreign-struct sys-wm-event
  (type uint8)
  (msg  :pointer-void))

;; Joystick

(def-foreign-struct joystick)

;; Main SDL event structure

(def-foreign-union event
  (type    uint8)
  (active  (:struct active-event))
  (key     (:struct keyboard-event))
  (motion  (:struct mouse-motion-event))
  (button  (:struct mouse-button-event))
  (jaxis   (:struct joy-axis-event))
  (jball   (:struct joy-ball-event))
  (jhat    (:struct joy-hat-event))
  (jbutton (:struct joy-button-event))
  (resize  (:struct resize-event))
  (expose  (:struct expose-event))
  (quit    (:struct quit-event))
  (user    (:struct user-event))
  (syswm   (:struct sys-wm-event)))

;; CD ROM Drive

(def-foreign-struct cd-track
    (id uint8)
  (type uint8)
  (length uint32)
  (offset uint32))

(def-foreign-struct-accessors (cd-track)
    id type length offset)

(def-foreign-struct cd
    (id int)
  (status cd-status)
  (numtracks int)
  (cur-track int)
  (cur-frame int)
  (track (:array cd-track #.(1+ +max-tracks+))))

(def-foreign-struct-accessors (cd)
    id status numtracks cur-track cur-frame)

(defun cd-track (cd track-num)
  (deref-array (slot cd cd track)
               (:array cd-track)
               track-num))
(export 'cd-track)


;;;
;;; SDL Functions 
;;; =============

;; Byte order

(def-foreign-routine ("byte_order" byte-order :module sdlstub)
    uint16)

;; General group

(def-foreign-routine ("SDL_Init" init) (signed-byte 32)
  (flags uint32))

(def-foreign-routine ("SDL_InitSubSystem" init-subsystem) int
  (flags uint32))

(def-foreign-routine ("SDL_QuitSubSystem" quit-subsystem) void
  (flags uint32))

(def-foreign-routine ("SDL_Quit" quit) void)

(def-foreign-routine ("SDL_WasInit" was-init) uint32
  (flags uint32))

(def-foreign-routine ("SDL_GetError" get-error) c-string)

;; Video group

(def-foreign-routine ("SDL_GetVideoSurface" get-video-surface)
    (:struct-pointer surface))

(def-foreign-routine ("SDL_GetVideoInfo" get-video-info)
    (:struct-pointer video-info))

(def-foreign-routine ("SDL_VideoDriverName" video-driver-name)
    (* :unsigned-char)
  (namebuf (* :unsigned-char))
  (maxlen int))

(def-foreign-routine ("SDL_ListModes" list-modes)
    (* (:struct-pointer rect))
  (format (:struct-pointer pixel-format))
  (flags uint32))

(def-foreign-routine ("SDL_VideoModeOK" video-mode-ok) int
  (width  int)
  (height int)
  (bpp    int)
  (flags  uint32))

(def-foreign-routine ("SDL_SetVideoMode" set-video-mode)
    (:struct-pointer surface)
  (width  int)
  (height int)
  (bpp    int)
  (flags  uint32))

(def-foreign-routine ("SDL_UpdateRect" update-rect) void
  (surface (:struct-pointer surface))
  (x sint32)
  (y sint32)
  (w uint32)
  (h uint32))

(def-foreign-routine ("SDL_Flip" flip) int
  (screen (:struct-pointer surface)))

(def-foreign-routine ("SDL_SetColors" set-colors) int
  (surface (:struct-pointer surface))
  (colors (:struct-pointer color))
  (firstcolor int)
  (ncolors int))

(def-foreign-routine ("SDL_SetPalette" set-palette) int
  (surface (:struct-pointer surface))
  (flags int)
  (colors (:struct-pointer color))
  (firstcolor int)
  (ncolors int))

(def-foreign-routine ("SDL_SetGamma" set-gamma)
    int
  (red sfloat)
  (green sfloat)
  (blue sfloat))

;; get-gamma-ramp
;; set-gamma-ramp

(def-foreign-routine ("SDL_MapRGB" map-rgb) (unsigned-byte 32)
  (format (:struct-pointer pixel-format))
  (r uint8)
  (g uint8)
  (b uint8))

(def-foreign-routine ("SDL_MapRGBA" map-rgba)
    uint32
  (format (:struct-pointer pixel-format))
  (r uint8)
  (g uint8)
  (b uint8)
  (a uint8))

(declaim (inline get-rgb))
(def-foreign-routine ("SDL_GetRGB" get-rgb)
    void
  (pixel uint32)
  (fmt (:struct-pointer pixel-format))
  (r (* uint8))
  (g (* uint8))
  (b (* uint8)))

;; get-rgba

(def-foreign-routine ("SDL_CreateRGBSurface" create-rgb-surface)
    (:struct-pointer surface)
  (flags uint32)
  (width int)
  (height int)
  (depth int)
  (rmask uint32)
  (gmask uint32)
  (bmask uint32)
  (amask uint32))

(def-foreign-routine ("SDL_CreateRGBSurfaceFrom" create-rgb-surface-from)
    (:struct-pointer surface)
  (pixels (* void))
  (width int)
  (height int)
  (depth int)
  (pitch int)
  (rmask uint32)
  (gmask uint32)
  (bmask uint32)
  (amask uint32))

(def-foreign-routine ("SDL_FreeSurface" free-surface) void
  (surface (:struct-pointer surface)))

(def-foreign-routine ("SDL_LockSurface" lock-surface) int
  (surface (:struct-pointer surface)))

(def-foreign-routine ("SDL_UnlockSurface" unlock-surface) void
  (surface (:struct-pointer surface)))

(def-foreign-routine ("load_bmp" load-bmp :module sdlstub)
    (:struct-pointer surface)
  (file c-string))
  
(def-foreign-routine ("save_bmp" save-bmp :module sdlstub)
    int
  (surface (:struct-pointer surface))
  (file c-string))

(def-foreign-routine ("SDL_SetColorKey" set-color-key) int
  (surface (:struct-pointer surface))
  (flag uint32)
  (key uint32))

(def-foreign-routine ("SDL_SetAlpha" set-alpha) int
  (surface (:struct-pointer surface))
  (flag uint32)
  (alpha uint8))

(def-foreign-routine ("SDL_SetClipRect" set-clip-rect)
    bool
  (surface (:struct-pointer surface))
  (rect (:struct-pointer rect)))

(def-foreign-routine ("SDL_GetClipRect" get-clip-rect)
    void
  (surface (:struct-pointer surface))
  (rect (:struct-pointer rect)))

(def-foreign-routine ("SDL_ConvertSurface" convert-surface)
    (:struct-pointer surface)
  (src (:struct-pointer surface))
  (fmt (:struct-pointer pixel-format))
  (flags uint32))

(def-foreign-routine ("blit_surface" blit-surface :module sdlstub) int
  (src (:struct-pointer surface))
  (srcrect (:struct-pointer rect))
  (dst (:struct-pointer surface))
  (dstrect (:struct-pointer rect)))

(def-foreign-routine ("SDL_FillRect" fill-rect) int
  (dst (:struct-pointer surface))
  (dstrect (:struct-pointer rect))
  (color uint32))

(def-foreign-routine ("SDL_DisplayFormat" display-format)
    (:struct-pointer surface)
  (surface (:struct-pointer surface)))

(def-foreign-routine ("SDL_DisplayFormatAlpha" display-format-alpha)
    (:struct-pointer surface)
  (surface (:struct-pointer surface)))

(def-foreign-routine ("SDL_WarpMouse" warp-mouse) void
  (x uint16)
  (y uint16))

(def-foreign-routine ("SDL_CreateCursor" create-cursor)
    (:struct-pointer cursor)
  (data (* uint8))
  (mask (* uint8))
  (w int)
  (h int)
  (hot-x int)
  (hot-y int))

(def-foreign-routine ("SDL_FreeCursor" free-cursor)
    void
  (cursor (:struct-pointer cursor)))

(def-foreign-routine ("SDL_SetCursor" set-cursor)
    void
  (cursor (:struct-pointer cursor)))

(def-foreign-routine ("SDL_GetCursor" get-cursor)
    (:struct-pointer cursor))

(def-foreign-routine ("SDL_ShowCursor" show-cursor) int
  (toggle int))

;; Video group (OpenGL part)

(def-foreign-routine ("SDL_GL_GetProcAddress" gl-get-proc-address) (* void)
  (name c-string))

(def-foreign-routine ("SDL_GL_GetAttribute" gl-get-attribute-raw) int
  (attr int)
  (res (* int)))

(unexport 'gl-get-attribute-raw)
(defun gl-get-attribute (attr)
  (declare (type (unsigned-byte 32) attr))
  (sgum:with-foreign-objects ((res int))
    (gl-get-attribute-raw attr res)
    (deref-pointer res int)))
(export 'gl-get-attribute)

(def-foreign-routine ("SDL_GL_SetAttribute" gl-set-attribute) int
  (attr int)
  (value int))

(def-foreign-routine ("SDL_GL_SwapBuffers" gl-swap-buffers) void)

;; YUV

;; create-yuv-overlay
;; lock-yuv-overlay
;; unlock-yuv-overlay
;; display-yuv-overlay
;; free-yuv-overlay

;; Window manager group

(def-foreign-routine ("SDL_WM_SetCaption" wm-set-caption) void
  (str c-string)   ; const
  (icon c-string)) ; const

;; wm-get-caption

(def-foreign-routine ("SDL_WM_SetIcon" wm-set-icon)
    void
  (icon (:struct-pointer surface))
  (mask (* uint8)))

(def-foreign-routine ("SDL_WM_IconifyWindow" wm-iconify-window)
    void)

(def-foreign-routine ("SDL_WM_ToggleFullScreen" wm-toggle-full-screen)
    int
  (surface (:struct-pointer surface)))

(def-foreign-routine ("SDL_WM_GrabInput" wm-grab-input) int
  (mode int))

;; Event handling group

(def-foreign-routine ("SDL_PumpEvents" pump-events) void)

(def-foreign-routine ("SDL_PeepEvents" peep-events)
    int
  (events (:struct-pointer event))
  (numevents int)
  (action eventaction)
  (mask uint32))

(def-foreign-routine ("SDL_PollEvent" poll-event) int
  (event (:struct-pointer event)))

(def-foreign-routine ("SDL_WaitEvent" wait-event) int
  (event (:struct-pointer event)))

(def-foreign-routine ("SDL_PushEvent" push-event) int
  (event (:struct-pointer event)))

;; set-event-filter
;; get-event-filter

(def-foreign-routine ("SDL_EventState" event-state)
    uint8
  (type uint8)
  (state int))

(def-foreign-routine ("SDL_GetKeyState" get-key-state)
    (* uint8)
  (numkeys (* int))) ; all examples use NULL for this parameter...

(def-foreign-routine ("SDL_GetModState" get-mod-state)
    kmod)

(def-foreign-routine ("SDL_SetModState" set-mod-state)
    void
  (modstate kmod))

(def-foreign-routine ("SDL_GetKeyName" get-key-name)
    c-string
  (key key))

(def-foreign-routine ("SDL_EnableUNICODE" enable-unicode) int
  (enable int))

(def-foreign-routine ("SDL_EnableKeyRepeat" enable-key-repeat)
    int
  (delay int)
  (interval int))

;; get-mouse-state
;; get-relative-mouse-state

(def-foreign-routine ("SDL_GetAppState" get-app-state)
    uint8)

(def-foreign-routine ("SDL_JoystickEventState" joystick-event-state)
    int
  (state int))

;; joystick-event-state

;; Joystick group

(def-foreign-routine ("SDL_NumJoysticks" num-joysticks) int)

(def-foreign-routine ("SDL_JoystickName" joystick-name)
    :cstring
  (index int))

(def-foreign-routine ("SDL_JoystickOpen" joystick-open)
    (:struct-pointer joystick)
  (index int))

(def-foreign-routine ("SDL_JoystickOpened" joystick-opened-p)
    int
  (joystick (:struct-pointer joystick)))
  
(def-foreign-routine ("SDL_JoystickIndex" joystick-index)
    int
  (joystick (:struct-pointer joystick)))

(def-foreign-routine ("SDL_JoystickNumAxes" joystick-num-axes)
    int
  (joystick (:struct-pointer joystick)))

(def-foreign-routine ("SDL_JoystickNumBalls" joystick-num-balls)
    int
  (joystick (:struct-pointer joystick)))

(def-foreign-routine ("SDL_JoystickNumHats" joystick-num-hats)
    int
  (joystick (:struct-pointer joystick)))

(def-foreign-routine ("SDL_JoystickNumButtons" joystick-num-buttons)
    int
  (joystick (:struct-pointer joystick)))

(def-foreign-routine ("SDL_JoystickUpdate" joystick-update) void)

(def-foreign-routine ("SDL_JoystickGetAxis" joystick-get-axis)
    sint16
  (joystick (:struct-pointer joystick))
  (axis int))

(def-foreign-routine ("SDL_JoystickGetHat" joystick-get-hat)
    uint8
  (joystick (:struct-pointer joystick))
  (hat int))

(def-foreign-routine ("SDL_JoystickGetButton" joystick-get-button)
    uint8
  (joystick (:struct-pointer joystick))
  (button int))

(def-foreign-routine ("SDL_JoystickGetBall" joystick-get-ball)
    int
  (joystick (:struct-pointer joystick))
  (ball int)
  (dx (* int))
  (dy (* int)))

(def-foreign-routine ("SDL_JoystickClose" joystick-close)
    void
  (joystick (:struct-pointer joystick)))

;; Audio group



;; CD-ROM group

(def-foreign-routine ("SDL_CDNumDrives" cd-num-drives)
    int)

(def-foreign-routine ("SDL_CDName" cd-name)
    c-string
  (drive int))

(def-foreign-routine ("SDL_CDOpen" cd-open)
    (:struct-pointer cd)
  (drive int))

(def-foreign-routine ("SDL_CDStatus" cd-status)
    cd-status
  (cdrom (:struct-pointer cd)))

(def-foreign-routine ("SDL_CDPlay" cd-play)
    int
  (cdrom (:struct-pointer cd))
  (start int)
  (length int))

(def-foreign-routine ("SDL_CDPlayTracks" cd-play-tracks)
    int
  (cdrom (:struct-pointer cd))
  (start-track int)
  (start-frame int)
  (ntracks int)
  (nframes int))

(macrolet ((frob (cname lispname)
             `(def-foreign-routine (,cname ,lispname)
               int
               (cdrom (:struct-pointer cd)))))
  (frob "SDL_CDPause" cd-pause)
  (frob "SDL_CDResume" cd-resume)
  (frob "SDL_CDStop" cd-stop)
  (frob "SDL_CDEject" cd-eject))

(def-foreign-routine ("SDL_CDClose" cd-close)
    void
  (cdrom (:struct-pointer cd)))

;; Timer group

(def-foreign-routine ("SDL_GetTicks" get-ticks) (unsigned-byte 32))

(def-foreign-routine ("SDL_Delay" delay) void
  (ms uint32))

;; add-timer
;; remove-timer
;; set-timer

;; RWops

(def-foreign-routine ("SDL_RWFromFile" rw-from-file) rwops*
  (file c-string)
  (mode c-string))

(provide :sdl)
