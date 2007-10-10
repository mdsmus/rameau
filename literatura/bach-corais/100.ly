
\version "2.10.33"

\header {
  title = "100 - Durch Adams Fall ist ganz verderbt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g g f g 
  ees d c g'8 a 
  bes4 c g a 
  bes a g g 
  g g f g 
  ees d c g'8 a 
  bes4 c g a 
  bes a g bes 
  bes bes8 gis g f ees f 
  g4 f ees g 
  g g f ees8 d 
  d2 c4 g' 
  g f g a 
  bes8 a g4 f c' 
  d c g8 a bes4 
  a g a2 
  g2. 
}


alto = \relative c {
  \partial 4 d'4 
  ees ees ees d 
  d8 c c b c4 ees 
  d c8 d ees4 ees 
  d c b d 
  ees ees ees d 
  d8 c c b c4 ees 
  d c8 d ees4 ees 
  d c b g' 
  f8 ees d c bes4 c8 d 
  ees4 d ees bes8 c 
  d4 c c c 
  c b c d 
  ees ees8 d ees g f ees 
  d c bes4 a f' 
  f ees8 d c4 d 
  d8 c bes4 ees d8 c 
  b2. 
}


tenor = \relative c {
  \partial 4 g'4 
  c c c g 
  g g8 f ees4 c' 
  bes8 a g4 c c 
  fis,8 g4 fis8 g4 g 
  c c c g 
  g g8 f ees4 c' 
  bes8 a g4 c c 
  fis,8 g4 fis8 g4 d' 
  bes f g g8 gis 
  bes4. gis8 g4 g 
  g8 f ees4 f8 g gis4 
  g4. f8 ees4 g 
  c8 bes gis4 bes c 
  f,4. e8 f4 a 
  bes8 a g fis g4 g 
  fis g2 fis4 
  g2. 
}


baixo = \relative c {
  \partial 4 b4 
  c8 d ees4 a b 
  c g c c 
  g'8 f ees d c bes a g 
  d'2 g,4 b 
  c8 d ees4 a b 
  c g c c 
  g'8 f ees d c bes a g 
  d'2 g,4 g' 
  d8 c bes4 ees8 d c4 
  g8 gis bes4 ees, ees' 
  b c8 bes gis g f4 
  g2 c4 b 
  c f ees8 d c4 
  bes c f, f' 
  bes, c8 d ees4 bes8 c 
  d4 ees8 d c4 d 
  g,2. 
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