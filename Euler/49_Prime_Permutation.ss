(define (Random_Select seq n)
 (cond ((= (length seq) n) seq)
	   ((< (length seq) n) '())
	   ((= n 0) '())
	   ((= n 1) (map (lambda(x) (list x)) seq))
	   (else 
		(append 
		 (map (lambda(x) (cons (car seq) x)) (Random_Select (cdr seq) (- n 1)))
		 (Random_Select (cdr seq) n)))))
