(defmode MODE-THM15B-NEW2
 (FLAG-SETTINGS (WEIGHT-C-FN OPTION-SET-NUM-VPATHS) (WEIGHT-C-COEFFICIENT 0) (WEIGHT-B-FN SIMPLEST-WEIGHT-B-FN) (WEIGHT-B-COEFFICIENT 1) (WEIGHT-A-FN EXPANSION-LEVEL-WEIGHT-A) (WEIGHT-A-COEFFICIENT 0) (USE-SYMSIMP T) (USE-RULEP T) (USE-FAST-PROP-SEARCH T) (UNIFY-VERBOSE SILENT) (UNI-SEARCH-HEURISTIC BREADTH-FIRST) (TRUTHVALUES-HACK NIL) (SUBSUMPTION-NODES LP-NODES) (SUBSUMPTION-CHECK NIL) (STOP-AT-TSN T) (SKOLEM-DEFAULT SK1) (SHOW-TIME T) (SEARCH-TIME-LIMIT 30) (SEARCH-COMPLETE-PATHS NIL) (RULEP-WFFEQ WFFEQ-AB) (RIGID-PATH-CK T) (REWRITE-EQUALITIES ALL) (REWRITE-DEFNS (EAGER)) (REMOVE-LEIBNIZ T) (REDUCE-DOUBLE-NEG T) (RECORDFLAGS (LAST-MODE-NAME DEFAULT-MS SHORT-SITE-NAME MACHINE-TYPE LISP-IMPLEMENTATION-TYPE MAX-SEARCH-LIMIT SEARCH-TIME-LIMIT MAX-UTREE-DEPTH MAX-SEARCH-DEPTH MIN-QUICK-DEPTH INITIAL-BKTRACK-LIMIT NUM-FRPAIRS FIRST-ORDER-MODE-MS NUM-OF-DUPS MAX-MATES ORDER-COMPONENTS REWRITE-DEFNS REWRITE-EQUALITIES REMOVE-LEIBNIZ MAX-PRIM-DEPTH MIN-PRIM-DEPTH PRIM-QUANTIFIER PRIM-BDTYPES NEG-PRIM-SUB OCCURS-CHECK RANK-EPROOF-FN SKOLEM-DEFAULT MIN-QUANTIFIER-SCOPE)) (RECONSIDER-FN INF-WEIGHT) (RANK-EPROOF-FN NUM-VPATHS-RANKING) (QUERY-USER NIL) (PROP-STRATEGY ALLOW-DUPLICATES) (PRINTMATEOPS (LAMBDA (EDOP) (DECLARE (IGNORE EDOP)) T)) (PRINTMATEFLAG-SLIDES NIL) (PRINTMATEFLAG NIL) (PRINTMATEFILE "mate.mss") (PRINT-MATING-COUNTER 300000) (PRIMSUB-METHOD PR93) (PRIM-QUANTIFIER T) (PRIM-PREFIX PRIM) (PRIM-BDTYPES-AUTO IGNORE) (PRIM-BDTYPES ("OI")) (PENALTY-FOR-ORDINARY-DUP INFINITY) (PENALTY-FOR-MULTIPLE-SUBS 1000) (PENALTY-FOR-MULTIPLE-PRIMSUBS 1000) (PENALTY-FOR-EACH-PRIMSUB 1) (ORDER-COMPONENTS NIL) (OPTIONS-VERBOSE NIL) (OPTIONS-GENERATE-UPDATE IDENT-ARG) (OPTIONS-GENERATE-FN ADD-OPTIONS-ORIGINAL) (OPTIONS-GENERATE-ARG 75) (OCCURS-CHECK T) (NUM-OF-DUPS 0) (NUM-FRPAIRS 5) (NEW-OPTION-SET-LIMIT 20) (NEW-MATING-AFTER-DUP NIL) (NEG-PRIM-SUB NIL) (MS91-WEIGHT-LIMIT-RANGE 100) (MS91-PREFER-SMALLER T) (MS90-3-DUP-STRATEGY 1) (MS-SPLIT T) (MS-INIT-PATH NIL) (MS-DIR QUASI-TPS1) (MONITORFLAG NIL) (MIN-QUICK-DEPTH 1) (MIN-QUANTIFIER-SCOPE NIL) (MIN-QUANT-ETREE T) (MIN-PRIM-LITS 2) (MIN-PRIM-DEPTH 1) (MAX-UTREE-DEPTH 20) (MAX-SEARCH-LIMIT 30) (MAX-SEARCH-DEPTH 20) (MAX-PRIM-LITS 4) (MAX-PRIM-DEPTH 2) (MAX-MATES 1) (MAX-DUP-PATHS INFINITY) (MATING-VERBOSE SILENT) (MATE-FFPAIR T) (LAST-MODE-NAME "Mode : MODE-THM15B-NEW1, but with SEARCH-TIME-LIMIT set to 30, and MAX-SEARCH-LIMIT set to 30, and ETREE-NAT-VERBOSE set to NIL, and TACTIC-VERBOSE set to MIN, and LOAD-WARN-P set to NIL, and MAX-SEARCH-LIMIT set to 35, and SEARCH-TIME-LIMIT set to 35, and QUERY-USER set to QUERY-JFORMS, and MIN-QUICK-DEPTH set to 1, and SEARCH-TIME-LIMIT set to 30, and MAX-SEARCH-LIMIT set to 30, and QUERY-USER set to NIL") (INTERRUPT-ENABLE T) (INITIAL-BKTRACK-LIMIT INFINITY) (IMITATION-FIRST T) (FIRST-ORDER-MODE-MS NIL) (EXCLUDING-GC-TIME T) (ETA-RULE T) (DUPLICATION-STRATEGY-PFD DUP-INNER) (DUPLICATION-STRATEGY DUP-OUTER) (DUP-ALLOWED NIL) (DNEG-IMITATION CONST-FLEX) (DEFAULT-MS MS91-6) (DEFAULT-MATE NPFD) (DEFAULT-EXPAND OSET) (COUNTSUBS-FIRST T) (APPLY-MATCH APPLY-MATCH-ALL-FRDPAIRS))
 (mhelp "fastest proof to date of thm15b"))
