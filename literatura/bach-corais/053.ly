
\version "2.10.33"

\header {
  title = "53 - Das neugeborne Kindelein"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key g \minor
}

soprano = \relative c {
  g''4 g g d'4. c8 bes4 d c 
  bes a2. 
  d4 d e f2 e4 d cis2 d2. 
  d4 c a bes4. c8 d4 c bes 
  a bes2. 
  f'4 g f d4. c8 bes4 a g 
  fis g2. 
}


alto = \relative c {
  d'4 g8 a bes4 a2 g4 g fis 
  g fis2. 
  g8 a bes4 bes a2 g4 f e2 fis2. 
  g4 ees d d 
  g f g f 
  f f2. 
  bes4 bes a a2 g4 ees d 
  d d2. 
}


tenor = \relative c {
  bes'4 d d d2 d8 c bes4 c 
  d d2. 
  d4 g g f 
  b, cis d a2 a2. 
  bes4 a a g 
  ees' d ees d 
  c d2. 
  d4 c c a 
  d d c bes 
  a b2. 
}


baixo = \relative c {
  g'8 a bes4 a8 g fis2 g4 bes, a 
  g d'2. 
  bes'4 a8 g cis4 d 
  d, e f8 g a4 
  a, d2. 
  g,4 g' fis g4. a8 bes4 ees, f 
  f, bes2. 
  bes'4 ees, f fis2 g4 c, d 
  d g,2. 
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