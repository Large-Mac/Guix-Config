;; T480
(define laptop? 
  (string=? (gethostname) "rafflesia"))

;; DELL XPS 13
(define desktop?
  (string=? (gethostname) "camellia"))
