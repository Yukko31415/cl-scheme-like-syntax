

(in-package #:cl-scheme-like-syntax/bangs)




;; ---------------------
;;;; Arrays Dictionary
;; ---------------------


(aliases (vector-pop!  . vector-pop)
	 (vector-push! . vector-push))


;; ---------------------
;;;; Conses Dictionary
;; ---------------------


(aliases (set-car!    . rplaca)
	 (set-cdr!    . rplacd)
	 (sublis!     . nsublis)
	 (subst!      . nsubst)
	 (subst-if!   . nsubst-if)
	 (append!     . nconc)
	 (revappend!  . nreconc)
	 (butlast!    . nbutlast)
	 
	 (intersection!     . nintersection)
	 (set-difference!   . nset-difference)
	 (set-exclusive-or! . nset-exclusive-or)
	 (union!            . nunion))





;; ----------------------
;;;; Strings Dictionary
;; ----------------------


(aliases (string-upcase!     . nstring-upcase)
	 (string-downcase!   . nstring-downcase)
	 (string-capitalize! . nstring-capitalize))





;; ----------------------
;;;; Symbols Dictionary
;; ----------------------


(aliases (remove-prop!    . remprop)
	 (make-unbound!   . makunbound)
	 (set!            . set))




;; ------------------------
;;;; Sequences Dictionary
;; ------------------------


(aliases (fill!              . fill)
	 (map!               . map-into)
	 (reverse!           . nreverse)
	 (replace!           . replace)
	 (substitute!        . nsubstitute)
	 (substitute-if!     . nsubstitute-if)
	 (merge!             . merge)
	 (remove!            . delete)
	 (remove-if!         . delete-if)
	 (remove-duplicates! . delete-duplicates))





;; --------------------------
;;;; Hash Tables Dictionary
;; --------------------------


(aliases (remove-hash! . remhash)
	 (clear-hash!  . clrhash))




;; ------------------------------------
;;;; Data and Control Flow Dictionary
;; ------------------------------------


;; `setq'は specil operator なので、エイリアスを登録することができない
;; マクロとして登録することは可能だが、あまり行儀のいい方法ではないか？

(alias make-function-unbound! fmakunbound)

(defmacro setq! (&rest things)
  `(cl:setq ,@things))

(defmacro psetq! (&rest pairs)
  `(cl:psetq ,@pairs))









