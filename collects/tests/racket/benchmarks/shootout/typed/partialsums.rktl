;; ---------------------------------------------------------------------
;; The Great Computer Language Shootout
;; http://shootout.alioth.debian.org/
;;
;; Based on D language implementation by Dave Fladebo [imperative version]
;;
;; Derived from the Chicken variant, which was
;; Contributed by Anthony Borla
;; ---------------------------------------------------------------------

(require scheme/cmdline)
(require scheme/flonum)

(let ((n (exact->inexact (assert (string->number (command-line #:args (n) (assert n string?)))))))
  
  (let: loop : Void
        ([d : Float 0.0]
         (alt : Float 1.0) (d2 : Float 0.0) (d3 : Float 0.0)
         (ds : Float 0.0) (dc : Float 0.0)
         (s0 : Float 0.0) (s1 : Float 0.0) (s2 : Float 0.0)
         (s3 : Float 0.0) (s4 : Float 0.0) (s5 : Float 0.0)
         (s6 : Float 0.0) (s7 : Float 0.0) (s8 : Float 0.0))
    (if (= d n)
        (let ([format-result
               (lambda: ((str : String) (n : Float))
                 (printf str (real->decimal-string n 9)))])
          
          (format-result "~a\t(2/3)^k\n" s0)
          (format-result "~a\tk^-0.5\n" s1)
          (format-result "~a\t1/k(k+1)\n" s2)
          (format-result "~a\tFlint Hills\n" s3)
          (format-result "~a\tCookson Hills\n" s4)
          (format-result "~a\tHarmonic\n" s5)
          (format-result "~a\tRiemann Zeta\n" s6)
          (format-result "~a\tAlternating Harmonic\n" s7)
          (format-result "~a\tGregory\n" s8))
        
        (let*: ((d : Float (+ d 1))
                (d2 : Float (* d d))
                (d3 : Float (* d2 d))
                (ds : Float (sin d))
                (dc : Float (cos d))
                
                (s0 : Float (+ s0 (assert (expt (/ 2.0 3) (- d 1)) real?)))
                (s1 : Float (+ s1 (/ 1 (flsqrt d))))
                (s2 : Float (+ s2 (/ 1 (* d (+ d 1)))))
                (s3 : Float (+ s3 (/ 1 (* d3 (* ds ds)))))
                (s4 : Float (+ s4 (/ 1 (* d3 (* dc dc)))))
                (s5 : Float (+ s5 (/ 1 d)))
                (s6 : Float (+ s6 (/ 1 d2)))
                (s7 : Float (+ s7 (/ alt d)))
                (s8 : Float (+ s8 (/ alt (- (* 2 d) 1))))
                (alt : Float (- alt)))
          
	  (loop d
		alt d2 d3 ds dc
		s0 s1 s2 s3 s4 s5 s6 s7 s8)))))
