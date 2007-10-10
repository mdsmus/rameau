
\version "2.10.33"

\header {
  title = "356 - Jesu, meine Freude"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  a''4 a g f 
  e2 d 
  a'4 b c a 
  d2 cis 
  d8 e f4 e e 
  d1 
  a4 a g f 
  e2 d 
  a'4 b c a 
  d2 cis 
  d8 e f4 e e 
  d1 
  a4 a bes a 
  g g f2 
  a4 b c8 b a4 
  d c8 b b2 
  a a4 a 
  g f e2 
  d1 
}


alto = \relative c {
  d'4 d e d 
  d cis a2 
  d4 g, g'8 f e4 
  a b a2 
  g4 a8 bes g bes a g 
  f1 
  d4 d e d 
  d cis a2 
  d4 g, g'8 f e4 
  a b a2 
  g4 a8 bes g bes a g 
  f1 
  f4 f8 dis d e f4 
  f e c2 
  c4 f e8 d c4 
  f e8 f e4. d8 
  cis2 d4 d8 cis 
  d e e d d cis16 b cis4 
  a1 
}


tenor = \relative c {
  f8 g a4 bes8 a a4 
  bes a8 g f2 
  f'8 e d4 c cis 
  d8 e f4 e2 
  d4 d d cis 
  a1 
  f8 g a4 bes8 a a4 
  bes a8 g f2 
  f'8 e d4 c cis 
  d8 e f4 e2 
  d4 d d cis 
  a1 
  d4 c bes8 c d4 
  d c8 bes a2 
  a4 g8 f g4 a 
  a8 gis a2 gis4 
  a2 f8 g a4 
  d,8 a' a4 b8 e, a g 
  fis1 
}


baixo = \relative c {
  d8 e f4 cis d 
  g, a d,2 
  d'8 e f4 e8 f g4 
  fis8 gis gis4 a2 
  bes4 a8 g a4 a, 
  d1 
  d8 e f4 cis d 
  g, a d,2 
  d'8 e f4 e8 f g4 
  fis8 gis gis4 a2 
  bes4 a8 g a4 a, 
  d1 
  d8 e f4 g d8 c 
  bes g c4 f,2 
  f'4 e8 d e4 f 
  b, c8 d e2 
  a, d8 e f4 
  b,8 cis d4 gis, a 
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