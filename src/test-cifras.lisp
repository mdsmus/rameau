(in-package #:rameau)
(use-package :lisp-unit)

(define-test pop2cifra
  (assert-equal '(* 2 (("fis" "dim" 3) ("fis" "dim" 3 "7-"))) (pop2cifra 'f#°/a--7))
  (assert-equal '(* 2 (("c" "maj" 0) ("c" "maj" 0 "7"))) (pop2cifra 'c--7))
  (assert-equal (format nil "(c maj 0)~%(c maj 3 7)") (pop2cifra 'c__7))
  (assert-equal (format nil "(c maj 0)~%(c maj 0 7)") (pop2cifra 'c==7))
  (assert-equal  '(* 2 (("c" "maj" 0) ("c" "maj" 3 "7"))) (pop2cifra 'c_-7)))

(define-test parse-acrescimos
  (assert-equal "7m" (parse-acrescimos "7m.13b"))
  (assert-equal "7" (parse-acrescimos "7.9"))
  (assert-equal "7" (parse-acrescimos "7")))

(define-test get-modo
  (assert-equal '("dim" 7-) (multiple-value-list (get-modo '°)))
  (assert-equal '("dim" 7) (multiple-value-list (get-modo 'ø)))
  (assert-equal "dim" (get-modo 'ø))
  (assert-equal "dim" (get-modo '°))
  (assert-equal "min" (get-modo 'm)))

(define-test parse-fundamental
  (assert-equal "c" (parse-fundamental "c"))
  (assert-equal "des" (parse-fundamental "db"))
  (assert-equal "cis" (parse-fundamental "c#")))

(define-test %chord-interval-code
  (assert-equal '(7 min) (%chord-interval-code "c" "bes"))
  (assert-equal '(2 maj) (%chord-interval-code "c" "d")))

(define-test qual-inversao?
  (assert-equal 1 (qual-inversao? "aes" "ces"))
  (assert-equal 2 (qual-inversao? "cis" "gis"))
  (assert-equal 1 (qual-inversao? "ces" "ees"))
  (assert-equal 0 (qual-inversao? "c" nil))
  (assert-equal 1 (qual-inversao? "c" "ees"))
  (assert-equal 3 (qual-inversao? "c" "bes")))

(define-test qual-intervalo-no-baixo?
  (assert-equal 7 (qual-intervalo-no-baixo? 3))
  (assert-equal 5 (qual-intervalo-no-baixo? 2))
  (assert-equal 3 (qual-intervalo-no-baixo? 1))
  (assert-equal 1 (qual-intervalo-no-baixo? 0)))

(define-test cifra->acorde
  (assert-equal '("des" "min" 1 "7") (cifra->acorde "dbm7/fb"))
  (assert-equal '("c" "maj" 0 "7m") (cifra->acorde "c7m")))


(define-test get-intervalo-inversao-pop
  (assert-equal 55 (get-intervalo-inversao-pop 'min 2))
  (assert-equal 55 (get-intervalo-inversao-pop 'maj 2))
  (assert-equal 42 (get-intervalo-inversao-pop 'aug 2))
  (assert-equal 54 (get-intervalo-inversao-pop 'dim 2))
  (assert-equal 27 (get-intervalo-inversao-pop 'dim 1))
  (assert-equal 27 (get-intervalo-inversao-pop 'min 1))
  (assert-equal 28 (get-intervalo-inversao-pop 'maj 1)))

(define-test get-inversao-pop
  (assert-equal "gb" (get-inversao-pop "aes" 'min 3))
  (assert-equal "cb" (get-inversao-pop "aes" 'min 1))
  (assert-equal nil (get-inversao-pop "c" 'maj 0))
  (assert-equal "e" (get-inversao-pop "c" 'maj 1))
  (assert-equal "eb" (get-inversao-pop "c" 'min 1)))

(define-test acorde->cifra
  (assert-equal "Abø7/Cb" (acorde->cifra '("ab" dim 1 "7")))
  (assert-equal "Abø7/Gb" (acorde->cifra '("ab" dim 3 "7")))
  (assert-equal "Abø7/Ebb" (acorde->cifra '("ab" dim 2 "7")))
  (assert-equal "Ab°7/Ebb" (acorde->cifra '("ab" dim 2 "7d")))
  (assert-equal "Ab°7" (acorde->cifra '("ab" dim "7d")))
  (assert-equal "Abm7m/G" (acorde->cifra '("ab" min 3 "7m")))
  (assert-equal "Abm7/Gb" (acorde->cifra '("ab" min 3 "7")))
  (assert-equal "Cm7/Eb" (acorde->cifra '("c" min 1 "7")))
  (assert-equal "Cm7" (acorde->cifra '("c" min 7)))
  (assert-equal "Cm" (acorde->cifra '("c" min))))
