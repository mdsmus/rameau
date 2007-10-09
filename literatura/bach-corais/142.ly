
\version "2.10.33"

\header {
  title = "142 - Schwing dich auf zu deinem Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  d''4 a d e 
  f d e2 
  c4 c c bes8 a 
  g2 a 
  d4 a d e 
  f d e2 
  c4 c c bes8 a 
  g2 a 
  f'4 f e e 
  d e cis2 
  a4 bes cis d 
  d cis d2 
  f4 f e e 
  d e cis2 
  a4 bes cis d 
  d cis d2 
}


alto = \relative c {
  a''4 a bes bes 
  a g g2 
  a4 a8 g f4 f8 e 
  d cis d4 cis2 
  a'4 a g8 f e4 
  a8 g f4 e2 
  e4 a a g8 a 
  bes4 c fis,2 
  a4 g g a 
  a e a2 
  e4 a g a 
  a4. g8 f2 
  a4 g g g 
  f g e2 
  f4 f e d8 e 
  f e16 d e4 fis2 
}


tenor = \relative c {
  f'4 e f g 
  c, d c2 
  e4 f a,8 g f4 
  f e8 d e2 
  a4 d8 c bes4 b 
  cis d8 c b2 
  c8 d dis4 d d 
  d8 bes a g d'2 
  d4 d c c 
  c8 b16 a b4 e2 
  cis4 d e f 
  e2 d 
  c4 d c8 bes a4 
  a bes a2 
  d4 d g, a8 bes 
  a2 a 
}


baixo = \relative c {
  d'4 c bes g 
  a b c2 
  a8 g f e d4. c8 
  bes2 a 
  f'4 fis g gis 
  a bes8 a gis2 
  a4 g fis g8 f 
  dis2 d 
  d'8 c b g c bes a g 
  fis4 gis a2 
  g4 f e d 
  a' a, bes2 
  a4 b c cis 
  d g, g'2 
  f4 e8 d e4 f8 g 
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