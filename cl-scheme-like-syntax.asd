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
  :components ((:module "src"
		:components ((:file "package")
			     (:file "internal")
			     (:file "predicates")
			     (:file "places")
			     (:file "bangs")
			     (:file "compatibility")
			     (:file "srfis")))))
