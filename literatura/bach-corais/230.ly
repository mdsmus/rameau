
\version "2.10.33"

\header {
  title = "230 - Christ, der du bist der helle Tag"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g bes a g 
  bes c d d 
  d d8 ees f ees d4 
  c c bes bes 
  bes d c a 
  bes c d d 
  d d c c 
  bes4. a16 g f4 f 
  bes8 c d4 c d 
  bes a g2 
}


alto = \relative c {
  \partial 4 d'4 
  d8 e f g f ees d4 
  g8 f ees f f4 f 
  f g a bes4. a16 g a4 f g 
  g8 a bes4 bes8 a16 g f4 
  f f f f 
  f f f8. ees16 d2 e4 d d 
  g8 a bes4 bes a4. g4 fis8 d2 
}


tenor = \relative c {
  \partial 4 bes'4 
  bes d8 c c4 bes8 a 
  g16 a bes4 a8 bes4 bes8 c 
  d c bes4 c bes8 d 
  g4 f8 ees d4 d 
  ees f f c 
  bes4. a8 bes4 bes 
  bes bes4. a8 a4. g8 g a16 bes a4 bes8 c 
  d c bes a g4 d' 
  d8 ees a d bes2 
}


baixo = \relative c {
  \partial 4 g4 
  g' d8 e f fis g f 
  ees d c f bes,4 bes 
  bes'8 a g4 f g8 f 
  ees4 f bes, g'8 f 
  ees d c bes f'4. ees8 
  d bes f'4 bes, bes 
  bes8 c d ees f4 fis8 d 
  g4 cis, d bes8 a 
  g4 g'8 f e4 fis 
  g8 c, d4 g,2 
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