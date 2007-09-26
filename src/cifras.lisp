(in-package #:rameau)

;; (cifra->acorde 'Cm7.9b.13/Eb)
;; (cifra->acorde 'C#m7/G#)
;; (parse-acrescimos "7.9b")

(defun parse-acrescimos (cifra)
  ;; por enquanto só funciona com acordes simples, como Cm7
  (when cifra
    (parse-integer (first (cl-ppcre:split "\\." cifra)))))

(defun %codigo-nota (nota)
  (note->code (string-downcase nota)))

(defun latin->lily (nota)
  "Aceita uma string com o nome da nota em latin e retorna a
representação do lilypond. Exemplo: (latin->lily \"Eb\") => \"ees\""
  (print-note (code->note (%codigo-nota nota)) 'lily))

(defun get-modo (abrev)
  (case (string->symbol abrev)
    (m 'min)
    (o 'dim)
    (+ 'aug)
    (t 'maj)))

(defun parse-acorde (acorde)
  (when acorde
    (string->symbol (latin->lily acorde))))

(defun qual-inversao? (acorde baixo)
  (print baixo)
  (let ((inversao (first (interval->code (interval (%codigo-nota baixo)
                                                   (%codigo-nota acorde))))))
    (print inversao)
    (case inversao
      (1 0)
      (3 1)
      (5 2)
      (7 3)
      (t (if (null inversao)
             0
             inversao)))))

(defun cifra->acorde (cifra)
  (cl-ppcre:register-groups-bind (acorde modo acrescimos baixo)
      ("([cdefgab]+[#b]?)(m|o)?([0-9.Mb\\+]+)?/?([cdefgab]+[#b]?)"
       (symbol->string cifra) :sharedp t)
    (list (parse-acorde acorde)
          (get-modo modo)
          (qual-inversao? acorde baixo)
          (parse-acrescimos acrescimos))))

(loop for acorde in '(G G C/E (C7/E) D/F G BM/D (BM7/D) EM C C7/B F#O/A G D
                      G D/F# E7/G F#O/A G/B AM7/C D (D7) G
                      G G AM G/B G/B G/B D7/A G D
                      EM EM BM/D AM/C G/B D7 G G/B G7 C
                      G D/F# (D7/F#) G F#O7/A G/B G D (D7) EM C G D
                      G D/F# C/E EM (EM7/D) AM7/C D7 (D7/C) G)
     when (atom acorde)
     collect acorde)

(cifra->acorde 'G)
