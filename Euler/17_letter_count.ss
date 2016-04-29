(define (pronounce  x)
	(cond
		((= x 1)  "one")
		((= x 2)  "two")
		((= x 3)  "three")
		((= x 4)  "four")
		((= x 5)  "five")
		((= x 6)  "six")
		((= x 7)  "seven")
		((= x 8)  "eight")
		((= x 9)  "nine")
		((= x 10)  "ten")
		((= x 11)  "eleven")
		((= x 12)  "twelve")
		((= x 13)  "thirteen")
		((= x 14) "fourteen")
		((= x 15)  "fifteen")
		((= x 16)  "sixteen")
		((= x 17)  "seventeen")
		((= x 18)  "eighteen")
		((= x 19)  "ninteen")
		((= x 20)  "twenty")))
"twenty"
"thirty"
"forty"
"fifty"
"sixty"
"seventy"
"eighty"
"ninty"
"hundred"
"thousand"
"and"

(define (seperate x)
  (if (< x 10)
	(list x)
	(cons (mod x 10)
	      (seperate (/  (- x (mod x 10)) 10)))))

(define (speak sequence)
  (cond ((= (length sequence) 1)
		 (let ((x (car sequence)))
			(cond
				((= x 0)  "")
				((= x 1)  "one")
				((= x 2)  "two")
				((= x 3)  "three")
				((= x 4)  "four")
				((= x 5)  "five")
				((=	x 6)  "six")
				((= x 7)  "seven")
				((= x 8)  "eight")
				((= x 9)  "nine"))))
		((= (length sequence) 2)
		 (if (= (car (cdr sequence)) 1)
				(let ((x (car sequence)))
					(cond
						((= x 0)  "ten")
						((= x 1)  "eleven")
						((= x 2)  "twelve")
						((= x 3)  "thirteen")
						((= x 4)  "fourteen")
						((= x 5)  "fifteen")
						((=	x 6)  "sixteen")
						((= x 7)  "seventeen")
						((= x 8)  "eighteen")
						((= x 9)  "nineteen")))
			  (let ((x (car sequence))
					(y (car (cdr sequence))))
			   (cond 
				((= y 0) (speak (list x)))
				((= y 2) (string-append "twenty" (speak (list x))))
				((= y 3) (string-append "thirty" (speak (list x))))
				((= y 4) (string-append "forty" (speak (list x))))
				((= y 5) (string-append "fifty" (speak (list x))))
				((= y 6) (string-append "sixty" (speak (list x))))
				((= y 7) (string-append "seventy" (speak (list x))))
				((= y 8) (string-append "eighty" (speak (list x))))
				((= y 9) (string-append "ninety" (speak (list x))))))))
		 ((= (length sequence) 3)
		  (let ((y (car (cddr sequence))))
		   (string-append (speak (list y)) "hundredand" (speak (list (car sequence) (car (cdr sequence)))))))
		 ((= (length sequence) 4) "onethousand")))
