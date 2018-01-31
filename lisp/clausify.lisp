;; funzioni fornite all'interno delle specifiche

(defun variablep (v)
  (and
   (symbolp v)(char= #\? (char (symbol-name v) 0))))

(defun skolem-variable ()
  (gentemp "SV-"))

(defun skolem-function* (&rest args)
  (cons (gentemp "SF-") args))

(defun skolem-function (args)
  (apply #'skolem-function* args))

;; funzioni principali

(defun as-cnf (fbf)
  ;;...
  )

(defun is-horn (fbf)
  ;;...
  )

;; rimozione regole di implicazione
;; passaggio 1 dell'algoritmo

(defun rm-implication (fbf)
  ;;...
  )

;; riduzione delle negazioni
;; passaggio 2 dell'algoritmo

(defun rd-negation (fbf)
  ;;...
  )

;; skolemizzazione
;; passaggio 3 dell'algoritmo

(defun skolemization (fbf)
  ;;...
  )

;; semplificazione degli universali
;;passaggio 4 dell'algoritmo

(defun un-semplification (fbf)
  ;;...
  )

;; distribuzione dell'or
;; passaggio 5 dell'algoritmo

(defun rm-or (fbf)
  ;;...
  )

;;======================================================
					;REGOLE
;;======================================================

(defun term (expr)
  (or
   (const expr)
   (variablep expr)
   (funct expr)
   )
  )

(defun const (expr)
  (or
   (number expr)
   (id expr)
   )
  )

(defun funct (expr)
  (and
   (not (null expr))
   (listp expr)
   (id (first expr))
   (term (rest expr))
   )
  )

(defun wff (expr)
  (or
   (pred expr)
   (neg expr)
   (conj expr)
   (disj expr)
   (impl expr)
   (univ expr)
   (exist expr)
   )
  )

(defun pred (expr)
  (or
   (id expr)
   (funct expr)
   )
  )

(defun neg (expr)
  (and
   (listp expr)
   (= 2 (length expr))
   (eq 'not' (first expr))
   (wff (rest expr))
   )
  )

(defun conj (expr)
  (and
   (not (null expr))
   (listp expr)
   (eq 'and (first expr))
   (every wff (rest expr))
   )
  )

(defun disj (expr)
  (and
   (not (null expr))
   (listp expr)
   (eq 'or (first expr))
   (every wff (rest expr))
   )
  )

(defun impl (expr)
  (and
   (not (null expr))
   (= 3 (length expr))
   (eq 'implies (first expr))
   (every wff (rest expr))
   )
  )

(defun univ (expr)
  (and
   (not (null expr))
   (= 3 (length expr))
   (eq 'every (first expr))
   (variablep (first (rest expr)))
   (wff (rest (rest expr)))
   )
  )

(defun exist (expr)
  (and
   (not (null expr))
   (= 3 (length expr))
   (eq 'exist (first expr))
   (variablep (second expr))
   (wff (third expr))
   )
  )

