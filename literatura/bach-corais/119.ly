
\version "2.10.33"

\header {
  title = "119 - Es woll uns Gott genädig sein 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 f'8 g 
  gis4 bes c bes 
  ees d8 c c4 bes 
  ees d c bes 
  gis g f f8 g 
  gis4 bes c bes 
  ees d8 c c4 bes 
  ees d c bes 
  gis g f f 
  bes bes g c 
  c b c c 
  f f g8 f ees4 
  f8 ees d4 c d 
  ees d c bes 
  c8 bes gis4 g f8 g 
  gis4 bes c8 bes gis4 
  bes8 gis g4 f f' 
  f f g f 
  ees d c2 
}


alto = \relative c {
  \partial 4 d'4 
  c8 d ees4 ees8 f g4 
  g g g g 
  g g gis8 g f4 
  c8 f4 e8 c4 c 
  f g gis g 
  c b g g 
  g8 c c bes bes gis g e 
  f4 e c c 
  f ees8 d ees f g4 
  g g g g 
  c bes bes c8 bes 
  gis4 d8 ees16 f ees4 g 
  g f ees8 f g4 
  c, f e c 
  f g g8 e f4 
  g8 f e4 c c' 
  bes bes bes c8 f, 
  g4. f8 e2 
}


tenor = \relative c {
  \partial 4 bes'4 
  gis g gis ees'8 d 
  c4 b ees d 
  c d8 e f4 f,8 g 
  gis bes c4 gis gis8 g 
  f gis cis4 ees ees8 f 
  g4 g ees d 
  c f,8 g gis4 bes 
  c bes8 gis gis4 gis8 g 
  f4 bes bes ees 
  d8 c d4 ees ees 
  ees d ees8 d c4 
  d8 c b4 g b 
  c8 bes gis bes c d e f 
  g4 c, c gis8 g 
  f gis cis4 c cis 
  cis g8 gis16 bes gis4 f 
  d'8 ees f d ees d c4 
  c b g2 
}


baixo = \relative c {
  \partial 4 bes4 
  f' ees gis g8 f 
  ees f g4 c, g' 
  c bes gis d8 e 
  f4 c f, f'8 ees 
  cis c bes4 gis ees'8 d 
  c4 g' c g 
  c, d8 e f4 cis 
  c8 bes c4 f, f'8 ees 
  d c bes4 ees d8 c 
  g'4 g, c c'8 bes 
  a4 bes ees, gis8 g 
  f4 g c, g' 
  c, f8 g gis4 g8 f 
  e4 f c f8 ees 
  cis c bes4 gis cis8 c 
  bes4 c f, a' 
  bes8 c d bes ees,4 gis 
  g8 f g g, c2 
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