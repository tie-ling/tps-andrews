@Appendix(Theorems and Exercises)@Label(theorem)

@begin(Comment)
old form when this was a chapter, not an appendix
@ChapterPh(Theorems)@Label(theorem)
@end(Comment)

@Section(Book Theorems)
Substitution instances of the theorems below can be inserted into a proof
by using the @T(ASSERT) command.

@Begin(Description, spread .3)
DESCR@ @ @ @ @ (Axiom of description at all types.)@\ @t{@g{i}@; [= Y@F12{oa}] = Y}

EXT@ @ @ @ @ (Axiom of extensionality at all types.)@\ @t{@forall@;x@F12{b} [f@F12{ab} x = g@F12{ab} x] @implies@; f = g}

REFL=@ @ @ @ @ (Reflexivity of Equality.)@\ @t{A@F12{a} = A}

SYM=@ @ @ @ @ (Symmetry of Equality.)@\ @t{A@F12{a} = B@F12{a} @implies@; B = A}

T5302@ @ @ @ @ (Symmetry of Equality.)@\ @t{x@F12{a} = y@F12{a} =.y = x}


T5310@ @ @ @ @ (Theorem about descriptions.)@\ @t{@forall@;z@F12{a} [p@F12{oa} z @equiv@; y@F12{a} = z] @implies@; @g{i}@; p = y}


T5310A@ @ @ @ @ (Theorem about descriptions.)@\ @t{@forall@;z@F12{a} [p@F12{oa} z @equiv@; z = y@F12{a}] @implies@; @g{i}@; p = y}
@End(Description)


@Section(First-Order Logic)

@Begin(Description, spread .3)
X2106@\ @t{@forall@;x [R x @implies@; P x] @and@; @forall@;x [@not@; Q x @implies@; R x] @implies@; @forall@;x.P x @or@; Q x}

X2107@\ @t{R a b @and@; @forall@;x @forall@;y [R x y @implies@; R y x @and@; Q x y] @and@; @forall@;u @forall@;v [Q u v @implies@; Q u u] @implies@; Q a a @and@; Q b b}

X2108@\ @t{@forall@;x @exists@;y.P x @implies@; P y}

X2109@\ @t{@exists@;x [p @and@; Q x] @equiv@; p @and@; @exists@;x Q x}

X2110@\ @t{@exists@;x R x @and@; @forall@;y [R y @implies@; @exists@;z Q y z] @and@; @forall@;x @forall@;y [Q x y @implies@; Q x x] @implies@; @exists@;x @exists@;y.Q x y @and@; R y}

X2111@\ @t{@forall@;x [@exists@;y P x y @implies@; @forall@;y Q x y] @and@; @forall@;z @exists@;y P z y @implies@; @forall@;y @forall@;x Q x y}

X2112@\ @t{@exists@;v @forall@;x P x v @and@; @forall@;x [S x @implies@; @exists@;y Q y x] @and@; @forall@;x @forall@;y [P x y @implies@; @not@; Q x y] @implies@; @exists@;u.@not@; S u}

X2113@\ @t{@forall@;y @exists@;w R y w @and@; @exists@;z @forall@;x [P x @implies@; @not@; R z x] @implies@; @exists@;x.@not@; P x}

X2114@\ @t{@forall@;x R x b @and@; @forall@;y [@exists@;z R y z @implies@; R a y] @implies@; @exists@;u @forall@;v R u v}

X2115@\ @t{@forall@;x [@exists@;y P x y @implies@; @forall@;z P z z] @and@; @forall@;u @exists@;v [P u v @or@; M u @and@; Q.f u v] @and@; @forall@;w [Q w @implies@; @not@; M.g w] @implies@; @forall@;u @exists@;v.P [g u] v @and@; P u u}

X2116@\ @t{@forall@;x @exists@;y [P x @implies@; R x [g.h y] @and@; P y] @and@; @forall@;w [P w @implies@; P [g w] @and@; P.h w] @implies@; @forall@;x.P x @implies@; @exists@;y.R x y @and@; P y}

X2117@\ @t{@forall@;u @forall@;v [R u u @equiv@; R u v] @and@; @forall@;w @forall@;z [R w w @equiv@; R z w] @implies@;.@exists@;x R x x @implies@; @forall@;y R y y}

X2118@\ @t{@forall@;x [p @and@; Q x @or@; @not@; p @and@; R x] @implies@; @forall@;x Q x @or@; @forall@;x R x}

X2119@\ @t{@exists@;y @forall@;x.P y @implies@; P x}

X2120@\ @t{@forall@;u @forall@;v @forall@;w [P u v @or@; P v w] @implies@; @exists@;x @forall@;y P x y}

