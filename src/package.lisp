;;; package.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2026 Yukko



(uiop:define-package #:cl-scheme-like-syntax.internal
  (:use #:cl 
	#:trivial-indent)
  (:export #:alias #:aliases #:with-inline))


(uiop:define-package #:cl-scheme-like-syntax/predicates
  (:use #:cl
	#:cl-scheme-like-syntax.internal)
  (:export #:set-car! #:set-cdr!
	   #:sublis! #:subst! #:subst-if!
	   #:append! #:revappend!
	   #:butlast! #:intersection!
	   #:set-difference! #:set-exclusive-or! #:union!)
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
	   #:eq? #:eql? #:equal? #:equalp?))



(uiop:define-package #:cl-scheme-like-syntax/places
  (:use #:cl
	#:cl-scheme-like-syntax.internal
	#:cl-scheme-like-syntax/predicates)
  (:shadow #:defun
	   #:defmethod)
  (:export #:rem@ #:get@ #:rotate@ #:dec@ #:inc@
	   #:shift@ #:set@ #:pset@ #:push@ #:pop@ #:pushnew@
	   #:defset@ #:get-set@-expansion #:define-set@-expander)
  (:export #:defun #:defmethod))


(uiop:define-package #:cl-scheme-like-syntax/bangs
  (:use #:cl
	#:cl-scheme-like-syntax.internal)
  (:export #:vector-pop! #:vector-push!)
  (:export #:set-car! #:set-cdr! #:sublis! #:subst! #:subst-if!
	   #:append! #:revappend! #:butlast! #:intersection!
	   #:set-difference! #:set-exclusive-or! #:union!)
  (:export #:string-upcase! #:string-downcase! #:string-capitalize!)
  (:export #:remove-prop! #:make-unbound! #:set!)
  (:export #:fill! #:map! #:reverse! #:replace! #:substitute!
	   #:substitute-if! #:merge! #:remove! #:remove-if! #:remove-duplicates!)
  (:export #:remove-hash! #:clear-hash!)
  (:export #:make-function-unbound! #:setq! #:psetq!))


(uiop:define-package #:cl-scheme-like-syntax/compatibility
  (:mix #:cl-scheme-like-syntax.internal
	#:cl-scheme-like-syntax/predicates
	#:cl-scheme-like-syntax/bangs
	#:cl-scheme-like-syntax/places
	#:cl)
  (:shadow #:string)
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
	   #:integer->char
	   #:let*-values
	   #:let-values
	   #:list->string
	   #:list->values
	   #:list->vector
	   #:list-ref
	   #:list-tail
	   #:name->char
	   #:number->string
	   #:prog1-with-values
	   #:setq-with-values!
	   #:string
	   #:string*
	   #:string->list
	   #:string->number
	   #:string->symbol
	   #:string->vector
	   #:string-mismatch
	   #:string-ref
	   #:symbol->string
	   #:values->list
	   #:vector->list
	   #:vector->string
	   #:vector-ref))


(uiop:define-package #:cl-scheme-like-syntax/srfis
  (:mix #:cl-scheme-like-syntax/compatibility
	#:cl-scheme-like-syntax/places
	#:cl-scheme-like-syntax/predicates
	#:cl-scheme-like-syntax/bangs
	#:trivial-indent
	#:cl)
  (:export #:cut #:cute #:string-compare))



(uiop:define-package #:cl-scheme-like-syntax
  (:documentation "The cl-scheme-like-syntax package.")
  (:mix #:cl-scheme-like-syntax/predicates
	#:cl-scheme-like-syntax/places
	#:cl-scheme-like-syntax/bangs
	#:cl-scheme-like-syntax/compatibility
	#:cl-scheme-like-syntax/srfis
	#:cl)
  (:reexport #:cl-scheme-like-syntax/predicates
	     #:cl-scheme-like-syntax/places
	     #:cl-scheme-like-syntax/bangs
	     #:cl-scheme-like-syntax/compatibility
	     #:cl-scheme-like-syntax/srfis)

  (:export #:&allow-other-keys #:&aux #:&body #:&environment
	   #:&key #:&optional #:&rest #:&whole)
  (:export #:* #:** #:*** #:*break-on-signals* #:*compile-file-pathname*
	   #:*compile-file-truename* #:*compile-print* #:*compile-verbose* #:*debug-io*
	   #:*debugger-hook* #:*default-pathname-defaults* #:*error-output* #:*features*
	   #:*gensym-counter* #:*load-pathname* #:*load-print* #:*load-truename*
	   #:*load-verbose* #:*macroexpand-hook* #:*modules* #:*package* #:*print-array*
	   #:*print-base* #:*print-case* #:*print-circle* #:*print-escape*
	   #:*print-gensym* #:*print-length* #:*print-level* #:*print-lines*
	   #:*print-miser-width* #:*print-pprint-dispatch* #:*print-pretty*
	   #:*print-radix* #:*print-readably* #:*print-right-margin* #:*query-io*
	   #:*random-state* #:*read-base* #:*read-default-float-format* #:*read-eval*
	   #:*read-suppress* #:*readtable* #:*standard-input* #:*standard-output*
	   #:*terminal-io* #:*trace-output*)
  (:export #:+ #:++ #:+++ #:- #:/ #:// #:/// #:/=)
  (:export #:1+ #:1-)
  (:export #:< #:<= #:= #:> #:>=)
  (:export #:abort #:abs #:acons #:acos #:acosh #:add-method
	   #:adjoin #:adjust-array #:allocate-instance #:and #:append #:apply #:apropos
	   #:apropos-list #:arithmetic-error #:arithmetic-error-operands
	   #:arithmetic-error-operation #:array #:array-dimension #:array-dimension-limit
	   #:array-dimensions #:array-displacement #:array-element-type #:array-rank
	   #:array-rank-limit #:array-row-major-index #:array-total-size
	   #:array-total-size-limit #:ash #:asin #:asinh #:assert #:assoc #:assoc-if
	   #:atan #:atanh)
  (:export #:base-char #:base-string #:bignum #:bit
	   #:bit-and #:bit-andc1 #:bit-andc2 #:bit-eqv #:bit-ior #:bit-nand #:bit-nor
	   #:bit-not #:bit-orc1 #:bit-orc2 #:bit-vector #:bit-xor #:block #:boole
	   #:boole-1 #:boole-2 #:boole-and #:boole-andc1 #:boole-andc2 #:boole-c1
	   #:boole-c2 #:boole-clr #:boole-eqv #:boole-ior #:boole-nand #:boole-nor
	   #:boole-orc1 #:boole-orc2 #:boole-set #:boole-xor #:boolean #:break
	   #:broadcast-stream #:broadcast-stream-streams #:built-in-class #:butlast
	   #:byte #:byte-position #:byte-size)
  (:export #:caaaar #:caaadr #:caaar #:caadar #:caaddr
	   #:caadr #:caar #:cadaar #:cadadr #:cadar #:caddar #:cadddr #:caddr #:cadr
	   #:call-arguments-limit #:call-method #:call-next-method #:car #:case #:catch
	   #:ccase #:cdaaar #:cdaadr #:cdaar #:cdadar #:cdaddr #:cdadr #:cdar #:cddaar
	   #:cddadr #:cddar #:cdddar #:cddddr #:cdddr #:cddr #:cdr #:ceiling #:cell-error
	   #:cell-error-name #:cerror #:change-class #:char #:char-code-limit
	   #:char-downcase #:char-int #:char-upcase #:character #:check-type
	   #:cis #:class #:class-name #:class-of #:clear-input #:clear-output #:close
	   #:coerce #:compilation-speed #:compile #:compile-file
	   #:compile-file-pathname #:compiled-function #:compiler-macro
	   #:compiler-macro-function #:complement #:complex #:compute-applicable-methods
	   #:compute-restarts #:concatenate #:concatenated-stream
	   #:concatenated-stream-streams #:cond #:condition #:conjugate #:cons
	   #:constantly #:constantp #:continue #:control-error #:copy-alist #:copy-list
	   #:copy-pprint-dispatch #:copy-readtable #:copy-seq #:copy-structure
	   #:copy-symbol #:copy-tree #:cos #:cosh #:count #:count-if
	   #:ctypecase)
  (:export #:debug #:declaim #:declaration #:declare #:decode-float
	   #:decode-universal-time

	   #:defclass #:defconstant #:defgeneric #:define-compiler-macro
	   #:define-condition #:define-method-combination #:define-modify-macro
	   #:define-symbol-macro #:defmacro #:defpackage #:defparameter #:defstruct #:deftype #:defvar

	   #:delete-file #:delete-package #:denominator #:deposit-field
	   #:describe #:describe-object #:destructuring-bind
	   #:directory #:directory-namestring #:disassemble #:division-by-zero #:do #:do*
	   #:do-all-symbols #:do-external-symbols #:do-symbols #:documentation #:dolist
	   #:dotimes #:double-float #:double-float-epsilon
	   #:double-float-negative-epsilon #:dpb #:dribble #:dynamic-extent)
  (:export #:ecase #:echo-stream #:echo-stream-input-stream #:echo-stream-output-stream #:ed
	   #:eighth #:elt #:encode-universal-time #:end-of-file #:enough-namestring
	   #:ensure-directories-exist #:ensure-generic-function #:error #:etypecase
	   #:eval #:eval-when #:every #:exp #:export #:expt #:extended-char)
  (:export #:fceiling #:fdefinition #:ffloor #:fifth #:file-author #:file-error
	   #:file-error-pathname #:file-length #:file-namestring #:file-position
	   #:file-stream #:file-string-length #:file-write-date #:fill-pointer #:find
	   #:find-all-symbols #:find-class #:find-if #:find-method
	   #:find-package #:find-restart #:find-symbol #:finish-output #:first #:fixnum
	   #:flet #:float #:float-digits #:float-precision #:float-radix #:float-sign
	   #:floating-point-inexact #:floating-point-invalid-operation
	   #:floating-point-overflow #:floating-point-underflow #:floor #:force-output
	   #:format #:formatter #:fourth #:fresh-line #:fround #:ftruncate #:ftype
	   #:funcall #:function #:function-keywords #:function-lambda-expression)
  (:export #:gcd #:generic-function #:gensym #:gentemp #:get #:get-decoded-time
	   #:get-dispatch-macro-character #:get-internal-real-time
	   #:get-internal-run-time #:get-macro-character #:get-output-stream-string
	   #:get-properties #:get-universal-time #:gethash #:go)
  (:export #:handler-bind #:handler-case #:hash-table #:hash-table-count
	   #:hash-table-rehash-size #:hash-table-rehash-threshold #:hash-table-size
	   #:hash-table-test #:host-namestring)
  (:export #:identity #:if #:ignorable #:ignore
	   #:ignore-errors #:imagpart #:import #:in-package #:initialize-instance
	   #:inline #:inspect #:integer #:integer-decode-float #:integer-length #:intern
	   #:internal-time-units-per-second #:intersection #:invalid-method-error
	   #:invoke-debugger #:invoke-restart #:invoke-restart-interactively #:isqrt)
  (:export #:keyword)
  (:export #:labels #:lambda #:lambda-list-keywords #:lambda-parameters-limit
	   #:last #:lcm #:ldb #:ldb-test #:ldiff #:least-negative-double-float
	   #:least-negative-long-float #:least-negative-normalized-double-float
	   #:least-negative-normalized-long-float #:least-negative-normalized-short-float
	   #:least-negative-normalized-single-float #:least-negative-short-float
	   #:least-negative-single-float #:least-positive-double-float
	   #:least-positive-long-float #:least-positive-normalized-double-float
	   #:least-positive-normalized-long-float #:least-positive-normalized-short-float
	   #:least-positive-normalized-single-float #:least-positive-short-float
	   #:least-positive-single-float #:length #:let #:let* #:lisp-implementation-type
	   #:lisp-implementation-version #:list #:list* #:list-all-packages #:list-length
	   #:listen #:load #:load-logical-pathname-translations #:load-time-value
	   #:locally #:log #:logand #:logandc1 #:logandc2 #:logcount #:logeqv
	   #:logical-pathname #:logical-pathname-translations #:logior #:lognand #:lognor
	   #:lognot #:logorc1 #:logorc2 #:logtest #:logxor #:long-float
	   #:long-float-epsilon #:long-float-negative-epsilon #:long-site-name #:loop
	   #:loop-finish)
  (:export #:machine-instance #:machine-type #:machine-version
	   #:macro-function #:macroexpand #:macroexpand-1 #:macrolet #:make-array
	   #:make-broadcast-stream #:make-concatenated-stream #:make-condition
	   #:make-dispatch-macro-character #:make-echo-stream #:make-hash-table
	   #:make-instance #:make-instances-obsolete #:make-list #:make-load-form
	   #:make-load-form-saving-slots #:make-method #:make-package #:make-pathname
	   #:make-random-state #:make-sequence #:make-string #:make-string-input-stream
	   #:make-string-output-stream #:make-synonym-stream
	   #:make-two-way-stream #:map #:mapc #:mapcan #:mapcar #:mapcon #:maphash #:mapl
	   #:maplist #:mask-field #:max #:member #:member-if
	   #:merge-pathnames #:method #:method-combination #:method-combination-error
	   #:method-qualifiers #:min #:mismatch #:mod #:most-negative-double-float
	   #:most-negative-fixnum #:most-negative-long-float #:most-negative-short-float
	   #:most-negative-single-float #:most-positive-double-float
	   #:most-positive-fixnum #:most-positive-long-float #:most-positive-short-float
	   #:most-positive-single-float #:muffle-warning

	   #:multiple-values-limit)
  (:export #:namestring #:next-method-p #:nil #:ninth #:no-applicable-method #:no-next-method #:not
	   #:notany #:notevery #:notinline
	   #:nth-value #:number #:numerator)
  (:export #:open #:optimize #:or #:otherwise #:output-stream-p)
  (:export #:package #:package-error #:package-error-package
	   #:package-name #:package-nicknames #:package-shadowing-symbols
	   #:package-use-list #:package-used-by-list #:pairlis #:parse-error
	   #:parse-integer #:parse-namestring #:pathname #:pathname-device
	   #:pathname-directory #:pathname-host #:pathname-name #:pathname-type
	   #:pathname-version #:peek-char #:phase #:pi #:position #:position-if
	   #:pprint #:pprint-dispatch #:pprint-exit-if-list-exhausted
	   #:pprint-fill #:pprint-indent #:pprint-linear #:pprint-logical-block
	   #:pprint-newline #:pprint-pop #:pprint-tab #:pprint-tabular #:prin1
	   #:prin1-to-string #:princ #:princ-to-string #:print #:print-not-readable
	   #:print-not-readable-object #:print-object #:print-unreadable-object
	   #:probe-file #:proclaim #:prog #:prog* #:prog1 #:prog2 #:progn #:program-error
	   #:progv #:provide)
  (:export #:quote)
  (:export #:random #:random-state)
  (:export #:rassoc #:rassoc-if #:ratio #:rational
	   #:rationalize #:read #:read-byte #:read-char #:read-char-no-hang
	   #:read-delimited-list #:read-from-string #:read-line
	   #:read-preserving-whitespace #:read-sequence #:reader-error #:readtable
	   #:readtable-case #:real #:realpart #:reduce #:reinitialize-instance #:rem
	   #:remove #:remove-duplicates #:remove-if
	   #:remove-method #:rename-file #:rename-package #:require #:rest #:restart
	   #:restart-bind #:restart-case #:restart-name #:return #:return-from
	   #:revappend #:reverse #:room #:round)
  (:export #:safety #:satisfies #:sbit #:scale-float #:schar #:search #:second #:sequence
	   #:serious-condition #:set-difference #:set-dispatch-macro-character
	   #:set-exclusive-or #:set-macro-character #:set-pprint-dispatch
	   #:set-syntax-from-char #:seventh #:shadow #:shadowing-import
	   #:shared-initialize #:short-float #:short-float-epsilon
	   #:short-float-negative-epsilon #:short-site-name #:signal #:signed-byte
	   #:signum #:simple-array #:simple-base-string #:simple-bit-vector
	   #:simple-condition #:simple-condition-format-arguments
	   #:simple-condition-format-control #:simple-error #:simple-string
	   #:simple-type-error #:simple-vector #:simple-warning #:sin #:single-float
	   #:single-float-epsilon #:single-float-negative-epsilon #:sinh #:sixth #:sleep
	   #:slot-makunbound #:slot-missing #:slot-unbound #:slot-value #:software-type
	   #:software-version #:some #:sort #:space #:special #:special-operator-p
	   #:speed #:sqrt #:stable-sort #:standard #:standard-char #:standard-class
	   #:standard-generic-function #:standard-method #:standard-object #:step
	   #:storage-condition #:store-value #:stream #:stream-element-type
	   #:stream-error #:stream-error-stream #:stream-external-format

	   #:string-capitalize #:string-downcase #:string-left-trim
	   #:string-right-trim #:string-stream #:string-trim #:string-upcase

	   #:structure #:structure-class #:structure-object #:style-warning

	   #:sublis #:subseq #:subst #:subst-if #:substitute #:substitute-if
	   #:svref #:sxhash

	   #:symbol #:symbol-function #:symbol-macrolet
	   #:symbol-package #:symbol-plist #:symbol-value #:synonym-stream
	   #:synonym-stream-symbol)
  (:export #:t #:tagbody #:tan #:tanh #:tenth #:terpri #:the
	   #:third #:throw #:time #:trace #:translate-logical-pathname
	   #:translate-pathname #:tree-equal #:truename #:truncate #:two-way-stream
	   #:two-way-stream-input-stream #:two-way-stream-output-stream #:type
	   #:type-error #:type-error-datum #:type-error-expected-type #:type-of
	   #:typecase)
  (:export #:unbound-slot #:unbound-slot-instance #:unbound-variable
	   #:undefined-function #:unexport #:unintern #:union #:unless #:unread-char
	   #:unsigned-byte #:untrace #:unuse-package #:unwind-protect
	   #:update-instance-for-different-class #:update-instance-for-redefined-class
	   #:upgraded-array-element-type #:upgraded-complex-part-type #:use-package
	   #:use-value #:user-homedir-pathname #:values)
  (:export #:variable #:vector
	   #:vector-push-extend #:warn #:warning #:when #:with-accessors
	   #:with-compilation-unit #:with-condition-restarts #:with-hash-table-iterator
	   #:with-input-from-string #:with-open-file #:with-open-stream
	   #:with-output-to-string #:with-package-iterator #:with-simple-restart
	   #:with-slots #:with-standard-io-syntax #:write #:write-byte #:write-char
	   #:write-line #:write-sequence #:write-string #:write-to-string))










