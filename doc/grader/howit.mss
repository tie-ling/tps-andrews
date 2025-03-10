@ChapBTPS(How it works)@label(howit)

@Section(The Record)
@GRADER creates and maintains, for each course, a record analogous 
to an instructor's grade 
book, and processes and displays the recorded information. This record
is kept in the file whose name is the value of the variable @GrVar(grade-file).

@Begin(Hand)
@GrComI(CREATE-GRADEFILE) creates the grade-file, which includes the following:
@End(Hand)

@begin(itemize)
The names of exercises 

The type of each exercise. The pre-defined types are @t{ET} for
scores generated by a teaching program and @t{LE} for letter grades.
The user may define additional types such as @t(HW) for homework, and 
@T(TEST) for tests.

The weights assigned to each exercise when totals are computed.
The default weight for each exercise is 1. The user can change it to any
desired number by invoking the command @GrCom(CHANGE-WEIGHT).

The maximum possible score, labelled @t{--MAX--}, for each exercise

The scores achieved by each student

Record of assignments submitted late

Penalty functions and due-dates

Actual names of exercises with aliases
@end(itemize)

Several commands, described in Chapter @ref(keepbook), let the user modify
this record. One of these is the command @GrCom(ETPS-GRADE), which reads 
files containing records of work done by students using an educational
computer program and updates grades accordingly. 
Each time one of these commands is completed, the file whose name is the 
value of @GrVar(grade-file) is given the name which is the value of 
@GrVarI(old-grade-file). The new version is then saved in @GrVar(grade-file).

The new version of the grade file not only incorporates changes from the
commands in Chapter @ref(keepbook), but also re-computes for each altered 
exercise the statistical measures listed in @GrVar(statistical-options).
See Section @ref(stats) for details.

Totals for the current record are computed by @GrCom(CALCULATE-GRADE).
By the same procedure as described above for @GrVar(grade-file) and
@GrVar(old-grade-file), the old totals go to @GrVar(old-totals-grade-file),
while the new totals are put in @GrVar(totals-grade-file).
