
\version "2.10.33"

\header {
  title = "72 - Erhalt uns, Herr, bei deinem Wort"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''8 a 
  bes4 a8 g fis4 g8 a 
  bes4 a g bes 
  c c d bes 
  c c d d 
  ees d8 ees f ees d4 
  c8 bes c4 bes d 
  bes c bes a 
  g fis g 
}


alto = \relative c {
  \partial 4 d'4 
  g8 f ees4 d d8 fis 
  g4 fis d g 
  f8 g a4 bes d, 
  g8 bes a g fis4 g 
  g8 a bes4 c bes 
  a8 bes4 a8 f4 a 
  g g8 fis g4 fis 
  g8 ees d4 d 
}


tenor = \relative c {
  \partial 4 bes'8 c 
  d4 c8 bes a4 bes8 c 
  d ees a d bes4 d 
  c f f g 
  g c,8 d16 ees a4 bes 
  c f, f f' 
  ees8 d ees c d4 d 
  d c d d8 c 
  bes4 a8 b16 c b4 
}


baixo = \relative c {
  \partial 4 g4 
  g' c, d8 c' bes a 
  g c, d4 g, g' 
  a f bes8 a g f 
  ees d ees4 d g 
  c, bes a bes 
  f' f bes, fis' 
  g8 g, a4 bes8 c d4 
  ees8 c d4 g, 
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