(define (Length_of_Recurring_Cycle x)
 (define n 0)
 (define Recurring_Cycle 
  (let ((numer (floor (/ 10 x))))
   (cons numer (- 10 (* x numer)))))
 (define Sequence (list Recurring_Cycle))

 (define (in? element sequence)
  (or (equal? element (car sequence)) (in? element (cdr sequence))))


