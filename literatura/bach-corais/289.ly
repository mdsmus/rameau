
\version "2.10.33"

\header {
  title = "289 - Nun ruhen alle Wälder"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key bes \major
}

soprano = \relative c {
  \partial 4 d''4 
  bes c d8 ees f4 
  ees2 d4 d8 ees 
  f4 f c d8 c 
  bes2 a4 f 
  bes c d8 ees16 f ees8 d 
  c2 s4 d 
  bes c d8 ees f4 
  ees2 d4 d8 ees 
  f4 f c d 
  bes2 a4 f 
  bes c d c8 d16 ees 
  d4 c bes2 
}


alto = \relative c {
  \partial 4 bes''4 
  g a bes bes 
  bes a bes f 
  bes bes4. a8 a4 
  g2 f4 c 
  f g8 a bes4 bes 
  f2 s4 a 
  a8 g g f f g gis g 
  g4 fis g bes 
  c8 a bes4 g8 f a2 g4 f c 
  f ees f g 
  f f f2 
}


tenor = \relative c {
  \partial 4 f'4 
  ees ees f f 
  g f f bes,8 c 
  d ees f4 f f8 ees 
  d4 c c a 
  bes8 d ees4 f8 d bes4 
  a2 s4 d 
  d8 ees ees f d2 
  g,4 a b g' 
  f8 ees d4 e8 f f4 
  f e c a 
  bes4. a8 bes4 bes 
  bes a8 ees d2 
}


baixo = \relative c {
  \partial 4 bes4 
  ees d8 c bes4 d 
  c f bes, bes' 
  bes,8 c d ees f4 d 
  g8 f e c f4 f8 ees 
  d4 c bes ees 
  f2 s4 fis 
  g a bes b 
  c c, g' g 
  a8 f bes4. a8 g f 
  g4 c, f f8 ees 
  d4 c bes ees 
  f f, bes2 
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