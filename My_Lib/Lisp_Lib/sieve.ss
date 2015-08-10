(define (sieve stream)
 (cons (car stream)
       (delay (sieve (stream-filter (lambda(x) (not (= 0 (mod x (car stream)))))  (force (cdr stream)))))))

(define (integers-from n)
 (cons n (delay (integers-from (+ n 1)))))
