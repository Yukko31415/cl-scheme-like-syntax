
(uiop:define-package #:cl-scheme-like-syntax.internal/common-lisp
  (:use #:cl))


(in-package #:cl-scheme-like-syntax.internal/common-lisp)


;; --------------------------------------------
;;;; 1. Evaluation and Compilation Dictionary
;; --------------------------------------------


(export
 '(lambda
   compile
   eval
   eval-when
   load-time-value
   quote
   compiler-macro-function
   define-compiler-macro
   defmacro
   macro-function
   macroexpand
   macroexpand-1
   define-symbol-macro
   symbol-macrolet
   *macroexpand-hook*
   proclaim
   declaim
   declare
   ignore
   ignorable
   dynamic-extent
   type
   typespec
   inline
   notinline
   ftype
   declaration
   optimize
   special
   locally
   the
   special-operator-p
   constantp))

(unexport
 '(special-operator-p
   constantp))



;; -----------------------------------
;;;; 2. Types and Classes Dictionary 
;; -----------------------------------


(export
 '(nil
   boolean
   function
   compiled-function
   generic-function
   standard-generic-function
   class
   built-in-class
   structure-class
   standard-class
   method
   standard-method
   structure-object
   standard-object
   method-combination
   t
   satisfies
   member
   not and or values
   eql
   coerce
   deftype
   subtypep
   type-of
   typep
   type-error
   type-error-datum
   type-error-expected-type
   simple-type-error))

(unexport
 '(subtypep typep))


;; ---------------------------------------
;;;; 3. Data and Control Flow Dictionary
;; ---------------------------------------


(export
 '(apply
   defun fdefinition fboundp
   fmakunbound
   flet
   labels
   macrolet
   funcall
   function
   function-lambda-expression
   functionp
   compiled-function-p
   call-arguments-limit
   lambda-list-keywords
   lambda-parameters-limit
   defconstant
   defparameter
   defvar destructuring-bind let
   let*
   progv
   setq psetq
   block
   catch go
   return-from
   return
   tagbody
   throw unwind-protect not
   t
   eq eql
   equal equalp
   identity
   complement
   constantly
   every
   some
   notevery
   notany
   and cond if or when unless case ccase
   ecase
   typecase
   ctypecase
   etypecase
   multiple-value-bind
   multiple-value-call
   multiple-value-list
   multiple-value-prog1
   multiple-value-setq
   values
   values-list
   multiple-values-limit
   nth-value
   prog
   prog*
   prog1
   prog2
   progn
   define-modify-macro
   defsetf
   define-setf-expander
   get-setf-expansion
   setf
   psetf
   shiftf
   rotatef
   control-error
   program-error
   undefined-function))

(unexport
 '(setq
   psetq))

(unexport
 '(rotatef
   shiftf
   setf
   psetf
   defsetf
   get-setf-expansion
   define-setf-expander))

(unexport
 '(fboundp functionp
   compiled-function-p
   eq eql
   equal equalp))

(unexport
 '(values-list
   multiple-value-list))

(unexport
 '(multiple-value-bind
   multiple-value-setq
   multiple-value-call
   multiple-value-prog1))


;; ---------------------------
;;;; 4. Iteration Dictionary
;; ---------------------------


(export
 '(do
   do*
   dotimes
   dolist
   loop
   loop
   loop-finish))


;; -------------------------
;;;; 5. Objects Dictionary
;; -------------------------


(export
 '(function-keywords
   ensure-generic-function
   documentation
   generic-function-class
   method-class
   allocate-instance
   reinitialize-instance
   shared-initialize
   update-instance-for-different-class
   update-instance-for-redefined-class
   change-class
   slot-boundp
   slot-exists-p
   slot-makunbound
   slot-missing
   slot-unbound
   slot-value
   method-qualifiers
   no-applicable-method
   no-next-method
   remove-method
   make-instance
   make-instances-obsolete
   make-load-form
   make-load-form-saving-slots
   with-accessors
   with-slots
   defclass
   defgeneric
   defmethod
   find-class
   next-method-p			;this is lical function
   call-method
   make-method
   call-next-method
   compute-applicable-methods
   define-method-combination
   define-method-combination
   find-method
   add-method
   initialize-instance
   class-name
   class-of
   unbound-slot
   unbound-slot-instance))

