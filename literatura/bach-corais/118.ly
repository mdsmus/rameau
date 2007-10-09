
\version "2.10.33"

\header {
  title = "118 - In dich hab ich gehoffet, Herr 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 bes''4 
  bes f' f ees8 d 
  c4 d ees8 d c4 
  bes bes c d 
  ees c f g 
  f d d8 ees f4 
  ees d8 c bes c d c 
  c4 d bes8 c d4 
  ees d c d 
  ees d c bes 
  f'4. ees8 d4 ees8 d 
  c2 bes 
}


alto = \relative c {
  \partial 4 f'4 
  g a8 bes c4 bes8 a 
  g4 f bes a 
  f g fis f 
  ees8 f g4 f4. e8 
  a4 a g f 
  c' bes d, g 
  f f g8 a b4 
  c bes bes gis 
  g f f8 ees d ees 
  f g a2 g4 
  g f8 ees d2 
}


tenor = \relative c {
  \partial 4 d'4 
  d8 ees f4 f g8 f 
  ees4 f bes, f'8 ees 
  d4 ees ees d 
  g, g8 a bes c d c 
  c4 c bes8 c d ees 
  f4 f g bes, 
  a bes8 a g4 f 
  g g'8 f ees4 f 
  bes, bes a bes 
  c2. bes4 
  bes a f2 
}


baixo = \relative c {
  \partial 4 bes'8 a 
  g4 d a' bes2 gis4 g8 ees f4 
  bes, ees a b 
  c8 d ees4 d8 c bes c 
  f4 fis g gis 
  a bes8 a g f e4 
  f bes, ees d 
  c g' gis8 g f4 
  ees bes f' g 
  a8 g f4 fis g8 f 
  e4 f bes,2 
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