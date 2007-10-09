
\version "2.10.33"

\header {
  title = "133 - Wir glauben all an einen Gott, Schöpfer Himmels und der Erden"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  d'2 a'4 g 
  a e f2 
  e g 
  f4 e d cis 
  d2 a'4 a 
  d c b a8 b 
  c4 b a2 
  s4 b c a 
  a e f f 
  e2 d4 e 
  f g a g 
  f e d2 
  d'4 d e d 
  e cis d2 
  d e4 b 
  c a a e 
  f2 e 
  a4 gis a b 
  c b a gis 
  a2 b4 cis 
  d2 a4 g 
  a e f2 
  e g 
  f4 e d cis 
  d8 e f4 e2 
  d f4 g 
  a b c b 
  a2 s4 g 
  f e d2 
  e f4 g 
  f g d cis 
  d1 
}


alto = \relative c {
  r4 a' d8 f4 e16 d 
  e4. d16 cis d2. cis4 r4 d8 e4 d cis8 d16 c ais8 a4 
  a2 f'8 e d4. e16 f e4 e4. d8 
  e f4 e16 d c2 
  r4 e8 f g e c d 
  e d e cis a b16 c d4. cis16 b cis4 d4. cis8 
  a ais16 c d8 c c cis d e4 d cis8 a2 
  b8 c d b c4 d8 g 
  g a ais g a fis g4. fis16 e fis4 e8 fis gis e 
  a4 cis, d4. cis8 
  d4. cis16 b cis2 
  e e4 f4. fis8 g gis a a, b d4 c16 b c4 g'8 f e g4 f16 e f4 
  f4. e4 d cis8 d2 
  e e4 a, 
  d8 c ais c a ais g e' 
  d cis d2 cis4 
  a2 d4 c2 f8 d e f g e 
  f2 r4 f8 e4 d cis8 d2 
  cis8 d e4. d8 cis e 
  a, ais4 a b8 a4 
  a1 
}


tenor = \relative c {
  r4 f8 g a4 d8 g,4 f16 e a4 a2 
  a r4 d,8 a' 
  a4 ais8 a16 g f8 g16 f e f g4 f16 e f4 d' a4. gis8 a4 gis8 
  c4 b16 a 
  gis8 a4 gis8 a2 
  r4 g8 f e g a4 
  a4. g8 f8. g16 a4 
  a2 f8 g16 a ais8 a16 g 
  f4. e8 f e d ais' 
  cis, a' ais a16 g f2 
  g g8 a b g 
  c a e'4 d8 c4 ais8 
  a2 a4 e'8 d 
  c d e4 a,2 
  a4. gis8 a2 
  a8 b c d c b a gis 
  a4 e'4. d8 e4 
  e2 g,4 a 
  a2 d4. c16 ais 
  a8*5 g8 a b 
  c2 cis8 d e4 
  a, g8 a fis g a4. g8 a4 ais a8 g4 f16 e f4 ais8 a g c 
  a4 d8 b g4. c8 
  c2 r4 d8 a 
  a ais4 a16 g f2 
  a a8 ais4 a16 g 
  a8 g16 f g8 f16 e f4 e16 f g4 fis16 e fis2. 
}


baixo = \relative c {
  r4 d8 e f d ais'4 
  cis,4. b16 a d8 e f d 
  a2 r4 b8 cis 
  d f, g a ais g a4 
  d,2 d'8 e f d 
  b4 c8 d e c f4 
  e8 d e4 a,2 
  r4 e'8 d c e f4 
  cis8 b cis a d a f d 
  a'2 ais8 a g a 
  d c ais c f, g16 a ais8 a16 g 
  a8 f g a d,2 
  g8 a b g c4 g'8 b 
  e, f g e fis d g4 
  d2 c8 d e4. f8 g e f g a g 
  f e d4 a2 
  c8 d e b c4 d4. dis8 e c f4 e 
  a,2 e'4 a, 
  d2 d8 c ais c 
  f, g a4 d,8 e f d 
  a'2 e'8 d cis e 
  d4. c8 c ais a g 
  f e d f g e a4 
  d,2 d'4 e 
  f8 e d g e d e c 
  f2 r4 b,8 cis 
  d ais g a ais2 
  a8 b cis a d4 e4. d4 cis8 d gis, a4 
  d,1 
}


\score {
  <<
    \new Staff {
      <<
        \global
        \new Voice = "1" { \voiceOne \soprano }
        \new Voice = "2" { \voiceTwo \alto }
      >>
    }
    \new Staff {
      <<
        \global
        \clef "bass"
        \new Voice = "1" {\voiceOne \tenor }
        \new Voice = "2" { \voiceTwo \baixo \bar "|."}
      >>
    }
  >>
}