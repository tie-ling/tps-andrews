(defmode THM112A-MODE-A
 (FLAG-SETTINGS (WEIGHT-C-FN OPTION-SET-NUM-LEAVES) (WEIGHT-C-COEFFICIENT 1) (WEIGHT-B-FN SIMPLE-WEIGHT-B-FN) (WEIGHT-B-COEFFICIENT 1) (WEIGHT-A-FN EXPANSION-LEVEL-WEIGHT-A) (WEIGHT-A-COEFFICIENT 1) (USE-SYMSIMP T) (USE-RULEP T) (UNIFY-VERBOSE SILENT) (UNIF-TRIGGER NIL) (UNIF-COUNTER-OUTPUT 0) (UNIF-COUNTER 0) (UNI-SEARCH-HEURISTIC BREADTH-FIRST) (SUBSUMPTION-NODES LP-NODES) (SUBSUMPTION-DEPTH INFINITY) (SUBSUMPTION-CHECK NIL) (STOP-AT-TSN T) (SKOLEM-DEFAULT SK1) (SEARCH-TIME-LIMIT 3) (SEARCH-COMPLETE-PATHS NIL) (RULEP-WFFEQ WFFEQ-AB) (RIGID-PATH-CK NIL) (REWRITE-EQUALITIES ALL) (REWRITE-EQUALITIES ALL) (REWRITE-DEFNS (EAGER)) (REMOVE-LEIBNIZ T) (REDUCE-DOUBLE-NEG T) (RECONSIDER-FN INF-WEIGHT) (QUERY-USER NIL) (PRUNING NIL) (PROP-STRATEGY ALLOW-DUPLICATES) (PRINT-MATING-COUNTER 300000) (PRIMSUB-METHOD PR93) (PRIM-QUANTIFIER T) (PENALTY-FOR-ORDINARY-DUP INFINITY) (PENALTY-FOR-MULTIPLE-SUBS 20) (PENALTY-FOR-MULTIPLE-PRIMSUBS 100) (PENALTY-FOR-EACH-PRIMSUB 1) (ORDER-COMPONENTS PREFER-RIGID1) (OPTIONS-VERBOSE NIL) (OPTIONS-GENERATE-UPDATE IDENT-ARG) (OPTIONS-GENERATE-FN ADD-OPTIONS-ORIGINAL) (OPTIONS-GENERATE-ARG 75) (NUM-OF-DUPS 2) (NUM-FRPAIRS 5) (NEW-OPTION-SET-LIMIT 5) (NEW-MATING-AFTER-DUP NIL) (MS91-WEIGHT-LIMIT-RANGE 1) (MS91-TIME-BY-VPATHS NIL) (MS91-PREFER-SMALLER T) (MS-SPLIT T) (MS-INIT-PATH NIL) (MS-DIR QUASI-TPS1) (MIN-QUICK-DEPTH 12) (MIN-QUANTIFIER-SCOPE NIL) (MIN-PRIM-LITS 2) (MIN-PRIM-DEPTH 2) (MAX-UTREE-DEPTH 7) (MAX-SUBSTS-VAR 3) (MAX-SUBSTS-QUICK NIL) (MAX-SUBSTS-PROJ-TOTAL NIL) (MAX-SUBSTS-PROJ NIL) (MAX-SEARCH-LIMIT 3) (MAX-SEARCH-DEPTH 7) (MAX-PRIM-LITS 4) (MAX-PRIM-DEPTH 2) (MAX-MATES 2) (MAX-DUP-PATHS INFINITY) (LEIBNIZ-SUB-CHECK NIL) (INTERRUPT-ENABLE T) (INITIAL-BKTRACK-LIMIT INFINITY) (IMITATION-FIRST T) (FIRST-ORDER-MODE-MS NIL) (ETA-RULE T) (DUPLICATION-STRATEGY-PFD DUP-INNER) (DUP-ALLOWED T) (DNEG-IMITATION CONST-FLEX) (DEFAULT-MS MS91-7) (DEFAULT-MATE PFD) (DEFAULT-EXPAND OSET) (COUNTSUBS-FIRST NIL) (APPLY-MATCH APPLY-MATCH-ALL-FRDPAIRS))
 (mhelp "temporary mode for THM112A"))
