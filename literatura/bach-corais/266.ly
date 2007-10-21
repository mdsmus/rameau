
\version "2.10.33"

\header {
  title = "266 - Wenn mein Stündlein vorhanden ist 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g fis g a 
  bes a g g 
  a a d c 
  bes2 a4 g 
  g fis g a 
  bes a g g 
  a a d c 
  bes2 a4 d 
  c bes a c 
  bes a g bes 
  a g f8 ees d e 
  f4 g a g8 a 
  bes4 c d4. c8 
  bes4 c8 bes a2 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  ees d d c 
  bes8 c d c bes4 d8 e 
  f4 f bes4. a8 
  a g16 fis g4 fis d 
  ees d d c 
  bes8 c d c bes4 d8 e 
  f4 f bes4. a8 
  a g16 fis g4 fis d8 ees 
  f4. e8 f4 g 
  g fis d e 
  f e8 d cis4 d 
  d c c c 
  d ees d8 fis g a 
  bes a g2 fis4 
  d1 
}


tenor = \relative c {
  \partial 4 bes'4 
  a a g d' 
  d8 e fis4 g bes, 
  c d8 ees f4 c8 d 
  g, d d'4 d bes 
  a a g d' 
  d8 e fis4 g bes, 
  c d8 ees f4 c8 d 
  g, d d'4 d bes 
  a bes c c 
  d d8 c bes4 c 
  c bes a8 g f4 
  bes a8 g f4 g 
  f g8 a bes4. a8 
  d4 c8 d ees4 d8 c 
  b1 
}


baixo = \relative c {
  \partial 4 g'4 
  c, d e fis 
  g d g, g' 
  f8 ees d c bes d e fis 
  g a bes c d4 g, 
  c, d e fis 
  g d g, g' 
  f8 ees d c bes d e fis 
  g a bes c d4 f,8 g 
  a4 g f ees 
  d8 c d4 g, c 
  f, g a bes8 c 
  d4 e f ees 
  d c bes8 d e fis 
  g f ees d c4 d 
  g,1 
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