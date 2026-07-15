

(in-package #:cl-scheme-like-syntax/number)


;; ---------
;;;; types
;; ---------


;;
;; proper-radix



(deftype proper-radix ()
  `(integer 2 36))


;;
;; exact complex, inexact complex

(defun exact-complex? (number)
  (and (complex? number)
       (rational? (realpart number))
       (rational? (imagpart number))))

(deftype exact-complex ()
  `(satisfies exact-complex?))

(deftype inexact-complex ()
  `(and complex (not exact-complex)))



(defparameter *factors*
  ;; 2 ~ 36までの素因数（事前に累乗を計算している）
  ;; 分数がその基数において有限小数かどうかの判定と、
  ;; その桁の判定に用いる。
  (vector '((2))   			; 2
	  '((3)) 			; 3
	  '((4 2)) 			; 4
	  '((5)) 			; 5
	  '((3) (2)) 			; 6
	  '((7)) 			; 7
	  '((8 4 2)) 			; 8
	  '((9 3)) 			; 9
	  '((5) (2)) 			; 10
	  '((11)) 			; 11
	  '((3) (4 2)) 			; 12
	  '((13)) 			; 13
	  '((7) (2)) 			; 14
	  '((5) (3)) 			; 15
	  '((16 8 4 2)) 		; 16
	  '((17)) 			; 17
	  '((9 3) (2)) 			; 18
	  '((19)) 			; 19
	  '((5) (4 2)) 			; 20
	  '((7) (3)) 			; 21
	  '((11) (2)) 			; 22
	  '((23)) 			; 23
	  '((3) (8 4 2)) 		; 24
	  '((10 5)) 			; 25
	  '((13) (2)) 			; 26
	  '((27 9 3)) 			; 27
	  '((7) (4 2)) 			; 28
	  '((29)) 			; 29
	  '((5) (3) (2)) 		; 30
	  '((31)) 			; 31
	  '((32 16 8 4 2)) 		; 32
	  '((11) (3)) 			; 33
	  '((17) (2)) 			; 34
	  '((7) (5)) 			; 35
	  '((9 3) (4 2)))) 		; 36




(defun radix->factor (radix)
  (declare (proper-radix radix))
  (vector-ref *factors* (- radix 2)))


(defun %terminating-decimal? (denominator list &aux (phase :first))
  (macrolet
      ((%inc@ (place) `(case phase (:first (inc@ ,place)) (:second (inc@ ,place) (set@ phase :other)))))
    (loop :with count := 0
	  :for num := (pop list) :then (if next? (pop list) num)
	  :for next? := nil
	  :if (null? num) :return (values denominator count) :else
	    :do (bind-with-values (quot rem) (truncate denominator num)
		  (cond ((not (zero? rem)) (set@ next? t) (case phase (:first (set@ phase :second))))
			((= 1 quot)       (%inc@ count)  (return (values quot count)))
			(t                (%inc@ count)  (set@ denominator quot)))))))


(defun terminating-decimal? (ratio &optional (radix 10))
  (declare (ratio ratio))
  (declare (proper-radix radix))
  (loop :with denominator := (denominator ratio)
	:with factors     := (radix->factor radix)
	:for  list        :in factors
	:for  (quot count) := (values->list (%terminating-decimal? denominator list))
	                       :then (values->list (%terminating-decimal? quot list))
	:maximize count :into max
	:if (= 1 quot) :return (values t max)
	  :finally (return (values nil nil))))



;; ------------------
;;;; number->string
;; ------------------



;;
;; integer->string


(defun %integer-digit (n &optional (radix 10))
  (if (zero? n) 1 (1+ (floor (log (abs n) radix)))))

(defun %integer-length (n &optional (radix 10))
  (let* ((minus? (minus? n))
	 (length (+ (%integer-digit n radix) (if minus? 1 0))))
    length))

