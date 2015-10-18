(load "prime.ss")
(define (Random_Select seq n)
 (cond ((= (length seq) n) (list seq))
       ((< (length seq) n) '())
	   ((= n 1) (map (lambda(x) (list x)) seq))
	   (else 
		(append 
		 (map (lambda(x) (cons (car seq) x)) (Random_Select (cdr seq) (- n 1)))
		 (Random_Select (cdr seq) n)))))

(define (permute lst)
 (define (removee ele seq)
  (if (= ele (car seq))
   (cdr seq)
   (cons (car seq) (removee ele (cdr seq)))))
 (cond ((= (length lst) 1) (list lst))
	   (else (apply append (map (lambda (i) (map (lambda (j) (cons i j)) (permute (removee i lst)))) lst)))))

(define (primes x)
 (define (PP? x)
  (prime? (+ (* 1000 (car x)) (* 100 (cadr x)) (* 10 (caddr x)) (cadddr x))))
 (if (null? x) 
  0
  (if (PP? (car x))
   (+ 1 (primes (cdr x)))
   (primes (cdr x)))))


(define (number x)
  (+ (* 1000 (car x)) (* 100 (cadr x)) (* 10 (caddr x)) (cadddr x)))

 (define (PP? x)
  (prime? (+ (* 1000 (car x)) (* 100 (cadr x)) (* 10 (caddr x)) (cadddr x))))

(define qq
 (filter (lambda(x) (> (primes x) 2)) (map (lambda(x) (permute x)) (Random_Select (list 1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9) 4))))

(define qqq
 (map (lambda(x) (filter PP? x)) qq))

(define qqqq (map (lambda(x) (map (lambda(y) (number y)) x)) qqq))

(define qqqqq (map (lambda(x) (Random_Select x 3)) qqqq))

(define (equaldiff? x)
 (= (- (car x) (cadr x)) (- (cadr x) (caddr x))))

(define qqqqqq (map (lambda(x) (filter equaldiff? x)) qqqqq))
