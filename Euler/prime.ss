;; all about primes 
(define (prime? x)
 (define (else_test i)
  (if (> (* i i) x)
	  #t
      (and (> (remainder x i) 0)
	       (> (remainder x (+ i 2)) 0)
		   (else_test (+ i 6)))))
 (cond ((<= x 1)  #f)
       ((<= x 3)  #t)
	   ((or (= (remainder x 2) 0)
		    (= (remainder x 3) 0))
		 #f)
	   (else (else_test 5))))

(define prime_sequence
 
