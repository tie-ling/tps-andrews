(defmode MODE-THM112A-TRY5
 (FLAG-SETTINGS (WEIGHT-C-FN OPTION-SET-NUM-LEAVES) (WEIGHT-C-COEFFICIENT 1) (WEIGHT-B-FN SIMPLE-WEIGHT-B-FN) (WEIGHT-B-COEFFICIENT 1) (WEIGHT-A-FN EXPANSION-LEVEL-WEIGHT-A) (WEIGHT-A-COEFFICIENT 1) (USE-SYMSIMP T) (USE-RULEP T) (USE-FAST-PROP-SEARCH T) (USE-DIY NIL) (UNIFY-VERBOSE SILENT) (UNIF-TRIGGER NIL) (UNIF-COUNTER-OUTPUT 0) (UNIF-COUNTER 0) (UNI-SEARCH-HEURISTIC BREADTH-FIRST) (TRUTHVALUES-HACK NIL) (TOTAL-NUM-OF-DUPS NIL) (TIMING-NAMED T) (SUBSUMPTION-NODES LP-NODES) (SUBSUMPTION-DEPTH INFINITY) (SUBSUMPTION-CHECK NIL) (STOP-AT-TSN T) (SKOLEM-DEFAULT SK1) (SHOW-TIME T) (SEARCH-TIME-LIMIT 30) (SEARCH-COMPLETE-PATHS NIL) (RULEP-WFFEQ WFFEQ-AB) (RIGID-PATH-CK NIL) (REWRITE-EQUIVS 1) (REWRITE-EQUALITIES ALL) (REWRITE-DEFNS (EAGER)) (REMOVE-LEIBNIZ T) (REDUCE-DOUBLE-NEG T) (RECORDFLAGS (LAST-MODE-NAME DEFAULT-MS SHORT-SITE-NAME MACHINE-TYPE LISP-IMPLEMENTATION-TYPE MAX-SEARCH-LIMIT SEARCH-TIME-LIMIT MAX-UTREE-DEPTH MAX-SEARCH-DEPTH MIN-QUICK-DEPTH INITIAL-BKTRACK-LIMIT NUM-FRPAIRS FIRST-ORDER-MODE-MS NUM-OF-DUPS MAX-MATES ORDER-COMPONENTS REWRITE-DEFNS REWRITE-EQUALITIES REMOVE-LEIBNIZ PRIM-QUANTIFIER PRIM-BDTYPES NEG-PRIM-SUB OCCURS-CHECK RANK-EPROOF-FN SKOLEM-DEFAULT MIN-QUANTIFIER-SCOPE)) (RECONSIDER-FN INF-WEIGHT) (RANK-EPROOF-FN NUM-VPATHS-RANKING) (QUERY-USER NIL) (PRUNING NIL) (PROP-STRATEGY ALLOW-DUPLICATES) (PRINTMATEOPS ALWAYS-TRUE) (PRINTMATEFLAG-SLIDES NIL) (PRINTMATEFLAG NIL) (PRINTMATEFILE "mate.mss") (PRINT-MATING-COUNTER 300000) (PRIMSUB-VAR-SELECT T) (PRIMSUB-METHOD PR93) (PRIM-QUANTIFIER T) (PRIM-PREFIX PRIM) (PRIM-BDTYPES-AUTO REPLACE) (PRIM-BDTYPES ("I")) (PR97C-PRENEX T) (PR97C-MAX-ABBREVS 1) (PENALTY-FOR-ORDINARY-DUP INFINITY) (PENALTY-FOR-MULTIPLE-SUBS 20) (PENALTY-FOR-MULTIPLE-PRIMSUBS 100) (PENALTY-FOR-EACH-PRIMSUB 1) (ORDER-COMPONENTS PREFER-RIGID1) (OPTIONS-VERBOSE NIL) (OPTIONS-GENERATE-UPDATE IDENT-ARG) (OPTIONS-GENERATE-FN ADD-OPTIONS-ORIGINAL) (OPTIONS-GENERATE-ARG 75) (OCCURS-CHECK T) (NUM-OF-DUPS 2) (NUM-FRPAIRS 5) (NEW-OPTION-SET-LIMIT 5) (NEW-MATING-AFTER-DUP NIL) (NEG-PRIM-SUB NIL) (MS91-WEIGHT-LIMIT-RANGE 1) (MS91-TIME-BY-VPATHS NIL) (MS91-PREFER-SMALLER T) (MS91-INTERLEAVE 5) (MS90-3-QUICK NIL) (MS90-3-DUP-STRATEGY 1) (MS-SPLIT T) (MS-INIT-PATH NIL) (MS-DIR QUASI-TPS1) (MONITORFLAG NIL) (MIN-QUICK-DEPTH 12) (MIN-QUANTIFIER-SCOPE NIL) (MIN-QUANT-ETREE T) (MIN-PRIM-LITS 2) (MIN-PRIM-DEPTH 2) (MERGE-MINIMIZE-MATING T) (MAX-UTREE-DEPTH 12) (MAX-SUBSTS-VAR NIL) (MAX-SUBSTS-QUICK NIL) (MAX-SUBSTS-PROJ-TOTAL NIL) (MAX-SUBSTS-PROJ NIL) (MAX-SEARCH-LIMIT NIL) (MAX-SEARCH-DEPTH 12) (MAX-PRIM-LITS 4) (MAX-PRIM-DEPTH 2) (MAX-MATES 3) (MAX-DUP-PATHS INFINITY) (MATING-VERBOSE SILENT) (MATE-FFPAIR NIL) (LEIBNIZ-SUB-CHECK NIL) (LAST-MODE-NAME "Mode : MODE-THM112A-TRY5, but with UNIFY-VERBOSE set to SILENT, and MATING-VERBOSE set to SILENT, and ETREE-NAT-VERBOSE set to NIL, and TACTIC-VERBOSE set to MIN, and OPTIONS-VERBOSE set to NIL") (INTERRUPT-ENABLE T) (INITIAL-BKTRACK-LIMIT INFINITY) (IMITATION-FIRST T) (FIRST-ORDER-MODE-MS NIL) (EXCLUDING-GC-TIME T) (ETA-RULE T) (DUPLICATION-STRATEGY-PFD DUP-INNER) (DUPLICATION-STRATEGY DUP-OUTER) (DUP-ALLOWED T) (DNEG-IMITATION CONST-FLEX) (DEFAULT-MS MS91-7) (DEFAULT-MATE PFD) (DEFAULT-EXPAND OSET) (COUNTSUBS-FIRST NIL) (APPLY-MATCH APPLY-MATCH-ALL-FRDPAIRS) (ADD-TRUTH IF-NEEDED))
 (mhelp "Exactly like the TRY4 version, but with max-mates 3 because of the changes to ms90-3."))
