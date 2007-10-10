
\version "2.10.33"

\header {
  title = "163 - Für Freuden laßt uns springen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 d''4 
  d d d c 
  bes2 a4 d 
  d8 ees f4 ees d 
  c2 d4 d 
  d d d c 
  bes2 a4 d 
  d8 ees f4 ees d 
  c2 d4 d 
  c bes a g 
  a bes a d 
  bes bes c d 
  ees d c c 
  d4. c8 b2 
}


alto = \relative c {
  \partial 4 g''8 fis 
  g4 fis8 g a g4 fis8 
  g fis g4 fis f 
  g f c'4. bes8 
  bes4 a bes g8 fis 
  g4 fis8 g a g4 fis8 
  g fis g4 fis f 
  g f c'4. bes8 
  bes4 a bes bes8 a 
  g4 g4. fis8 g4 
  c,8 a' d, e fis4 a2 g8 f4 ees8 gis g 
  g4 g a a8 g 
  fis g4 fis8 g2 
}


tenor = \relative c {
  \partial 4 bes'8 c 
  d c16 bes a4. bes8 c d 
  d4 d d d8 c 
  bes4 bes4. a16 g f8 f' 
  g4 f f bes,8 c 
  d c16 bes a4. bes8 c d 
  d4 d d d8 c 
  bes4 bes4. a16 g f8 f' 
  g4 f f f 
  ees8 d e4 a,8 d16 c bes8 c16 bes 
  a8 d16 c bes a g8 d'4 d 
  d ees8 f g4 f8 d4 c8 d e fis a, d ees 
  d c16 bes a8 d d2 
}


baixo = \relative c {
  \partial 4 g8 a 
  bes c d e fis g a d, 
  g a bes c d4 bes8 a 
  g f ees d c f bes, d 
  ees c f4 bes, g8 a 
  bes c d e fis g a d, 
  g a bes c d4 bes8 a 
  g f ees d c f bes, d 
  ees c f4 bes, bes 
  c4. cis8 d4 ees8 e 
  f fis g cis, d4 fis 
  g8 f ees d c4. b8 
  c c'4 bes8 a g fis g 
  d2 g 
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