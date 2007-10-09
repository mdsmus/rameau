
\version "2.10.33"

\header {
  title = "245 - Christe, der du bist Tag und Licht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 g''4 
  bes g f g8 a 
  bes4 a g bes 
  bes bes bes f 
  g bes a a 
  c c c8 bes16 a g8 a 
  bes4 a g a 
  bes g f g8 a 
  bes4 a g2 
}


alto = \relative c {
  \partial 4 d'4 
  d d d d8 fis 
  g4. fis8 d4 g 
  g g f8 ees4 d16 c 
  d8 e16 f g4 f f 
  f e8 fis g fis g d 
  d g4 fis8 d4 fis 
  g d d d8 fis 
  g4. fis8 d2 
}


tenor = \relative c {
  \partial 4 d'8 c 
  bes4 bes a bes8 c 
  d4 ees8 d16 c bes4 d 
  d d d8 g, a bes4 a8 g c c4 c8 bes 
  a g a4 g8 c bes a 
  g d' ees d16 c bes4 d 
  d bes a bes8 c 
  d4 ees8 d16 c b2 
}


baixo = \relative c {
  \partial 4 bes8 a 
  g a bes c d c bes a 
  g bes c d g,4 g' 
  g,8 a bes c d ees f4 
  f e f f,8 g 
  a bes c d ees4. fis,8 
  g bes c d g,4 d' 
  g,8 a bes c d c bes a 
  g bes c d g,2 
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