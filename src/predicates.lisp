

(in-package #:cl-scheme-like-syntax/predicates)







(defparameter *char-whitespace*
  '(9 10 11 12 13 32 133 160 5760 8192 8193 8194 8195 8196 8197
    8198 8199 8200 8201 8202 8232 8233 8239 8287 12288))







;; --------------
;;;; predicates
;; --------------



;;
;; Arrays Dictionary


(aliases (adjustable-array?       . adjustable-array-p)
	 (array-has-fill-pointer? . array-has-fill-pointer-p)
	 (array-in-bounds?        . array-in-bounds-p)
	 (array?                  . arrayp)
	 (simple-vector?          . simple-vector-p)
	 (vector?                 . vectorp)
	 (bit-vector?             . bit-vector-p)
	 (simple-bit-vector?      . simple-bit-vector-p))



;;
;; Conses Dictionary


(aliases (cons?   . consp)
	 (list?   . listp)
	 (end?    . endp)
	 (tail?   . tailp)
	 (subset? . subsetp)
	 ;; null?は空集合を検査するための述語なので、nil?とはしない。
	 ;; 実際にnilかどうか判定したい場合はnotを使う。
	 (null?   . null) 
	 (atom?   . atom))



;;
;; Reader Dictionary


(alias readtable? readtablep)


;;
;; Numbers Dictionary


(aliases (minus?        . minusp)
	 (plus?         . plusp)
	 (odd?          . oddp)
	 (even?         . evenp)
	 (zero?         . zerop)
	 (random-state? . random-state-p)
	 (number?       . numberp)
	 (complex?      . complexp)
	 (real?         . realp)
	 (rational?     . rationalp)
	 (integer?      . integerp)
	 (logbit?       . logbitp)
	 (float?        . floatp))



;;
;; Objects Dictionary


(aliases (slot-bound?  . slot-boundp)
	 (slot-exists? . slot-exists-p))



;;
;; Streams Dictionary


(aliases (input-stream?       . input-stream-p)
	 (interactive-stream? . interactive-stream-p)
	 (open-stream?        . open-stream-p)
	 (stream?             . streamp)
	 (yes-or-no?          . yes-or-no-p)
	 (y-or-n?             . y-or-n-p))




;;
;; Strings Dictionary


(alias string? stringp)


(with-inline

 (defun string=? (string1 string2 &key (start1 0) end1 (start2) end2)
   "string=? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (string= string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2))

 (defun string-equal? (string1 string2 &key (start1 0) end1 (start2) end2)
   "string-equal? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (string-equal string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2))
 

 (defun string/=? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string/=? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string/= string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string-not-equal? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string-not-equal? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string-not-equal string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun string<? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string<? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string< string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string-less? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string-less? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string-lessp string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun string>? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string>? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string> string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string-greater? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string-grater? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string-greaterp string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun string<=? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string<=? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string<= string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string-not-greater? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string-not-grater? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string-not-greaterp string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun string>=? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string>=? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string>= string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string-not-less? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string-not-less? string1 string2 &key start1 end1 start2 end2 => boolean"
   (declare (string string1 string2))
   (when (string-not-lessp string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t)))


(with-inline

 (defun symbol=? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol=? symbol1 symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (string= symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2))

 (defun symbol-equal? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol-epual symbol1 symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (string-equal symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2))


 (defun symbol/=? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol/=? symbol1 symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string/= symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun symbol-not-equal? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol-not-epual symbol1 symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string-not-equal symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun symbol<? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol<? symbol1 symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string< symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun symbol-less? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol-less? symbol1 symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string-lessp symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun symbol>? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol>? symbol1 symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string> symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun symbol-greater? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol-greater? symbol1 symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string-greaterp symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun symbol<=? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol<=?  symbol1  symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string<= symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun symbol-not-greater? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol-not-grater?  symbol1  symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string-not-greaterp symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun symbol>=? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol>=?  symbol1  symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string>= symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun symbol-not-less? (symbol1 symbol2 &key (start1 0) end1 (start2 0) end2)
   "symbol-not-less?  symbol1  symbol2 &key start1 end1 start2 end2 => boolean"
   (declare (symbol symbol1 symbol2))
   (when (string-not-lessp symbol1 symbol2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t)))


(with-inline

 (defun string*=? (string1 string2 &key (start1 0) end1 (start2) end2)
   "string*=? string1 string2 &key start1 end1 start2 end2 => boolean"
   (string= string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2))

 (defun string*-equal? (string1 string2 &key (start1 0) end1 (start2) end2)
   "string*-equal? string1 string2 &key start1 end1 start2 end2 => boolean"
   (string-equal string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2))


 (defun string*/=? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string*/=? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string/= string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string*-not-equal? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string*-not-equal? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string-not-equal string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun string*<? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string*<? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string< string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string*-less? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string-*less? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string-lessp string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun string*>? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string*>? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string> string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string*-greater? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string-grater? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string-greaterp string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun string*<=? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string*<=? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string<= string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string*-not-greater? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string*-not-grater? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string-not-greaterp string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))


 (defun string*>=? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string*>=? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string>= string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t))

 (defun string*-not-less? (string1 string2 &key (start1 0) end1 (start2 0) end2)
   "string*-not-less? string1 string2 &key start1 end1 start2 end2 => boolean"
   (when (string-not-lessp string1 string2 :start1 start1 :end1 end1 :start2 start2 :end2 end2) t)))








;;
;; Symbols Dictionary


(aliases (symbol?  . symbolp)
	 (keyword? . keywordp)
	 (bound?   . boundp))



;;
;; Packages Dictionary


(alias package? packagep)


;;
;; Filenames Dictionary

(aliases (pathname?       . pathnamep)
	 (wild-pathname?  . wild-pathname-p)
	 (pathname-match? . pathname-match-p))



;;
;; Characters Dictionary

(aliases (char?              . characterp) 
	 (char-alphabetic?   . alpha-char-p)
	 (char-lower-case?   . lower-case-p)
	 (char-upper-case?   . upper-case-p)
	 (char-alphanumeric? . alphanumericp)

	 (char-both-case? . both-case-p)
	 (char-graphic?   . graphic-char-p)
	 (char-standard?  . standard-char-p))



(aliases (char=?  . char=)
	 (char/=? . char/=)
	 (char<?  . char<)
	 (char>?  . char>)
	 (char<=? . char<=)
	 (char>=? . char>=)
	 
	 (char-equal?       . char-equal)
	 (char-not-equal?   . char-not-equal)
	 (char-less?        . char-lessp)
	 (char-greater?     . char-greaterp)
	 (char-not-greater? . char-not-greaterp)
	 (char-not-less?    . char-not-lessp))




(with-inline

 (defun digit-char? (char &optional (radix 10))
   "digit-char? char &optional radix => boolean"
   (when (digit-char-p char radix) t))

 (defun char-whitespace? (char)
   "char-whitespace? char => boolean"
   (when (member (char-code char) *char-whitespace* :test #'=) t))

 (defun char-numeric? (char)
   "char-numeric? char => boolean"
   (digit-char? char)))




;;
;; Hash Tables Dictionary


(alias hash-table? hash-table-p)



;;
;; Types and Classes Dictionary


(aliases (subtype? . subtypep)
	 (type?    . typep))


;;
;; Data and Control Flow Dictionary


(aliases (fbound?            . fboundp)
	 (function?          . functionp)
	 (compiled-function? . compiled-function-p)
	 (eq?                . eq)
	 (eql?               . eql)
	 (equal?             . equal)
	 (equalp?            . equalp))


