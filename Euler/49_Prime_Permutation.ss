(define (Random_Select seq n)
 (cond ((= (length seq) n) (list seq))
       ((< (length seq) n) '())
	   ((= n 1) (map (lambda(x) (list x)) seq))
	   (else 
		(append 
		 (map (lambda(x) (cons (car seq) x)) (Random_Select (cdr seq) (- n 1)))
		 (Random_Select (cdr seq) n)))))
