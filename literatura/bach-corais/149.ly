
\version "2.10.33"

\header {
  title = "149 - Nicht so traurig, nicht so sehr"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  \partial 4 ees''4 d8 c 
  g'4 f8 ees d4 ees8 f 
  b,2 c8 d ees4 
  aes, g f bes 
  g2 ees'4 d8 c 
  g'4 f8 ees d4 ees8 f 
  b,2 c8 d ees4 
  aes, g f bes 
  g2 g'4 bes, 
  a bes ees d8 c 
  d2 d4 ees8 f 
  b,4 g' ees d8. c16 
  c1 
}


alto = \relative c {
  \partial 4 g''4 f 
  ees8 f g4 aes g8 f 
  g2 g4 g 
  f bes, bes f' 
  ees2 g4 f 
  ees8 f g4 aes g8 f 
  g2 g4 g 
  f bes, bes f' 
  ees2 ees4 ees 
  f f g f 
  f2 f4 f 
  g g g f8. ees16 
  ees1 
}


tenor = \relative c {
  \partial 4 c'4 b 
  c c c b8 c 
  d2 c4 c 
  c8 d ees4 ees d 
  bes2 c4 b 
  c c c b8 c 
  d2 c4 c 
  c8 d ees4 ees d 
  bes2 bes4 bes 
  c bes bes a 
  bes2 bes4 c 
  d c c4. b8 
  g1 
}


baixo = \relative c {
  \partial 4 c4 d 
  ees c f g8 aes 
  g2 ees8 d c4 
  f g8 aes bes4 bes, 
  ees2 c4 d 
  ees c f g8 aes 
  g2 ees8 d c4 
  f g8 aes bes4 bes, 
  ees2 ees4 g 
  f8 ees d4 c f 
  bes,2 bes'4 aes 
  g8 f ees f g4 g, 
  c1 
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