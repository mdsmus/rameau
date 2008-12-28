\header { 
  title = "Sinfonia K.97, III" 	
  composer = "Mozart" 
  piece = "Trio" 
}

\new ChoirStaff <<
\new Staff \relative c'{\time 3/4 \key g \major  
\repeat volta 2 {
b'-. a-. b-. 
c2( a4)
b4-. a-. b-.
c2( a4)
d-. c-. d-.
e2( c4)
b d8 c b a
g2 r4 } \repeat volta 2 {
g'-. fis-. e-.
a( g fis )
g-. fis-. e-.
a(g fis)
c?-. c-. c-.
b ( d g )
e d8 c b a
g2 r4 }

}

\new Staff \relative c''{\time 3/4 \key g \major  
\repeat volta 2 {
g8 d fis d g d
a' d, a' d, fis d
g d fis d g d
a' d, a' d, fis d
b' d, a' d, b' d,
c' d, c' d, a' d,
g d b' a g fis
g d c b a g } \repeat volta 2 {
b' d a d g, d'
fis, d' e, cis' d, d'
b d a d g, d'
fis, d' e, cis' d, d'
fis, d' e, d' d, d'
d, d' b d g, d'
e, c' b a g fis
g2 r4
}

}

\new Staff \relative c'{\time 3/4 \key g \major  \clef alto
\repeat volta 2 {
b4-. a4-. b4-.
c2( a4)
b4-. a4-. b4-.
c2( a4)
d4-. c4-. d4-.
e2( c4)
b4 d8 c b a
g4 r r } \repeat volta 2 {
r2.
a'4( g fis)
r2.
a4( g fis)
c!4-. c4-. c4-.
b4( e g)
r4 d d
d2 r4
}
}

\new Staff \relative c'{\time 3/4 \key g \major  \clef bass
\repeat volta 2 {
g4 r r
r d' d,
g4 r r
r d' d,
g4 r r
r fis fis
g4 d' d,
g4 r r } \repeat volta 2 {
r2.
d4( e fis)
r2.
d4( e fis)
d4-. e-. fis-.
g r b, c d d 
g,2 r4
}
}

>>