X2121@\ @t{@exists@;v @forall@;y @exists@;z.P a y [h y] @or@; P v y [f y] @implies@; P v y z}

X2122@\ @t{@exists@;x R x x @implies@; @forall@;y R y y @implies@; @exists@;u @forall@;v.R u u @implies@; R v v}

X2123@\ @t{@exists@;y [P y @implies@; Q x] @implies@; @exists@;y.P y @implies@; Q y}

X2124@\ @t{@exists@;x [P x @implies@; Q x] @equiv@; @forall@;x P x @implies@; @exists@;x Q x}

X2125@\ @t{@exists@;x @forall@;y [P x @equiv@; P y] @equiv@;.@exists@;x P x @equiv@; @forall@;y P y}

X2126@\ @t{@forall@;x [P x @equiv@; @exists@;y P y] @equiv@;.@forall@;x P x @equiv@; @exists@;y P y}

X2127@\ @t{@exists@;x @forall@;y [P y @equiv@; P x] @implies@; @forall@;x P x @or@; @forall@;x.@not@; P x}

X2128@\ @t{@forall@;x [P x @equiv@; @forall@;y P y] @equiv@;.@exists@;x P x @equiv@; @forall@;y P y}

X2129@\ @t{@exists@;x @forall@;y [P x @equiv@; P y] @equiv@; [@exists@;x Q x @equiv@; @forall@;y P y] @equiv@;.@exists@;x @forall@;y [Q x @equiv@; Q y] @equiv@;.@exists@;x P x @equiv@; @forall@;y Q y}

X2130@\ @t{@forall@;x P x @implies@; @not@; @exists@;y Q y @or@; @exists@;z.P z @implies@; Q z}

X2131@\ @t{@forall@;x P x @implies@; @exists@;y.@forall@;x @forall@;z Q x y z @implies@; @not@; @forall@;z.P z @and@; @not@; Q y y z}

X2132@\ @t{@forall@;w [@not@; R w w] @implies@; @exists@;x @exists@;y.@not@; R x y @and@;.Q y x @implies@; @forall@;z Q z z}

X2133@\ @t{@forall@;x [@exists@;y Q x y @implies@; P x] @and@; @forall@;v @exists@;u Q u v @and@; @forall@;w @forall@;z [Q w z @implies@; Q z w @or@; Q z z] @implies@; @forall@;z P z}

X2134@\ @t{@forall@;z @exists@;x [@forall@;y P x y @or@; Q x z] @implies@; @forall@;y @exists@;x.P x y @or@; Q x y}

X2135@\ @t{@exists@;x @forall@;y.P x @and@; Q y @implies@; Q x @or@; P y}

X2136@\ @t{@exists@;x @exists@;y @forall@;u.P x y z @implies@; P u x x}

X2137@\ @t{@exists@;x @forall@;y.P x @implies@; Q x @or@; P y}

X2138@\ @t{@forall@;x @exists@;y F x y @and@; @exists@;x @forall@;e @exists@;n @forall@;w [S n w @implies@; D w x e] @and@; @forall@;e @exists@;d @forall@;a @forall@;b [D a b d @implies@; @forall@;y @forall@;z.F a y @and@; F b z @implies@; D y z e] @implies@; @exists@;y @forall@;e @exists@;m @forall@;w.S m w @implies@; @forall@;z.F w z @implies@; D z y e}@End(Description)

@Section(Higher-Order Logic)

@Begin(Description, spread .3)
X5200@\ @t{x@F12{oa} @union@; y@F12{oa} = @setunion@;.@g{l}@;v@F12{oa}.v = x @or@; v = y}

X5201@\ @t{x@F12{oa} @intersect@; y@F12{oa} = @setintersect@;.@g{l}@;v@F12{oa}.v = x @or@; v = y}

X5202@\ @t{% f@F12{ab} [x@F12{ob} @union@; y@F12{ob}] = % f x @union@; % f y}

X5203@\ @t{% f@F12{ab} [x@F12{ob} @intersect@; y@F12{ob}] @subset@; % f x @intersect@; % f y}

X5204@\ @t{% f@F12{ab} [@setunion@; w@F12{o(ob)}] = @setunion@;.% [% f] w}

X5205@\ @t{% f@F12{ab} [@setintersect@; w@F12{o(ob)}] @subset@; @setintersect@;.% [% f] w}

X5206@\ @t{% f@F12{ab} [x@F12{ob} @union@; y@F12{ob}] = % f x @union@; % f y}

X5207@\ @t{% f@F12{ab} [x@F12{ob} @intersect@; y@F12{ob}] @subset@; % f x @intersect@; % f y}

