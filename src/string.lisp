
(in-package #:cl-scheme-like-syntax/string)

;;
;; string, string*


(defun string (&rest char)
  "string &rest char => string"
  (the simple-string (list->string char)))

(defun string* (stringable)
  (cl:string stringable))

(deftype string (&optional size)
  (if size
      `(cl:string ,size)
      'cl:string))

(set@ (documentation 'string* 'function) (documentation 'cl:string 'function))




;;
;; string-trim, string-left-trim, string-right-trim

(defun string-trim (char-bag string)
  "string-trim char-bag string => string"
  (declare (string string))
  (cl:string-trim char-bag string))

(defun string-right-trim (char-bag string)
  "string-right-trim char-bag string => string"
  (declare (string string))
  (cl:string-right-trim char-bag string))

(defun string-left-trim (char-bag string)
  "string-left-trim => char-bag string => string"
  (declare (string string))
  (cl:string-left-trim char-bag string))

(aliases (string*-trim       . cl:string-trim)
	 (string*-right-trim . cl:string-right-trim)
	 (string*-left-trim  . cl:string-left-trim))

(set@ (documentation 'string*-trim 'function)
      "string*-trim char-bag string => string"
      (documentation 'string*-right-trim 'function)
      "string*-right-trim char-bag string => string"
      (documentation 'string*-left-trim 'function)
      "string*-left-trim char-bag string => string")



;;
;; string-upcase, string-downcase, string-capitalize


(defun string-upcase (string &key (start 0) (end nil))
  "string-upcase string &key start end"
  (declare (string string))
  (cl:string-upcase string :start start :end end))

(defun string-downcase (string &key (start 0) (end nil))
  "string-downcase string &key start end"
  (declare (string string))
  (cl:string-downcase string :start start :end end))

(defun string-capitalize (string &key (start 0) (end nil))
  "string-capitalize string &key start end"
  (declare (string string))
  (cl:string-capitalize string :start start :end end))

(aliases (string*-upcase     . cl:string-upcase)
	 (string*-downcase   . cl:string-downcase)
	 (string*-capitalize . cl:string-capitalize))

(set@ (documentation 'string*-upcase 'function)
      "string*-upcase string &key start end => string"
      (documentation 'string*-downcase 'function)
      "string*-downcase string &key start end => string"
      (documentation 'string*-capitalize 'function)
      "string*-capitalize string &key start end => string")






