
\version "2.10.33"

\header {
  title = "122 - Ist Gott mein Schild und Helfersmann"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  c b c d8 ees 
  bes4. gis8 g4 g 
  f bes g c 
  b4. c8 d4 ees 
  d8 c bes gis g4 gis8 bes 
  f2 ees4 ees' 
  d c8 bes bes4 c 
  bes gis8 g g4 f 
  bes4. gis8 g4 ees'8 d 
  b4. c8 d4 ees 
  f8 ees d c b4 c8 d 
  d4. c8 c4 ees 
  ees8 d c b g'4 c,8 a 
  b4. c8 c2 
}


alto = \relative c {
  \partial 4 ees'8 f 
  g4 g g f8 ees 
  f4 d ees ees 
  c bes8 f' ees d c g' 
  f ees ees g16 fis g4 g 
  f4. d8 ees4 ees 
  ees d bes g' 
  f ees8 f g4 gis8 g 
  f ees f d ees4 d 
  e f d g 
  f8 d ees g16 fis g4 g 
  f8 g gis4 gis g8 gis 
  g4 f8 ees ees4 gis 
  gis gis8 g g4 g8 f 
  d ees16 f g4 g2 
}


tenor = \relative c {
  \partial 4 c'4 
  c d ees g, 
  f bes bes bes 
  gis8 g f bes bes g' f ees 
  d4 g,8 a b4 c8 bes 
  gis f bes4 bes gis8 g 
  c4 bes8 gis g4 bes 
  gis8 bes c d ees4 gis, 
  bes8 c d4 bes bes 
  bes c b c 
  d g,8 a b4 c 
  c f f ees8 c 
  c a b4 c c 
  c8 f ees d c b c d 
  g,4 d' e2 
}


baixo = \relative c {
  \partial 4 c4 
  ees g c c, 
  d bes ees ees 
  ees d ees gis 
  d c g' c 
  f,8 ees d bes ees d c bes 
  gis4 bes ees ees 
  f8 g gis4 g f8 ees 
  d c bes4 ees bes'8 gis 
  g4 f f ees 
  d c g' c8 bes 
  gis g f ees d4 ees8 f 
  g4 g, gis gis'8 g 
  f4 f ees8 d ees f 
  g4 g, c2 
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