X5208@\ @t{@exists@;S@F12{oi} @forall@;x@F12{i} [[S x @or@; P@F12{oi} x] @and@;.@not@; S x @or@; Q@F12{oi} x] @equiv@; @forall@;y@F12{i}.P y @or@; Q y}

X5209@\ @t{@powerset@;@F12{o(oa)(oa)} [D@F12{oa} @intersect@; E@F12{oa}] = @powerset@; D @intersect@; @powerset@; E}

X5210@\ @t{[= x@F12{a}] = @g{l}@;z@F12{a} @exists@;y@F12{a}.y = x @and@; z = y}

X5211@\ @t{y@F12{oa} = @setunion@;.@g{l}@;z@F12{oa} @exists@;x@F12{a}.y x @and@; z = [= x]}

X5212@\ @t{@g{l}@;z@F12{a} @exists@;x@F12{b} [g@F12{ob} x @and@; z = f@F12{ab} x] = % f g}

X5304@\ @t{@not@; @exists@;g@F12{oaa} @forall@;f@F12{oa} @exists@;j@F12{a}.g j = f}

X5305@\ @t{@forall@;s@F12{oa}.@not@; @exists@;g@F12{oaa} @forall@;f@F12{oa}.f @subset@; s @implies@; @exists@;j@F12{a}.s j @and@; g j = f}

X5308@\ @t{@exists@;j@F12{b(ob)} @forall@;p@F12{ob} [@exists@;x@F12{b} p x @implies@; p.j p] @implies@;.@forall@;x@F12{a} @exists@;y@F12{b} r@F12{oba} x y @equiv@; @exists@;f@F12{ba} @forall@;x r x.f x}


X5309@\ @t{@not@;@exists@;h@F12{i(oi)} @forall@;p@F12{oi} @forall@;q@F12{oi}.h p = h q @implies@; p = q}


X5310@\ @t{@forall@;r@F12{ob(ob)} [@forall@;x@F12{ob} @exists@;y@F12{b} r x y @implies@; @exists@;f@F12{b(ob)} @forall@;x r x.f x] @implies@; @exists@;j@F12{b(ob)} @forall@;p@F12{ob}.@exists@;z@F12{b} p z @implies@; p.j p}


X5500@\ @t{@forall@;P@F12{ob} [@exists@;x@F12{b} P x @implies@; P.J@F12{b(ob)} P] @implies@; @forall@;f@F12{ab} @forall@;g@F12{ab}.f [J.@g{l}@;x.@not@; f x = g x] = g [J.@g{l}@;x.@not@; f x = g x] @implies@; f = g}

X6004@\ @t{@eqp@;@F12{o(oa)(ob)} [= x@F12{b}].= y@F12{a}}

X6101@\ @t{@one@; = @g{S}@;@+{1}@;@F12{o(oi)}}


X6104@\ @t{@exists@;i@F12{o(aa)(aa)}.@forall@;g@F12{aa} [i g [@g{l}@;x@F12{a} x] @and@; i g.@g{l}@;x g.g x] @and@; @forall@;f@F12{aa} @forall@;y@F12{a}.i [@g{l}@;x y] f @implies@; f y = y}


X6105@ @ @ @ @ (This is a lemma for X6106. 
You may need to ASSERT DESCR or T5310 or T5310A)@\ @t{@forall@;n@F12{o(oi)}.NAT n @implies@; @forall@;q@F12{oi}.n q @implies@; @exists@;j@F12{i(oi)} @forall@;r@F12{oi}.r @subset@; q @and@; @exists@;x@F12{i} r x @implies@; r.j r}


X6106@\ @t{FINITE [@g{l}@;x@F12{i} @truth@;] @implies@; @exists@;j@F12{i(oi)} @forall@;r@F12{oi}.@exists@;x r x @implies@; r.j r}

X6201@\ @t{@exists@;r@F12{oaa} @forall@;x@F12{a} @forall@;y@F12{a} @forall@;z@F12{a} [@exists@;w@F12{a} r x w @and@; @not@; r x x @and@;.r x y @implies@;.r y z @implies@; r x z] @implies@; @exists@;R@F12{o(oa)(oa)} @forall@;X@F12{oa} @forall@;Y@F12{oa} @forall@;Z@F12{oa}.@exists@;W@F12{oa} R X W @and@; @not@; R X X @and@;.R X Y @implies@;.R Y Z @implies@; R X Z}

X8030A@\ @t{[g@F12{oo} @truth@; @and@; g @falsehood@;] = @forall@;x@F12{o} g x}@End(Description)



