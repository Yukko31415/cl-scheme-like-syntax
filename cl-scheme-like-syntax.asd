;;; cl-scheme-like-syntax.asd
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2026 Yukko

(asdf:defsystem #:cl-scheme-like-syntax
  :description "A basic application."
  :author      "Yukko"
  :license     "MIT"
  :version     "0.1.0"
  :depends-on  ("trivial-indent")
  :serial t
  :components ((:file "src/package")
	       (:file "src/internal")
	       (:file "src/predicates")
	       (:file "src/places")
	       (:file "src/bangs")
	       (:file "src/compatibility")
	       (:file "src/srfis")))
