;;; package.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2026 Yukko



(uiop:define-package #:cl-scheme-like-syntax.internal
  (:use #:trivial-indent 
	#:cl)
  (:export #:alias #:aliases #:with-inline))


(uiop:define-package #:cl-scheme-like-syntax/predicates
  (:use #:cl-scheme-like-syntax.internal
	#:cl)
  (:shadow #:defstruct)
  (:export #:cons? #:list? #:end? #:tail? #:subset? #:null? #:atom?)
  (:export #:readtable?)
  (:export #:minus? #:plus? #:odd? #:even?
	   #:zero? #:random-state? #:number? #:complex?
	   #:real? #:rational? #:integer? #:logbit? #:float?)
  (:export #:slot-bound? #:slot-exists?)
  (:export #:input-stream? #:interactive-stream?
	   #:open-stream? #:stream? #:yes-or-no? #:y-or-n?)
  (:export #:simple-string? #:string=? #:string-equal?
	   #:string? #:string/=? #:string-not-equal? #:string<?
	   #:string-less? #:string>? #:string-greater?
	   #:string<=? #:string-not-greater? #:string>=? #:string-not-less?)
  (:export #:symbol=? #:symbol-equal? #:symbol/=? #:symbol-not-equal? #:symbol<?
	   #:symbol-less? #:symbol>? #:symbol-greater? #:symbol<=? #:symbol-not-greater?
	   #:symbol>=? #:symbol-not-less?)
  (:export #:string*=? #:string*-equal? #:string*/=? #:string*-not-equal?
	   #:string*<? #:string*-less? #:string*>? #:string*-greater?
	   #:string*<=? #:string*-not-greater? #:string*>=? #:string*-not-less?)
  (:export #:symbol? #:keyword? #:bound?)
  (:export #:package?)
  (:export #:pathname? #:wild-pathname? #:pathname-match?)
  (:export #:char? #:char-alphabetic? #:char-lower-case?
	   #:char-upper-case? #:char-alphanumeric?
	   #:char-both-case? #:char-graphic? #:char-standard?
	   #:char=? #:char/=? #:char<? #:char>? #:char<=?
	   #:char>=? #:char-equal? #:char-not-equal? #:char-less?
	   #:char-greater? #:char-not-greater? #:char-not-less?
	   #:digit-char? #:char-whitespace? #:char-numeric?)
  (:export #:hash-table?)
  (:export #:subtype? #:type?)
  (:export #:fbound? #:function? #:compiled-function?
	   #:eq? #:eql? #:equal? #:equalp?)
  (:export #:defstruct))



(uiop:define-package #:cl-scheme-like-syntax/places
  (:mix #:cl-scheme-like-syntax.internal
	#:cl-scheme-like-syntax/predicates
	#:cl)
  (:shadow #:defun
	   #:defmethod)
  (:export #:rem@ #:get@ #:rotate@ #:dec@ #:inc@
	   #:shift@ #:set@ #:pset@ #:push@ #:pop@ #:pushnew@
	   #:defset@ #:get-set@-expansion #:define-set@-expander)
  (:export #:defun #:defmethod))


(uiop:define-package #:cl-scheme-like-syntax/bangs
  (:use #:cl-scheme-like-syntax.internal
	#:cl)
  (:export #:vector-pop! #:vector-push!)
  (:export #:set-car! #:set-cdr! #:sublis! #:subst! #:subst-if!
	   #:append! #:revappend! #:butlast! #:intersection!
	   #:set-difference! #:set-exclusive-or! #:union!)
  (:export #:string-upcase! #:string-downcase! #:string-capitalize!)
  (:export #:remove-prop! #:make-unbound! #:set!)
  (:export #:fill! #:map! #:reverse! #:replace! #:substitute!
	   #:substitute-if! #:merge! #:remove! #:remove-if! #:remove-duplicates!)
  (:export #:hash-table-remove! #:hash-table-clear!)
  (:export #:make-function-unbound! #:setq! #:psetq!))



(uiop:define-package #:cl-scheme-like-syntax/control-flow
  (:mix #:cl-scheme-like-syntax.internal
	#:cl-scheme-like-syntax/predicates
	#:cl-scheme-like-syntax/places
	#:cl-scheme-like-syntax/bangs
	#:cl)
  (:shadow #:cond
	   #:case #:ccase #:ecase
	   #:typecase #:ctypecase #:etypecase)
  (:export #:and-let*
	   #:case
	   #:ccase
	   #:cond
	   #:ctypecase
	   #:ecase
	   #:etypecase
	   #:if-let
	   #:if-let*
	   #:typecase
	   #:when-let
	   #:when-let*))


(uiop:define-package #:cl-scheme-like-syntax/compatibility
  (:mix #:cl-scheme-like-syntax.internal
	#:cl-scheme-like-syntax/predicates
	#:cl-scheme-like-syntax/places
	#:cl-scheme-like-syntax/bangs
	#:cl-scheme-like-syntax/control-flow
	#:cl)
  (:export #:alist->hash-table
	   #:array-flat-ref
	   #:array-ref
	   #:bind-with-values
	   #:call-with-values
	   #:char->code
	   #:char->integer
	   #:char->name
	   #:char-encode
	   #:code->char
	   #:hash-table->alist
	   #:hash-table-map
	   #:hash-table-ref
	   #:integer->char
	   #:let*-values
	   #:let-values
	   #:list->string
	   #:list->values
	   #:list->vector
	   #:list-ref
	   #:list-tail
	   #:name->char
	   #:prog1-with-values
	   #:setq-with-values!
	   #:slot-ref
	   #:string->list
	   #:string->symbol
	   #:string->vector
	   #:string-append
	   #:string-ref
	   #:symbol->string
	   #:values->list
	   #:vector->list
	   #:vector->string
	   #:vector-append
	   #:vector-ref))


(uiop:define-package #:cl-scheme-like-syntax/string
  (:mix #:cl-scheme-like-syntax.internal
	#:cl-scheme-like-syntax/predicates
	#:cl-scheme-like-syntax/places
	#:cl-scheme-like-syntax/bangs
	#:cl-scheme-like-syntax/control-flow
	#:cl-scheme-like-syntax/compatibility
	#:cl)
  (:shadow #:string
	   #:string-trim #:string-right-trim #:string-left-trim
	   #:string-upcase #:string-downcase #:string-capitalize)
  (:export #:string
	   #:string*
	   #:string-trim
	   #:string-right-trim
	   #:string-left-trim
	   #:string-upcase
	   #:string-downcase
	   #:string-capitalize))


(uiop:define-package #:cl-scheme-like-syntax/number
  (:mix #:cl-scheme-like-syntax/places
	#:cl-scheme-like-syntax/predicates
	#:cl-scheme-like-syntax/bangs
	#:cl-scheme-like-syntax/compatibility
	#:cl-scheme-like-syntax/control-flow
	#:cl-scheme-like-syntax/compatibility
	#:cl-scheme-like-syntax/string
	#:cl)
  (:export #:number->string #:string->number))


(uiop:define-package #:cl-scheme-like-syntax/srfis
  (:mix #:cl-scheme-like-syntax/predicates
	#:cl-scheme-like-syntax/places
	#:cl-scheme-like-syntax/bangs
	#:cl-scheme-like-syntax/control-flow
	#:cl-scheme-like-syntax/compatibility
	#:cl-scheme-like-syntax/string
	#:trivial-indent
	#:cl)
  (:export #:cut #:cute #:string-compare))


(uiop:define-package #:cl-scheme-like-syntax
  (:documentation "The cl-scheme-like-syntax package.")
  (:mix-reexport #:cl-scheme-like-syntax/predicates
		 #:cl-scheme-like-syntax/places
		 #:cl-scheme-like-syntax/bangs
		 #:cl-scheme-like-syntax/compatibility
		 #:cl-scheme-like-syntax/number
		 #:cl-scheme-like-syntax/srfis
		 #:cl-scheme-like-syntax/control-flow
		 #:cl-scheme-like-syntax/string
		 #:cl-scheme-like-syntax.internal/common-lisp))










