
\version "2.10.33"

\header {
  title = "228 - Vitam quae faciunt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  c b c d 
  e e d c 
  b2 b4 b 
  e d d c 
  b c d c 
  b b a2 
}


alto = \relative c {
  \partial 4 e'4 
  a b4. a4 g8 
  g4 g g8 f e4 
  e2 e4 e 
  e fis gis a4. gis8 a4 a8 gis a4 
  a4. gis8 e2 
}


tenor = \relative c {
  \partial 4 c'4 
  e e e d4. c16 b c4 b4. a gis8 fis gis4 gis 
  a a b c8 d 
  e4 e d e 
  f e8. d16 c2 
}


baixo = \relative c {
  \partial 4 a4 
  a'4. gis8 a a, b4 
  c8 d e f g4 a 
  e2 e,4 e'8 d 
  c4 c b a 
  e' a8 g f4 e 
  d e a,2 
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