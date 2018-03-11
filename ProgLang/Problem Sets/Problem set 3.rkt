#lang racket
;---------------Question 1 ---------------------;
;Construct (4 (7 22) “art” (“math” (8) 99) 100);
(cons(cons 4 (cons (cons 7 '(22))'()))
     (cons "art"
           (cons (cons "math" (cons '(8)(cons 99 '())))'(100))))
(list '(4(7 22) "art" ("math" (8) 99) 100))

;---------------Question 2 ---------------------;
;(define q (lambda (func L)
;            (if (null? L) L
;            (q func;;

;---------------Question 3 ---------------------;


;---------------Question 4 ---------------------;
(define sum (lambda (L)
              (if(null? L) 0
                 (+ (car L) (sum (cdr L))))))
(define avg (lambda (L number)
              (if(= number 0) 0
                 (/(sum L) number))))
;(avg '(1 2 3) 3)


;---------------Question 5 ---------------------;