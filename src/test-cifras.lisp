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
  (assert-equal "B°" (acorde->cifra '("b" dim)))
  (assert-equal "B°" (acorde->cifra '("b" dim 0)))
  (assert-equal "B°/d" (acorde->cifra '("b" dim 1)))
  (assert-equal "B°/f" (acorde->cifra '("b" dim 2)))
  (assert-equal "B°7" (acorde->cifra '("b" dim "7d")))
  (assert-equal "B°7" (acorde->cifra '("b" dim 0 "7d")))
  (assert-equal "B°7/D" (acorde->cifra '("b" dim 1 "7d")))
  (assert-equal "B°7/F" (acorde->cifra '("b" dim 2 "7d")))
  (assert-equal "B°7/Ab" (acorde->cifra '("b" dim 3 "7d")))
  (assert-equal "Bø7" (acorde->cifra '("b" dim "7")))
  (assert-equal "Bø7" (acorde->cifra '("b" dim 0 "7")))
  (assert-equal "Bø7/D" (acorde->cifra '("b" dim 1 "7")))
  (assert-equal "Bø7/F" (acorde->cifra '("b" dim 2 "7")))
  (assert-equal "Bø7/A" (acorde->cifra '("b" dim 3 "7")))
  (assert-equal "C" (acorde->cifra '("c" maj)))
  (assert-equal "C" (acorde->cifra '("c" maj 0)))
  (assert-equal "C/E" (acorde->cifra '("c" maj 1)))
  (assert-equal "C/G" (acorde->cifra '("c" maj 2)))
  (assert-equal "C7m" (acorde->cifra '("c" maj "7m")))
  (assert-equal "C7m" (acorde->cifra '("c" maj 0 "7m")))
  (assert-equal "C7m/E" (acorde->cifra '("c" maj 1 "7m")))
  (assert-equal "C7m/G" (acorde->cifra '("c" maj 2 "7m")))
  (assert-equal "C7m/B" (acorde->cifra '("c" maj 3 "7m")))
  (assert-equal "C7" (acorde->cifra '("c" maj "7")))
  (assert-equal "C7" (acorde->cifra '("c" maj 0 "7")))
  (assert-equal "C7/E" (acorde->cifra '("c" maj 1 "7")))
  (assert-equal "C7/G" (acorde->cifra '("c" maj 2 "7")))
  (assert-equal "C7/Bb" (acorde->cifra '("c" maj 3 "7")))
  (assert-equal "Cm" (acorde->cifra '("c" min)))
  (assert-equal "Cm" (acorde->cifra '("c" min 0)))
  (assert-equal "Cm/Eb" (acorde->cifra '("c" min 1)))
  (assert-equal "Cm/G" (acorde->cifra '("c" min 2)))
  (assert-equal "Cm7m" (acorde->cifra '("c" min "7m")))
  (assert-equal "Cm7m" (acorde->cifra '("c" min 0 "7m")))
  (assert-equal "Cm7m/Eb" (acorde->cifra '("c" min 1 "7m")))
  (assert-equal "Cm7m/G" (acorde->cifra '("c" min 2 "7m")))
  (assert-equal "Cm7m/B" (acorde->cifra '("c" min 3 "7m")))
  (assert-equal "Cm7" (acorde->cifra '("c" min "7")))
  (assert-equal "Cm7" (acorde->cifra '("c" min 0 "7")))
  (assert-equal "Cm7/Eb" (acorde->cifra '("c" min 1 "7")))
  (assert-equal "Cm7/G" (acorde->cifra '("c" min 2 "7")))
  (assert-equal "Cm7/Bb" (acorde->cifra '("c" min 3 "7")))
  (assert-equal "C+" (acorde->cifra '("c" aug)))
  (assert-equal "C+" (acorde->cifra '("c" aug 0)))
  (assert-equal "C+/E" (acorde->cifra '("c" aug 1)))
  (assert-equal "C+/G#" (acorde->cifra '("c" aug 2)))
  (assert-equal "C+7m" (acorde->cifra '("c" aug "7m")))
  (assert-equal "C+7m" (acorde->cifra '("c" aug 0 "7m")))
  (assert-equal "C+7m/E" (acorde->cifra '("c" aug 1 "7m")))
  (assert-equal "C+7m/G#" (acorde->cifra '("c" aug 2 "7m")))
  (assert-equal "C+7m/B" (acorde->cifra '("c" aug 3 "7m")))
  (assert-equal "C+7" (acorde->cifra '("c" aug "7")))
  (assert-equal "C+7" (acorde->cifra '("c" aug 0 "7")))
  (assert-equal "C+7/E" (acorde->cifra '("c" aug 1 "7")))
  (assert-equal "C+7/G#" (acorde->cifra '("c" aug 2 "7")))
  (assert-equal "C+7/Bb" (acorde->cifra '("c" aug 3 "7")))
  (assert-equal "C°" (acorde->cifra '("c" dim)))
  (assert-equal "C°" (acorde->cifra '("c" dim 0)))
  (assert-equal "C°/Eb" (acorde->cifra '("c" dim 1)))
  (assert-equal "C°/Gb" (acorde->cifra '("c" dim 2)))
  (assert-equal "C°7" (acorde->cifra '("c" dim "7d")))
  (assert-equal "C°7" (acorde->cifra '("c" dim 0 "7d")))
  (assert-equal "C°7/Eb" (acorde->cifra '("c" dim 1 "7d")))
  (assert-equal "C°7/Gb" (acorde->cifra '("c" dim 2 "7d")))
  (assert-equal "C°7/Bbb" (acorde->cifra '("c" dim 3 "7d")))
  (assert-equal "Cø7" (acorde->cifra '("c" dim "7")))
  (assert-equal "Cø7" (acorde->cifra '("c" dim 0 "7")))
  (assert-equal "Cø7/Eb" (acorde->cifra '("c" dim 1 "7")))
  (assert-equal "Cø7/Gb" (acorde->cifra '("c" dim 2 "7")))
  (assert-equal "Cø7/Bb" (acorde->cifra '("c" dim 3 "7"))))

(define-test expande-cifra-setima
  (assert-equal '(* 2 (("c" "maj" 0) ("c" "maj" 0 "7m"))) (expande-cifra-setima '("c" "7m"))))

(define-test setima-no-baixo
  (assert-equal '("c" "maj" 3 "7") (setima-no-baixo '("c" "maj" 1) "7")))

(define-test processa-cifra
  (assert-equal '("c" "min" 1 "7m") (processa-cifra 'cm7m/eb))
  (assert-equal '("c" "maj" 0) (processa-cifra 'c)))

(define-test expande-cifra-setima-baixo
  (assert-equal "(c min 0)
(c min 3 7)" (expande-cifra-setima-baixo '("c" "min"))))

(define-test expande-cifra-super-setima-baixo
  (assert-equal '(* 2 (("c" "maj" 0) ("c" "maj" 3 "maj"))) (expande-cifra-super-setima-baixo '("c" "maj"))))

(define-test expande-cifra-super-setima
  (assert-equal "(c maj 0)
(c maj 3 7)" (expande-cifra-setima-baixo '("c" "maj"))))

(define-test multiplica-cifra
  (assert-equal '(* 2 ("c" "maj" 0)) (multiplica-cifra '("c" 2))))

(define-test expande-cifra-sexta-aumentada
  (assert-equal '("c" "it" 0) (expande-cifra-sexta-aumentada '("c" "it"))))