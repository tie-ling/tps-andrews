;;; -*- Mode:LISP; Package:ML -*-
;;; ******************************************************************* ;;;
;;;         (c) Copyrighted 1988 by Carnegie Mellon University.         ;;;
;;;                        All rights reserved.                         ;;;
;;;         This code was written as part of the TPS project.           ;;;
;;;   If you want to use this code or any part of TPS, please contact   ;;;
;;;               Peter B. Andrews (Andrews@CS.CMU.EDU)                 ;;;
;;; ******************************************************************* ;;;

(in-package :ml)
(part-of ml-etr-tactics)

;;; Written by Dan Nesmith

(context etr-nat)
(deffile ml-etr-tactics-sline
  (extension lisp)
  (part-of ml-etr-tactics)
  (mhelp "Defines support line tactics as used in Pfenning's thesis
for translating expansion proofs to natural deduction proofs."))

(context prop-tactics)

(deftactic econj-tac
  (etree-nat
   (lambda (pline)
     (econj-tac-etree-nat-fn pline))
   "Applies conjunction elimination to a support line if applicable.
Pfenning's tactics 199-200, but regardless of whether the conjuncts
are both essential to proving the planned line."))

(defun econj-match2 (support)
  (and (econj-match1 support)
       (auto::econjunction-p (line-node support))))

(defun econj-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if #'(lambda (x) (mated-line x (line-mating pline))) ; cebrown 9/5/00
				      (remove-if-not #'econj-match2 supports)))
	 (matched-support (car matched-supports))
	 (node (if matched-support (line-node matched-support)))
	 (juncts (if node (auto::etree-components node))))
    (when (eq tacmode 'interactive)
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply ECONJ to line ~D?"
					(linealias x)) t))
		     matched-supports)))
    (if matched-support
	(let ((msg "Applied ECONJ."))
	  (tactic-output msg t)
	  (econj-short matched-support)
	  (let* ((new-supports (remove-if #'(lambda (x) (memq x supports))
					  (cdr (assoc pline 
						      (proof-plans dproof))))))
	    (if (< (linealias (car new-supports)) 
		   (linealias (cadr new-supports)))
		(progn
		  (setf (line-node (car new-supports))
			(car juncts))
		  (setf (line-node (cadr new-supports))
			(cadr juncts)))
		(progn
		  (setf (line-node (car new-supports))
			(cadr juncts))
		  (setf (line-node (cadr new-supports))
			(car juncts))))
	    (values (list pline) msg 'succeed)))
	(let ((msg (if matched-supports
		       "Not applying ECONJ."
		       "Can't apply ECONJ.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))


(deftactic econj*-tac
  (etree-nat
   (lambda (pline)
     (econj*-tac-etree-nat-fn pline))
   "Applies conjunction elimination to a support line if applicable.
If support line is a multiple conjunction, completely breaks it up."))


(defun econj*-match2 (support)
  (and (econj-match1 support)
       (auto::econjunction-p (line-node support))))

(defun econj*-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if #'(lambda (x) (mated-line x (line-mating pline))) ; cebrown 9/5/00
				      (remove-if-not #'econj*-match2 supports)))
	 (matched-support (car matched-supports))
	 (node (if matched-support (line-node matched-support)))
	 (node-wff-list
	  (if matched-support 
	      (find-all-conjunct-nodes
	       node (line-assertion matched-support))))
	 (oldplans (current-plan-lines dproof)))
    (when (eq tacmode 'interactive)
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply ECONJ* to line ~D?"
					(linealias x)) t))
		     matched-supports)))
    (if matched-support
	(progn (make-room-after matched-support (length node-wff-list))
	(let* ((msg "Applied ECONJ*.")
	       (newplans nil))
	  (tactic-output msg t)
	  (setq newplans
		(do ((node-wff-list node-wff-list (cdr node-wff-list))
		     (line (1+ (linealias matched-support)) (1+ line))
		     (newplans nil (cons newplan newplans))
		     (hyps (mapcar #'linealias 
				   (line-hypotheses matched-support)))
		     (oldplans oldplans (cons newplan oldplans))
		     (newplan nil))
		    ((null node-wff-list) newplans)
		  (comdecode 
			   (list 'lemma (linealias pline) line
				 (list 'quote (cdar node-wff-list)) '$
				 '$ hyps))
		  (setq newplan
			(car (set-difference 
			      (current-plan-lines dproof)
			      oldplans)))
		  (setf (line-node newplan) (caar node-wff-list))
		  (comdecode
			   (list 'rulep (linealias newplan)
				 (list (linealias matched-support))))))
	  (update-plan `((pp ,matched-support ss))
		       `((pp ,@newplans ss)))
	  (values (list pline) msg 'succeed)))
	(let ((msg (if matched-supports
		       "Not applying ECONJ*."
		       "Can't apply ECONJ*.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(defun find-room-after (line)
  (do ((checknum (1+ (linealias line)) (1+ checknum)))
      ((or (numalias checknum) (eq checknum 1000000)) (1- checknum))))

(defun find-room-before (line)
  (do ((checknum (1- (linealias line)) (1- checknum)))
      ((or (numalias checknum) (eq checknum 0)) (1+ checknum))))

;return the last unused line before the next plan, or the first unused line after
;the last support.

(defun cases-match2 (pline support other-supps)
  (and (cases-match1 pline support)
       (auto::edisjunction-p (line-node support))
       (let ((conn-list (line-mating pline))
	     (other-supp-nodes (mapcar #'(lambda(x) (line-node x))
				       other-supps))
	     (supp-node (line-node support))
	     (pline-node (line-node pline)))
	 (and (auto::spans pline-node
			   (cons (car (etree-components supp-node))
				 other-supp-nodes)
			   conn-list)
	       (auto::spans pline-node
			   (cons (cadr (etree-components supp-node))
				 other-supp-nodes)
			   conn-list)))))


(deftactic cases-tac
  (etree-nat
   (lambda (pline)
     (cases-tac-etree-nat-fn pline))
   "If a support line is a disjunction, applies rule of cases. 
Pfenning's tactic 202."))

(defun cases-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if #'(lambda (x) (mated-line x (line-mating pline))) ; cebrown 9/5/00
				      (remove-if-not 
				       #'(lambda (x)
					   (cases-match2 pline x 
							 (remove x supports)))
				       supports)))
	 (matched-support (car matched-supports))
	 (node (if matched-support (line-node matched-support)))
	 (juncts (if node (auto::etree-components node)))
	 (oldplans (remove pline (current-plan-lines dproof))))
    (when (eq tacmode 'interactive)
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply CASES to line ~D?"
					(linealias x)) t))
		     matched-supports)
	    node (if matched-support (line-node matched-support))
	    juncts (if node (auto::etree-components node))))
    (if matched-support
	(let ((msg "Applied CASES."))
	  (tactic-output msg t)
	  (cases-short pline matched-support)
	  (let* ((newplans
		  (set-difference (current-plan-lines dproof)
				  oldplans))
		 (new-supports (reduce 'append (mapcar
						#'(lambda (newplan) 
						    (set-difference 
						     (cdr (assoc newplan (proof-plans dproof)))
						     supports))
						newplans))))
	    (dolist (newplan newplans)
	      (setf (line-node newplan) (line-node pline)))
	    (if (< (linealias (car new-supports))
		   (linealias (cadr new-supports)))
		(progn
		  (setf (line-node (car new-supports))
			(car juncts))
		  (setf (line-node (cadr new-supports))
			(cadr juncts)))
		(progn
		  (setf (line-node (car new-supports))
			(cadr juncts))
		  (setf (line-node (cadr new-supports))
			(car juncts))))
	    (setf (line-mating (car newplans))
		   (line-mating pline))
	    (setf (line-mating (cadr newplans))
		   (line-mating pline))
	    (values newplans msg 'succeed)))
	(let ((msg (if matched-supports
		       "Not applying CASES."
		       "Can't apply CASES.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(deftactic absurd-tac
  (etree-nat
   (lambda (pline)
     (absurd-etree-nat-fn pline))
   "If a support line is FALSEHOOD applies absurdity rule."))


(defun absurd-match2 (support)
  (or (wffeq 'falsehood (line-assertion support))
      (auto::false-p (line-node support))))

(defun absurd-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support
	  (find-if #'absurd-match2 supports))
	 (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply ABSURD to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(let ((msg "Applied ABSURD."))
	  (tactic-output msg t)
	  (comdecode (list 'absurd 
			   (linealias pline) (linealias matched-support)
			   '!))
	  (values nil msg 'succeed))
	(let ((msg (if matched-support
		       "Not applying ABSURD."
		       "Can't apply ABSURD.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))


(context quant-tactics)

#+comment
(defun ui-match2 (support pline other-lines conn-list)
  (let* ((node (line-node support))
	 (plan-node (line-node pline))
	 (components (auto::etree-components node))
	 (other-nodes (mapcar #'(lambda (x) (line-node x)) other-lines)))
    (and (ui-match1 support)
	 (auto::expansion-p node)
	 components
	 (find-if #'(lambda (x)
		   (and (auto::admissible-p (cons plan-node 
						  other-nodes)
					    (car x))
			;; following makes sure that the expansion
			;; is actually necessary for the planned line
			(not (auto::spans plan-node
					  (append (remove (cdr x)
							  components)
						  other-nodes)
					  conn-list))))
	       (map 'list #'cons
		    (auto::expansion-terms node)
		    components)))))

(defun ui-match2 (support pline other-lines conn-list)
  (let* ((node (line-node support))
	 (plan-node (line-node pline))
	 (components (auto::etree-components node))
	 (other-nodes (mapcar #'(lambda (x) (line-node x)) other-lines)))
    (and (ui-match1 support)
	 (not (mated-line support (line-mating pline))) ; cebrown 9/5/00
	 (auto::expansion-p node)
	 components
	 (find-if 
           #'(lambda (x)
               (let ((restcom (remove (cdr x) components)))
	         (and (auto::admissible-p (cons plan-node (append other-nodes restcom))
					  (car x))
		      ;; following makes sure that the expansion
		      ;; is actually necessary for the planned line
		      (not (sufficient-lines-p pline other-lines restcom conn-list))))) ; cebrown 9/7/00 - to handle non-leaf conns
;		      (not (auto::spans plan-node
;					  (append (remove (cdr x)
;							  components)
;						  other-nodes)
;					  conn-list)))))
	       (map 'list #'cons
		    (auto::expansion-terms node)
		    components)))))


(deftactic ui-tac
  (etree-nat
   (lambda (pline)
     (ui-tac-etree-nat-fn pline))
   "If a support node is an expansion node with an admissible expansion,
applies universal instantiation.  Pfenning's tactics 204/205.  If a support
line has multiple expansions, it will be duplicated, with the duplication
receiving just the excess expansion terms.  The instantiated line will
not become a support of any other goal than the current one, since it
is not known if it is yet admissible for others.  The original support
line will be dropped from the supports of the current goal, but
remain as a support for any other goals.  The new support lines
will be supports only for the current goal."))

(defun ui-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-support
	  (find-if #'(lambda (x)
		       (ui-match2 x 
				  pline
				  (remove x supports)
				  (line-mating pline)))
		     supports))
	 (terms (if matched-support
		    (auto::expansion-terms (line-node matched-support))))
	 (kids (if matched-support
		   (auto::etree-components (line-node matched-support))))
	 (pos (if matched-support
		  (position (cdr (ui-match2 matched-support pline
				       (remove matched-support supports)
				       (line-mating pline)))
			    (auto::etree-components 
			      (line-node matched-support))))
;	      (if matched-support
;		  (position-if #'(lambda (x)
;				   (and
;				    (auto::admissible-p
;				     (mapcar #'(lambda (y) 
;						 (line-node y))
;					     (cons pline supports))
;				     (car x))
;				    (not (auto::inessential-p
;					  (line-mating pline) (cdr x)))))
;			       (map 'list #'cons terms kids)))
	      )
	 (matched-term 
	  (if matched-support (nth pos terms)))
	 (matched-kid (if matched-support (nth pos kids)))
	 (otherplans (delete pline (current-plan-lines dproof)))
	 (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply UI to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(progn
	  (subproof pline) ; cebrown 2/17/01 - to fix a bug
	(if (cdr kids)
	    ;; Expansion node has more than one expansion
	   (let ((msg "Applied UI.")
		 (new-node (auto::copy-expansion
			    (line-node matched-support)))
		 (new-univ-line nil)
		 (instantiated-line nil))
	     (setf (auto::expansion-terms new-node)
		   (append (subseq (auto::expansion-terms new-node) 0 pos)
			   (subseq (auto::expansion-terms new-node) (1+ pos))))
	     (setf (auto::etree-components new-node)
		   (append (subseq (auto::etree-components new-node) 0 pos)
			   (subseq (auto::etree-components new-node) (1+ pos))))
	     (tactic-output msg t)
	     (comdecode
		   (list 'lemma (linealias pline) (car (auto::get-useful-range pline)) ;'$ 
			 (list 'quote 
			       (line-assertion matched-support)) '$
			 '$ (mapcar #'linealias
				    (line-hypotheses matched-support))))
	     (setq new-univ-line
		   (car (delete pline
				(set-difference
				 (current-plan-lines dproof)
				 otherplans))))
	     (same-short new-univ-line matched-support)
	     ;;	     (ui-short new-univ-line matched-term)
	     ;; args for ui (D1 D2 \t A \x LCONTR D1-HYPS D2-HYPS)
	     (comdecode (list 'ui (linealias new-univ-line) '$
			      (list 'quote matched-term)
			      '$ '$
			      (list 'quote (get-shallow matched-kid))
			      '$ '$))
	     (setq instantiated-line
		   (car (remove new-univ-line
			  (set-difference 
			   (cdr (assoc pline (proof-plans dproof)))
			   supports))))
	       ;; remove the matched-support line as a support for pline
	     (comdecode
		      (list 'unsponsor (linealias pline)
			    (linealias matched-support)))
	     ;; remove instantiated-line from supports of all other
	     ;; planned lines -- it might not yet be admissible
	     (dolist (pl otherplans)
	       (comdecode
			(list 'unsponsor (linealias pl)
			      (linealias instantiated-line))))
	       (setf (line-node new-univ-line) new-node)
	       (setf (line-node instantiated-line) matched-kid)
	       (values (list pline) msg 'succeed))
	   ;; only one expansion term, admissible for current goal
	   (let ((msg "Applied UI.")
		 (instantiated-line nil))
	     (tactic-output msg t)
	     ;;(ui-short matched-support matched-term)
	     (comdecode (list 'ui (linealias matched-support) '$
			      (list 'quote matched-term)
			      '$ '$
			      (list 'quote (get-shallow matched-kid))
			      '$ '$))
	     (setq instantiated-line
		   (car (set-difference 
			 (cdr (assoc pline (proof-plans dproof)))
			 supports)))
	       ;; remove the matched-support line as a support for pline
	     (comdecode
		      (list 'unsponsor (linealias pline)
			    (linealias matched-support)))
	     ;; remove instantiated-line from supports of all other
	     ;; planned lines -- it might not yet be admissible
	     (dolist (pl otherplans)
	       (comdecode
			(list 'unsponsor (linealias pl)
			      (linealias instantiated-line))))
	       (setf (line-node instantiated-line) matched-kid)
	       (values (list pline) msg 'succeed))))
	(let ((msg "Can't apply UI." ))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(deftactic rulec-tac
  (etree-nat
   (lambda (pline)
     (rulec-tac-etree-nat-fn pline))
   "If a support line corresponds to a selection node, applies 
RuleC.  Same as Pfenning's tactic 207."
))

(defun rulec-match2 (pline support)
  (and (rulec-match1 pline support)
       (not (mated-line support (line-mating pline))) ; cebrown 9/5/00
       (or (auto::selection-p (line-node support))
	   (auto::skolem-p (line-node support)))))

(defun rulec-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if-not
			    #'(lambda (x) (rulec-match2 pline x))
			    supports))
	 (matched-support (car matched-supports))
	 (instvar (if matched-support 
		      (if (auto::skolem-p (line-node matched-support))
			  (car (auto::skolem-terms (line-node matched-support)))
			  (car (auto::selection-terms (line-node matched-support))))))
	 (oldplans (remove pline (current-plan-lines dproof)))
	 (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply RULEC to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(let ((msg "Applied RULEC."))
	  (tactic-output msg t)
	  (rulec-short pline matched-support instvar)
	  (let* ((newplan (car (set-difference (mapcar #'car 
						       (proof-plans dproof))
					       oldplans)))
		 (new-support (car (set-difference 
				    (cdr (assoc newplan (proof-plans dproof)))
				    supports))))
	    (setf (line-mating newplan) (line-mating pline))
	    (setf (line-node newplan) (line-node pline))
	    (setf (line-node new-support)
		  (car (auto::etree-components (line-node matched-support))))
	    (values (list newplan) msg 'succeed)))
	(let ((msg "Can't apply RULEC."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(context prop-tactics)

(defun mp-match2 (pline support other-supports)
  (if (mp-match1 support)
       (let ((support-node (line-node support))
	     (other-support-nodes 
	      (let ((nodes nil))
		(dolist (supp other-supports nodes)
		  (push (line-node supp) nodes)))))
	 (and (auto::implication-p support-node)
	      (not (mated-line support (line-mating pline))) ; cebrown 9/5/00
	      (auto::spans (car (auto::etree-components support-node))
			   other-support-nodes 
			   (line-mating pline))
	      (auto::spans (line-node pline)
			   (cons (cadr (auto::etree-components support-node))
				 other-support-nodes)
			   (line-mating pline))))))


(deftactic mp-tac
  (etree-nat
   (lambda (pline)
     (mp-tac-etree-nat-fn pline))
   "If a support line is an implication, planned line follows from the
succedent and the antecedent is provable, applies Modus Ponens.  Same
as Pfenning's tactic 209."))

(defun mp-tac-etree-nat-fn (pline)
     (let* ((auto::*ignore-statuses* t)
	    (supports (cdr (assoc pline (proof-plans dproof)))) 
	    (matched-supports (remove-if-not
			       #'(lambda (x) 
				   (mp-match2 pline x
					      (remove x supports)))
			       supports))
	    (matched-support (car matched-supports))
	    (otherplans (current-plan-lines dproof)))
       (when (eq tacmode 'interactive)
	 (setq matched-support
	       (find-if #'(lambda (x)
			    (query (format nil  "Apply MP to line ~D?"
					   (linealias x)) t))
			matched-supports)))
       (if matched-support
	   (let ((msg "Applied MP.")
		 (new-imp-line nil))
	     (tactic-output msg t)
	     ;;; matched-support may not have all the hypotheses needed
	     (comdecode
		   (list 'lemma (linealias pline) (car (auto::get-useful-range pline)) ; '$ 
			 (list 'quote 
			       (line-assertion matched-support)) '$
			 '$ '$))
	     (setq new-imp-line
		   (car (set-difference
			 (current-plan-lines dproof)
			 otherplans)))
	     (same-short new-imp-line matched-support)
	     (comdecode
		      (list 'unsponsor (linealias pline)
			    (list (linealias matched-support))))
	     (setf (line-node new-imp-line)
		   (line-node matched-support))
	     (setq matched-support new-imp-line)
	     (mp-short matched-support)
	     ;; newplan corresponds to the antecedent of the implication
	     ;; new-support is the consequent of the implication
	     (let* ((newplan (car (set-difference 
				   (current-plan-lines dproof)
				   otherplans)))
		    (new-support (car (set-difference 
				       (cdr (assoc pline (proof-plans dproof)))
				       (cons newplan supports))))
		    (juncts (auto::etree-components
			     (line-node matched-support))))
	       (comdecode (list 'unsponsor (linealias pline)
					  (linealias newplan)))
	       (setf (line-node newplan) (car juncts))
	       (setf (line-node new-support) (cadr juncts))
	       (setf (line-mating newplan) (line-mating pline))
	       (values (list pline newplan) msg 'succeed)))
	   (let ((msg (if matched-supports
			  "Not applying MP."
			  "Can't apply MP.")))
	     (tactic-output msg nil)
	     (values (list pline) msg 'fail)))
       ))


(defun indirect2-match2 (support other-supports conn-list)
  (let ((supp-bottom (chain-of-negs (line-node support))))
    (when supp-bottom
      (dolist (other other-supports nil)
	(let* ((supp-node (line-node other))
	       (other-bottom (chain-of-negs supp-node)))
	  (if (and other-bottom
		   (auto::mated-to-node other-bottom supp-bottom conn-list)
		   (or (wffeq-ab (cons 'not (line-assertion support))
			      (line-assertion other))
		       (wffeq-ab (line-assertion support)
			      (cons 'not (line-assertion other)))))
	      (return other)))))))

(deftactic indirect2-tac
  (etree-nat
   (lambda (pline)
     (indirect2-tac-etree-nat-fn pline))
   "If planned line is FALSEHOOD, two support lines are contradictory, 
and are mated, applies indirect2 rule.  Same as Pfenning's tactic 212."))

(defun indirect2-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support-lines
	  (dolist (supp supports nil)
	    (let ((match (indirect2-match2 supp (remove supp supports)
					   (line-mating pline))))
	      (if match (return (list match supp))))))
	 (dummy-support 
	  (if (and (eq tacmode 'interactive) matched-support-lines)
	      (find-if #'(lambda (x) (query (format nil  "Apply INDIRECT2 to line ~D?" (linealias x)) t))
		       matched-support-lines)
	    matched-support-lines))
	 (matched-support-lines (if (eq dummy-support nil) nil matched-support-lines)))
    (if matched-support-lines
	(let ((msg "Applied INDIRECT2.")
	      (old-supports (cdr (assoc (car matched-support-lines)
					(proof-plans dproof)))))
	  (setq matched-support-lines
		(if (wffeq (cons 'not (line-assertion
				       (car matched-support-lines)))
			   (line-assertion (cadr matched-support-lines)))
		    (reverse matched-support-lines)
		    matched-support-lines))
	  (tactic-output msg t)
	  (comdecode 
		   (append `(indirect2 ,(linealias pline))
			   (mapcar #'linealias 
				   matched-support-lines)
			   (list (1- (linealias pline)))
			   ))
	  (let ((new-support
		 (car (or (set-difference 
			   (cdr (assoc (car matched-support-lines)
				       (proof-plans dproof)))
			   old-supports)
			  (set-difference 
			   (cdr (assoc (cadr matched-support-lines)
				       (proof-plans dproof)))
			   old-supports)))))
	    (when new-support 
	      (update-plan `((pp ,new-support ss)) '((pp ss)))))
	  (values nil msg 'succeed))
	(let ((msg "Can't apply INDIRECT2."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(defun neg-neg-match2 (support)
  (let ((node (line-node support)))
    (and (auto::negation-p node)
         (let ((com (car (auto::etree-components node))))
	   (if (and (auto::leaf-p com)
		    (wffeq (auto::leaf-shallow com) '(NOT . TRUTH))) ; a special case that was causing a bug - cebrown 2/17/01
	       (progn
		 (auto::deepen-to-literals* node)
		 t)
	     (or (auto::true-p com) (auto::negation-p com)))))))


(deftactic neg-neg-sline-tac
  (etree-nat
   (lambda (pline)
     (neg-neg-sline-tac-etree-nat-fn pline))
   "If a support line is a double negation, removes the negations."))

(defun neg-neg-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if #'(lambda (x) (mated-line x (line-mating pline))) ; cebrown 9/5/00
				      (remove-if-not #'neg-neg-match2 supports)))
	 (matched-support (car matched-supports)))
    (when (eq tacmode 'interactive)
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply NEG-NEG-SLINE to line ~D?"
					(linealias x)) t))
		     matched-supports)))
    (if matched-support
	(let ((msg "Applied NEG-NEG-SLINE."))
	  (tactic-output msg t)
	  (subproof pline) ; cebrown 2/17/01 - to fix a bug
	  (pushneg-short matched-support)
	  (let ((new-support 
		 (car (set-difference 
		       (cdr (assoc pline (proof-plans dproof)))
		       supports))))
	    (setf (line-node new-support)
		  (or (car (auto::etree-components
			(car (auto::etree-components
			       (line-node matched-support)))))
                      (auto::make-false :positive T :junctive 'CON)))) ; cebrown 6/10/2002 changed to :positive T; cebrown 11/19/00 added :positive NIL :junctive 'CON
	  (values (list pline) msg 'succeed))
	(let ((msg (if matched-supports
		       "Not applying NEG-NEG-SLINE."
		       "Can't apply NEG-NEG-SLINE.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))


(defun neg-or-match2 (support)
  (let ((node (line-node support)))
    (and (auto::negation-p node)
	 (auto::edisjunction-p (car (auto::etree-components node))))))


(deftactic neg-or-sline-tac
  (etree-nat
   (lambda (pline)
     (neg-or-sline-tac-etree-nat-fn pline))
   "If a support line is a negated disjunction, pushes the negation
through, creating a conjunction."))

(defun neg-or-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if #'(lambda (x) (mated-line x (line-mating pline))) ; cebrown 9/5/00
				      (remove-if-not #'neg-or-match2 supports)))
	 (matched-support (car matched-supports)))
    (when (eq tacmode 'interactive)
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply NEG-OR-SLINE to line ~D?"
					(linealias x)) t))
		     matched-supports)))
    (if matched-support
	(let ((msg "Applied NEG-OR-SLINE."))
	  (tactic-output msg t)
	  (subproof pline) ; cebrown 2/17/01 - to fix a bug
	  (pushneg-short matched-support)
	  (let* ((new-support
		  (car
		   (set-difference 
		    (cdr (assoc pline (proof-plans dproof)))
		    supports)))
		 (neg-node (line-node matched-support))
		 (disj-node (car (auto::etree-components 
				  neg-node)))
		 (conj-node
		  (auto::make-econjunction
		   :positive (auto::positive-p neg-node)
		   :free-vars (auto::etree-free-vars neg-node)
		   :junctive (auto::etree-junctive disj-node)))
		 (left-node (auto::copy-negation neg-node))
		 (right-node (auto::copy-negation neg-node))
		 (juncts (auto::etree-components disj-node)))
	    (if (auto::negation-p (cadr juncts))		   
		(setq right-node
		      (car (auto::etree-components (cadr juncts))))
		(setf (auto::etree-components right-node)
		      (list (cadr juncts))))
	    (if (auto::negation-p (car juncts))		   
		(setq left-node
		      (car (auto::etree-components (car juncts))))
		(setf (auto::etree-components left-node)
		      (list (car juncts))))
	    (setf (auto::etree-components conj-node)
		  (list left-node right-node))
	    (setf (line-node new-support) conj-node)
	    (values (list pline) msg 'succeed)))
	(let ((msg (if matched-supports
		       "Not applying NEG-OR-SLINE."
		       "Can't apply NEG-OR-SLINE.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(defun neg-and-match2 (support)
  (let ((node (line-node support)))
    (and (auto::negation-p node)
	 (auto::econjunction-p (car (auto::etree-components node))))))


(deftactic neg-and-sline-tac
  (etree-nat
   (lambda (pline)
     (neg-and-elim-tac-etree-nat-fn pline))
   "If a support line is a negated conjunction, applies indirect proof.
Similar to Pfenning's tactic 215."))

;;; following is not as good as neg-and-elim-tac, which is what it
;;; is trying to do.
#+comment(defun neg-and-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if #'(lambda (x) (mated-line x (line-mating pline))) ; cebrown 9/5/00
				      (remove-if-not #'neg-and-match2 supports)))
	 (matched-support (car matched-supports))
	 (oldplans (remove pline (current-plan-lines dproof))))
    (when (eq tacmode 'interactive)
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply NEG-AND-SLINE to line ~D?"
					(linealias x)) t))
		     matched-supports)))
    (if matched-support
	(let ((msg "Applied NEG-AND-SLINE."))
	  (tactic-output msg t)
	  (comdecode 
		   (list 'indirect2 (linealias pline)
			 (linealias matched-support) '$
			 '!))  
	  (let* ((newplan
		  (car (set-difference (current-plan-lines dproof)
				       oldplans)))
		 (new-support
		  (car (set-difference (cdr (assoc newplan 
						   (proof-plans dproof)))
				       supports))))
	    (update-plan `((pp ,new-support ss)) '((pp ss)))
	    (setf (line-node newplan)
		  (car (auto::etree-components (line-node matched-support))))
	    (setf (line-mating newplan)
		  (line-mating pline))
	    (values (list newplan) msg 'succeed)))
	(let ((msg (if matched-supports
		       "Not applying NEG-AND-SLINE."
		       "Can't apply NEG-AND-SLINE.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(defun neg-imp-match2 (support)
  (let ((node (line-node support)))
    (and (auto::negation-p node)
	 (auto::implication-p (car (auto::etree-components node))))))

(deftactic neg-imp-sline-tac
  (etree-nat
   (lambda (pline)
     (neg-imp-sline-tac-etree-nat-fn pline))
   "If a support line is a negated implication, pushes the negation through
creating a conjunction."))

(defun neg-imp-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if #'(lambda (x) (mated-line x (line-mating pline))) ; cebrown 9/5/00
				      (remove-if-not #'neg-imp-match2 supports)))
	 (matched-support (car matched-supports)))
    (when (eq tacmode 'interactive)
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply NEG-IMP-SLINE to line ~D?"
					(linealias x)) t))
		     matched-supports)))
    (if matched-support
	(let ((msg "Applied NEG-IMP-SLINE."))
	  (tactic-output msg t)
	  (subproof pline) ; cebrown 2/17/01 - to fix a bug
	  (pushneg-short matched-support)
	  (let* ((new-support
		  (car
		   (set-difference 
		    (cdr (assoc pline (proof-plans dproof)))
		    supports)))
		 (neg-node (line-node matched-support))
		 (imp-node (car (auto::etree-components 
				 neg-node)))
		 (conj-node
		  (auto::make-econjunction
		   :positive (auto::positive-p neg-node)
		   :free-vars (auto::etree-free-vars neg-node)
		   :junctive (auto::etree-junctive imp-node)))
		 (right-node (auto::copy-negation neg-node))
		 (juncts (auto::etree-components imp-node))
		 (left-node (car juncts)))
	    (if (auto::negation-p (cadr juncts))		   
		(setq right-node
		      (car (auto::etree-components (cadr juncts))))
		(setf (auto::etree-components right-node)
		      (list (cadr juncts))))
	    (setf (auto::etree-components conj-node)
	      (list left-node right-node))
	    (setf (line-node new-support) conj-node)
	    (values (list pline) msg 'succeed)))
	(let ((msg (if matched-supports
		       "Not applying NEG-IMP-SLINE."
		       "Can't apply NEG-IMP-SLINE.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(context quant-tactics)

(defun neg-sel-match2 (support)
  (let ((node (line-node support)))
    (and (auto::negation-p node)
	 (or (auto::skolem-p (car (auto::etree-components node)))
	     (auto::selection-p (car (auto::etree-components node)))))))


(deftactic neg-sel-sline-tac
  (etree-nat
   (lambda (pline)
     (neg-sel-sline-tac-etree-nat-fn pline))
   "If a support line is a negated selection node, pushes the negation
through the quantifier."))

(defun neg-sel-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if #'(lambda (x) (mated-line x (line-mating pline))) ; cebrown 9/5/00
				      (remove-if-not #'neg-sel-match2 supports)))
	 (matched-support (car matched-supports)))
    (when (eq tacmode 'interactive)
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply NEG-SEL-SLINE to line ~D?"
					(linealias x)) t))
		     matched-supports)))
    (if matched-support
	(let* ((msg "Applied NEG-SEL-SLINE.")
	       (neg-node (auto::copy-negation (line-node matched-support)))
	       (univ-node 
		(funcall
		 (if (auto::selection-p 
		      (car (auto::etree-components neg-node)))
		     #'auto::copy-selection
		     #'auto::copy-skolem)
		 (car (auto::etree-components neg-node)))))
	  (setf (auto::etree-positive univ-node) T) ; cebrown 6/10/2002
	  (setf (auto::etree-components neg-node)
		(auto::etree-components univ-node))
	  (tactic-output msg t)
	  (subproof pline) ; cebrown 2/17/01 - to fix a bug
	  (pushneg-short matched-support)
	  (let ((new-support
		 (car (set-difference (cdr (assoc pline
						  (proof-plans dproof)))
				      supports))))
	    (if (auto::negation-p
		 (car (auto::etree-components univ-node)))
		(setf (auto::etree-components univ-node)
		      (auto::etree-components
		       (car (auto::etree-components univ-node))))
		(setf (auto::etree-components univ-node)
		      (list neg-node)))
	    (setf (line-node new-support) univ-node)
	    (values (list pline) msg 'succeed)))
	(let ((msg (if matched-supports
		       "Not applying NEG-SEL-SLINE."
		       "Can't apply NEG-SEL-SLINE.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(defun neg-exp-match2 (support)
  (let ((node (line-node support)))
    (and (auto::negation-p node)
	 (auto::expansion-p (car (auto::etree-components node))))))

					; cebrown 2/18/01 - wrote this function to fix a bug when pushneg is applied to a formula
					; like ~[exists x ~A] and the expansion requires a lambda rewrite
(defun strip-away-a-negation (kid)
  (cond ((auto::negation-p kid) ; this was the only case considered before
	 (car (auto::etree-components kid)))
	((auto::rewrite-p kid)
	 (let ((new-rew (auto::copy-rewrite kid)))
	   (unless (not-p (auto::rewrite-shallow new-rew))
	     (throwfail "Translation Problem: Expected shallow of rewrite to be a negation:" kid))
	   (setf (auto::rewrite-shallow new-rew)
	     (cdr (auto::rewrite-shallow new-rew)))
	   (setf (auto::etree-components new-rew)
	     (list (strip-away-a-negation (car (auto::etree-components new-rew)))))
	   new-rew))
	(t
	 (throwfail "Translation Problem: Expected a negation node" kid))))


(deftactic neg-exp-sline-tac
  (etree-nat
   (lambda (pline)
     (neg-exp-sline-tac-etree-nat-fn pline))
   "If a support line is a negated expansion node, pushes negation through
the quantifier."))

(defun neg-exp-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof)))) 
	 (matched-supports (remove-if #'(lambda (x) (mated-line x (line-mating pline))) ; cebrown 9/5/00
				      (remove-if-not #'neg-exp-match2 supports)))
	 (matched-support (car matched-supports)))
    (when (eq tacmode 'interactive)
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply NEG-EXP-SLINE to line ~D?"
					(linealias x)) t))
		     matched-supports)))
    (if matched-support
	(let* ((msg "Applied NEG-EXP-SLINE.")
	       (neg-node (line-node matched-support))
	       (new-exist-node 
		(auto::copy-expansion
		 (car (auto::etree-components
		       neg-node)))))
	  (tactic-output msg t)
	  (subproof pline) ; cebrown 2/17/01 - to fix a bug
	  (pushneg-short matched-support)
	  (let ((new-support
		 (car (set-difference (cdr (assoc pline
						  (proof-plans dproof)))
				      supports))))
	    (if (not-p (cddr (line-assertion matched-support))) ; if we started with ~[exists x ~A], pushneg gives forall x A
					; I changed the code to handle this case a little differently (the old code did too,
					; but got into trouble if there was a lambda rewrite as a kid of the expansion)
					; The bug showed up with BLEDSOE-FENG-7 in GAZING-MODE2, ADD-TRUTH NIL - cebrown 2/18/01
		(setf (auto::etree-components new-exist-node)
		  (mapcar #'(lambda (kid)
					; want to strip away a negation, but must take care if there is a rewrite in the way
			      (strip-away-a-negation kid))
			  (auto::etree-components new-exist-node)))
	      (setf (auto::etree-components new-exist-node)
		(do ((kids (auto::etree-components new-exist-node)
			   (cdr kids))
		     (new-node (auto::copy-negation neg-node)
			       (auto::copy-negation neg-node))
		     (new-kids nil))
		    ((null kids) (nreverse new-kids))
		  (setf (auto::etree-components new-node)
		    (list (car kids)))
					;		(if (auto::negation-p (car kids)) ; the old way of handling the special case
					; (push (car (auto::etree-components (car kids)))
					;			  new-kids)
		  (push new-node new-kids))))
	    (setf (auto::etree-positive new-exist-node) T) ; cebrown 6/10/2002
	    (setf (line-node new-support) new-exist-node)
	    (values (list pline) msg 'succeed)))
	(let ((msg (if matched-supports
		       "Not applying NEG-EXP-SLINE."
		       "Can't apply NEG-EXP-SLINE.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

(context prop-tactics)

(defun equiv-implics-match2 (support)
  (let ((node (line-node support)))
    (and (auto::rewrite-p node)
	 (eq (auto::rewrite-justification node) 
	     'auto::equiv-implics)
	; (auto::econjunction-p (car (auto::etree-components node)))
	 )))

(deftactic equiv-implics-tac
  (etree-nat
   (lambda (pline)
     (equiv-implics-tac-etree-nat-fn pline))
   "If a support line is a rewrite node for an equivalence to a
conjunction, applies the equiv-implics rule."))

(defun equiv-implics-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support 
	  (find-if #'(lambda (s)
		       (and (not (mated-line s (line-mating pline)))
			    (equiv-implics-match2 s))) supports))
	 (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply EQUIV-IMPLICS to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(let ((msg "Applied EQUIV-IMPLICS.")
	      (old-supports (cdr (assoc pline (proof-plans dproof)))))
	  (tactic-output msg t)
	  (subproof pline)		; just to be safe - cebrown 2/17/01 (note the calls to subproof in UI & before pushneg fixed a bug)
;	  (equiv-implics-short pline) ; should be support line!  apparently this tactic has NEVER BEEN CALLED! - cebrown 2/20/01
	  (equiv-implics-short matched-support) ; the fix - cebrown 2/20/01
	  (let ((new-support (car (set-difference 
				   (cdr (assoc pline (proof-plans dproof)))
				   old-supports))))
	    (setf (line-node new-support)
		  (car (auto::etree-components (line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg (if matched-support
		       "Not applying EQUIV-IMPLICS."
		       "Can't apply EQUIV-IMPLICS.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))

(defun equiv-disj-match2 (support)
  (let ((node (line-node support)))
    (and (auto::rewrite-p node)
	 (eq (auto::rewrite-justification node) 
	     'auto::equiv-disjs))))

(deftactic equiv-disj-tac
  (etree-nat
   (lambda (pline)
     (equiv-disj-tac-etree-nat-fn pline))
   "If a support line is a rewrite node from an equivalence to a disjunction,
carries out the rewrite."))

(defun equiv-disj-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support 
	  (find-if #'(lambda (s)
		       (and (not (mated-line s (line-mating pline))) ; cebrown 9/5/00
			    (equiv-disj-match2 s)))
		   supports))
	  (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply EQUIV-DISJ to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(let ((msg "Applied EQUIV-DISJ.")
	      (old-supports (cdr (assoc pline (proof-plans dproof)))))
	  (tactic-output msg t)
	  (comdecode
		   (list 'lemma (linealias pline) '$ 
			 (list 'quote (auto::get-shallow 
				       (car (auto::etree-components 
					     (line-node matched-support))))) '$
			 '$ (mapcar #'linealias
				    (line-hypotheses matched-support))))
	  (let ((new-support (car (set-difference 
				   (cdr (assoc pline (proof-plans dproof)))
				   old-supports))))
	    (rulep-enter new-support (list matched-support))
	    (setf (line-just-rule new-support) "EquivConj")
	    (comdecode 
		     (list 'unsponsor (linealias pline) 
			   (list (linealias matched-support))))
	    (update-plan `((pp ,matched-support ss)) 
			 `((pp ,new-support ss)))
	    (setf (line-node new-support)
		  (car (auto::etree-components (line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg (if matched-support
		       "Not applying EQUIV-DISJ."
		       "Can't apply EQUIV-DISJ.")))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))

(context lambda-tactics)

(deftactic lcontr*-beta-tac
  (etree-nat
   (lambda (pline)
     (lcontr*-beta-tac-etree-nat-fn pline))
   "If a support line is a rewrite node justified by beta, applies
lcontr*-beta rule."))

(defun lcontr*-beta-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (lambda-match-beta2 s)))
				   supports))
         (matched-support 
            (if (and (eq tacmode 'interactive) matched-support)
                (find-if #'(lambda (x) 
                      (query (format nil  "Apply LCONTR*-BETA to line ~D?" (linealias x)) t))
                      (list matched-support))
                matched-support)))
    (if matched-support
	(let ((msg "Applied LCONTR*-BETA.")
              (nextline 
                  (do ((line (1+ (linealias matched-support)) (1+ line)))
                      ((not (and (numalias line) 
                                 (member (numalias line) (proof-lines dproof))))
                       line))))
	  (tactic-output msg t)
	  (comdecode
	   (list 'lemma (linealias matched-support) 
        	  nextline
		 (list 'quote 
		       (auto::get-shallow 
			(car (auto::etree-components 
			      (line-node matched-support))))) '$
			      '$ '$))
	  (comdecode (list 'lcontr*-beta (linealias matched-support) nextline
			   '$ '$ '$ '$))
	  ;;(lcontr*-short matched-support)
	  (let ((new-support (car (set-difference 
				   (cdr (assoc pline (proof-plans dproof)))
				   supports))))
	    (setf (line-node new-support)
		  (car (auto::etree-components (line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg "Can't apply LCONTR*-BETA."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))


(deftactic lcontr*-eta-tac
  (etree-nat
   (lambda (pline)
     (lcontr*-eta-tac-etree-nat-fn pline))
   "If a support line is a rewrite node justified by eta, applies
lcontr*-eta rule."))

(defun lcontr*-eta-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (lambda-match-eta2 s)))
				   supports))
         (matched-support 
            (if (and (eq tacmode 'interactive) matched-support)
                (find-if #'(lambda (x) 
                      (query (format nil  "Apply LCONTR*-ETA to line ~D?" (linealias x)) t))
                      (list matched-support))
                matched-support)))
    (if matched-support
	(let ((msg "Applied LCONTR*-ETA.")
              (nextline 
                  (do ((line (1+ (linealias matched-support)) (1+ line)))
                      ((not (and (numalias line) 
                                 (member (numalias line) (proof-lines dproof))))
                       line))))
	  (tactic-output msg t)
	  (comdecode
	   (list 'lemma (linealias matched-support) 
        	  nextline
		 (list 'quote 
		       (auto::get-shallow 
			(car (auto::etree-components 
			      (line-node matched-support))))) '$
			      '$ '$))
	  (comdecode (list 'lcontr*-eta (linealias matched-support) nextline
			   '$ '$ '$ '$))
	  ;;(lcontr*-short matched-support)
	  (let ((new-support (car (set-difference 
				   (cdr (assoc pline (proof-plans dproof)))
				   supports))))
	    (setf (line-node new-support)
		  (car (auto::etree-components (line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg "Can't apply LCONTR*-ETA."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))

(deftactic lcontr*-tac
  (etree-nat
   (lambda (pline)
     (lcontr*-tac-etree-nat-fn pline))
   "If a support line is a rewrite node justified by lambda, applies
lcontr* rule."))

(defun lcontr*-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (lambda-match2 s))) supports))
         (matched-support 
            (if (and (eq tacmode 'interactive) matched-support)
                (find-if #'(lambda (x) 
                      (query (format nil  "Apply LCONTR* to line ~D?" (linealias x)) t))
                      (list matched-support))
                matched-support)))
    (if matched-support
	(let ((msg "Applied LCONTR*.")
              (nextline 
                  (do ((line (1+ (linealias matched-support)) (1+ line)))
                      ((not (and (numalias line) 
                                 (member (numalias line) (proof-lines dproof))))
                       line))))
	  (tactic-output msg t)
	  (comdecode
	   (list 'lemma (linealias matched-support) 
        	  nextline
		 (list 'quote 
		       (auto::get-shallow 
			(car (auto::etree-components 
			      (line-node matched-support))))) '$
			      '$ '$))
	  (comdecode (list 'lcontr* (linealias matched-support) nextline
			   '$ '$ '$ '$))
	  ;;(lcontr*-short matched-support)
	  (let ((new-support (car (set-difference 
				   (cdr (assoc pline (proof-plans dproof)))
				   supports))))
	    (setf (line-node new-support)
		  (car (auto::etree-components (line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg "Can't apply LCONTR*."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))

(context quant-tactics)

(deftactic ab-sline-tac
  (etree-nat
   (lambda (pline)
     (ab-sline-tac-etree-nat-fn pline))
   "If a support line is a rewrite node justified by ab, applies the
ab* rule."))

(defun ab-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (ab-match2 s)))
				   supports))
	 (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply AB-SLINE to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(let ((msg "Applied AB-SLINE."))
	  (tactic-output msg t)
	  (comdecode 
		   (list 'ab* (linealias matched-support)
			 '$ (list 'quote (auto::get-shallow 
					  (car (auto::etree-components 
						(line-node matched-support))))) 
			 '$
			 (mapcar #'linealias (line-hypotheses matched-support))
			 (mapcar #'linealias (line-hypotheses matched-support))))
	  (let ((new-support
		 (car (set-difference
		       (cdr (assoc pline (proof-plans dproof)))
		       supports))))
	    (setf (line-node new-support)
		  (car (auto::etree-components (line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg  "Can't apply AB-SLINE."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))

(context defn-tactics)

(deftactic equiv-wffs-sline-tac
  (etree-nat
   (lambda (pline)
     (equiv-wffs-sline-tac-etree-nat-fn pline))
   "If a support line is a rewrite node justified by equiv-wffs (instantiating
definitions), applies the appropriate rule."))

(defun equiv-wffs-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (equiv-wffs-match2 s)))
				   supports))
	 (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply EQUIV-WFFS-SLINE to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(let ((msg "Applied EQUIV-WFFS-SLINE."))
	  (tactic-output msg t)
	  (comdecode 
		   (list 'equiv-wffs (linealias matched-support) 
			 '$ (list 'quote (auto::get-shallow 
					  (car (auto::etree-components 
						(line-node matched-support)))))
			 '$
			 (mapcar #'linealias (line-hypotheses matched-support))
			 (mapcar #'linealias (line-hypotheses matched-support))))
	  (let ((new-support 
		 (car (set-difference 
		       (cdr (assoc pline (proof-plans dproof)))
		       supports))))
	    (setf (line-node new-support)
		  (car (auto::etree-components (line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg  "Can't apply EQUIV-WFFS-SLINE."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))

(context quant-tactics)

(deftactic ruleq-sline-tac
  (etree-nat
   (lambda (pline)
     (ruleq-sline-tac-etree-nat-fn pline))
   "If a support line is a rewrite node justified by ruleq, applies
the rewrite."))

(defun ruleq-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (ruleq-match2 s)))
				   supports))
	 (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply RULEQ-SLINE to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(let ((msg "Applied RULEQ-SLINE."))
	  (tactic-output msg t)
	  (make-room-after matched-support 1)
	  (comdecode 
		   (list 'lemma (linealias pline) 
			 (1+ (linealias matched-support))
			 (list 'quote (auto::get-shallow 
				       (car (auto::etree-components 
					     (line-node matched-support)))))
			 '$ 
			 '$
			 (remove-duplicates 
			  (append (mapcar #'linealias (line-hypotheses matched-support))
				  (mapcar #'linealias (line-hypotheses pline))))))
	  (let ((new-support
		 (car (set-difference 
		       (cdr (assoc pline (proof-plans dproof)))
		       supports))))
	    (setf (proof-plans dproof)
		  (delete new-support (proof-plans dproof) :key #'car))
	    (update-plan `((pp ,matched-support SS)) 
			 `((pp ,new-support SS)))
	    (setf (line-justification new-support)
		  (list "RuleQ" nil (list matched-support)))
	    (setf (line-node new-support)
		  (car (auto::etree-components (line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg "Can't apply RULEQ-SLINE."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))
(context equality-tactics)

(deftactic equality-sline-tac
  (etree-nat
    (orelse ext=-sline-tac leibniz=-sline-tac)
   "If a support line is a rewrite node rewritten because of an equality,
carries out the rewrite."))

(deftactic leibniz=-sline-tac
  (etree-nat
   (lambda (pline)
     (leibniz=-sline-tac-etree-nat-fn pline))
   "If a support line corresponds to rewrite node with justification
for a rewritten equality using the Leibniz definition, justifies the line 
appropriately, and makes a new support line with the rewritten wff."))

(defun leibniz=-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (leibniz=-match2 s)))
				   supports))
	 (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply LEIBNIZ=-SLINE to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(let ((msg "Applied LEIBNIZ=-SLINE."))
	  (tactic-output msg t)
	  (comdecode
	    (list 'lemma (linealias pline) '$
		  (list 'quote (auto::get-shallow 
				 (car (auto::etree-components 
					(line-node matched-support)))))
		  '$ 
		  '$ (mapcar #'linealias (line-hypotheses matched-support))))
	  (let ((new-support
		 (car (set-difference 
		       (cdr (assoc pline (proof-plans dproof)))
		       supports))))
	    (setf (line-justification new-support)
		  (list "Equality" nil (list matched-support)))
	    (update-plan `((pp ,matched-support SS)) 
			 `((pp ,new-support SS)))
	    (setf (line-node new-support)
		  (car (auto::etree-components 
			(line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg "Can't apply LEIBNIZ=-SLINE."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))

(deftactic ext=-sline-tac
  (etree-nat
   (lambda (pline)
     (ext=-sline-tac-etree-nat-fn pline))
   "If a support line corresponds to rewrite node with justification
for a rewritten equality using extensionality, justifies the line 
appropriately, and makes a new support line with the rewritten wff."))


(defun ext=-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (ext=-match2 s)))
				   supports))
	 (matched-support 
	  (if (and (eq tacmode 'interactive) matched-support)
	      (find-if #'(lambda (x) (query (format nil  "Apply EXT=-SLINE to line ~D?" (linealias x)) t))
		       (list matched-support))
	    matched-support)))
    (if matched-support
	(let ((msg "Applied EXT=-SLINE."))
	  (tactic-output msg t)
	  (comdecode 
	    (list 'lemma (linealias pline) '$
		  (list 'quote (auto::get-shallow 
				 (car (auto::etree-components 
					(line-node matched-support)))))
		  '$ 
		  '$ (mapcar #'linealias (line-hypotheses matched-support))))
	  (let ((new-support
		 (car (set-difference 
		       (cdr (assoc pline (proof-plans dproof)))
		       supports))))
	    (setf (line-justification new-support)
		  (list "Ext=" nil (list matched-support)))
	    (update-plan `((pp ,matched-support SS)) 
			 `((pp ,new-support SS)))
	    (setf (line-node new-support)
		  (car (auto::etree-components 
			(line-node matched-support))))
	    (values (list pline) msg 'succeed)))
	(let ((msg "Can't apply EXT=-SLINE."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail))
	)))


(context defn-tactics)

;(deftactic neg-rew-sline-tac
;  (etree-nat
;   (lambda (pline)
;     (neg-rew-sline-tac-etree-nat-fn pline))
;   "If a support line is a negated rewrite node, move the negation under
;the rewrite node."))
;
;
;(defun neg-rew-sline-tac-etree-nat-fn (pline)
;  (let* ((auto::*ignore-statuses* t)
;	 (supports (cdr (assoc pline (proof-plans dproof))))
;	 (matched-support (find-if #'neg-rew-match2 supports)))
;    (when (and matched-support (eq tacmode 'interactive))
;      (setq matched-support
;	    (find-if #'(lambda (x)
;			 (query (format nil  "Apply NEG-REW-PLAN to line ~D?"
;					(linealias x)) t))
;		     (list matched-support))))
;    (if matched-support
;	(let* ((msg "Applied NEG-REW-SLINE.")
;	       (save-node (line-node matched-support))
;	       (neg-node (auto::copy-negation save-node))
;	       (rew-node (auto::copy-rewrite 
;			  (car (auto::etree-components neg-node)))))
;	  (setf (auto::etree-components neg-node)
;		(auto::etree-components rew-node))
;	  (setf (auto::etree-components rew-node)
;		(list neg-node))
;	  (setf (line-node matched-support) rew-node)
;	  (tactic-output msg t)
;	  (values (list pline) "Applied NEG-REW-PLAN." 'succeed))
;	(let ((msg "Can't apply NEG-REW-SLINE."))
;	  (tactic-output msg nil)
;	  (values (list pline) msg 'fail)))
;    ))

;;; Above code was totally bogus.  Actually, we want to carry out the
;;; rewrite in the nat-ded proof, and update the expansion tree
;;; accordingly. DAN 24FEB90

(deftactic neg-rew-sline-tac
  (etree-nat
   (lambda (pline)
     (neg-rew-sline-tac-etree-nat-fn pline))
   "If a support line is a negated rewrite node, carry out the rewrite,
leaving the negation above."))


(defun neg-rew-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (neg-rew-match2 s)
					    (or use-rulep
						(not (member
						      (auto::rewrite-justification
						       (car (auto::etree-components
							     (line-node s))))
						      '(auto::equiv-disjs auto::equiv-implics))))))
				   supports)))
    (when (and matched-support (eq tacmode 'interactive))
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply NEG-REW-SLINE to line ~D?"
					(linealias x)) t))
		     (list matched-support))))
    (if matched-support
	(let* ((msg "Applied NEG-REW-SLINE.")
	       (save-node (line-node matched-support))
               (rew-node (car (etree-components save-node)))
	       (neg-node (auto::copy-negation save-node))
               (kid-node (car (etree-components rew-node)))
               (oldplans (mapcar #'car (proof-plans dproof)))
               (newplan nil)
               )
	  (setf (auto::etree-components neg-node)
		(auto::etree-components rew-node))
          (make-room-after matched-support 1) 
          (apply #'lemma-enter 
                 (lemma-build (linealias pline)
                              (1+ (linealias matched-support))
                              (cons 'not (get-shallow kid-node))
                              (line-assertion pline)
                              (mapcar #'linealias (line-hypotheses pline))
                              (mapcar #'linealias 
                                      (line-hypotheses matched-support))))
          (setq newplan
                (car (set-difference (mapcar #'car (proof-plans
                                                    dproof))
                                     oldplans)))
          (setf (line-just-rule newplan)
                (case (auto::rewrite-justification rew-node)
                  (auto::lambda "Lambda")
                  (auto::beta "Beta rule")
                  (auto::eta "Eta rule")
                  (auto::ab "AB")
                  ((auto::equiv-disjs auto::equiv-implics) "RuleP")
                  ((auto::equivwffs auto::dual) "EquivWffs")
                  (auto::ext= "Ext=")
                  (auto::leibniz= "Equality")
                  (auto::refl= "Refl=")
                  (otherwise (line-just-rule newplan))))
          (setf (line-just-lines newplan)
                (list matched-support))
          (setf (proof-plans dproof)
                (delete newplan (proof-plans dproof) :key #'car))
          (unsponsor pline (list matched-support))
          (setf (line-node newplan) neg-node)
	  (tactic-output msg t)
	  (values (list pline) "Applied NEG-REW-SLINE." 'succeed))
	(let ((msg "Can't apply NEG-REW-SLINE."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))

; cebrown 9/9/01
(deftactic neg-equiv-sline-tac
  (etree-nat
   (lambda (pline)
     (neg-equiv-sline-tac-etree-nat-fn pline))
   "If a support line is a negated equiv-implics rewrite node,
and the planned line is FALSEHOOD, do an eneg to make the support line
the planned line without the negation, then do the rewrite."))

(defun neg-equiv-sline-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (matched-support (find-if #'(lambda (s)
				       (and (not (mated-line s (line-mating pline)))
					    (neg-rew-match2 s)
					    (eq (line-assertion pline) 'FALSEHOOD)
					    (member (auto::rewrite-justification
						     (car (etree-components
							   (line-node s))))
						    '(auto::equiv-disjs auto::equiv-implics))))
				   supports)))
    (when (and matched-support (eq tacmode 'interactive))
      (setq matched-support
	    (find-if #'(lambda (x)
			 (query (format nil  "Apply NEG-EQUIV-SLINE to line ~D?"
					(linealias x)) t))
		     (list matched-support))))
    (if matched-support
	(let* ((msg "Applied NEG-EQUIV-SLINE.")
	       (save-node (line-node matched-support))
               (rew-node (car (etree-components save-node)))
	       (neg-node (auto::copy-negation save-node))
               (kid-node (car (etree-components rew-node)))
               (newplan nil)
	       (i (linealias matched-support))
	       (j (linealias pline))
	       (j1 (+ j 1))
	       (j2 (+ j 2))
               )
	  (setf (auto::etree-components neg-node)
		(auto::etree-components rew-node))
	  (introduce-gap pline 2)
	  (comdecode (list 'cl-user::eneg j2 i j1 '$ '$ '$ '$))
	  (if (eq (auto::rewrite-justification rew-node) 'auto::equiv-implics)
	      (comdecode (list 'cl-user::implics-equiv j1 j '$ '$ '$ '$))
	    (let ((midplan (numalias j1)))
	      (comdecode (list 'lemma j1 j
			       (list 'quote (get-shallow kid-node))
			       '$ '$ '$))
	      (rulep-enter midplan (list (numalias j)))
	      (setf (line-just-rule midplan) "EquivConj")
	      ))
	  (setq newplan (numalias j))
          (setf (line-node newplan) kid-node)
	  (setf (line-mating newplan) (line-mating pline))
	  (tactic-output msg t)
	  (values (list newplan) "Applied NEG-EQUIV-SLINE." 'succeed))
	(let ((msg "Can't apply NEG-EQUIV-SLINE."))
	  (tactic-output msg nil)
	  (values (list pline) msg 'fail)))
    ))


(context compound-tactics)


(deftactic sline-tac
  (etree-nat
   (orelse 
      econj-tac cases-tac mp-tac ui-tac rulec-tac 
      neg-neg-tac neg-and-sline-tac neg-or-sline-tac neg-imp-sline-tac 
      neg-sel-sline-tac neg-exp-sline-tac equiv-disj-tac
      equiv-implics-tac lcontr*-vary-tac 
      equiv-wffs-sline-tac ab-sline-tac ruleq-sline-tac
      equality-sline-tac)))

(context aux-tactics)
(deftactic rewrite-sline-p-tac
  (etree-nat
   (lambda (pline)
     (let* ((supports (cdr (assoc pline (proof-plans dproof))))
	    (nodes (mapcar #'(lambda (x) (line-node x)) supports)))
       (if (find-if #'auto::rewrite-p nodes)
	   (values (list pline) "Rewrite support node found." 'succeed)
	   (values (list pline) "Rewrite support node not found." 'fail))))
   "Returns success if some support line represents a rewrite node."))

(deftactic neg-sline-p-tac
  (etree-nat
   (lambda (pline)
     (let* ((supports (cdr (assoc pline (proof-plans dproof))))
	    (nodes (mapcar #'(lambda (x) (line-node x)) supports)))
       (if (find-if #'auto::negation-p nodes)
	   (values (list pline) "Negated support node found." 'succeed)
	   (values (list pline) "Negated support node not found." 'fail))))
   "Returns success if some support line represents a negation node."))

					; for duplicate-support-tac, we need to treat neg's as being mated
					; if a direct descendent is
					; I'm having it return the mated node in case we want to check if it is a leaf
					; cebrown 2/17/01
(defun mated-line-or-neg (line litnames)
  (let ((node (line-node line)))
    (and (not (get line 'duplicate))
	 (not (auto::leaf-p node))
	 (or (member (etree-name node) litnames)
	     (and (auto::negation-p node)
		  (auto::etree-components node)
		  (not (auto::leaf-p (car (auto::etree-components node))))
		  (member (etree-name (car (auto::etree-components node)))
			  litnames))))))

					; block neg elim rules (see ml-etr-tactics-neg) when the etree is neg of a mated node
					; even if it has been duplicated, since we should not apply the appropriate introduction
					; rule to the resulting planned line.  Note that we are not checking if the line
					; is a duplicate, as we do in the other mated-line functions
					; (we were getting an "indirect <-> neg elim" loop)
					; 8/30/01 - found another bug - was failing to apply
					; neg-imp when we needed to - changed this
					; to allow the rule to apply to duplicates,
					; and changed indirect to block loops
(defun neg-mated-line (line litnames)
  (let ((node (line-node line)))
    (and (auto::negation-p node)
	 (auto::etree-components node)
	 (not (auto::leaf-p (car (auto::etree-components node))))
	 (not (get line 'duplicate)) ; cebrown 9/9/01
	 (member (etree-name (car (auto::etree-components node)))
		 litnames))))

					; cebrown - 9/5/00 - tactic for duplicating a support line which corresponds to a mated (nonleaf) node
(deftactic duplicate-support-tac
    (etree-nat
     (lambda (pline)
       (duplicate-support-tac-etree-nat-fn pline))
     "If a support line is part of the mating, the duplicate the
line, where the original line will remain a support line and
where support line tactics can be applied to the copy.
This is needed to make proofs with non-leaf matings translate properly.
See Pfenning's Tactic 183."))

(defun duplicate-support-tac-etree-nat-fn (pline)
  (let* ((auto::*ignore-statuses* t)
	 (supports (cdr (assoc pline (proof-plans dproof))))
	 (mating (line-mating pline))
	 (mated-nodes (append (mapcar #'car mating) (mapcar #'cdr mating)))
	 (matched-supports (remove-if-not
			    #'(lambda (x)
				(and (not (get x 'duplicated))
				     (mated-line-or-neg x mated-nodes)))
			    supports))
	 (matched-support (car matched-supports)))
    (when (eq tacmode 'interactive)
      (setq matched-support
	(find-if #'(lambda (x)
		     (query (format nil "Apply DUPLICATE-SUPPORT to line ~D?"
				    (linealias x)) t))
		 matched-supports)))
    (if matched-support
	(let* ((msg "Applied DUPLICATE-SUPPORT.")
	       (i (linealias matched-support))
	       (a (numalias (+ i 1))))
	  (when a
	    (introduce-gap a 1))
	  (comdecode (list 'same (+ i 1) i 
			   (list 'quote (line-assertion matched-support))
			   '$ '$))
	  (let* ((new-support (numalias (+ i 1)))
		 (node (line-node matched-support))
		 (new-conns nil)
		 (new-leaf (make-leaf :free-vars (auto::etree-free-vars node)
				      :positive (etree-positive node)
				      :junctive nil
				      :shallow (get-shallow node)))
		 (matednodename (if (auto::negation-p node)
				    (etree-name (car (auto::etree-components node)))
				  (etree-name node)))
		 (newleafname (etree-name new-leaf)))
	    (dolist (conn mating)
		    (when (eq (car conn) matednodename)
		      (push (cons newleafname (cdr conn)) new-conns))
		    (when (eq (cdr conn) matednodename)
		      (push (cons (car conn) newleafname) new-conns)))
	    (dolist (p (proof-plans dproof))
		    (when (member matched-support (cdr p))
		      (push new-support (cdr p))
		      (setf (line-mating (car p))
			    (append new-conns (line-mating (car p))))))
	    (setf (line-node new-support) (line-node matched-support))
	    (setf (line-node matched-support) new-leaf)
	    (setf (get matched-support 'duplicated) t)
	    (setf (get new-support 'duplicate) t)
	    (values (list pline) msg 'succeed)))
      (let ((msg "Can't apply DUPLICATE-SUPPORT"))
	(tactic-output msg nil)
	(values (list pline) msg 'fail)))))

