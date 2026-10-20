

(uiop:define-package #:cl-scheme-like-syntax.internal/common-lisp
  (:use #:cl))

(uiop:define-package #:cl-scheme-like-syntax.internal/core
  (:use #:trivial-indent 
	#:cl)
  (:export #:alias #:aliases))
