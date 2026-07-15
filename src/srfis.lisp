

(in-package #:cl-scheme-like-syntax/srfis)





;;
;; srfi 13: String Libraries


(defun string-compare (string1 string2 proc< proc= proc> &key (start1 0) end1 (start2 0) end2)
  "string-compare string1 string2 proc< proc= proc> &key start1 end1 star2 end2 => {result}*"
  (declare (string string1 string2))
  (let* ((index   (mismatch string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2
					    :test #'char=?))
	 (length1 (length string1))
	 (length2 (length string2))
	 (min     (min length1 length2)))
    (cond ((not index) (funcall proc= min))
	  ((or (= index length1) (char<? (char string1 index) (char string2 index))) (funcall proc< index))
	  (t (funcall proc> index)))))


;;
;; srfi 26: Notation for Specializing Parameters without Currying


;; cut [[!slot-or-expr]] [rest-slot] => function
;; cute [[!slot-or-expr]] [rest-slot] => function
;; slot-or-expr ::= {<>}* | {expr}*
;; rest-slot ::= <...>



(defun var-slot? (object)
  (and (symbol? object) (symbol=? object '<>)))

(defun rest-slot? (object)
  (and (symbol? object) (symbol=? object '<...>)))

(defun slot? (object)
  (and (symbol? object)
       (or (symbol=? object '<>)
	   (symbol=? object '<...>))))



(defun make-cut (list)
  (loop :for sym := (pop list)
	:with apply?
	:while sym
	
	:if (var-slot? sym)
	  :do (set@ sym (gensym "SLOT"))
	  :and :collect sym :into lambda-list

	:else
	  :if (and (null list) (rest-slot? sym))
	    :do (set@ sym (gensym "REST-SLOT"))
	    :and :append `(&rest ,sym) :into lambda-list
	    :and :do (set@ apply? t) :end
	:end
	
	:collect sym :into arg-list

	:finally (return (values lambda-list arg-list apply?))))


(defun %make-cute (list)
  (loop :for object :in list
	:with sym
	:if (not (slot? object))
	  :do (setf sym (gensym "EVALUATED"))
	  :and :collect (list sym object) :into bindings
	  :and :collect sym :into arg-list

	:else
	  :collect object :into arg-list
	:finally (return (values bindings arg-list))))


(defun make-cute (list)
  (multiple-value-bind (bindings %arg-list) (%make-cute list)
    (multiple-value-bind (lambda-list arg-list apply?) (make-cut %arg-list)
      (values bindings lambda-list arg-list apply?))))



(defmacro cut (&rest slot-or-expr)
  "cut [[!slot-or-expr]] [rest-slot] => function
   slot-or-expr ::= {<>}* | {expr}*
   rest-slot ::= <...>"
  (multiple-value-bind (lambda-list arg-list apply?) (make-cut slot-or-expr)
    (destructuring-bind (function . arg-list) arg-list
      (if apply?
	  `(lambda ,lambda-list (apply ,function ,@arg-list))
	  `(lambda ,lambda-list (funcall ,function ,@arg-list))))))


(defmacro cute (&rest slot-or-expr)
  "cute [[!slot-or-expr]] [rest-slot] => function
   slot-or-expr ::= {<>}* | {expr}*
   rest-slot ::= <...>"
  (multiple-value-bind (bindings lambda-list arg-list apply?) (make-cute slot-or-expr)
    (destructuring-bind (function . arg-list) arg-list
      (if apply?
	  `(let ,bindings (lambda ,lambda-list (apply ,function ,@arg-list)))
	  `(let ,bindings (lambda ,lambda-list (funcall ,function ,@arg-list)))))))




