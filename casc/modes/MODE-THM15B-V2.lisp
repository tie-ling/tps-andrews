(defmode MODE-THM15B-V2
 (FLAG-SETTINGS (WEIGHT-C-FN OPTION-SET-NUM-VPATHS) (WEIGHT-C-COEFFICIENT 0) (WEIGHT-B-FN SIMPLEST-WEIGHT-B-FN) (WEIGHT-B-COEFFICIENT 1) (WEIGHT-A-FN EXPANSION-LEVEL-WEIGHT-A) (WEIGHT-A-COEFFICIENT 0) (USE-SYMSIMP T) (USE-RULEP T) (USE-FAST-PROP-SEARCH T) (UNIFY-VERBOSE SILENT) (UNIF-TRIGGER NIL) (UNIF-COUNTER-OUTPUT 0) (UNIF-COUNTER 0) (UNI-SEARCH-HEURISTIC BREADTH-FIRST) (TRUTHVALUES-HACK NIL) (TOTAL-NUM-OF-DUPS NIL) (SUBSUMPTION-NODES ALL-NODES) (SUBSUMPTION-DEPTH 5) (SUBSUMPTION-CHECK NIL) (STOP-AT-TSN T) (SKOLEM-DEFAULT SK1) (SHOW-TIME T) (SEARCH-TIME-LIMIT 9) (SEARCH-COMPLETE-PATHS NIL) (RULEP-WFFEQ WFFEQ-AB) (RIGID-PATH-CK T) (REWRITE-DEFNS (EAGER)) (REMOVE-LEIBNIZ T) (REDUCE-DOUBLE-NEG T) (RECORDFLAGS (LAST-MODE-NAME DEFAULT-MS SHORT-SITE-NAME MACHINE-TYPE LISP-IMPLEMENTATION-TYPE MAX-SEARCH-LIMIT SEARCH-TIME-LIMIT MAX-UTREE-DEPTH MAX-SEARCH-DEPTH MIN-QUICK-DEPTH INITIAL-BKTRACK-LIMIT NUM-FRPAIRS FIRST-ORDER-MODE-MS NUM-OF-DUPS MAX-MATES ORDER-COMPONENTS REWRITE-DEFNS REWRITE-EQUALITIES REMOVE-LEIBNIZ MAX-PRIM-DEPTH MIN-PRIM-DEPTH PRIM-QUANTIFIER PRIM-BDTYPES NEG-PRIM-SUB OCCURS-CHECK RANK-EPROOF-FN SKOLEM-DEFAULT MIN-QUANTIFIER-SCOPE)) (RECONSIDER-FN INF-WEIGHT) (RANK-EPROOF-FN NUM-VPATHS-RANKING) (QUERY-USER NIL) (PRUNING NIL) (PROP-STRATEGY ALLOW-DUPLICATES) (PRINTMATEOPS (LAMBDA (EDOP) (DECLARE (IGNORE EDOP)) T)) (PRINTMATEFLAG-SLIDES NIL) (PRINTMATEFLAG NIL) (PRINTMATEFILE "mate.mss") (PRINT-MATING-COUNTER 300000) (PRIMSUB-VAR-SELECT T) (PRIMSUB-METHOD PR97) (PRIM-QUANTIFIER T) (PRIM-PREFIX PRIM) (PRIM-BDTYPES-AUTO IGNORE) (PRIM-BDTYPES ("OI")) (PENALTY-FOR-ORDINARY-DUP INFINITY) (PENALTY-FOR-MULTIPLE-SUBS 1000) (PENALTY-FOR-MULTIPLE-PRIMSUBS 1000) (PENALTY-FOR-EACH-PRIMSUB 1) (ORDER-COMPONENTS NIL) (OPTIONS-VERBOSE NIL) (OPTIONS-GENERATE-UPDATE IDENT-ARG) (OPTIONS-GENERATE-FN ADD-OPTIONS-ORIGINAL) (OPTIONS-GENERATE-ARG 75) (OCCURS-CHECK T) (NUM-OF-DUPS 0) (NUM-FRPAIRS 5) (NEW-OPTION-SET-LIMIT 3) (NEW-MATING-AFTER-DUP NIL) (NEG-PRIM-SUB NIL) (MS91-WEIGHT-LIMIT-RANGE 100) (MS91-TIME-BY-VPATHS T) (MS91-PREFER-SMALLER T) (MS91-INTERLEAVE 3) (MS90-3-DUP-STRATEGY 1) (MS-SPLIT T) (MS-INIT-PATH NIL) (MS-DIR QUASI-TPS1) (MONITORFLAG NIL) (MIN-QUICK-DEPTH NIL) (MIN-QUANTIFIER-SCOPE NIL) (MIN-QUANT-ETREE T) (MIN-PRIM-LITS 2) (MIN-PRIM-DEPTH 1) (MAX-UTREE-DEPTH 18) (MAX-SUBSTS-VAR 3) (MAX-SUBSTS-QUICK 3) (MAX-SUBSTS-PROJ-TOTAL NIL) (MAX-SUBSTS-PROJ NIL) (MAX-SEARCH-LIMIT 9) (MAX-SEARCH-DEPTH 18) (MAX-PRIM-LITS 2) (MAX-PRIM-DEPTH 1) (MAX-MATES 1) (MAX-DUP-PATHS INFINITY) (MATING-VERBOSE SILENT) (MATE-FFPAIR T) (LEIBNIZ-SUB-CHECK NIL) (LAST-MODE-NAME "Mode : MODE-THM15B-PR97-A, but with QUERY-USER set to QUERY-JFORMS, and MAX-SEARCH-LIMIT set to 300, and SEARCH-TIME-LIMIT set to 300, and MAX-SEARCH-LIMIT set to 7, and SEARCH-TIME-LIMIT set to 7, and MS91-TIME-BY-VPATHS set to T, and REWRITE-DEFNS set to LAZY2, and REWRITE-DEFNS set to EAGER, and REWRITE-EQUALITIES set to LAZY2, and MATING-VERBOSE set to MAX, and UNIFY-VERBOSE set to MAX, and MAX-SEARCH-DEPTH set to NIL, and MAX-UTREE-DEPTH set to NIL, and MAX-SUBSTS-VAR set to 10, and MAX-SUBSTS-QUICK set to 10, and REWRITE-EQUALITIES set to ALL, and REWRITE-EQUALITIES set to LAZY2, and REWRITE-EQUALITIES set to ALL, and REWRITE-EQUALITIES set to LAZY2, and MAX-SUBSTS-VAR set to 3, and MAX-SUBSTS-QUICK set to 3, and UNIFY-VERBOSE set to SILENT, and MATING-VERBOSE set to SILENT, and TACTIC-VERBOSE set to MIN, and REWRITE-EQUALITIES set to ALL, and REWRITE-DEFNS set to ALL, and QUERY-USER set to NIL, and MAX-SEARCH-DEPTH set to 18, and MAX-UTREE-DEPTH set to 18, and QUERY-USER set to QUERY-JFORMS, and REWRITE-DEFNS set to (EAGER), and MAX-SEARCH-LIMIT set to 9, and SEARCH-TIME-LIMIT set to 9, and QUERY-USER set to NIL") (INTERRUPT-ENABLE T) (INITIAL-BKTRACK-LIMIT INFINITY) (IMITATION-FIRST T) (FIRST-ORDER-MODE-MS NIL) (EXCLUDING-GC-TIME T) (ETA-RULE T) (DUPLICATION-STRATEGY-PFD DUP-INNER) (DUPLICATION-STRATEGY DUP-OUTER) (DUP-ALLOWED NIL) (DNEG-IMITATION CONST-FLEX) (DEFAULT-MS MS91-6) (DEFAULT-MATE NPFD) (DEFAULT-EXPAND OSET) (COUNTSUBS-FIRST T) (APPLY-MATCH APPLY-MATCH-ALL-FRDPAIRS) (ADD-TRUTH IF-NEEDED))
 (mhelp ""))
