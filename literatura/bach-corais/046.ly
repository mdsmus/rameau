
\version "2.10.33"

\header {
  title = "46 - Vom Himmel hoch, da komm ich her"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 d''4 
  cis b cis a 
  b cis d d4 d a 
  a fis8 g a4 g 
  fis fis4 
  b b a8 b cis4 
  d8 cis b4 a d4 cis b 
  a b8 a g fis e4 
  d2 
}


alto = \relative c {
  \partial 4 a''4 
  a8 gis fis4 e fis8 e 
  d4 e fis fis8 g a g fis4 
  e d d e 
  d d8 e 
  fis4 e e8 gis a4 
  a4. gis8 e4 fis8 e e fis4 e8 
  cis d b cis d4. cis8 
  a2 
}


tenor = \relative c {
  \partial 4 fis'4 
  e d cis d8 cis 
  b a g4 a a4 d d 
  cis c8 b a4 a 
  a a4 
  a gis a8 d cis b 
  a cis fis e cis4 d8 b4 a8 a g 
  a4 g8 fis d4 a'8 g 
  fis2 
}


baixo = \relative c {
  \partial 4 d4 
  a'4. gis8 a g fis4 
  g8 fis e4 d d8 e fis4 fis8 g 
  a4 a8 g fis e d cis 
  d4 d4 
  dis e8 d cis b a4 
  fis'8 e d e a,4 b'8 e, a4 d,8 g4 fis8 g a b g a a, 
  d2 
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