(unexport
 '(slot-boundp slot-exists-p))

(unexport
 '(slot-value))


;; ----------------------------
;;;; 6. Structures Dictionary
;; ----------------------------


(export
 '(defstruct
   copy-structure))


;; ----------------------------
;;;; 7. Conditions Dictionary
;; ----------------------------


(export
 '(condition
   warning
   style-warning
   serious-condition
   error
   cell-error
   cell-error-name
   parse-error
   storage-condition
   assert
   error
   cerror
   check-type
   simple-error
   invalid-method-error
   method-combination-error
   signal
   simple-condition
   simple-condition-format-control
   simple-condition-format-arguments
   warn
   simple-warning
   invoke-debugger
   break
   *debugger-hook*
   *break-on-signals*
   handler-bind
   handler-case
   ignore-errors
   define-condition
   make-condition
   restart
   compute-restarts
   find-restart
   invoke-restart
   invoke-restart-interactively
   restart-bind
   restart-case
   restart-name
   with-condition-restarts
   with-simple-restart
   abort
   continue
   muffle-warning
   store-value
   use-value
   abort
   continue
   muffle-warning
   store-value
   use-value))


;; -------------------------
;;;; 8. Symbols Dictionaly
;; -------------------------


(export
 '(symbol
   keyword
   symbolp
   keywordp
   make-symbol
   copy-symbol
   gensym
   *gensym-counter*
   gentemp
   symbol-function
   symbol-name
   symbol-package
   symbol-plist
   symbol-value
   get
   remprop
   boundp
   makunbound
   set
   unbound-variable))

(unexport
 '(remprop
   makunbound
   set))

(unexport
 '(symbolp keywordp boundp))

(unexport
 '(make-symbol
   symbol-name))


;; --------------------------
;;;; 9. Packages Dictionary 
;; --------------------------


(export
 '(package
   export
   find-symbol
   find-package
   find-all-symbols
   import
   list-all-packages
   rename-package
   shadow
   shadowing-import
   delete-package
   make-package
   with-package-iterator
   unexport
   unintern
   in-package
   unuse-package
   use-package
   defpackage
   do-symbols
   do-external-symbols
   do-all-symbols
   intern
   package-name
   package-nicknames
   package-shadowing-symbols
   package-use-list
   package-used-by-list
   packagep
   *package*
   package-error
   package-error-package))

(unexport
 '(packagep))


;; --------------------------
;;;; 10. Numbers Dictionary
;; --------------------------


(export
 '(number
   complex
   real
   float
   short-float
   single-float
   double-float
   long-float
   rational
   ratio
   integer
   signed-byte
   unsigned-byte
   mod
   bit
   fixnum
   bignum
   = /= < > <= >= max
   min
   minusp plusp zerop
   floor
   ffloor
   ceiling
   fceiling
   truncate
   ftruncate
   round
   fround
   sin
   cos
   tan
   asin
   acos
   atan
   pi
   sinh
   cosh
   tanh
   asinh
   acosh
   atanh
   *
   +
   -
   -
   /
   /
   1+ 1- abs
   evenp
   oddp
   exp
   expt
   gcd
   incf decf lcm
   log
   mod
   rem
   signum
   sqrt
   isqrt
   random-state
   make-random-state
   random
   random-state-p
   *random-state*
   numberp
   cis
   complex
   complexp
   conjugate
   phase
   realpart
   imagpart
   upgraded-complex-part-type
   realp
   numerator
   denominator
   rational
   rationalize
   rationalp
   ash
   integer-length
   integerp
   parse-integer
   boole
   boole-1
   boole-2
   boole-and
   boole-andc1
   boole-andc2
   boole-c1
   boole-c2
   boole-clr
   boole-eqv
   boole-ior
   boole-nand
   boole-nor
   boole-orc1
   boole-orc2
   boole-set
   boole-xor
   logand
   logandc1
   logandc2
   logeqv
   logior
   lognand
   lognor
   lognot
   logorc1
   logorc2
   logxor
   logbitp
   logcount
   logtest
   byte
   byte-size
   byte-position
   deposit-field
   dpb
   ldb
   ldb-test
   mask-field
   most-positive-fixnum
   most-negative-fixnum
   decode-float
   scale-float
   float-radix
   float-sign
   float-digits
   float-precision
   integer-decode-float
   float
   floatp
   most-positive-short-float
   least-positive-short-float
   least-positive-normalized-short-float
   most-positive-double-float
   least-positive-double-float
   least-positive-normalized-double-float
   most-positive-long-float
   least-positive-long-float
   least-positive-normalized-long-float
   most-positive-single-float
   least-positive-single-float
   least-positive-normalized-single-float
   most-negative-short-float
   least-negative-short-float
   least-negative-normalized-short-float
   most-negative-single-float
   least-negative-single-float
   least-negative-normalized-single-float
   most-negative-double-float
   least-negative-double-float
   least-negative-normalized-double-float
   most-negative-long-float
   least-negative-long-float
   least-negative-normalized-long-float
   short-float-epsilon
   short-float-negative-epsilon
   single-float-epsilon
   single-float-negative-epsilon
   double-float-epsilon
   double-float-negative-epsilon
   long-float-epsilon
   long-float-negative-epsilon
   arithmetic-error
   arithmetic-error-operands
   arithmetic-error-operation
   division-by-zero
   floating-point-invalid-operation
   floating-point-inexact
   floating-point-overflow
   floating-point-underflow))

