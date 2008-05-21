(in-package :rameau)

(enable-sharp-l-syntax)

(defparameter *cadence-templates* '(; maiores:
                                    (3 6 (4 2) (7 5) 1)
                                    (7 1) ; representa iii -> IV e V -> vi
                                    (4 1)
                                    ; menores:
                                    (7 3 6 (4 2) (7 5) 1)))


;;; Listar todas e agrupar, estilo jumps.