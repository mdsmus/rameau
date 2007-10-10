
\version "2.10.33"

\header {
  title = "94 - Warum betrübst du dich, mein Herz"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g8 a bes4 a d8 d 
  c4 bes a bes8 a 
  g4 d' c d 
  g,8 a b4 c bes 
  a d c bes 
  a2 s4 g8 a 
  bes4 bes c c 
  d d bes d 
  c bes a g8 a 
  bes4 a g2 
}


alto = \relative c {
  \partial 4 d'4 
  ees d8 e fis4 g8 g 
  a4 g fis g 
  g f8 g a4 b 
  c g8 g g4 g 
  fis g a d, 
  d2 s4 d 
  g g8 f ees4 f8 g 
  gis4 g8 f g4 g 
  g8 fis g4 fis g 
  g fis d2 
}


tenor = \relative c {
  \partial 4 g'4 
  c bes8 c d4 d8 d 
  d4 d d d8 c 
  bes c d ees f4 f 
  g d8 d ees4 d 
  d d fis, g 
  fis2 s4 bes8 c 
  d4 cis c8 bes gis g 
  f4 f' ees f 
  ees e a,8 bes c4 
  d8 e a, c b2 
}


baixo = \relative c {
  \partial 4 b4 
  c8 c g4 d' bes'8 bes 
  fis4 g d g, 
  g'8 a bes4 f d 
  ees8 f g4 c, g' 
  d8 c bes4 a g 
  d'2 s4 g, 
  g'8 f ees4 gis8 g f4 
  bes, bes ees b 
  c cis d ees 
  d8 cis d4 g,2 
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