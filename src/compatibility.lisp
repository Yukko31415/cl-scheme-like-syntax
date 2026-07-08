
(in-package #:cl-scheme-like-syntax/compatibility)







;; ---------------
;;;; conversions
;; ---------------


;;
;; string, string*


(defun string (&rest char)
  "string &rest char => string"
  (the simple-string (list->string char)))

(defun string* (stringable)
  (cl:string stringable))

(set@ (documentation 'string* 'function) (documentation 'cl:string 'function))

(deftype string (&optional size)
  (if size
      `(cl:string ,size)
      'cl:string))


;; 
;; char->integer, integer-char


(defun char->integer (char &optional (radix 10))
  "char->integer char &optional radix => integer"
  (assert (digit-char? char radix) (char))
  (digit-char-p char radix))

(defun integer->char (integer &optional radix)
  "integer->char integer &optional radix => char"
  (assert (<= 0 integer (1- radix)))
  (digit-char integer radix))



;;
;; list->string, string->list


(defun list->string (list)
  "list->string list => string"
  (declare (list list))
  (coerce list 'string))

(defun string->list (string &key (start 0) (end nil))
  "string->list string &key start end => list"
  (let* ((end (or end (length string))))
    (loop :for i :from start :below end
	  :collect (char string i))))



;;
;; list->vector, vector-list


(defun list->vector (list)
  "list->vector list => vector"
  (declare (list list))
  (coerce list 'vector))

(defun vector->list (vector &key (start 0) (end nil))
  "vector->list vector &key start end"
  (let* ((end (or end (length vector))))
    (loop :for i :from start :below end
	  :collect (aref vector i))))



;;
;; string->number, number->string


(defun string->number (string &key (start 0) end (radix 10))
  "string->number string &key start end radix => number"
  (values (parse-integer string :radix radix :start start :end end)))

(defun number->string (number &optional (radix 10))
  "number->string number &optional radix => string"
  (with-output-to-string (stream)
    (write number :base radix :stream stream)))

;;
;; string->vector, vector->string


(defun string->vector (string &key (start 0) (end nil))
  "string->vector string &key start end => vector"
  (let* ((end (or end (length string)))
	 (vec (make-array (- end start))))
    (replace! vec string :start2 start :end2 end)))

(defun vector->string (vector &key (start 0) (end nil))
  "vector->string vector &key start end => string"
  (let* ((end (or end (length vector)))
	 (str (make-array (- end start) :element-type 'character)))
    (replace! str vector :start2 start :end2 end)))



;;
;; symbol->string, string->symbol


(defun symbol->string (symbol)
  "symbol->string symbol => string"
  (symbol-name symbol))

(defun string->symbol (string)
  "string->symbol string => symbol"
  (make-symbol string))



;;
;; char->code, code->char, char-encode


(aliases (char->code  . char-code)
	 (code->char  . code-char)
	 (char-encode . char-int))



;;
;; values->list, list->values


(aliases (list->values . values-list)
	 (values->list . multiple-value-list))

(set@ (documentation 'values->list 'function)
      "values->list form => list")


;;
;; name->char, char->name

(aliases (name->char . name-char)
	 (char->name . char-name))



;;
;; alist->hash-table, hash-table->alist


(defun alist->hash-table (alist &key (test 'eql) (size 7) (rehash-size 1.5) (rehash-threshold 1))
  "alist->hash-table alist &key test size rehash-size rehash-threshold => hash-table"
  (let ((ht (make-hash-table :test test :size size
			     :rehash-size rehash-size :rehash-threshold rehash-threshold)))
    (flet ((hash-table-set! (cons)
	     (multiple-value-bind (val present-p) (gethash (car cons) ht)
	       (declare (ignore val))
	       (if present-p nil (set@ (gethash (car cons) ht) (cdr cons))))))
      (mapc #'hash-table-set! alist)
      ht)))

(defun hash-table->alist (hash-table)
  "hash-table->alist hash-table => alist"
  (loop :for key :being :the :hash-key :of hash-table
	  :using (hash-value val)
	:collect (cons key val)))






;; --------------
;;;; references
;; --------------



;; 
;; string-ref


(defun string-ref (string index)
  "string-ref string index => char"
  (declare (string string))
  (the character (aref string index)))

(defun (set@ string-ref) (char string index)
  (declare (character char))
  (declare (simple-string string))
  (set@ (aref string index) char))



;;
;; array-ref, array-flat-ref


(defun array-ref (array &rest subscripts)
  "array-ref array &rest subscripts => element"
  (declare (type (not string) array))
  (apply #'aref array subscripts))

(defun (set@ array-ref) (object array &rest subscripts)
  (declare (array array))
  (set@ (apply #'aref array subscripts) object))


(defun array-flat-ref (array index)
  "array-flat-ref array index => element"
  (declare (integer index))
  (row-major-aref array index))

(defun (set@ array-flat-ref) (object array index)
  (declare (integer index))
  (set@ (row-major-aref array index) object))



;;
;; vector-ref

(defun vector-ref (vector index)
  "vector-ref vector index => element"
  (declare (simple-vector vector))
  (declare (integer index))
  (aref vector index))

(defun (set@ vector-ref) (object vector index)
  (declare (simple-vector vector))
  (declare (integer index))
  (set@ (aref vector index) object))



;;
;; list-ref, list-tail


(defun list-ref (list index)
  "list-ref list idnex => element"
  (declare (integer index))
  (nth index list))

(defun (set@ list-ref) (object list index)
  (set@ (nth index list) object))


(defun list-tail (list index)
  "list-tail list index => tail"
  (declare (integer index))
  (nthcdr index list))

(defun (set@ list-tail) (object list index)
  (set-cdr! (nthcdr (1- index) list) object))










;; ----------
;;;; values
;; ----------


;;
;; let-values, let*-values


(defun %make-formal (list)
  (cond ((null? list) (values nil nil nil))

	((atom? list) (let ((sym1 (string->symbol (symbol->string list))))
			(values sym1 (list sym1) (list list))))

	((list? list) (multiple-value-bind (sym2 sym3 sym4) (%make-formal (cdr list))
			(let ((sym1 (string->symbol (symbol->string (car list)))))
			  (values (cons sym1 sym2)
				  (cons sym1 sym3)
				  (cons (car list) sym4)))))))



(defun %let-values (bindings body &optional vars args)
  (if (null? bindings)
      `(funcall #'(lambda ,vars ,@body) ,@args)
      (destructuring-bind (formal init) (car bindings)
	(if (symbol? formal)
	    (let ((sym (string->symbol (symbol->string formal))))
	      `(let ((,sym (values->list ,init)))
		 ,(%let-values (cdr bindings) body (append (list formal) vars) (append (list sym) args))))
	    (multiple-value-bind (improp-args prop-args prop-vars) (%make-formal formal)
	      `(destructuring-bind ,improp-args (values->list ,init)
		 ,(%let-values (cdr bindings) body (append prop-vars vars)
			       (append prop-args args))))))))



(defmacro let-values (bindings &body body)
  "let-values ({({!formal} init-form)}*) {declaration}* {form}*
   formal ::= var | ({var}*) | ({var}* . var)"
  (%let-values bindings body))





(defun %make-let-bindings (list1 list2)
  (mapcar #'list list1 list2))

(defun %let*-values (bindings body)
  (destructuring-bind (formal init) (car bindings)
    (multiple-value-bind (improp-args prop-args prop-vars) (%make-formal formal)
      (let ((let-bindings (%make-let-bindings prop-vars prop-args)))
	(if (symbol? formal)
	    `(let ((,formal (values->list ,init)))
	       ,@(if (null? (cdr bindings))
		     body
		     (list (%let*-values (cdr bindings) body))))
	    `(destructuring-bind ,improp-args (values->list ,init)
	       (let ,let-bindings
		 ,@(if (null? (cdr bindings))
		       body
		       (list (%let*-values (cdr bindings) body))))))))))


(defmacro let*-values (bindings &body body)
  "let*-values ({({!formal} init-form)}*) {declaration}* {form}*
   formal ::= var | ({var}*) | ({var}* . var)"
  (%let*-values bindings body))



;;
;; bind-with-values, call-with-values, prog1-with-values, setq-with-values


(aliases (bind-with-values  . multiple-value-bind)
	 (setq-with-values! . multiple-value-setq))

(set@ (documentation 'bind-with-values 'function)
      "bind-with-values ({var}*) values-form {declaration}* {form}* => {result}*"
      (documentation 'setq-with-values! 'function)
      "setq-with-values! vars form => result")

(defmacro call-with-values (function arg &rest arguments)
  "call-with-values function-form {form}* => {result}*"
  `(multiple-value-call ,function ,arg ,@arguments))

(defmacro prog1-with-values (values-form &rest forms)
  "prog1-with-values first-form {form}* ⇒ first-form-results"
  `(multiple-value-prog1 ,values-form ,@forms))



;; ------------
;;;; mismatch
;; ------------


(defun string-mismatch (string1 string2 &key (start1 0) end1 (start2 0) end2 from-end)
  "string-mismatch string1 string2 &key start1 end1 start2 end3 from-end => position"
  (declare (simple-string string1 string2))
  (mismatch string1 string2
	    :from-end from-end :test #'char=
	    :start1 start1 :end1 end1
	    :start2 start2 :end2 end2))









