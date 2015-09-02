 (define (factal x)
  (if (= x 1) 1 (* x (factal (- x 1)))))
 (define (sum x)
  (if (=  (remainder x 10) x) 
   (factal x)
   (+ (factal (remainder x 10))  (sum (floor (/ x 10))))))
(define (curious? x)
 (= x (sum x)))

(define (N a b)
 (if (> a b) 
  '()
  (cons a (N (+ a 1) b))))