(unexport
 '(decf
   incf))

(unexport
 '(minusp plusp oddp evenp
   zerop random-state-p
   numberp
   complexp
   realp
   rationalp
   integerp
   logbitp
   floatp))


;; -----------------------------
;;;; 11. Characters Dictionary
;; -----------------------------


(export
 '(character
   base-char
   standard-char
   extended-char
   char=
   char/=
   char<
   char>
   char<=
   char>=
   char-equal
   char-not-equal
   char-lessp
   char-greaterp
   char-not-greaterp
   char-not-lessp
   character
   characterp
   alpha-char-p
   alphanumericp
   digit-char
   digit-char-p
   graphic-char-p
   standard-char-p
   char-upcase
   char-downcase
   upper-case-p
   lower-case-p
   both-case-p
   char-code
   char-int
   code-char
   char-code-limit
   char-name
   name-char))

(unexport
 '(characterp
   alpha-char-p
   lower-case-p
   upper-case-p
   alphanumericp
   both-case-p
   graphic-char-p
   standard-char-p
   char=
   char/=
   char<
   char>
   char<=
   char>=
   char-equal
   char-not-equal
   char-lessp
   char-greaterp
   char-not-greaterp
   char-not-lessp
   digit-char-p))

(unexport
 '(name-char
   char-name

   char-code 
   code-char
   char-int))

(unexport
 '(digit-char))



;; -------------------------
;;;; 12. Conses Dictionary
;; -------------------------


(export
 '(cons
   consp
   atom
   rplaca
   rplacd
   car
   cdr
   caar
   cadr
   cdar
   cddr
   caaar
   caadr
   cadar
   caddr
   cdaar
   cdadr
   cddar
   cdddr
   caaaar
   caaadr
   caadar
   caaddr
   cadaar
   cadadr
   caddar
   cadddr
   cdaaar
   cdaadr
   cdadar
   cdaddr
   cddaar
   cddadr
   cdddar
   cddddr
   copy-tree
   sublis
   nsublis
   subst
   subst-if
   subst-if-not
   nsubst
   nsubst-if
   nsubst-if-not
   tree-equal
   copy-list
   list
   list*
   list-length
   listp
   make-list
   push
   pop
   first
   second
   third
   fourth
   fifth
   sixth
   seventh
   eighth
   ninth
   tenth
   nth
   endp
   null
   nconc
   append
   revappend
   nreconc
   butlast
   nbutlast
   last
   ldiff
   tailp
   nthcdr
   rest
   member
   member-if
   member-if-not
   mapc
   mapcar
   mapcan
   mapl
   maplist
   mapcon
   acons
   assoc
   assoc-if
   assoc-if-not
   copy-alist
   pairlis
   rassoc
   rassoc-if
   rassoc-if-not
   get-properties
   getf
   remf
   intersection
   nintersection
   adjoin
   pushnew
   set-difference
   nset-difference
   set-exclusive-or
   nset-exclusive-or
   subsetp
   union
   nunion))


(unexport
 '(rplaca
   rplacd
   nsublis
   nsubst
   nsubst-if
   nconc
   nreconc
   nbutlast
   nintersection
   nset-difference
   nset-exclusive-or
   nunion))

(unexport
 '(remf
   getf
   push
   pop
   pushnew))

(unexport
 '(consp listp endp
   tailp
   subsetp))


(unexport
 '(nth
   nthcdr))

(unexport
 '(subst-if-not
   nsubst-if-not 
   member-if-not
   assoc-if-not
   rassoc-if-not))



;; ------------------------
;;;; 13. Array Dictionary
;; ------------------------


