
\version "2.10.33"

\header {
  title = "279 - Ach Gott und Herr, wie groß und schwer"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 bes''4 
  a g f f 
  g a bes c 
  bes a g a8 bes 
  g2 f4 bes 
  a bes c c 
  d8 c bes4 c f, 
  g a bes8 c d4 
  c bes c2 
  bes1 
  bes 
}


alto = \relative c {
  \partial 4 f'4 
  f e c c 
  f fis g a 
  g f c c 
  c2 c4 d 
  ees f f f 
  f8 ees cis4 c f 
  f e d4. g8 
  a4 bes2 gis fis f8 ees 
  f1 
}


tenor = \relative c {
  \partial 4 d'4 
  c c8 bes a4 a 
  bes ees d d 
  d d e f 
  f8 e16 d e4 a, f 
  c' d a a 
  gis g ees' ees 
  d g f f 
  ees d g f2. ees d8 c d2 
}


baixo = \relative c {
  \partial 4 bes4 
  f' c f, ees' 
  cis c g' fis 
  g d'8 c bes a g f 
  c'4 c, f d 
  c bes f' f 
  bes, ees gis, a 
  b cis d4. e8 
  fis4 g8 f e4 f8 ees 
  d4 ees8 f fis gis bes4 
  bes,1 
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