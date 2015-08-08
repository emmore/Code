(define (Palindromic n)
 (if (< n 10)
     (list n)
	 (cons (mod n 10) (Palindromic (floor (/ n 10))))))