(export
 '(array
   simple-array
   vector
   simple-vector
   bit-vector
   simple-bit-vector
   make-array
   initial-element
   initial-contents
   adjustable
   fill-pointer
   displaced-to
   displaced-index-offset
   adjust-array
   initial-element
   initial-contents
   fill-pointer
   displaced-to
   displaced-index-offset
   adjustable-array-p
   aref
   array-dimension
   array-dimensions
   array-element-type
   array-has-fill-pointer-p
   array-displacement
   array-in-bounds-p
   array-rank
   array-row-major-index
   array-total-size
   arrayp
   fill-pointer
   row-major-aref
   upgraded-array-element-type
   array-dimension-limit
   array-rank-limit
   array-total-size-limit
   simple-vector-p
   svref
   vector
   vector-pop
   vector-push
   vector-push-extend
   vectorp
   bit
   sbit
   bit-and
   bit-andc1
   bit-andc2
   bit-eqv
   bit-ior
   bit-nand
   bit-nor
   bit-orc1
   bit-orc2
   bit-xor
   bit-not
   bit-vector-p
   simple-bit-vector-p))

(unexport
 '(vector-pop vector-push))

(unexport
 '(adjustable-array-p
   array-has-fill-pointer-p
   array-in-bounds-p
   arrayp
   simple-vector-p
   vectorp
   bit-vector-p
   simple-bit-vector-p))

(unexport
 '(aref
   row-major-aref))


;; --------------------------
;;;; 14. Strings Dictionary
;; --------------------------

(export
 '(string
   base-string
   simple-string
   simple-base-string
   simple-string-p
   char
   schar
   string
   string-upcase
   string-downcase
   string-capitalize
   nstring-upcase
   nstring-downcase
   nstring-capitalize
   string-trim
   string-left-trim
   string-right-trim
   string=
   string/=
   string<
   string>
   string<=
   string>=
   string-equal
   string-not-equal
   string-lessp
   string-greaterp
   string-not-greaterp
   string-not-lessp
   stringp
   make-string))

(unexport
 '(nstring-upcase
   nstring-downcase
   nstring-capitalize))

(unexport
 '(stringp
   string=
   string-equal
   string/=
   string-not-equal
   string<
   string-lessp
   string>
   string-greaterp
   string<=
   string-not-greaterp
   string>=
   string-not-lessp))


;; ----------------------------
;;;; 15. Sequences Dictionary
;; ----------------------------


(export
 '(sequence
   copy-seq
   elt
   fill
   make-sequence
   subseq
   map
   map-into
   reduce
   count
   count-if
   count-if-not
   length
   reverse
   nreverse
   sort
   stable-sort
   find
   find-if
   find-if-not
   position
   position-if
   position-if-not
   search
   key
   end1
   mismatch
   replace
   substitute
   test-not
   end
   substitute-if
   substitute-if-not
   nsubstitute
   nsubstitute-if
   nsubstitute-if-not
   concatenate
   merge
   remove
   remove-if
   remove-if-not
   delete
   delete-if
   delete-if-not
   remove-duplicates
   start
   delete-duplicates
   start))

(unexport
 '(fill
   map-into
   nreverse
   replace
   nsubstitute
   nsubstitute-if
   merge
   delete
   delete-if
   delete-duplicates))

(unexport
 '(count-if-not
   find-if-not
   position-if-not
   substitute-if-not
   nsubstitute-if-not
   remove-if-not
   delete-if-not))


;; ------------------------------
;;;; 16. Hash Tables Dictionary
;; ------------------------------


(export
 '(hash-table
   make-hash-table
   hash-table-p
   hash-table-count
   hash-table-rehash-size
   hash-table-rehash-threshold
   hash-table-size
   hash-table-test
   gethash
   remhash
   maphash
   with-hash-table-iterator
   clrhash
   sxhash))

(unexport
 '(remhash clrhash))

(unexport
 '(hash-table-p))

(unexport
 '(gethash
   maphash))


;; ----------------------------
;;;; 17. Filenames Dictionary
;; ----------------------------


(export
 '(pathname
   logical-pathname
   pathname
   make-pathname
   pathnamep
   pathname-host
   pathname-device
   pathname-directory
   pathname-name
   pathname-type
   pathname-version
   load-logical-pathname-translations
   logical-pathname-translations
   logical-pathname
   *default-pathname-defaults*
   namestring
   file-namestring
   directory-namestring
   host-namestring
   enough-namestring
   parse-namestring
   wild-pathname-p
   pathname-match-p
   translate-logical-pathname
   translate-pathname
   merge-pathnames))

(unexport
 '(pathnamep
   wild-pathname-p
   pathname-match-p))


;; ------------------------
;;;; 18. Files Dictionary
;; ------------------------


(export
 '(directory
   probe-file
   ensure-directories-exist
   truename
   file-author
   file-write-date
   rename-file
   delete-file
   file-error
   file-error-pathname))


;; --------------------------
;;;; 19. Streams Dictionary
;; --------------------------


