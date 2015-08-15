(define (Fib a b N)
 (cond ((= N 0) '())
       (cons a (Fib	b (+ a b) (- N 1)))))
