; Chad: I set max-substs-var to 2 in this mode; it was NIL which never works.
(defmode MS98-FO-MODE
  (flag-settings
   (ADD-TRUTH IF-NEEDED)
   (APPLY-MATCH APPLY-MATCH-ALL-FRDPAIRS)
   (BREAK-AT-QUANTIFIERS T)
   (COUNTSUBS-FIRST NIL)
   (DEFAULT-MS MS98-1)
   (DNEG-IMITATION CONST-FLEX)
   (DUP-ALLOWED T)
   (DUPLICATION-STRATEGY DUP-OUTER)
   (DUPLICATION-STRATEGY-PFD DUP-INNER)
   (ETA-RULE T)
   (ETREE-NAT-VERBOSE NIL)
   (EXCLUDING-GC-TIME T)
   (FF-DELAY NIL)
   (FIRST-ORDER-MODE-MS T)
   (HPATH-THRESHOLD 1)
   (IMITATION-FIRST T)
   (INITIAL-BKTRACK-LIMIT INFINITY)
   (INTERRUPT-ENABLE T)
   (LAST-MODE-NAME ", and DEFAULT-MS set to MS98-1, and MS98-INIT set to 1, and MS98-NUM-OF-DUPS set to 4 (except max-substs-var set to 2)")
   (LEIBNIZ-SUB-CHECK NIL)
   (MATE-FFPAIR NIL)
   (MATING-VERBOSE SILENT)
   (MAX-DUP-PATHS INFINITY)
   (MAX-MATES 2)
   (MAX-PRIM-DEPTH 1)
   (MAX-PRIM-LITS 4)
   (MAX-SEARCH-DEPTH 20)
   (MAX-SEARCH-LIMIT NIL)
   (MAX-SUBSTS-PROJ NIL)
   (MAX-SUBSTS-PROJ-TOTAL NIL)
   (MAX-SUBSTS-QUICK NIL)
   (MAX-SUBSTS-VAR 2)
   (MAX-UTREE-DEPTH 20)
   (MAXIMIZE-FIRST NIL)
   (MERGE-MINIMIZE-MATING T)
   (MIN-PRIM-DEPTH 1)
   (MIN-PRIM-LITS 2)
   (MIN-QUANT-ETREE T)
   (MIN-QUANTIFIER-SCOPE NIL)
   (MIN-QUICK-DEPTH 3)
   (MONITORFLAG NIL)
   (MS-DIR QUASI-TPS1)
   (MS-INIT-PATH NIL)
   (MS-SPLIT T)
   (MS90-3-DUP-STRATEGY 1)
   (MS90-3-QUICK NIL)
   (MS91-INTERLEAVE 5)
   (MS98-BASE-PRIM NIL)
   (MS98-DUP-PRIMSUBS NIL)
   (MS98-FRAGMENT-ORDER 2)
   (MS98-INIT 1)
   (MS98-MAX-PRIMS 1)
   (MS98-MEASURE 0)
   (MS98-NUM-OF-DUPS 4)
   (MS98-REWRITE-DEPTH 2)
   (MS98-REWRITE-MODEL NIL)
   (MS98-REWRITE-PRUNE T)
   (MS98-REWRITE-SIZE NIL)
   (MS98-REWRITE-UNIF NIL)
   (MS98-REWRITES NIL)
   (MS98-UNIF-HACK NIL)
   (MS98-VALID-PAIR 1)
   (MS98-VERBOSE NIL)
   (NEG-PRIM-SUB NIL)
   (NEW-MATING-AFTER-DUP NIL)
   (NUM-FRPAIRS 5)
   (NUM-OF-DUPS 2)
   (OCCURS-CHECK T)
   (ORDER-COMPONENTS T)
   (PR97C-MAX-ABBREVS 1)
   (PR97C-PRENEX T)
   (PRIM-BDTYPES ("I"))
   (PRIM-BDTYPES-AUTO REPLACE)
   (PRIM-PREFIX PRIM)
   (PRIM-QUANTIFIER T)
   (PRIMSUB-METHOD PR93)
   (PRIMSUB-VAR-SELECT T)
   (PRINT-MATING-COUNTER 300000)
   (PRINTMATEFILE "mate.mss")
   (PRINTMATEFLAG NIL)
   (PRINTMATEFLAG-SLIDES NIL)
   (PRINTMATEOPS ALWAYS-TRUE)
   (PROP-STRATEGY ALLOW-DUPLICATES)
   (PRUNING NIL)
   (QUERY-USER NIL)
   (RANK-EPROOF-FN NUM-VPATHS-RANKING)
   (RECORDFLAGS (LAST-MODE-NAME DEFAULT-MS SHORT-SITE-NAME MACHINE-TYPE LISP-IMPLEMENTATION-TYPE MAX-SEARCH-LIMIT SEARCH-TIME-LIMIT MAX-UTREE-DEPTH MAX-SEARCH-DEPTH MIN-QUICK-DEPTH INITIAL-BKTRACK-LIMIT NUM-FRPAIRS FIRST-ORDER-MODE-MS NUM-OF-DUPS MAX-MATES ORDER-COMPONENTS REWRITE-DEFNS REWRITE-EQUALITIES REMOVE-LEIBNIZ PRIM-QUANTIFIER PRIM-BDTYPES NEG-PRIM-SUB OCCURS-CHECK RANK-EPROOF-FN SKOLEM-DEFAULT MIN-QUANTIFIER-SCOPE))
   (REDUCE-DOUBLE-NEG T)
   (REMOVE-LEIBNIZ T)
   (REWRITE-DEFNS (EAGER))
   (REWRITE-EQUALITIES ALL)
   (REWRITE-EQUIVS 1)
   (RIGID-PATH-CK T)
   (RULEP-WFFEQ WFFEQ-AB)
   (SEARCH-COMPLETE-PATHS NIL)
   (SEARCH-TIME-LIMIT 60)
   (SHOW-TIME T)
   (SKOLEM-DEFAULT SK1)
   (STOP-AT-TSN T)
   (SUBSUMPTION-CHECK NIL)
   (SUBSUMPTION-DEPTH INFINITY)
   (SUBSUMPTION-NODES LP-NODES)
   (TEST-THEOREMS ((X2106 MS98-FO-MODE) (X2107 MS98-FO-MODE) (X2109 MS98-FO-MODE) (X2110 MS98-FO-MODE) (X2111 MS98-FO-MODE) (X2113 MS98-FO-MODE) (X2114 MS98-FO-MODE) (X2115 MS98-FO-MODE) (X2116 MS98-FO-MODE) (X2118 MS98-FO-MODE) (X2119 MS98-FO-MODE) (X2121 MS98-FO-MODE) (X2122 MS98-FO-MODE) (X2123 MS98-FO-MODE) (X2124 MS98-FO-MODE) (X2126 MS98-FO-MODE) (X2127 MS98-FO-MODE) (X2128 MS98-FO-MODE) (X2131 MS98-FO-MODE) (X2132 MS98-FO-MODE) (X2134 MS98-FO-MODE) (X2135 MS98-FO-MODE) (X2136 MS98-FO-MODE) (X2137 MS98-FO-MODE) (X2138 MS98-FO-MODE) (X2108 MS98-FO-MODE) (X2112 MS98-FO-MODE) (X2117 MS98-FO-MODE) (X2120 MS98-FO-MODE) (X2125 MS98-FO-MODE) (X2130 MS98-FO-MODE) (X2133 MS98-FO-MODE)))
   (TOTAL-NUM-OF-DUPS NIL)
   (TRUTHVALUES-HACK NIL)
   (UNI-SEARCH-HEURISTIC BREADTH-FIRST)
   (UNIF-COUNTER 0)
   (UNIF-COUNTER-OUTPUT 0)
   (UNIF-TRIGGER NIL)
   (UNIFY-VERBOSE SILENT)
   (USE-DIY NIL)
   (USE-FAST-PROP-SEARCH T)
   (USE-RULEP T)
   (USE-SYMSIMP T)) 
  (mhelp "mode for first-order problems in ms98-1"))