(defun %integer->string! (target-string n &key (start 0) (radix 10))
  (if (zero? n) (set@ (string-ref target-string start) #\0)
      (let* ((abs-n         (abs n))
	     (minus?        (minus? n))
	     (start-index   (+ (%integer-digit n radix) (if minus? 0 -1) start))
	     (end-index     (if minus? (+ start 1) (+ start 0))))
	(loop :for index :downfrom start-index :to end-index
	      :initially (when minus? (set@ (string-ref target-string start) #\-))
	      :until (zerop abs-n)
	      :do (bind-with-values (quot rem) (truncate abs-n radix)
		    (set@ (string-ref target-string index) (integer->char rem radix))
		    (set@ abs-n quot)))))
  target-string)



;;
;; ratio->string


(defun %ratio-digit (ratio &optional (radix 10))
  (declare (ratio ratio))
  (bind-with-values (terminating? fractional-digit) (terminating-decimal? ratio radix)
    (if (not terminating?) nil
	(let* ((quot (truncate ratio))
	       (integer-digit (%integer-digit quot radix)))
	  (+ integer-digit fractional-digit)))))


(defun %ratio-length (ratio &optional (radix 10))
  (declare (ratio ratio))
  (let* ((digit (%ratio-digit ratio radix))
	 (minus? (minus? ratio)))
    (when digit (+ digit 1 (if minus? 1 0)))))

(defun %ratio-length/non-float (ratio &optional radix)
  (+ (%integer-length (numerator ratio) radix)
     (%integer-length (denominator ratio) radix)
     1))


(defun %ratio->string! (target-string ratio &key (start 0) (radix 10))
  (declare (ratio ratio))
  (bind-with-values (quot rem) (truncate ratio)
    (let* ((minus? (minus? ratio))
	   (integer-digit (%integer-digit quot radix))
	   (point-index (+ integer-digit start (if minus? 1 0))))
      (when minus? (set@ (string-ref target-string start) #\-))
      (%integer->string! target-string quot :radix radix :start (+  start (if minus? 1 0)))
      (set@ (string-ref target-string point-index) #\.)
      (loop :for index :from (1+ point-index)
	    :with abs-rem := (abs rem)
	    :until (zero? abs-rem)
	    :do (bind-with-values (int frac) (truncate (* abs-rem radix))
		  (set@ (string-ref target-string index) (integer->char int radix))
		  (set@ abs-rem frac)))
      target-string)))

(defun %ratio->string!/non-float (target-string ratio &key (start 0) (radix 10))
  (declare (ratio ratio))
  (let* ((numerator (numerator ratio))
	 (denominator (denominator ratio))
	 (numerator-length (%integer-length numerator radix)))
    (%integer->string! target-string numerator :start start :radix radix)
    (set@ (string-ref target-string numerator-length) #\/)
    (%integer->string! target-string denominator :start (1+ numerator-length) :radix radix)))



;;
;; float->string



(defun %rationalize (float)
  (declare (float float))
  (loop :count (set@ float (* float 10)) :into count
	:when (zero? (nth-value 1 (truncate float)))
	  :return (/ (rational float) (expt 10 count))))

(defun %float-length (float &optional (radix 10))
  (declare (float float))
  (let ((rationalize (%rationalize float)))
    (typecase rationalize
      (integer (+ 2 (%integer-length rationalize radix)))
      (ratio   (%ratio-length rationalize radix)))))

(defun %float->string! (target-string float &key (start 0) (radix 10))
  (declare (float float))
  (let ((rationalize (%rationalize float)))
    (typecase rationalize
      (integer (%integer->string! target-string rationalize :start start :radix radix)
	       (replace! target-string ".0" :start1 (+ start (%integer-length rationalize))))
      (ratio (%ratio->string! target-string rationalize :start start :radix radix)))))



;;
;; real->string


(defun %real-length (real &optional (radix 10))
  (declare (real real))
  (etypecase real
    (integer (%integer-length real radix))
    (float   (%float-length real radix))
    (ratio   (%ratio-length/non-float real radix))))

(defun %real->string! (target-string real &key (start 0) (radix 10))
  (declare (real real))
  (etypecase real
    (integer (%integer->string! target-string real :start start :radix radix))
    (float   (%float->string! target-string real :start start :radix radix))
    (ratio   (%ratio->string!/non-float target-string real :start start :radix radix))))

(defun real->string (real &optional (radix 10) &aux (length (%real-length real radix)))
  (declare (real real))
  (when length (%real->string! (make-string length) real :radix radix)))



;;
;; complex->string


(defun %imag-length (imag &optional (radix 10) &aux (length (%real-length imag radix)))
  (when length
    (+ length (if (minus? imag) 1 2) (if (eql? 1 imag) -1 0))))


(defun %imag->string! (target-string imag &key (start 0) (radix 10))
  (let ((minus?      (minus? imag))
	(imag-length (%real-length imag radix))
	(one?        (eql? 1 (abs imag))))
    (cond (one?   (set@ imag-length 0)
		  (replace! target-string (if minus? "-i" "+i") :start1 start))
	  (minus? (%real->string! target-string imag :start start :radix radix)
		  (set@ (string-ref target-string (+ start imag-length)) #\i))
	  (t      (set@ (string-ref target-string start) #\+)
		  (%real->string! target-string imag :start (1+ start) :radix radix)
		  (set@ (string-ref target-string (+ start imag-length 1)) #\i))))
  target-string)


(defun %complex->string! (target-string complex &key (start 0) (radix 10))
  (let* ((realpart    (realpart complex))
	 (imagpart    (imagpart complex))
	 (real-length (%real-length realpart radix)))
    (%real->string! target-string realpart :start start :radix radix)
    (%imag->string! target-string imagpart :start (+ real-length start) :radix radix))
  target-string)


(defun complex->string (complex &optional (radix 10))
  (declare (complex complex))
  (let* ((realpart    (realpart complex))
	 (imagpart    (imagpart complex))
	 (real-length (%real-length realpart radix))
	 (imag-length (%imag-length imagpart radix)))
    (when (and real-length imag-length)
      (%complex->string! (make-string (+ real-length imag-length)) complex :radix radix))))


;;
;; number->string

(defun number->string (number &optional (radix 10))
  (declare (number number))
  (etypecase number
    (real    (real->string    number radix))
    (complex (complex->string number radix))))





;; ------------------
;;;; string->number
;; ------------------



;;
;; string->integer


(defun string->integer (string &key (start 0) (end nil) (radix 10) (sign-allowed t))
  (declare (proper-radix radix))
  (when (or sign-allowed (not (member (char string start) '(#\+ #\-))))
    (values (ignore-errors (parse-integer string :radix radix :start start :end end)))))

(defmacro %string->integer (string start end radix sign-allowed)
  `(string->integer ,string :start ,start :end ,end :radix ,radix :sign-allowed ,sign-allowed))

;;
;; string->float-or-ratio


(defun %make-float (int frac digit)
  (funcall (if (minus? int) #'- #'identity)
	   (float (+ (abs int) (/ frac (expt 10 digit))))))

(defun string->float-or-ratio (string &key (start 0) (end nil) (radix 10) (sign-allowed t) &aux type-char)
  (if-let (pos (position-if (lambda (char) (if-let (list (member char '(#\. #\/))) (set@ type-char (car list))))
			    string :start start :end end))
    (let* ((end    (or end (length string)))
	   (first  (%string->integer string start pos radix sign-allowed))
	   (second (%string->integer string (1+ pos) end radix nil)))
      (cond ((char=? type-char #\.) (%make-float (if (zero? pos) 0 first) second (- end (1+ pos))))
	    ((not (and first second)) nil)
	    ((char=? type-char #\/) (/ first second))))))

(defmacro %string->float-or-ratio (string start end radix sign-allowed)
  `(string->float-or-ratio ,string :start ,start :end ,end :radix ,radix :sign-allowed ,sign-allowed))


;;
;; string->real

(defun string->real (string &key (start 0) (end nil) (radix 10) (sign-allowed t))
  (or (%string->integer string start end radix sign-allowed)
     (%string->float-or-ratio string start end radix sign-allowed)))

(defmacro %string->real (string start end radix sign-allowed)
  `(string->real ,string :start ,start :end ,end :radix ,radix :sign-allowed ,sign-allowed))

;;
;; string->imag

(defun string->imag (string &key (start 0) (end nil) (radix 10) (sign-allowed t))
  (let* ((lst              nil)
	 (end              (or end (length string)))
	 (length           (- end start))
	 (string->imagpart (lambda () (if-let (num (%string->real string start (1- end) radix sign-allowed))
				   (complex 0 num)))))
    (when (char=? (char string (1- end)) #\i)
      (cond ((= length 1) (complex 0 1))
	    ((and (= length 2) (if-let (list (member (char string start) '(#\+ #\-))) (set@ lst list)))
	     (cond ((char=? (car lst) #\-) (complex 0 -1))
		   ((char=? (car lst) #\+) (complex 0 1))))
	    (t (funcall string->imagpart))))))

(defmacro %string->imag (string start end radix sign-allowed)
  `(string->imag ,string :start ,start :end ,end :radix ,radix :sign-allowed ,sign-allowed))

;;
;; string->complex


(defmacro and-let* (bindings &body body)
  `(let ,bindings
     (when (and ,@(mapcar #'car bindings))
       ,@body)))

(defun string->complex (string &key (start 0) (end nil) (radix 10) (sign-allowed t))
  (if-let (pos (position-if (lambda (char) (member char '(#\+ #\-))) string :start start :end end :from-end t))
    (if (zero? pos)
	(%string->imag string start end radix sign-allowed)
	(let ((realpart (%string->real string start pos radix sign-allowed))
	      (imagpart (%string->imag string pos end radix sign-allowed)))
	  (when (and realpart imagpart) (+ realpart imagpart))))
    (%string->imag string start end radix sign-allowed)))


;;
;; string->number

(defun string->number (string &key (start 0) (end nil) (radix 10))
  (or (string->complex string :start start :end end :radix radix)
      (string->real string :start start :end end :radix radix)))








