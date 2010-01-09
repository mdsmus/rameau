;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; SDL Mixer FFI

(in-package #:sdl-mixer)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (in-module sdl-mixer))

(def-foreign-constant +channels+ 8)
(def-foreign-constant +default-frequency+ 22050)
;; need to deal with endianess first
;;(def-foreign-constant +default-format+ +audio-s16sys+)
(def-foreign-constant +default-channels+ 2)
(def-foreign-constant +max-value+ 128)
(def-foreign-constant +channel-post+ -2)

(def-foreign-constant +no-fading+ 0)
(def-foreign-constant +fading-out+ 1)
(def-foreign-constant +fading-in+ 2)

(def-foreign-constant +mus-none+ 0)
(def-foreign-constant +mus-cmd+ 1)
(def-foreign-constant +mus-wav+ 2)
(def-foreign-constant +mus-mod+ 3)
(def-foreign-constant +mus-mid+ 4)
(def-foreign-constant +mus-ogg+ 5)
(def-foreign-constant +mus-mp3+ 6)

(def-foreign-type fading int)
(def-foreign-type music-type int)
(def-foreign-type music* (* void))

(def-foreign-struct chunk
    (allocated int)
  (abuf (* uint8))
  (alen uint32)
  (volume uint8))

(def-foreign-type chunk* (:struct-pointer chunk))


;; linked-version


(def-foreign-routine ("Mix_OpenAudio" open-audio) int
  (frequency int)
  (format uint16)
  (channels int)
  (chunksize int))

(def-foreign-routine ("Mix_CloseAudio" close-audio) void)

;; set-error
;; get-error

(def-foreign-routine ("Mix_QuerySpec" query-spec)
    int
  (frequency (* int))
  (format (* uint16))
  (channels (* int)))

#+nil
(def-foreign-routine ("load_wav" load-wav) chunk*
  (file c-string))

(defun load-wav (file)
  (load-wav-rw (sdl:rw-from-file file "rb") 1))
(export '(load-wav))

(def-foreign-routine ("Mix_LoadWAV_RW" load-wav-rw)
    chunk*
  (src rwops*)
  (freesrc int))

(def-foreign-routine ("Mix_QuickLoad_WAV" quick-load-wav)
    chunk*
  (mem (* uint8)))

(def-foreign-routine ("Mix_QuickLoad_RAW" quick-load-raw)
    chunk*
  (mem (* uint8)))

(def-foreign-routine ("Mix_VolumeChunk" volume-chunk)
    int
  (chunk chunk*)
  (volume int))

(def-foreign-routine ("Mix_FreeChunk" free-chunk)
    void
  (chunk chunk*))

(def-foreign-routine ("Mix_AllocateChannels" allocate-channels)
    int
  (numchans int))

(def-foreign-routine ("Mix_Volume" volume)
    int
  (channel int)
  (vol int))

#+nil
(def-foreign-routine ("play_channel" play-channel) int
  (channel int)
  (chunk chunk*)
  (loops int))

(defun play-channel (channel chunk loops)
  (play-channel-timed channel chunk loops -1))
(export '(play-channel))

(def-foreign-routine ("Mix_PlayChannelTimed" play-channel-timed)
    int
  (channel int)
  (chunk chunk*)
  (loops int)
  (ticks int))

(def-foreign-routine ("Mix_FadeInChannelTimed" fade-in-channel-timed)
    int
  (channel int)
  (chunk chunk*)
  (loops int)
  (ms int)
  (ticks int))

(declaim (inline fade-in-channel))
(defun fade-in-channel (channel chunk loops ms)
  (fade-in-channel-timed channel chunk loops ms -1))

(def-foreign-routine ("Mix_Pause" pause)
    void
  (channel int))

(def-foreign-routine ("Mix_Resume" resume)
    void
  (channel int))

(def-foreign-routine ("Mix_HaltChannel" halt-channel)
    int
  (channel int))

(def-foreign-routine ("Mix_ExpireChannel" expire-channel)
    int
  (channel int)
  (ticks int))

(def-foreign-routine ("Mix_FadeOutChannel" fade-out-channel)
    int
  (which int)
  (ms int))

;; channel-finished

(def-foreign-routine ("Mix_Playing" playing)
    int
  (channel int))

(def-foreign-routine ("Mix_Paused" paused)
    int
  (channel int))

(def-foreign-routine ("Mix_FadingChannel" fading-channel)
    fading
  (which int))

(def-foreign-routine ("Mix_GetChunk" get-chunk)
    chunk*)

;; Groups

(def-foreign-routine ("Mix_ReserveChannels" reserve-channels)
    int
  (num int))

(def-foreign-routine ("Mix_GroupChannel" group-channel)
    int
  (which int)
  (tag int))

(def-foreign-routine ("Mix_GroupCount" group-count)
    int
  (tag int))

(def-foreign-routine ("Mix_GroupAvailable" group-available)
    int
  (tag int))

(def-foreign-routine ("Mix_GroupOldest" group-oldest)
    int
  (tag int))

(def-foreign-routine ("Mix_GroupNewer" group-newer)
    int
  (tag int))

(def-foreign-routine ("Mix_FadeOutGroup" fade-out-group)
    int
  (tag int)
  (ms int))

(def-foreign-routine ("Mix_HaltGroup" halt-group)
    int
  (tag int))

;; Music

(def-foreign-routine ("Mix_LoadMUS" load-mus)
    music*
  (file c-string))

(def-foreign-routine ("Mix_FreeMusic" free-music)
    void
  (music music*))

(def-foreign-routine ("Mix_PlayMusic" play-music)
    int
  (music music*)
  (loops int))

(def-foreign-routine ("Mix_FadeInMusic" fade-in-music)
    int
  (music music*)
  (loops int)
  (ms int))

(def-foreign-routine ("Mix_FadeInMusicPos" fade-in-music-pos)
    int
  (music music*)
  (loops int)
  (ms int)
  (position dfloat))

;; hook-music

(def-foreign-routine ("Mix_VolumeMusic" volume-music)
    int
  (volume int))

(def-foreign-routine ("Mix_PauseMusic" pause-music)
    void)

(def-foreign-routine ("Mix_ResumeMusic" resume-music)
    void)

(def-foreign-routine ("Mix_RewindMusic" rewind-music)
    void)

(def-foreign-routine ("Mix_SetMusicPosition" set-music-position)
    int
  (position dfloat))

(def-foreign-routine ("Mix_SetMusicCMD" set-music-cmd)
    int
  (cmd c-string))

(def-foreign-routine ("Mix_HaltMusic" halt-music)
    int)

(def-foreign-routine ("Mix_FadeOutMusic" fade-out-music)
    int
  (ms int))

;; hook-music-finished

(def-foreign-routine ("Mix_GetMusicType" get-music-type)
    music-type
  (music music*))

(def-foreign-routine ("Mix_PlayingMusic" playing-music)
    int)

(def-foreign-routine ("Mix_PausedMusic" paused-music)
    int)

(def-foreign-routine ("Mix_FadingMusic" fading-music)
    fading)

(def-foreign-routine ("Mix_GetMusicHookData" get-music-hook-data)
    (* void))

;; Effects

;; register-effect
;; unregister-effect

(def-foreign-routine ("Mix_UnregisterAllEffects" unregister-all-effects)
    int
  (channel int))

;; set-post-mix

(def-foreign-routine ("Mix_SetPanning" set-panning)
    int
  (channel int)
  (left uint8)
  (right uint8))

(def-foreign-routine ("Mix_SetDistance" set-distance)
    int
  (channel int)
  (distance uint8))

(def-foreign-routine ("Mix_SetPosition" set-position)
    int
  (channel int)
  (angle sint16)
  (distance uint8))

(def-foreign-routine ("Mix_SetReverseStereo" set-reverse-stereo)
    int
  (channel int)
  (flip int))

