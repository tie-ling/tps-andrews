(defmode MODE-THM170-PR00
 (FLAG-SETTINGS (USE-SYMSIMP T) (USE-RULEP T) (USE-FAST-PROP-SEARCH T) (USE-DIY NIL) (UNIFY-VERBOSE SILENT) (UNIF-TRIGGER NIL) (UNIF-COUNTER-OUTPUT 0) (UNIF-COUNTER 0) (UNI-SEARCH-HEURISTIC BREADTH-FIRST) (TRUTHVALUES-HACK NIL) (TOTAL-NUM-OF-DUPS NIL) (TIMING-NAMED NIL) (SUBSUMPTION-NODES ALL-NODES) (SUBSUMPTION-DEPTH 5) (SUBSUMPTION-CHECK NIL) (STOP-AT-TSN T) (SKOLEM-DEFAULT NIL) (SHOW-TIME T) (SEARCH-TIME-LIMIT 1) (SEARCH-COMPLETE-PATHS NIL) (RULEP-WFFEQ WFFEQ-AB) (RIGID-PATH-CK T) (REWRITE-EQUIVS 1) (REWRITE-EQUALITIES ALL) (REWRITE-DEFNS (EAGER)) (REMOVE-LEIBNIZ T) (REDUCE-DOUBLE-NEG T) (RECORDFLAGS (LAST-MODE-NAME DEFAULT-MS SHORT-SITE-NAME MACHINE-TYPE LISP-IMPLEMENTATION-TYPE MAX-SEARCH-LIMIT SEARCH-TIME-LIMIT MAX-UTREE-DEPTH MAX-SEARCH-DEPTH MIN-QUICK-DEPTH INITIAL-BKTRACK-LIMIT NUM-FRPAIRS FIRST-ORDER-MODE-MS NUM-OF-DUPS MAX-MATES ORDER-COMPONENTS REWRITE-DEFNS REWRITE-EQUALITIES REMOVE-LEIBNIZ MAX-PRIM-DEPTH MIN-PRIM-DEPTH PRIM-QUANTIFIER PRIM-BDTYPES NEG-PRIM-SUB OCCURS-CHECK RANK-EPROOF-FN SKOLEM-DEFAULT MIN-QUANTIFIER-SCOPE)) (RANK-EPROOF-FN NUM-VPATHS-RANKING) (QUERY-USER NIL) (PRUNING NIL) (PROP-STRATEGY ALLOW-DUPLICATES) (PRINTMATEOPS (LAMBDA (EDOP) (DECLARE (IGNORE EDOP)) T)) (PRINTMATEFLAG-SLIDES NIL) (PRINTMATEFLAG NIL) (PRINTMATEFILE "mate.mss") (PRINT-MATING-COUNTER 300000) (PRIMSUB-VAR-SELECT T) (PRIMSUB-METHOD PR00) (PRIM-QUANTIFIER T) (PRIM-PREFIX PRIM) (PRIM-BDTYPES-AUTO IGNORE) (PRIM-BDTYPES ("OI")) (PR97C-PRENEX T) (PR97C-MAX-ABBREVS 1) (PR00-REQUIRE-ARG-DEPS NIL) (PR00-NUM-ITERATIONS 1) (PR00-MAX-SUBSTS-VAR 13) (ORDER-COMPONENTS NIL) (OCCURS-CHECK T) (NUM-OF-DUPS 0) (NUM-FRPAIRS 5) (NEW-MATING-AFTER-DUP NIL) (NEG-PRIM-SUB NIL) (NATREE-DEBUG T) (MS98-VERBOSE NIL) (MS98-VARIABLE-ORDER 1) (MS98-VALID-PAIR 1) (MS98-UNIF-HACK2 T) (MS98-UNIF-HACK T) (MS98-TRACE NIL) (MS98-REWRITES NIL) (MS98-REWRITE-UNIF NIL) (MS98-REWRITE-SIZE NIL) (MS98-REWRITE-PRUNE T) (MS98-REWRITE-MODEL NIL) (MS98-REWRITE-DEPTH 2) (MS98-REW-PRIMSUBS NIL) (MS98-PRIMSUB-COUNT 3) (MS98-NUM-OF-DUPS NIL) (MS98-MINIMALITY-CHECK NIL) (MS98-MERGE-DAGS 0) (MS98-MEASURE 0) (MS98-MAX-PRIMS 1) (MS98-MAX-COMPONENTS NIL) (MS98-LOW-MEMORY NIL) (MS98-INIT 3) (MS98-FRAGMENT-ORDER 1) (MS98-FORCE-H-O NIL) (MS98-FIRST-FRAGMENT NIL) (MS98-DUP-PRIMSUBS NIL) (MS98-DUP-BELOW-PRIMSUBS T) (MS98-BASE-PRIM NIL) (MS91-INTERLEAVE 3) (MS90-3-QUICK NIL) (MS90-3-DUP-STRATEGY 1) (MS-SPLIT T) (MS-INIT-PATH NIL) (MS-DIR QUASI-TPS1) (MONITORFLAG NIL) (MIN-QUICK-DEPTH NIL) (MIN-QUANTIFIER-SCOPE NIL) (MIN-QUANT-ETREE T) (MIN-PRIM-LITS 2) (MIN-PRIM-DEPTH 1) (MERGE-MINIMIZE-MATING T) (MAXIMIZE-FIRST NIL) (MAX-UTREE-DEPTH 18) (MAX-SUBSTS-VAR 3) (MAX-SUBSTS-QUICK 3) (MAX-SUBSTS-PROJ-TOTAL NIL) (MAX-SUBSTS-PROJ NIL) (MAX-SEARCH-LIMIT NIL) (MAX-SEARCH-DEPTH 18) (MAX-PRIM-LITS 2) (MAX-PRIM-DEPTH 1) (MAX-MATES 1) (MAX-DUP-PATHS INFINITY) (MATING-VERBOSE SILENT) (MATE-FFPAIR T) (LEIBNIZ-SUB-CHECK NIL) (LAST-MODE-NAME "Mode : MODE-THM15B-PR97-A, but with PRIMSUB-METHOD set to PR00, and SKOLEM-DEFAULT set to NIL, and DEFAULT-MS set to MS98-1, and MS98-INIT set to 3, and PR00-MAX-SUBSTS-VAR set to 7, and PR00-MAX-SUBSTS-VAR set to 10, and ALLOW-NONLEAF-CONNS set to (REW), and ALLOW-NONLEAF-CONNS set to (REWRITES), and MAX-SUBSTS-VAR set to 15, and MAX-SUBSTS-VAR set to 10, and MAX-SUBSTS-VAR set to 5, and MAX-SUBSTS-VAR set to 10, and MAX-SUBSTS-VAR set to 15, and MAX-SUBSTS-VAR set to 12, and MAX-SUBSTS-VAR set to 13, and PR00-MAX-SUBSTS-VAR set to 13, and MAX-SUBSTS-VAR set to 3, and ALLOW-NONLEAF-CONNS set to NIL, and MS98-INIT set to 1, and MS98-INIT set to 3, and MAX-SEARCH-LIMIT set to NIL") (INTERRUPT-ENABLE T) (INITIAL-BKTRACK-LIMIT INFINITY) (IMITATION-FIRST T) (HPATH-THRESHOLD 1) (FIRST-ORDER-MODE-MS NIL) (FF-DELAY NIL) (EXCLUDING-GC-TIME T) (ETA-RULE T) (DUPLICATION-STRATEGY-PFD DUP-INNER) (DUPLICATION-STRATEGY DUP-OUTER) (DUP-ALLOWED NIL) (DNEG-IMITATION CONST-FLEX) (DISSOLVE NIL) (DEFAULT-MS MS98-1) (DEFAULT-MATE MS98-1) (DEFAULT-EXPAND MS98-1) (COUNTSUBS-FIRST T) (BREAK-AT-QUANTIFIERS NIL) (APPLY-MATCH APPLY-MATCH-ALL-FRDPAIRS) (ALLOW-NONLEAF-CONNS NIL) (ADD-TRUTH IF-NEEDED))
 (mhelp ""))
