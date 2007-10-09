
\version "2.10.33"

\header {
  title = "73 - Wenn mein Stündlein vorhanden ist 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g fis g a 
  bes a g g 
  a a d c 
  bes2 a4 g 
  g fis g a 
  bes a g g 
  a a d c 
  bes2 a4 d 
  c bes a8 bes c4 
  bes a g bes 
  a g f8 e d e 
  f4 g a a 
  bes c d4. c8 
  bes4 c8 bes a2 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  ees d8 c bes4 ees 
  d d d d 
  ees d d g8 fis 
  g2 fis4 d 
  ees d8 c bes4 ees 
  d d d d 
  ees d d g8 fis 
  g2 fis4 g 
  g8 f f ees ees d c a' 
  fis g4 fis8 d4 g8 f 
  e d d cis d e f cis 
  d f4 e8 f4 f 
  f8 g a4 a d,2 c8 d ees4 d8 c 
  b1 
}


tenor = \relative c {
  \partial 4 bes'4 
  a a g c 
  fis,8 g4 fis8 bes4 bes 
  c c b c 
  d e8 g, d'4 bes 
  a a g c 
  fis,8 g4 fis8 bes4 bes 
  c c b c 
  d e8 g, d'4 d 
  ees8 f g bes, c d g, c 
  d ees a d bes4 d 
  cis8 d e4 a,4. g8 
  a c d c c4 c 
  d ees f fis 
  g g,2 fis4 
  d1 
}


baixo = \relative c {
  \partial 4 g'4 
  c, d ees d8 c 
  d4 d g, g' 
  g fis f ees 
  d cis d g 
  c, d ees d8 c 
  d4 d g, g' 
  g fis f ees 
  d cis d bes'4. a8 g4. f8 ees4 
  d8 c d4 g, g'4. f8 e4 d8*5 a8 bes c f,4 f'8 ees 
  d ees d c bes c bes a 
  g bes ees d c a d4 
  g,1 
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