
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

(with-inline

 (defun string-trim (char-bag string)
   (declare (string string))
   (cl:string-trim char-bag string))

 (defun string-right-trim (char-bag string)
   (declare (string string))
   (cl:string-right-trim char-bag string))

 (defun string-left-trim (char-bag string)
   (declare (string string))
   (cl:string-left-trim char-bag string)))


;;
;; string-upcase, string-downcase, string-capitalize


(with-inline

 (defun string-upcase (string &key (start 0) (end nil))
   (declare (string string))
   (cl:string-upcase string :start start :end end))

 (defun string-downcase (string &key (start 0) (end nil))
   (declare (string string))
   (cl:string-downcase string :start start :end end))

 (defun string-capitalize (string &key (start 0) (end nil))
   (declare (string string))
   (cl:string-capitalize string :start start :end end)))
