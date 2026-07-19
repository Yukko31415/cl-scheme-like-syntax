

(in-package #:cl-scheme-like-syntax/control-flow)

;; --------------------------------------------------
;;;; if-let, if-let*, when-let, when-let*. and-let*
;; --------------------------------------------------


(defmacro if-let (bindings then-form &optional else-form) ;; from alexandria
  "if-let !bindings then &optional else => {result}*
   bindings ::= {(var form) | ({(var form)}*)}"
  ;; bindings can be (var form) or ((var1 form1) ...)
  (check-type bindings list)
  (let* ((binding-list (if (symbolp (car bindings)) (list bindings) bindings))
	 (variables (mapcar #'car binding-list)))
    `(let ,binding-list
       (if ,(if (= (length variables) 1) (car variables) `(and ,@variables))
	   ,then-form
	   ,else-form))))

(defmacro if-let* (bindings then-form &optional else-form) ;; from alexandria
  "if-let* ({(var [init-form])}*) then &optional else => {result}*"
  ;; bindings can be (var form) or ((var1 form1) ...)
  (check-type bindings list)
  (dolist (binding bindings) (check-type binding list))
  (let* ((variables (mapcar #'car bindings)))
    `(let* ,bindings
       (if ,(if (= (length variables) 1) (car variables) `(and ,@variables))
	   ,then-form ,else-form))))


(defmacro when-let (bindings &body forms)
  "when-let !bindings {form}* => {result}*
   bindings ::= {(var form) | ({(var form)}*)}"
  ;; bindings can be (var form) or ((var1 form1) ...)
  (check-type bindings list)
  (let* ((binding-list (if (symbolp (car bindings)) (list bindings) bindings))
	 (variables (mapcar #'car binding-list)))
    `(let ,binding-list
       (when ,(if (= (length variables) 1) (car variables) `(and ,@variables))
	 ,@forms))))

(defmacro when-let* (bindings &body forms)
  "when-let* ({(var [init-form])}*) {form}* => {result}*"
  ;; bindings can be (var form) or ((var1 form1) ...)
  (check-type bindings list)
  (dolist (binding bindings) (check-type binding list))
  (let* ((variables (mapcar #'car bindings)))
    `(let* ,bindings
       (when ,(if (= (length variables) 1) (car variables) `(and ,@variables))
	 ,@forms))))


(defun %make-and-let* (clauses forms)
  (cond ((null? clauses) forms)
	((symbol? (car clauses))
	 (list `(when ,(car clauses)
		  ,@(%make-and-let* (cdr clauses) forms))))
	((list? (car (car clauses)))
	 (list `(when ,(car (car clauses))
		  ,@(%make-and-let* (cdr clauses) forms))))
	((symbol? (car (car clauses)))
	 (list `(when-let ,(car clauses)
		  ,@(%make-and-let* (cdr clauses) forms))))))

(defmacro and-let* (clauses &body forms)
  "and-let* ({!clause}*) {form}* => {result}*
   clause ::= (var [init-form]) | predicate | var"
  (check-type clauses list)
  (car (%make-and-let* clauses forms)))



;; --------
;;;; cond
;; --------

;; clause ::= (test {form}*)  |
;;            (test => receiver) |
;;            (else {form}*)

(defun %make-cond (clauses)
  (when clauses
    (let ((car (car clauses))
	  (cdr (cdr clauses)))
      (if (and (symbolp (second car)) (symbol=? (second car) '=>))
	  (destructuring-bind (test => receiver) car
	    (declare (ignore =>))
	    (let ((sym (gensym)))
	      `(if-let (,sym ,test) (funcall ,receiver ,sym) ,(%make-cond cdr))))
	  (destructuring-bind (test &rest forms) car
	    `(if ,(if (and (symbolp test) (symbol=? test 'else)) 'T test)
		 ,(if (= (length forms) 1) (car forms) `(progn ,@forms))
		 ,(%make-cond cdr)))))))


(defmacro cond (&rest clauses)
  "cond {!clause}* => {result}*
   clause ::= (test-form {form}*) | (test-form => function) | (else {form}*)"
  (%make-cond clauses))





;; --------
;;;; case
;; --------


;; case keyform {!normal-clause}* [!otherwise-clause] => {result}*
;;    normal-clause ::= (keys {{form}* | => receiver})
;;    otherwise-clause ::= ({otherwise | t | else} {{form}* | => receiver})


(defun %make-case (clauses key &optional otherwise-clause?)
  (flet ((%symbol=? (symbol1 symbol2) (and (symbol? symbol1) (symbol=? symbol1 symbol2))))
    (loop :for (keys . forms) :in clauses
	  :if (and otherwise-clause? (%symbol=? keys 'else))
	    :do (set@ keys 't)
	  :if (%symbol=? (car forms) '=>)
	    :do (set@ forms (list `(funcall ,(second forms) ,key)))
	  :collect (cons keys forms))))


(defmacro case (keyform &rest cases)
  "case keyform {!normal-clause}* [!otherwise-clause] => {result}*
   normal-clause ::= (keys {{form}* | => receiver})
   otherwise-clause ::= ({otherwise | t | else} {{form}* | => receiver})"
  (let ((key (gensym "KEYFORM")))
    `(let ((,key ,keyform))
       (cl:case ,key ,@(%make-case cases key t)))))

(defmacro ccase (keyform &rest cases)
  "ccase keyform {!normal-clause}* => {result}*
   normal-clause ::= (keys {{form}* | => receiver})"
  (let ((key (gensym "KEYFORM")))
    `(let ((,key ,keyform))
       (cl:ccase ,key ,@(%make-case cases key)))))

(defmacro ecase (keyform &rest cases)
  "ecase keyform {!normal-clause}* => {result}*
   normal-clause ::= (keys {{form}* | => receiver})"
  (let ((key (gensym "KEYFORM")))
    `(let ((,key ,keyform))
       (cl:ecase ,key ,@(%make-case cases key)))))



(defmacro typecase (keyform &rest cases)
  "typecase keyform {!normal-clause}* [!otherwise-clause] => {result}*
   normal-clause ::= (keys {{form}* | => receiver})
   otherwise-clause ::= ({otherwise | t | else} {{form}* | => receiver})"
  (let ((key (gensym "KEYFORM")))
    `(let ((,key ,keyform))
       (cl:typecase ,key ,@(%make-case cases key t)))))

(defmacro ctypecase (keyform &rest cases)
  "ctypecase keyform {!normal-clause}* => {result}*
   normal-clause ::= (keys {{form}* | => receiver})"
  (let ((key (gensym "KEYFORM")))
    `(let ((,key ,keyform))
       (cl:ctypecase ,key ,@(%make-case cases key)))))

(defmacro etypecase (keyform &rest cases)
  "etypecase keyform {!normal-clause}* => {result}*
   normal-clause ::= (keys {{form}* | => receiver})"
  (let ((key (gensym "KEYFORM")))
    `(let ((,key ,keyform))
       (cl:etypecase ,key ,@(%make-case cases key)))))







