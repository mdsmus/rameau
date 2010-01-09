;;;; -*- Mode: Lisp -*-

(defpackage #:clobber
  (:use #:cl)
  (:shadow #:block)
  (:export #:start))

(in-package #:clobber)

(declaim (optimize (safety 1) (space 1) (speed 3) (debug 3)))

(defparameter *screen-width* 640)
(defparameter *screen-height* 480)

(defvar *board*)
(defvar *mode* 'opening)
(defvar *font*)
(defvar *rect*)
(defparameter *font-file* (sdl-data:data-file "bboron" "ttf"))
(defparameter *font-size* 18)
(defparameter *block-count* 16)
(defparameter *gravity-acceleration* 512)
(defparameter *player-speed* 1/4)

(defstruct block
  type r g b (prev-move 0) (speed 1) (y-position 0))

(defun init-sdl (&key (title "Clobber!"))
  (sdl:init (logior sdl:+init-video+ sdl:+init-noparachute+))
  (let ((surface (set-video-mode)))
    (when (sgum:null-pointer-p surface)
      (error "Unable to set video mode"))
    (sdl:wm-set-caption title nil)
    surface))

(defmacro def-game-vars (ig1 ig2 &rest vars)
  (declare (ignore ig1 ig2)) ;;reserved
  `(progn
    ,@ (loop for var in vars collect
        (let ((var (intern (format nil "*~A*"
                                   (if (consp var)
                                       (first var)
                                       var))))
              (val (when (consp var)
                     `(,(second var)))))
          `(defvar ,var ,@val)))))

(def-game-vars () ()
  left right top bottom board-width board-height
  block-size (block-speed 25)
  board-r board-g board-b
  block-r block-g block-b
  stand-r stand-g stand-b
  (prev-block-release 0)
  (block-release-interval 1000)
  (player-sprite nil)
  player-x% player-y%
  player-vx% player-vy%
  (prev-game-loop 0)
  player-status)


(defmacro with-game-vars ((&rest names) &body body)
  `(symbol-macrolet ,(loop for name in names collect
                           `(,name ,(intern (format nil "*~A*" name))))
    ,@body))

(defun set-video-mode ()
  (with-game-vars (left right top bottom board-width board-height 
                        block-size
                        board-r board-g board-b
                        block-r block-g block-b
                        stand-r stand-g stand-b
                        player-sprite)
    (let ((w (* 9 (truncate *screen-width* 10)))
          (h (* 9 (truncate *screen-height* 10))))
      (decf w (rem w *block-count*))
      (decf h (rem h *block-count*))
      (setf w (min w h)
            h w)
      
      (setf left (- (truncate *screen-width* 2)
                    (truncate w 2))
            right (+ (truncate *screen-width* 2)
                     (truncate w 2))
            top (- (truncate *screen-height* 2)
                   (truncate h 2))
            bottom (+ (truncate *screen-height* 2)
                      (truncate h 2))
            board-width (- right left)
            board-height (- bottom top))
      
      (setf block-size (/ w *block-count*)))

    (setf board-r 255
          board-g 255
          board-b 255
          block-r 255
          block-g 0
          block-b 0
          stand-r 0
          stand-g 255
          stand-b 0)

    (when player-sprite
      (sdl:free-surface player-sprite))
    
    (setf player-sprite 
      (sdl:create-rgb-surface sdl:+swsurface+
                              block-size block-size 16 0 0 0 0))
    (sdl:set-color-key player-sprite sdl:+srccolorkey+ 0)
    (render-sprite player-sprite))
  
  (sdl:set-video-mode *screen-width*
                      *screen-height*
                      16
                      (logior sdl:+resizable+
                              sdl:+swsurface+
                              sdl:+doublebuf+)))

(defun run-sdl-event-loop (surface update-fn mouse-fn key-down-fn key-up-fn)
  (sdl:event-loop
   (:key-down (scan-code key mod unicode)
              (format t "Key down: ~A~%"
                      (if (< key 256)
                          (code-char key)
                        key))
              (funcall key-down-fn
                       scan-code key mod unicode))
   
   (:key-up (scan-code key mod unicode)
            (format t "Key up: ~A~%"
                    (if (< key 256)
                          (code-char key)
                      key))
            (funcall key-up-fn
                     scan-code key mod unicode))
   (:mouse-button-up (button x y)
                     (format t "Mouse button up: ~A (~A, ~A)~%" button x y)
                     (funcall mouse-fn button x y :up))
   (:mouse-button-down (button x y)
                       (format t "Mouse button dn: ~A (~A, ~A)~%" button x y))
   (:quit ()
          (throw 'quit-game t))
   (:resize (width height)
            (setf *screen-width* width
                  *screen-height* height
                  surface (set-video-mode))
            (format t "Resized width = ~A height = ~A~%" width height))
   (:idle ()
          (funcall update-fn surface))))

(defun default-key-down-handler (scan-code key mod unicode)
  (declare (ignorable scan-code key mod unicode))
  (with-game-vars (player-vx% player-vy% board-height player-status)
    (cond ((eq *mode* 'opening)
           (setf *mode* 'playing))
          (t
           (case key
             ((#.(char-code #\q))
              (throw 'quit-game t))
             ((#.(char-code #\space))
              (when (eq player-status 'standing)
                (decf player-vy% (/ *gravity-acceleration*
                                    board-height
                                    2))
                (setf player-status 'jumping)))
             (273 ;; up
              (when (eq player-status 'standing)
                (decf player-vy% (/ *gravity-acceleration*
                                    board-height
                                    2))
                (setf player-status 'jumping)))
             (274 ;; down
              )
             (275 ;; right
              (incf player-vx% *player-speed*))
             (276 ;; left
              (decf player-vx% *player-speed*)))))))

(defun default-key-up-handler (scan-code key mod unicode)
  (declare (ignorable scan-code key mod unicode))
  (with-game-vars (player-vx% player-vy%)
    (case key
      (275
       (decf player-vx% *player-speed*))
      (276 
       (incf player-vx% *player-speed*)))))


(defun default-mouse-handler (button x y up-or-down)
  (declare (ignorable button x y up-or-down))
  nil)


(defun display-opening (surface)
  (cl-sdl-ttf:with-solid-text (title-text *font* "Clobber!" 255 255 255)
    (sgum:with-foreign-objects ((rect sdl:rect))
      (setf (sdl:rect-x rect) (truncate *screen-width* 2)
            (sdl:rect-y rect) (truncate *screen-height* 2))
      (sdl:blit-surface title-text sgum:+null-pointer+
                        surface rect))))

(defun update (surface)
  (update-game)
  (update-screen surface))

(defun release-new-block (i)
  (with-game-vars (block-size block-speed block-r block-g block-b)
    (let ((j 0))
      (loop while (block-p (aref *board* i j))
            do (incf j)
            when (>= j *block-count*)
            do (return-from release-new-block nil))
      (unless (zerop j)
        ;; check for collision with possible block in that place
        (when (> block-size
                 (block-y-position (aref *board* i (1- j))))
          (return-from release-new-block nil)))
      (setf (aref *board* i j)
            (make-block :type 'falling
                        :r block-r :g block-g :b block-b
                        :speed block-speed)))))


(defun grounded-block (block)
  (with-game-vars (stand-r stand-g stand-b)
    (setf (block-type block) 'standing
          (block-r block) stand-r
          (block-g block) stand-g
          (block-b block) stand-b)))

(defun sprite-collision-check (x1 y1 w1 h1 sprite x2 y2 w2 h2)
  (let ((top1 y1)
        (bottom1 (+ y1 h1))
        (left1 x1)
        (right1 (+ x1 w1))
        (top2 y2)
        (bottom2 (+ y2 h2))
        (left2 x2)
        (right2 (+ x2 w2))
        over-bottom
        over-top
        over-right
        over-left)
    (when (or (< bottom1 top2)
              (> top1 bottom2)
              (< right1 left2)
              (> left1 right2))
      (return-from sprite-collision-check 
        (values 0 0)))
    
    (setf over-bottom (- (if (> bottom1 bottom2)
                             bottom2
                           bottom1)
                         y2)
          over-top (- (if (< top1 top2)
                          top2
                        top1)
                      y2)
          over-right (- (if (> right1 right2)
                            right2
                          right1)
                        x2)
          over-left (- (if (< left1 left2)
                           left2
                         left1)
                       x2))
    
    (sdl:with-locked-surface (sprite)
      (loop for x from (truncate over-left) below (truncate over-right) do
            (loop for y from (truncate over-top) below (truncate over-bottom) 
                when (plusp (sdl:get-pixel sprite x y))
                do (return-from sprite-collision-check
                     (let ((x-diff (- over-right over-left))
                           (y-diff (- over-bottom over-top)))
                       (if (< x-diff y-diff)
                           (if (< x1 x2)
                               (values 1 0)
                             (values (- 1) 0))
                         (if (< y1 y2)
                             (values 0 1)
                           (values 0 (- 1)))))))))
    (values 0 0)))

(defun update-game ()
  (with-game-vars (left top bottom
                        block-size prev-block-release block-release-interval
                        prev-game-loop
                        player-x% player-y%
                        player-vx% player-vy%
                        board-width board-height
                        player-sprite player-status)
    (dotimes (i *block-count*)
      (dotimes (j *block-count*)
        (let ((block (aref *board* i j)))
          (when (block-p block)
            ;; update each block
            (when (eq (block-type block) 'falling)
              (unless (zerop (block-prev-move block))
                (let ((seconds-passed
                       (/ (- (sdl:get-ticks)
                             (block-prev-move block))
                          1000)))
                  ;; change in position
                  (incf (block-y-position block)
                        (* (block-speed block)
                           seconds-passed))
                  ;; change in velocity
                  (incf (block-speed block)
                        (* *gravity-acceleration*
                           seconds-passed))))
              (setf (block-prev-move block)
                (sdl:get-ticks)))

            (if (zerop j)
                ;; check for collision with bottom
                (when (>= (block-y-position block)
                          (- bottom block-size))
                  (grounded-block block)
                  (setf (block-y-position block)
                    (- bottom block-size)))
              
              ;; check for collision with previous block
              (let ((prev-block-top
                     (block-y-position (aref *board* i (1- j))))
                    (block-bottom
                     (+ (block-y-position block)
                        block-size)))
                
                (when (>= block-bottom prev-block-top)
                  (decf (block-y-position block)
                        (- block-bottom prev-block-top))
                  (when (eq 'standing
                            (block-type (aref *board* i (1- j))))
                    (grounded-block block)))))))))
    
    ;; randomly drop new blocks
    (when (>= (- (sdl:get-ticks)
                 prev-block-release)
              block-release-interval)
      (when (release-new-block (random *block-count*))
        (setf prev-block-release (sdl:get-ticks))))
    
    (unless (zerop prev-game-loop)
      (let ((msec-passed (- (sdl:get-ticks)
                            prev-game-loop)))
        
        
        ;; player movement
        (setf player-vy% (if (= 1 player-y%)
                             (min 0 player-vy%)
                           (+ player-vy%
                              (* (/ msec-passed 1000)
                                 (/ *gravity-acceleration*
                                    board-height))))
              player-x% (min 1 (max 0 (+ player-x%
                                         (* player-vx%
                                            (/ msec-passed 1000)))))
              player-y% (min 1 (max 0 (+ player-y%
                                         (* player-vy%
                                            (/ msec-passed 1000))))))
        
        (when (and (= 1 player-y%)
                   (zerop player-vy%))
          (setf player-status 'standing))

        (when (zerop player-y%)
          (write-line "Reached top!")
          (finish-output))
        
        ;; player collision detection
        (let* ((player-x-range (- board-width block-size))
               (player-y-range (- board-height block-size))
               (block-num (truncate (* *block-count*
                                       player-x%)))
               (start (max 0 (1- block-num)))
               (end (min (1- *block-count*) 
                         (1+ block-num))))
          (loop for i from start to end do
                (dotimes (j *block-count*)
                  (let ((block (aref *board* i j)))
                    (when (block-p block)
                      (multiple-value-bind (x-offset y-offset)
                          (sprite-collision-check (+ left (* i block-size))
                                                  (truncate
                                                   (block-y-position block))
                                                  block-size
                                                  block-size
                                                  player-sprite
                                                  (truncate
                                                   (+ left
                                                      (* player-x%
                                                         player-x-range)))
                                                  (truncate
                                                   (+ top
                                                      (* player-y%
                                                         player-y-range)))
                                                  block-size
                                                  block-size)
                        (when (plusp y-offset)
                          (write-line "Clobbered!")
                          (finish-output))
                        (when (minusp y-offset)
                          (setf player-vy% 0
                                player-status 'standing))
                        
                        (setf player-x%
                          (min 1 (max 0 (+ player-x%
                                           (/ x-offset
                                              player-x-range)))))
                        (setf player-y% 
                          (min 1 (max 0 (+ player-y%
                                           (/ y-offset 
                                              player-y-range)))))))))))))
    (setf prev-game-loop (sdl:get-ticks))))

(defun update-screen (surface)
  (sdl:draw-filled-rectangle surface
                             0 0 *screen-width* *screen-height*
                             0 0 0)
  (case *mode*
    (opening (display-opening surface))
    (playing (draw-board surface)
             (draw-player surface)))
  (sdl:flip surface))

(defun draw-board (surface)
  (with-game-vars (left right top bottom board-r board-g board-b block-size)
    (dotimes (i *block-count*)
      (dotimes (j *block-count*)
        (let ((block (aref *board* i j)))
          (when (block-p block)
            (sdl:draw-filled-rectangle surface
                                       (+ left (* block-size i))
                                       (truncate (block-y-position block))
                                       block-size
                                       block-size
                                       (block-r block)
                                       (block-g block)
                                       (block-b block))))))
    (sdl:draw-line surface
                   left top
                   left bottom
                   board-r board-g board-b)
    (sdl:draw-line surface
                   right top
                   right bottom
                   board-r board-g board-b)

    (sdl:draw-line surface
                   left bottom
                   right bottom
                   board-r board-g board-b)))

(defun draw-player (surface)
  (with-game-vars (player-sprite player-x% player-y% 
                                 board-width board-height left top
                                 block-size)
    (setf (sdl:rect-x *rect*) (truncate
                               (+ (* player-x% 
                                     (- board-width block-size))
                                  left))
          (sdl:rect-y *rect*) (truncate
                               (+ (* player-y% 
                                     (- board-height block-size))
                                  top)))
    (sdl:blit-surface player-sprite sgum:+null-pointer+
                      surface *rect*)))


(defun render-sprite (surface)
  (with-game-vars (block-size)
    (sdl:draw-filled-rectangle surface
                               (truncate block-size 4)
                               0
                               (truncate block-size 2)
                               block-size
                               0 0 255)))

(defun start (&key (width 640) (height 480) (title "Clobber!"))
  (let ((*screen-width* width)
        (*screen-height* height)
        (surface nil))
    (with-game-vars (player-x% player-y% player-vx% player-vy% player-status)
      (setf *mode* 'playing
            *board* (make-array (list *block-count* *block-count*)
                                :initial-element nil)
            player-x% 1/2 player-y% 1
            player-vx% 0 player-vy% 0
            player-status 'standing))
    #+nil
    (setf (aref *board* 0 0)
          (make-block :type 'falling :speed 25
                      :r 255 :g 0 :b 0
                      :y-position 40)
          (aref *board* 0 1)
          (make-block :type 'falling :speed 30
                      :r 0 :g 255 :b 0))
    
    
    (catch 'quit-game
      (unwind-protect
          (progn
            (setf surface (init-sdl :title title))
            (when surface
              (sdl-ttf:init)
              (unwind-protect
                  (progn
                    (setf *font* (sdl-ttf:open-font *font-file* *font-size*))
                    (setf *rect* (sgum:allocate-foreign-object 'sdl:rect))
                    (when *font*
                      (run-sdl-event-loop surface
                                          'update
                                          'default-mouse-handler
                                          'default-key-down-handler
                                          'default-key-up-handler)))
                (progn
                  (when *font*
                    (sdl-ttf:close-font *font*))
                  (when *rect*
                    (sgum:free-foreign-object *rect*))))))
        (sdl:quit)))))