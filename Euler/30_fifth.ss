(define (enumerate a b)
 (if (> a b)
  '()
  (cons a (enumerate (+ a 1) b))))

(define (digit_depart x)
 (if (= x 0)
  '()
  (cons (mod x 10)
   (digit_depart (/ (- x (mod x 10)) 10)))))

(define (fifth? x)
 (define (functional_accumulate function seq)
  (if (null? seq)
   0
   (+ (function (car seq)) (functional_accumulate function (cdr seq)))))
 (= (functional_accumulate (lambda(x) (expt x 5)) (digit_depart x)) x))


(define (test_accumulate test seq)
 (cond ((null? seq) 0)
       ((test (car seq)) (+ (car seq) (test_accumulate test (cdr seq))))
	   (else (test_accumulate test (cdr seq)))))

(define result (test_accumulate fifth? (enumerate 2 99999)))

(define (filt test seq)
 (cond ((null? seq) '())
       ((test (car seq)) (cons (car seq) (filt test (cdr seq))))
	   (else (filt test (cdr seq)))))

(define ss (filt fifth? (enumerate 2 9999999)))
