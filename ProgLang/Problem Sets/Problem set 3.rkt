#lang racket
;---------------Question 1 ---------------------;
;Construct (4 (7 22) “art” (“math” (8) 99) 100);
(cons(cons 4 (cons (cons 7 '(22))'()))
     (cons "art"
           (cons (cons "math" (cons '(8)(cons 99 '())))'(100))))

;---------------Question 2 ---------------------;
