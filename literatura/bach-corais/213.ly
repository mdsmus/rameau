
\version "2.10.33"

\header {
  title = "213 - O wie selig seid ihr doch, ihr Frommen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  a''4 d c bes8 a 
  bes4 a g a8 bes 
  g2 f 
  a8 bes c4 b4. cis8 
  d4 c8 d e4 d8 c 
  b2 a 
  s4 a g e 
  f2 e 
  d4 e f g 
  a b cis d 
  d cis d2 
}


alto = \relative c {
  f'4 g g f4. e8 f4. e8 f4 
  f e c2 
  f4 g8 a g4 g 
  a8 b a4 a a 
  a gis e2 
  s4 cis d e 
  e d cis2 
  d4 a d c 
  c f e d8 e 
  f e16 d e4 fis2 
}


tenor = \relative c {
  d'4 d e d 
  d8 bes c4 c c 
  d8 bes g c a2 
  c8 d e d d4 e 
  d8 b e4 e f 
  b,8 e4 d8 cis2 
  s4 e, d a' 
  a2 a 
  a4 a a8 bes a g 
  f a g f g4 a8 bes 
  a4 a a2 
}


baixo = \relative c {
  d4 c8 bes a4 d 
  g, a8 bes c4 f 
  bes, c f,2 
  f'4 e8 fis g f e4 
  fis8 gis a4 c, d 
  e e, a2 
  s4 a b cis 
  d d, a'2 
  f'4 cis d e 
  f e8 d e4 f8 g 
  a4 a, d2 
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