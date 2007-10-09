
\version "2.10.33"

\header {
  title = "96 - Jesu, meine Freude"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  a''4 a g f 
  e2 d 
  a'4 a b cis 
  d2 cis 
  d8 e f4 e e 
  d1 
  a4 a g f 
  e2 d 
  a'4 a b cis 
  d2 cis 
  d8 e f4 e e 
  d1 
  a4 a bes a 
  g8 a16 bes g4 f2 
  a4 b c a 
  d c8 b b2 
  a a4 d 
  g, f8 e e2 
  d1 
}


alto = \relative c {
  f'4 f e d 
  d cis a2 
  f'4 f f8 d g4 
  a g a2 
  a4 a bes a8 g 
  f1 
  f4 f e d 
  d cis a2 
  f'4 f f8 d g4 
  a g a2 
  a4 a bes a8 g 
  f1 
  f8 g a4 a8 g f4 
  f e c2 
  f4 f g e 
  a8 e e f e f e d 
  cis2 d4 d 
  d8 cis d4 d8 cis16 b cis4 
  a1 
}


tenor = \relative c {
  d'4 d d8 cis d4 
  a8 bes a g f2 
  d'4 d d8 b e4 
  d8 e16 f e8 d e2 
  a,4 d d cis 
  a1 
  d4 d d8 cis d4 
  a8 bes a g f2 
  d'4 d d8 b e4 
  d8 e16 f e8 d e2 
  a,4 d d cis 
  a1 
  d4 d d c 
  c8 a bes g a2 
  c4 d e cis 
  a8 b c a a4 gis 
  a2 f8 g a f 
  g4 a8 bes a e a g 
  fis1 
}


baixo = \relative c {
  d8 e f d bes'4 a8 g 
  a4 a, d2 
  d8 e f d g4 f8 e 
  f g16 a bes4 a2 
  f8 e d f g e a4 
  d,1 
  d8 e f d bes'4 a8 g 
  a4 a, d2 
  d8 e f d g4 f8 e 
  f g16 a bes4 a2 
  f8 e d f g e a4 
  d,1 
  d8 e f d g4 a8 bes 
  c4 c, f2 
  f8 e d f e f g e 
  fis gis a d, e4 e, 
  a2 d8 e f d 
  bes'4 a8 g a4 a, 
  d1 
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