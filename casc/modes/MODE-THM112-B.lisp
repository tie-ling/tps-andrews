(defmode MODE-THM112-B
 (FLAG-SETTINGS (PRINTMATEFILE "mate.mss") (PRINTMATEFLAG NIL) (PRINTMATEFLAG-SLIDES NIL) (PRINTMATEOPS (LAMBDA (EDOP) (DECLARE (IGNORE EDOP)) T)) (DEFAULT-MS MS89) (MS90-3-DUP-STRATEGY 1) (RANK-EPROOF-FN NUM-VPATHS-RANKING) (SHOW-TIME T) (DUP-ALLOWED T) (DUPLICATION-STRATEGY DUP-OUTER) (FIRST-ORDER-MODE-MS NIL) (INITIAL-BKTRACK-LIMIT 3) (INTERRUPT-ENABLE T) (MATE-FFPAIR NIL) (MATING-VERBOSE MAX) (MAX-SEARCH-LIMIT 2) (MIN-QUANTIFIER-SCOPE NIL) (MS-DIR QUASI-TPS1) (MS-INIT-PATH NIL) (MS-SPLIT T) (NEW-MATING-AFTER-DUP NIL) (OCCURS-CHECK T) (ORDER-COMPONENTS T) (PRIM-QUANTIFIER T) (PROP-STRATEGY ALLOW-DUPLICATES) (QUERY-USER NIL) (REC-MS-FILE NIL) (REC-MS-FILENAME "mating.rec") (REMOVE-LEIBNIZ NIL) (REWRITE-DEFNS (EAGER)) (REWRITE-EQUALITIES ALL) (RULEP-WFFEQ WFFEQ-AB) (SEARCH-COMPLETE-PATHS NIL) (SEARCH-TIME-LIMIT 2) (SKOLEM-DEFAULT SK1) (UNIFY-VERBOSE T) (USE-RULEP T) (USE-SYMSIMP T) (NUM-OF-DUPS 1) (ETA-RULE T) (IMITATION-FIRST T) (MAX-SEARCH-DEPTH 10) (MAX-UTREE-DEPTH 5) (MIN-QUICK-DEPTH 3) (REDUCE-DOUBLE-NEG T) (STOP-AT-TSN T) (SUBSUMPTION-CHECK NIL) (APPLY-MATCH APPLY-MATCH-ALL-FRDPAIRS) (UNI-SEARCH-HEURISTIC BREADTH-FIRST) (NEG-PRIM-SUB NIL) (PRIM-BDTYPES ("I")) (PRIM-PREFIX PRIM))
 (mhelp "Gives quick trivial proofof THM112"))