(export
 '(stream
   broadcast-stream
   concatenated-stream
   echo-stream
   file-stream
   string-stream
   synonym-stream
   two-way-stream
   input-stream-p
   output-stream-p
   interactive-stream-p
   open-stream-p
   stream-element-type
   streamp
   read-byte
   write-byte
   peek-char
   read-char
   read-char-no-hang
   terpri
   fresh-line
   unread-char
   write-char
   read-line
   write-string
   write-line
   read-sequence
   write-sequence
   file-length
   file-position
   file-position
   file-string-length
   open
   if-exists
   stream-external-format
   with-open-file
   close
   with-open-stream
   listen
   clear-input
   finish-output
   force-output
   clear-output
   y-or-n-p
   yes-or-no-p
   make-synonym-stream
   synonym-stream-symbol
   broadcast-stream-streams
   make-broadcast-stream
   make-two-way-stream
   two-way-stream-input-stream
   two-way-stream-output-stream
   echo-stream-input-stream
   echo-stream-output-stream
   make-echo-stream
   concatenated-stream-streams
   make-concatenated-stream
   get-output-stream-string
   make-string-input-stream
   make-string-output-stream
   with-input-from-string
   with-output-to-string
   *debug-io*
   *error-output*
   *query-io*
   *standard-input*
   *standard-output*
   *trace-output*
   *terminal-io*
   stream-error
   stream-error-stream
   end-of-file))

(unexport
 '(input-stream-p
   interactive-stream-p
   open-stream-p
   streamp
   yes-or-no-p
   y-or-n-p))



;; --------------------------
;;;; 20. Printer Dictionary
;; --------------------------


(export
 '(copy-pprint-dispatch
   formatter
   pprint-dispatch
   pprint-exit-if-list-exhausted
   pprint-fill
   pprint-linear
   pprint-tabular
   pprint-indent
   pprint-logical-block
   pprint-newline
   pprint-pop
   pprint-tab
   print-object
   print-unreadable-object
   set-pprint-dispatch
   write
   length
   pretty
   prin1
   princ
   print
   pprint
   write-to-string
   length
   pretty
   prin1-to-string
   princ-to-string
   *print-array*
   *print-base*
   *print-radix*
   *print-case*
   *print-circle*
   *print-escape*
   *print-gensym*
   *print-level*
   *print-length*
   *print-lines*
   *print-miser-width*
   *print-pprint-dispatch*
   *print-pretty*
   *print-readably*
   *print-right-margin*
   print-not-readable
   print-not-readable-object
   format))


;; -------------------------
;;;; 21. Reader Dictionary
;; -------------------------


(export
 '(readtable
   copy-readtable
   make-dispatch-macro-character
   read
   read-preserving-whitespace
   eof-value
   read-delimited-list
   read-from-string
   readtable-case
   readtablep
   get-dispatch-macro-character
   set-dispatch-macro-character
   get-macro-character
   set-macro-character
   set-syntax-from-char
   with-standard-io-syntax
   *read-base*
   *read-default-float-format*
   *read-eval*
   *read-suppress*
   *readtable*
   reader-error))

(unexport
 '(readtablep))


;; --------------------------------------
;;;; 22. System Construction Dictionary 
;; --------------------------------------


(export
 '(compile-file
   print
   compile-file-pathname
   load
   if-does-not-exist
   with-compilation-unit
   *features*
   *compile-file-pathname*
   *compile-file-truename*
   *load-pathname*
   *load-truename*
   *compile-print*
   *compile-verbose*
   *load-print*
   *load-verbose*
   *modules*
   provide require))


;; ------------------------------
;;;; 23. Environment Dictionary
;; ------------------------------


(export
 '(decode-universal-time
   encode-universal-time
   get-universal-time
   get-decoded-time
   sleep
   apropos
   apropos-list
   describe
   describe-object
   trace
   untrace
   step
   time
   internal-time-units-per-second
   get-internal-real-time
   get-internal-run-time
   disassemble
   documentation
   room
   ed
   inspect
   dribble
   -
   +
   ++
   +++
   *
   **
   ***
   /
   //
   ///
   lisp-implementation-type
   lisp-implementation-version
   short-site-name
   long-site-name
   machine-instance
   machine-type
   machine-version
   software-type
   software-version
   user-homedir-pathname))


;; ----------
;;;; Others
;; ----------


(export
 '(&whole
   &rest
   otherwise
   space
   speed
   &environment
   compilation-speed
   &allow-other-keys
   compiler-macro
   standard
   &body
   &key
   &optional
   structure
   variable
   &aux
   debug
   safety))

