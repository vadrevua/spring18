#lang racket
; ------------------- Question 1 --------------------- ;
;(define (addTA L)
;(let([f (future ( lambda () (addTA L '())))])
;map (lambda (s) (string-append "TA" s))))
;(addTA '("cat" "in" 7 "the" 6 "hat"))

; ------------------- Question 2 --------------------- ;
(define thread1(thread (lambda()
                         (for([i 100])
                           (printf "thread1 ran ~a~n" i)))))
(define thread2(thread (lambda()
                         (for([i 100])
                           (printf "thread2 ran ~a~n" i)))))
(define thread3(thread (lambda()
                         (for([i 100])
                           (printf "thread3 ran ~a~n" i)))))
(thread-wait thread1)
(thread-wait thread2)
(thread-wait thread3)