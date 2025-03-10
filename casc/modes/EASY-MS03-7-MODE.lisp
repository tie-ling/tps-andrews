(defmode EASY-MS03-7-MODE
  (flag-settings
   (ADD-TRUTH IF-NEEDED)
   (ALLOW-NONLEAF-CONNS NIL)
   (APPLY-MATCH APPLY-MATCH-ALL-FRDPAIRS)
   (BAD-VAR-CONNECTED-PRUNE T)
   (COUNTSUBS-FIRST NIL)
   (DEFAULT-EXPAND MS03-7)
   (DEFAULT-MATE MS03-7)
   (DEFAULT-MS MS03-7)
   (DELAY-SETVARS NIL)
   (DISSOLVE NIL)
   (DNEG-IMITATION CONST-FLEX)
   (DUP-ALLOWED T)
   (DUPLICATION-STRATEGY DUP-OUTER)
   (DUPLICATION-STRATEGY-PFD DUP-INNER)
   (ETA-RULE T)
   (EXCLUDING-GC-TIME NIL)
   (EXT-SEARCH-LIMIT INFINITY)
   (FIRST-ORDER-MODE-MS NIL)
   (IMITATION-FIRST T)
   (INCLUDE-COINDUCTION-PRINCIPLE T)
   (INCLUDE-INDUCTION-PRINCIPLE T)
   (INITIAL-BKTRACK-LIMIT INFINITY)
   (INTERRUPT-ENABLE T)
   (LAST-MODE-NAME ", and SOURCE-PATH set to (/home/theorem/tps/bin/ /home/theorem/tps/lisp/ /home/theorem/tps/proofs/complete/ /home/theorem/tps/proofs/complete/cleaned /home/theorem/tps/proofs/incomplete/ /home/theorem/tps/cebrown/ /home/theorem/tps/cebrown/domain/), and RIGHTMARGIN set to 130, and PSEQ-USE-LABELS set to NIL, and DEFAULT-MS set to MS03-7, and QUERY-USER set to T, and MS03-VERBOSE set to T, and USE-RULEP set to NIL, and QUERY-USER set to NIL, and MS03-VERBOSE set to NIL, and USE-RULEP set to T")
   (LEIBNIZ-SUB-CHECK NIL)
   (MATE-FFPAIR NIL)
   (MATE-UP-TO-NNF T)
   (MATING-VERBOSE MED)
   (MAX-CONSTRAINT-SIZE 3)
   (MAX-DUP-PATHS INFINITY)
   (MAX-MATES 2)
   (MAX-NUM-CONSTRAINTS 2)
   (MAX-PRIM-DEPTH 1)
   (MAX-PRIM-LITS 4)
   (MAX-SEARCH-DEPTH 20)
   (MAX-SEARCH-LIMIT NIL)
   (MAX-SUBSTS-PROJ NIL)
   (MAX-SUBSTS-PROJ-TOTAL NIL)
   (MAX-SUBSTS-QUICK NIL)
   (MAX-SUBSTS-VAR 2)
   (MAX-UTREE-DEPTH 20)
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
   (MS03-DUP-METHOD 1)
   (MS03-QUICK-EUNIFICATION-LIMIT 50)
   (MS03-SOLVE-RIGID-PARTS T)
   (MS03-USE-JFORMS T)
   (MS03-USE-SET-CONSTRAINTS NIL)
   (MS03-VERBOSE NIL)
   (MS03-WEIGHT-BANNED-SELS 300)
   (MS03-WEIGHT-CHANGE-DUPS 100)
   (MS03-WEIGHT-DISJ-EUNIF 10)
   (MS03-WEIGHT-DISJ-MATE 10)
   (MS03-WEIGHT-DISJ-UNIF 10)
   (MS03-WEIGHT-DUP-VAR 300)
   (MS03-WEIGHT-EUNIF1 1)
   (MS03-WEIGHT-EUNIF2 1)
   (MS03-WEIGHT-FLEXFLEXDIFF 3)
   (MS03-WEIGHT-FLEXFLEXDIFF-O 10)
   (MS03-WEIGHT-FLEXFLEXSAME 5)
   (MS03-WEIGHT-FLEXFLEXSAME-O 20)
   (MS03-WEIGHT-FLEXRIGID-BRANCH 6)
   (MS03-WEIGHT-FLEXRIGID-EQN 100)
   (MS03-WEIGHT-FLEXRIGID-FLEXEQN 100)
   (MS03-WEIGHT-FLEXRIGID-MATE 1)
   (MS03-WEIGHT-FLEXRIGID-NOEQN 500)
   (MS03-WEIGHT-FLEXRIGID-O 20)
   (MS03-WEIGHT-IMITATE 1)
   (MS03-WEIGHT-OCCURS-CHECK 150)
   (MS03-WEIGHT-PRIMSUB-FALSEHOOD 50)
   (MS03-WEIGHT-PRIMSUB-FIRST-AND 200)
   (MS03-WEIGHT-PRIMSUB-FIRST-EQUALS 200)
   (MS03-WEIGHT-PRIMSUB-FIRST-EXISTS 200)
   (MS03-WEIGHT-PRIMSUB-FIRST-FORALL 200)
   (MS03-WEIGHT-PRIMSUB-FIRST-NOT-EQUALS 200)
   (MS03-WEIGHT-PRIMSUB-FIRST-OR 200)
   (MS03-WEIGHT-PRIMSUB-FIRST-PROJ 500)
   (MS03-WEIGHT-PRIMSUB-NEXT-AND 200)
   (MS03-WEIGHT-PRIMSUB-NEXT-EQUALS 200)
   (MS03-WEIGHT-PRIMSUB-NEXT-EXISTS 200)
   (MS03-WEIGHT-PRIMSUB-NEXT-FORALL 200)
   (MS03-WEIGHT-PRIMSUB-NEXT-NOT-EQUALS 200)
   (MS03-WEIGHT-PRIMSUB-NEXT-OR 200)
   (MS03-WEIGHT-PRIMSUB-NEXT-PROJ 500)
   (MS03-WEIGHT-PRIMSUB-TRUTH 50)
   (MS03-WEIGHT-PROJECT 1)
   (MS03-WEIGHT-RIGID-MATE 1)
   (MS03-WEIGHT-RIGIDRIGID-EQN 50)
   (MS03-WEIGHT-RIGIDRIGID-FLEXEQN 60)
   (MS03-WEIGHT-RIGIDRIGID-NOEQN 500)
   (MS03-WEIGHT-RIGIDRIGIDDIFF-O 40)
   (MS03-WEIGHT-RIGIDRIGIDSAME-O 15)
   (MS90-3-DUP-STRATEGY 1)
   (MS90-3-QUICK NIL)
   (MS91-INTERLEAVE 5)
   (NATREE-DEBUG NIL)
   (NEG-PRIM-SUB NIL)
   (NEW-MATING-AFTER-DUP NIL)
   (NUM-FRPAIRS 5)
   (NUM-OF-DUPS 2)
   (OCCURS-CHECK T)
   (ORDER-COMPONENTS T)
   (PR00-ALLOW-SUBNODE-CONNS T)
   (PR00-MAX-SUBSTS-VAR 4)
   (PR00-NUM-ITERATIONS 1)
   (PR00-REQUIRE-ARG-DEPS NIL)
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
   (RECORDFLAGS (LAST-MODE-NAME DEFAULT-MS MEASUREMENTS SHORT-SITE-NAME MACHINE-TYPE LISP-IMPLEMENTATION-TYPE MAX-SEARCH-LIMIT SEARCH-TIME-LIMIT MAX-UTREE-DEPTH MAX-SEARCH-DEPTH MIN-QUICK-DEPTH INITIAL-BKTRACK-LIMIT NUM-FRPAIRS FIRST-ORDER-MODE-MS NUM-OF-DUPS MAX-MATES ORDER-COMPONENTS REWRITE-DEFNS REWRITE-EQUALITIES REMOVE-LEIBNIZ PRIM-QUANTIFIER PRIM-BDTYPES NEG-PRIM-SUB OCCURS-CHECK RANK-EPROOF-FN SKOLEM-DEFAULT MIN-QUANTIFIER-SCOPE))
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
   (SKOLEM-DEFAULT NIL)
   (STOP-AT-TSN T)
   (SUBSUMPTION-CHECK NIL)
   (SUBSUMPTION-DEPTH INFINITY)
   (SUBSUMPTION-NODES LP-NODES)
   (TIMING-NAMED NIL)
   (TOTAL-NUM-OF-DUPS NIL)
   (TRUTHVALUES-HACK NIL)
   (UNI-SEARCH-HEURISTIC BREADTH-FIRST)
   (UNIF-COUNTER 0)
   (UNIF-COUNTER-OUTPUT 0)
   (UNIF-TRIGGER NIL)
   (UNIFY-VERBOSE MED)
   (USE-DIY NIL)
   (USE-EXT-LEMMAS NIL)
   (USE-FAST-PROP-SEARCH T)
   (USE-RULEP T)
   (USE-SYMSIMP T)
   (WHICH-CONSTRAINTS (MAX MIN))) 
  (mhelp "DEFAULT-MS MS03-7 (extensional saturation search) with default values."))
