

(in-package #:cl-scheme-like-syntax.internal)



;; 関数エイリアス
(defmacro function-alias (to from)
  ;; function-alias to from => {result}*
  `(setf (fdefinition ',to) (fdefinition ',from)))

;; マクロエイリアス
(defmacro macro-alias (to from)
  ;; macro-alias to from => {result}*
  `(setf (macro-function ',to) (macro-function ',from)))

;; 自動判別マクロ
(defmacro alias (to from)
  "alias to from => {result}*"
  `(progn (cond ((macro-function ',from)
		 (setf (macro-function ',to) (macro-function ',from)))
		((fboundp ',from)
		 (setf (fdefinition ',to) (fdefinition ',from)))
		(t (error "~a is not fbound" ',from)))
	  ',(make-symbol (symbol-name to))))

;; 複数エイリアス登録
(defmacro aliases (&rest pairs)
  "aliases {!pair}* => {result}*
   pair ::= (to . from)"
  (cons 'progn (loop :for (to . from) :in pairs
		     :collect `(alias ,to ,from) :into aliases
		     :collect (make-symbol (symbol-name to)) :into names
		     :collect from :into froms
		     :finally (return `(,@aliases (values ',names ',froms))))))



;;
;; with-inline

(defmacro with-inline (&rest definitions)
  (let ((names (mapcar #'(lambda (definition) (nth 1 definition)) definitions)))
    `(progn ,@definitions
	    (declaim (inline ,@names))
	    ',(mapcar #'(lambda (sym) (make-symbol (symbol-name sym))) names))))

(define-indentation with-inline (&rest))

