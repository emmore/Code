(define coins (list 1 2 5 10 20 50 100 200))
(define (coin_sum sum lis)
  (cond	
        ((equal? sum 0) 1)
        ((null? lis) 0)
        ((< sum (car lis)) 0)
		(else (+ (coin_sum (- sum (car lis)) lis)
			    (coin_sum sum (cdr lis))))))
