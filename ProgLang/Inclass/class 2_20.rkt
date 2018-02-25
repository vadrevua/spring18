#lang racket
;Classwork 2/20

;q1
;(cons 5(cons 6(cons(cons 3(cons 4 '())))(cons 7(cons 8 '()))))

;q2
(define (cubeList L)
  (if (null? L)
  '()
  (cons(* (car L) (car L) (car L)) (cubeList (cdr L)))))

(cubeList '(2 3 4 5))

;With tail recursion
(define (tailCube L R)
  (if(null? L) R 
    (tailCube (cdr L)
              (append R (list (*(car L) (car L) (car L)))))))

(tailCube '(2 3 4)'())

;generic solution
;define function
;(cons f(car L))(doFunction f (cdr L))))))
;define cube
;(doFunction cube '(2 3 4 5 6 7))

;problem 5
(define (multiply L R)
  (if (null? L) '()
      (multiply ((* (car L) R )))))

(multiply '(2 3) 2)