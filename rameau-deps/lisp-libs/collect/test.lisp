(defun f0()
  (collect sum (x) 
    (step x 1 (< x 1000000) (1+ x))))

(defun f1()
  (let ((a 0)) 
    (dotimes (i 1000000 ) 
      (incf a i)) a))

(defun g0(l)
  (map 'list #'(lambda (x) (* x x))
       l))

(defun g1 ( l)
  (collect list ((* x x))
    (in x l)))

(defun h0 ()
  (dotimes (i 100000)
    (g0 '(1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 ))))

(defun h1 ()
  (dotimes (i 100000)
    (g1 '(1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 ))))
