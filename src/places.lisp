

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
	 (shift@    . shiftf)
	 (set@      . setf)
	 (pset@     . psetf)
	 (push@     . push)
	 (pop@      . pop)
	 (pushnew@  . pop)
	 
	 (defset@   . defsetf)
	 (get-set@-expansion   . get-setf-expansion)
	 (define-set@-expander . define-setf-expander))



;;
;; defun (set@)

(defmacro defun (name lambda-list &body body)
  (when (and (list? name) (symbol=? 'set@ (car name)))
    (setf name (cons 'setf (cdr name))))
  `(cl:defun ,name ,lambda-list ,@body))

(setf (documentation 'defun 'function)
      (documentation 'cl:defun 'function))


;;
;; defmethod (set@)

(defmacro defmethod (name &rest args)
  (when (and (list? name) (symbol=? 'set@ (car name)))
    (setf name (cons 'setf (cdr name))))
  `(cl:defmethod ,name ,@args))

(setf (documentation 'defmethod 'function)
      (documentation 'cl:defmethod 'function))







