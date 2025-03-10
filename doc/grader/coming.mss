@ChapBTPS(Coming and Going)

@Section(Getting into @hGRADER)

@GRADER is part of @TPS and @ETPS.
Starting @GRADER is similar to starting @TPS or @ETPS
(see section 13.3 of the TPS User's Manual),
but requires the additional command line argument @t(-grader).
For example, to start @GRADER using Allegro Common Lisp 5.0 or greater, you can use the command
@begin(verbatim)
lisp -I tps3.dxl -- -grader &
@end(verbatim)
or
@begin(verbatim)
lisp -I etps.dxl -- -grader &
@end(verbatim)
where tps3.dxl and etps.dxl are the files that were created when @TPS and @ETPS were built. 

However, Grader can be used by someone who knows nothing about @TPS
or @ETPS. At Carnegie Mellon University,
versions of @Grader exist on the Andrew system, and can be started by
connecting to a Unix server or running on an Andrew Linux machine and
entering the command @t(/afs/andrew/mcs/math/etps/bin/grader). 
If you are at a different site, ask your local @ETPS maintainer how
to use @grader.
Before using @GRADER for the first time, you may wish to create the files
mentioned in sections @ref(chg-vars) and @ref(creating).

@Section(@hGRADER Top-Level: HELP)

The commands you issue to @GRADER will be received by a part of the program
called the top-level. The prompt for the top-level is @wt{<Gr@i(n)>}, where
@i(n) is an integer between 0 and 9. 

You may abort any @GRADER command by typing @t[^C],
i. e., typing @t(C) while pressing
the control, @t(CTRL), key. You will return to the @GRADER top-level.
@GrCom(INSERT-GRADES) has its own method of resuming work.
See Section @ref(insertg) for how @GrCom(INSERT-GRADES) operates.

A partially specified command can be completed by pressing the @t(<ESC>)
key, then the @t(<RETURN>) key. 
@comment<This facility is also available for student and
exercise names when they are requested in the program.>

Possible completions of a partially completed command can be gotten
by typing @t(?) before entering. Thus, a complete list of commands
can be generated by typing @t(?).

One other aid is provided:

@Begin(Hand)
@BTPSComI(HELP) @i(command) tells you what @i(command) does and what kind of
arguments it takes.  @BTPSCOMI(HELP) @i(var) tells you about the variable
@i(var) and what its current value is.  If you are not sure
of something, try asking for help on it.
@End(Hand)

@comment<Descriptions of @BTPS commands can be found in Appendix @ref(btps-command).>

@Section(Getting out: GR-EXIT and EXIT)

There are two ways to leave @GRADER:

@Hand[@BTPSComI(GR-EXIT) takes you out of @GRADER.]  This command may
be abbreviated as @grcom(EXIT).



