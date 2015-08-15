(define (Sum_Divisors n)
 (define (sum_divisor x n)
   (cond ((= (* x x) n) x)
         ((> (* x x) n) 0)
         ((= 0 (mod n x)) (+ x (/ n x) (sum_divisor (+ x 1) n)))
		 (else (sum_divisor (+ x 1) n))))
 (+ (sum_divisor 2 n) 1))

(define (Amicable? x)
 (and (= x (Sum_Divisors (Sum_Divisors x))) (not (= x (Sum_Divisors x)))))

(define (enumerate a b)
 (cond ((> a b) '())
       (else (cons a (enumerate (+ a 1) b )))))

(define (Conditional_Accumulate condition lis)
 (cond ((null? lis) 0)
       ((condition (car lis)) (+ (car lis) (Conditional_Accumulate condition (cdr lis))))
	   (else (Conditional_Accumulate condition (cdr lis)))))

(define (Abundant? x)
 (> (Sum_Divisors x) x))
(define (Deficient? x)
 (< (Sum_Divisors x) x))

(define q (filter Abundant? (enumerate 1 28123)))

(define (Two_Abundances q)
 (let ((ele (car q)))
  (cond ((> (+ ele (cadr q)) 28123) 0)
        ((> ele (/ 28123 2))  0)
		(

