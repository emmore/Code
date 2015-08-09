(define (stream-ref s n)
 (if (= n 0)
  (car s)
  (stream-ref ((cdr s)) (- n 1))))

(define (stream-map proc s)
 (if (null? s)
  '()
  (cons (proc (car s))  (delay (stream-map proc ((cdr s)))))))

(define (stream-for-each proc s)
 (if (null? s)
	'done
	(begin (proc (car s))
		   (stream-for-each proc ((cdr s))))))

(define (stream-filter pred stream)
 (cond ((null? stream) '())
	   ((pred (car stream)) (cons (car stream) (delay (stream-filter pred ((cdr stream))))))
	   (else (stream-filter pred ((cdr stream))))))
		


