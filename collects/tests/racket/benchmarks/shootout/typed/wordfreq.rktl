; $Id: wordfreq-mzscheme.code,v 1.10 2006/06/21 15:05:34 bfulgham Exp $
;  http://shootout.alioth.debian.org/
;  wordfreq.mzscheme by Grzegorz Chrupaa
;  Updated and corrected by Brent Fulgham
;  Re-written by Matthew Flatt with some inspriation from the Python example
;  Converted to Typed Scheme by Vincent St-Amour

(require mzlib/list)

(: t (HashTable String Natural))
(define t (make-hash))

(: register-word! (Bytes -> Void))
(define (register-word! s)
  (let ([s (string-downcase (bytes->string/utf-8 s))])
    (hash-set! t s (add1 (hash-ref t s (lambda () 0))))))

(let ([in (current-input-port)])
  (let: loop : Void ()
    (let ([m (regexp-match #rx#"[a-zA-Z]+" in)])
      (when m
        (register-word! (assert (car m)))
        (loop)))))

(for-each display
          ((inst sort String String)
           (hash-map
            t
            (lambda: ((word : String) (count : Natural))
                     (let ((count (number->string count)))
                       (format"~a~a ~a~%"
                              (make-string (assert (- 7 (string-length count)) exact-nonnegative-integer?) #\space)
                              count
                              word))))
           string>?))
