
\version "2.10.33"

\header {
  title = "39 - Ach, was soll ich Sünder machen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  e'4 e g g 
  a a b b 
  b d c b 
  a4. a8 g2 
  a4 a b g 
  fis4. fis8 e2 
  e'4 e d d 
  cis cis b b 
  d d c b 
  a4. a8 g2 
  a4 a b g 
  fis4. fis8 e2 
}


alto = \relative c {
  b'4 b e e 
  e a8 fis g4 g 
  g g g8 fis g4 
  g fis d2 
  fis4 e dis8 fis b, e16 dis 
  e4 dis b2 
  g'4 g fis fis 
  g fis fis fis 
  fis g g8 a4 g8 
  g4 fis d2 
  e4 fis fis4. e8 
  e4 dis b2 
}


tenor = \relative c {
  g'4 g b b 
  c d d d 
  d d8 b c d d4 
  e8 c a d16 c b2 
  d4 a4. g16 fis g8 c4 a8 fis b16 a g2 
  b4 b b b 
  b4. ais8 d4 d 
  d8 c b4 e8 d4 e c8 a d16 c b2 
  cis4 d8 c b4 b8 c4 a8 fis b16 a gis2 
}


baixo = \relative c {
  e8 fis g fis e d c b 
  a g fis d g4 g' 
  g,8 a b e a, d g, b 
  c a d4 g,2 
  fis'8 e d c b dis e c 
  a fis b4 e,2 
  e8 fis g a b cis d b 
  e cis fis4 b,2 
  b'8 a g fis e fis g e 
  c a d4 g,2 
  g'4 fis8 e dis4 e8 c 
  a fis b4 e,2 
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