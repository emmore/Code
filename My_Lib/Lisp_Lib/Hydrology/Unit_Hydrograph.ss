(define (S_Curve UH T Tg)
	(define (nUH)
	 (define (zeros x)
	  (if (= x 0)
	   '()
	   (cons 0 (zeros (- x 1)))))
	 (let ((res (remainder (length UH) T)))
	  (if (= res 0)
		UH
		(append UH (zeros (- T res))))))

	(define (firstN lis n)
	 (if (= n 0)
	  '()
	  (cons (car lis) (firstN (cdr lis) (- n 1)))))
	(define (restN lis n)
	 (if (= n 0)
	  lis
	  (restN (cdr lis) (- n 1))))

	(define (Add a b)
	  (append (map + a (firstN b (length a))) (restN b (length a))))
	
	(define (S)
		(define (S_Generator lis)
			(let ((first (firstN lis T))
				  (rest  (restN  lis T)))
			(if (null? rest)
				first
				(append first (S_Generator (Add first rest))))))
		(S_Generator (nUH)))

	(map (lambda(x) (/ (* x T) Tg)) (append (firstN (S) Tg) (map - (restN  (S) Tg) (firstN (S) (- (length (S)) Tg))))))
