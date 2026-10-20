

(in-package #:cl-scheme-like-syntax/places)


;; -------------------------
;;;; Generalized Reference
;; -------------------------


;;;  operators relating to places and generalized reference

;; assert	         defsetf	     push
;; ccase  	         get-setf-expansion  remf
;; ctypecase      	 getf	             rotatef
;; decf	                 incf 	             setf
;; define-modify-macro	 pop	             shiftf
;; define-setf-expander	 psetf	


(aliases (rem@      . remf)
	 (get@      . getf)
	 (rotate@   . rotatef)
	 (dec@      . decf)
	 (inc@      . incf)
	 (set@      . setf)
	 (shift@    . shiftf)
	 (pset@     . psetf)
	 (push@     . push)
	 (pop@      . pop)
	 (pushnew@  . pushnew)
	 
	 (defset@   . defsetf)
	 (get-set@-expansion   . get-setf-expansion)
	 (define-set@-expander . define-setf-expander))


