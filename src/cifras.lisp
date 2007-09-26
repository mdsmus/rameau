(in-package #:rameau)

cifra pode ser no formatos:

Ab7
Ab7/Eb
Ab/Eb
Am7/Eb
C9, C11, C6, C7M, C6(9), C7M(9), C7M(6)
Cm9, Cm11, Cmb6, Cm6, Cm7, Cm7M
C7, C7(9), C7(b13), C7(13), C7(4/9)
C+5
C7M
C7b
C7/9
C13b
C13+
C5+

(defun parse-acrescimos (cifra)
  (cl-ppcre:split "\\." cifra))

(parse-acrescimos "7.9b")

(defun cifra->acorde (cifra)
  (cl-ppcre:register-groups-bind (acorde acidente modo acrescimos baixo acc2)
      ("(c|d|e|f|g|a|b)(#|b)*(m|o)?([0-9.Mb\\+]+)?/?(c|d|e|f|g|a|b)?(#|b)*" (string-downcase (symbol-name cifra)) :sharedp t)
    (list acorde acidente modo (parse-acrescimos acrescimos) baixo acc2)))

(cifra->acorde 'cm[7+/5+]/e)
(cifra->acorde 'cm.b7.9.13b/e)
(cifra->acorde 'cm7.9b.13/e)

    (remove-if #'null
               (list
                (nota-lily acorde acidente)
                (get-modo modo)
                (if baixo
                    (get-inversao-pop (mod6 (- (cons-nota acorde acidente) (cons-nota baixo acc2))))
                    0)
                (when setima (parse-integer setima))))))