(defmode MODE-THM104-B
 (FLAG-SETTINGS (USE-SYMSIMP T) (USE-RULEP T) (USE-FAST-PROP-SEARCH T) (UNIFY-VERBOSE SILENT) (UNI-SEARCH-HEURISTIC BREADTH-FIRST) (TRUTHVALUES-HACK NIL) (SUBSUMPTION-CHECK NIL) (STOP-AT-TSN T) (SKOLEM-DEFAULT SK1) (SHOW-TIME T) (SEARCH-TIME-LIMIT 2) (SEARCH-COMPLETE-PATHS NIL) (RULEP-WFFEQ WFFEQ-AB) (RIGID-PATH-CK T) (REWRITE-EQUALITIES ALL) (REWRITE-DEFNS (EAGER)) (REMOVE-LEIBNIZ T) (REDUCE-DOUBLE-NEG T) (RECORDFLAGS (LAST-MODE-NAME DEFAULT-MS SHORT-SITE-NAME MACHINE-TYPE LISP-IMPLEMENTATION-TYPE MAX-SEARCH-LIMIT SEARCH-TIME-LIMIT MAX-UTREE-DEPTH MAX-SEARCH-DEPTH MIN-QUICK-DEPTH INITIAL-BKTRACK-LIMIT NUM-FRPAIRS FIRST-ORDER-MODE-MS NUM-OF-DUPS MAX-MATES ORDER-COMPONENTS REWRITE-DEFNS REWRITE-EQUALITIES REMOVE-LEIBNIZ PRIM-QUANTIFIER PRIM-BDTYPES NEG-PRIM-SUB OCCURS-CHECK RANK-EPROOF-FN SKOLEM-DEFAULT MIN-QUANTIFIER-SCOPE)) (RANK-EPROOF-FN NUM-VPATHS-RANKING) (QUERY-USER NIL) (PROP-STRATEGY ALLOW-DUPLICATES) (PRINTMATEOPS (LAMBDA (EDOP) (DECLARE (IGNORE EDOP)) T)) (PRINTMATEFLAG-SLIDES NIL) (PRINTMATEFLAG NIL) (PRINTMATEFILE "mate.mss") (PRINT-MATING-COUNTER 300000) (PRIM-QUANTIFIER T) (PRIM-PREFIX PRIM) (PRIM-BDTYPES-AUTO REPLACE) (PRIM-BDTYPES ("A")) (ORDER-COMPONENTS T) (OCCURS-CHECK T) (NUM-OF-DUPS 1) (NUM-FRPAIRS 5) (NEW-MATING-AFTER-DUP NIL) (NEG-PRIM-SUB NIL) (MS90-3-DUP-STRATEGY 1) (MS-SPLIT T) (MS-INIT-PATH NIL) (MS-DIR QUASI-TPS1) (MONITORFLAG NIL) (MIN-QUICK-DEPTH 3) (MIN-QUANTIFIER-SCOPE NIL) (MIN-QUANT-ETREE T) (MIN-PRIM-DEPTH 1) (MAX-UTREE-DEPTH 20) (MAX-SEARCH-LIMIT 2) (MAX-SEARCH-DEPTH 10) (MAX-PRIM-DEPTH 1) (MAX-MATES 2) (MAX-DUP-PATHS INFINITY) (MATING-VERBOSE SILENT) (MATE-FFPAIR NIL) (LAST-MODE-NAME "Mode : MODE-THM104-B, but with LAMBDA-CONV set to BETA-ETA-SEPARATE") (LAMBDA-CONV BETA-ETA-SEPARATE) (INTERRUPT-ENABLE T) (INITIAL-BKTRACK-LIMIT 3) (IMITATION-FIRST T) (FIRST-ORDER-MODE-MS NIL) (EXCLUDING-GC-TIME T) (ETREE-NAT-VERBOSE NIL) (ETA-RULE T) (DUPLICATION-STRATEGY-PFD DUP-INNER) (DUPLICATION-STRATEGY DUP-OUTER) (DUP-ALLOWED T) (DEFAULT-MS MS90-9) (COUNTSUBS-FIRST NIL) (APPLY-MATCH APPLY-MATCH-ALL-FRDPAIRS))
 (mhelp "new mode for thm104"))
