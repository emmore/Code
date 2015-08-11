(define (C a b)
 (define (multi_iter x y)
  (if (= x y)  1
   (* x (multi_iter (- x 1) y))))
 (/ (multi_iter a b) (multi_iter b 1)))
