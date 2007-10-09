
\version "2.10.33"

\header {
  title = "170 - Nun komm, der Heiden Heiland"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  a''4 a g c 
  b8 a b4 a2 
  a8 b c4 d c 
  d e c2 
  c4 d e8 d c4 
  d8 c b4 a2 
  a4 a g c 
  b8 a b4 a2 
}


alto = \relative c {
  e'4 d e e 
  e8 fis gis4 e2 
  e8 gis a4 d, g 
  f e8 f16 g f2 
  f4 f e e 
  d8 a' gis4 e2 
  dis8 e fis4 e e 
  f8 c d4 cis2 
}


tenor = \relative c {
  c'4 b8 a b a g a 
  b c d4 c2 
  c8 d e f b, a g a 
  b4 c8 g a2 
  a4 b8 c b4 a 
  a e'8 d c2 
  fis,4 b b a 
  a4. gis8 e2 
}


baixo = \relative c {
  a'8 g f4 e4. fis8 
  gis a e4 a,2 
  a4 a' g8 f e4 
  d c f2 
  f8 e d4 gis a8 g 
  f d e4 a,2 
  b8 cis dis b e d c a 
  d e16 f e4 a,2 
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