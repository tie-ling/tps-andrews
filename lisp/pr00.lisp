;;; -*- Mode:LISP; Package:AUTO -*-
;;; ******************************************************************* ;;;
;;;         (c) Copyrighted 1988 by Carnegie Mellon University.         ;;;
;;;                        All rights reserved.                         ;;;
;;;         This code was written as part of the TPS project.           ;;;
;;;   If you want to use this code or any part of TPS, please contact   ;;;
;;;               Peter B. Andrews (Andrews@CS.CMU.EDU)                 ;;;
;;; ******************************************************************* ;;;

(in-package :AUTO)
(part-of PRIMITIVE-SUBST)

;;;
;;; File: PR00
;;; Functions for generating set substitutions using PRIMSUB-METHOD PR00

(deffile pr00
  (part-of PRIMITIVE-SUBST)
  (extension clisp)
  (mhelp "PR00 set substitution functions"))

(context primsubs)

(defvar *pr00-setsubs* nil)

(defflag PR00-NUM-ITERATIONS
  (flagtype posinteger)
  (default 1)
  (subjects primsubs important transmit)
  (relevancy-preconditions
   (primsub-method (eq primsub-method 'pr00)))
  (irrelevancy-preconditions
   (primsub-method (neq primsub-method 'pr00)))
  (mhelp "Number of times to iterate the PR00 Set Substitution process."))

(defflag pr00-max-substs-var
  (flagtype null-or-integer)
  (default 4)
  (subjects primsubs unification transmit)
  (relevancy-preconditions
   (primsub-method (eq primsub-method 'pr00)))
  (irrelevancy-preconditions
   (primsub-method (neq primsub-method 'pr00)))
  (mhelp "The setting for MAX-SUBSTS-VAR when generating
set variable instantiations by unification
using PRIMSUB-METHOD PR00."))

(defflag pr00-require-arg-deps
    (flagtype boolean)
  (default nil)
  (subjects primsubs transmit)
  (relevancy-preconditions
   (primsub-method (eq primsub-method 'pr00)))
  (irrelevancy-preconditions
   (primsub-method (neq primsub-method 'pr00)))
  (mhelp "If T, do not consider set subsitutions which do not
depend on some argument.  For example, do not consider
    P --> lambda x y PHI
where neither x nor y is free in PHI.  This often rules out many
setsubs generated by unification."))

(defflag pr00-allow-subnode-conns
    (flagtype boolean)
  (default t)
  (subjects primsubs transmit)
  (relevancy-preconditions
   (primsub-method (eq primsub-method 'pr00)))
  (irrelevancy-preconditions
   (primsub-method (neq primsub-method 'pr00)))
  (mhelp "If T, we allow connections between nodes and their subnodes."))

; fall back on older function
(defun replace-pi-sigma-with-quantifiers (wff)
  (let ((binder-sigma-string (symbol-name binder-sigma))
	(binder-pi-string (symbol-name binder-pi)))
    (declare (special binder-sigma-string binder-pi-string))
    (replace-pi-and-sigma-in-wff wff)))  ; an old function in mating-merge2.lisp, but it needs the two special variables to be defined

(defun compound-formula-p (wff &optional past-negs)
  (do ((w wff (cdr w)))
      ((not (lambda-bd-p w))
       (or (equals-p w)
	   (implies-p w)
	   (and-p w)
	   (or-p w)
	   (equiv-p w)
	   (ae-bd-wff-p w)
	   (and past-negs (not-p w) (compound-formula-p (cdr w) t))))))

(defun term-indep-of-args-p (trm)
  (let ((trm1 trm)
	(trm2 trm))
    (do ((y (type trm) (car y)))
	((atom y)
	 (wffeq-ab (lnorm trm1) (lnorm trm2)))
      (setq trm1 (cons trm1 (fresh-var (cdr y) 'x)))
      (setq trm2 (cons trm2 (fresh-var (cdr y) 'y))))))

(defun pr00-formula-unify (wff1 wff2 free-vars)
  (let ((stop-at-tsn nil)) ; want every success node
    (multiple-value-bind
	(root-node subst-hash-table)
	(initialize-utree (list (cons wff1 wff2)) 
			  (mapcar #'strip-exp-vars
				  free-vars))
      (multiple-value-bind
	  (flag root hash-table success-nodes)
	  (unify-old root-node subst-hash-table) ; unify-msv only returns first success node
	  (declare (ignore root hash-table))
	(values flag success-nodes)))))

					; exception-setvars - list of setvars which should not be instantiated (e.g., Leibniz q's)
					; num-prims - number of primsubs to allow for a single expansion node
(defun generate-pr00-setsubs (exception-setvars num-prim)
  (declare (special *pr00-setsubs* options-verbose))
  (setq *pr00-setsubs* nil)
  (unless (and (eproof-p current-eproof)
	       (etree-p (eproof-etree current-eproof)))
    (throwfail "Should have an eproof in current-eproof with an etree in its etree slot when generate-pr00-setsubs is called."))
  (let ((f (etree-to-ftree (eproof-etree current-eproof)))
	(ALLOW-NONLEAF-CONNS '(ALL))
	(DISSOLVE nil)
	(MAX-SUBSTS-VAR PR00-MAX-SUBSTS-VAR)
	(exceptions exception-setvars))
    (declare (special ALLOW-NONLEAF-CONNS DISSOLVE MAX-SUBSTS-VAR exceptions))
    (generate-pr00-setsubs-rec f nil num-prim)))

					; f - ftree
					; conns - connections
					; num-prims - number of primsubs to allow for a single expansion node
(defun generate-pr00-setsubs-rec (f conns num-prim)
  (declare (special exceptions options-verbose))
  (when (> PR00-NUM-ITERATIONS 0)
    (when options-verbose
      (msgf "Iteration Level " PR00-NUM-ITERATIONS t))
    (let* ((frees (substitutable-exp-vars-of-ftree f))
	   (setvars nil)
	   (MATE-UP-TO-NNF NIL))
      (declare (special MATE-UP-TO-NNF))
      (let ((jform (ftree-to-jform f)))
	(dolist (v frees)
		(when (set-var-p v)
		  (unless (member v exceptions :test #'(lambda (x y)
							 (equal (exp-var-var x) y)))
		    (push (exp-var-var v) setvars))))
	(generate-pr00-unif-setsubs jform f conns setvars frees num-prim)))))

(defun generate-pr00-unif-setsubs (jform f conns setvars frees num-prim)
  (case (jform-type jform)
    (conjunction 
     (do ((cl1 (conjunction-components jform) (cdr cl1)))
	 ((not cl1)) 
       (generate-pr00-unif-setsubs (car cl1) f conns setvars frees num-prim)
       (dolist (c2 (cdr cl1))
	 (generate-pr00-unif-setsubs-2 (car cl1) c2 f conns setvars frees num-prim))))
    (disjunction
     (dolist (c (disjunction-components jform))
       (generate-pr00-unif-setsubs c f conns setvars frees num-prim)))
    (t nil)))

(defun generate-pr00-unif-setsubs-2 (j1 j2 f conns setvars frees num-prim)
  (declare (special options-verbose))
  (let ((litlist1 (ob-jform-to-literal-list j1))
	(litlist2 (ob-jform-to-literal-list j2))
	(nn-assoc2 nil))
    (dolist (lit2 litlist2)
      (push (cons lit2 (if (jform-pos lit2)
					    (cons 'NOT (literal-represents lit2))
			 (literal-represents lit2)))
	    nn-assoc2))
    (dolist (lit1 litlist1)
      (let ((nsh1 (neg-norm (if (jform-pos lit1)
				(literal-represents lit1)
			      (cons 'NOT (literal-represents lit1))))))
	(dolist (lit2 litlist2)
	  (when (or PR00-ALLOW-SUBNODE-CONNS
		    (not (or (find-ftree-node-rec (literal-name lit2) (find-ftree-node (literal-name lit1) f))
			     (find-ftree-node-rec (literal-name lit1) (find-ftree-node (literal-name lit2) f)))))
	  (when options-verbose
	    (msgf "Trying to connect " lit1 " with " lit2))
	  (if (not (eq (jform-pos lit1) (jform-pos lit2))) ; if trees have opposite sign,
					; we might be able to unify the actual formulas (not just nnf's) in which case
					; we might end up with a cleaner ND proof (see X5310 for an example)
	      (multiple-value-bind
		  (flag success)
		  (pr00-formula-unify (literal-represents lit1)
				      (literal-represents lit2) frees)
		(if (eq flag 'fail)	; might still be able to unify nnf's
		    (let ((n2 (cdr (assoc lit2 nn-assoc2))))
		      (multiple-value-bind
			  (flag2 success2)
			  (pr00-formula-unify nsh1 n2 frees)
			(unless (eq flag2 'fail)
			  (dolist (sn success2)
			    (generate-pr00-unif-setsubs-3 
			     sn f 
			     (acons (literal-name lit1) (literal-name lit2) conns)
			     setvars frees num-prim)))))
		  (dolist (sn success)
		    (generate-pr00-unif-setsubs-3
		     sn f
		     (acons (literal-name lit1) (literal-name lit2) conns)
		     setvars frees num-prim))))
	    (let ((n2 (cdr (assoc lit2 nn-assoc2))))
	      (multiple-value-bind
		  (flag success)
		  (pr00-formula-unify nsh1 n2 frees)
		(unless (eq flag 'fail)
		  (dolist (sn success)
		    (generate-pr00-unif-setsubs-3 
		     sn f
		     (acons (literal-name lit1) (literal-name lit2) conns)
		     setvars frees num-prim))))))))))))

; sn - success (unif) node
(defun generate-pr00-unif-setsubs-3 (sn f conns setvars frees num-prim)
  (declare (special options-verbose))
  (let* ((subst-stack (node-subst-stack sn))
	 (ss (intersection setvars (mapcar #'car subst-stack)))
	 (frees2 (mapcar #'strip-exp-vars frees))
	 (theta nil)
	 (rejected nil)
	 (some-compound-formula nil))
    (when ss
      (dolist (v frees2)
	(let ((a (assoc v subst-stack)))
	  (when a
	    (let ((trm (replace-pi-sigma-with-quantifiers
			(lambda-reduce-subst (cdr a) subst-stack))))
	      (push (cons v trm)
		    theta)
	      (when (and pr00-require-arg-deps
			 (member v ss)
			 (term-indep-of-args-p trm))
		(setq rejected t)
		(return nil))
	      (when (and (member v ss)
			 (compound-formula-p trm))
		(setq some-compound-formula t))))))
      (when (and some-compound-formula
		 (not rejected))
	(let* ((f2 
		(catch 'cycle
		  (simul-substitute-in-ftree
		   theta
		   (if (> num-prim 0)
		       (duplicate-evars-max (intersection setvars (mapcar #'car theta)) f num-prim)
		     f))))
	       (conns2 (when (ftree-p f2) (ftree-mating-image conns f f2))))
	  (when (and (ftree-p f2)
		     (check-acyclicity-ftree f2))
	    (when options-verbose
	      (msgf "Generated SetSub:" t)
	      (dolist (sub theta)
		(msgf ((car sub) . gwff) " --> " ((cdr sub) . gwff))))
					; I could have some subsumption check to make sure essentially the same subst is not found
					; in two different ways.
	    (unless rejected
	      (let ((DISSOLVE conns2)
		    (ALLOW-NONLEAF-CONNS '(ALL)))
		(declare (special DISSOLVE ALLOW-NONLEAF-CONNS))
		(push (cons f2 conns2)
		      *pr00-setsubs*)
		(let ((PR00-NUM-ITERATIONS (- PR00-NUM-ITERATIONS 1)))
		  (declare (special PR00-NUM-ITERATIONS))
		  (generate-pr00-setsubs-rec f2 conns2 num-prim))
		(when (and options-verbose (> PR00-NUM-ITERATIONS 1))
		  (msgf "Returning to Iteration Level " PR00-NUM-ITERATIONS))))))))))

(defun set-var-p (v)
  (do ((y (type v) (car y)))
      ((atom y)
       (eq y 'O))))

