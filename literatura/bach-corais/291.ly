
\version "2.10.33"

\header {
  title = "291 - Die Wollust dieser Welt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 a''4 
  fis e8 d a'4 a 
  b2. b4 
  e, e a g 
  fis e d a' 
  b b a g 
  fis2. e4 
  fis gis a b8 cis16 d 
  cis4 b8 a a4 a 
  a a d c 
  b2. b4 
  b b e d 
  cis2. a4 
  b a b cis 
  d2. a4 
  a g8 fis e fis16 g e4 
  d2. 
}


alto = \relative c {
  \partial 4 e'4 
  d cis d fis 
  g2. e4 
  e8 d cis4 d e 
  e8 d4 cis8 a4 d 
  d g g8 fis e4 
  d2. e4 
  d d cis fis 
  e2 e4 e 
  fis8 e fis g a4 fis 
  g2. a4 
  a gis gis8 fis fis e 
  e2. d4 
  d d g8 fis g4 
  fis2. e4 
  fis8 e d4 d cis 
  a2. 
}


tenor = \relative c {
  \partial 4 a'4 
  a g a d 
  d2. d4 
  cis8 b a4 a a 
  a2 fis4 a 
  g b cis8 d d cis 
  a2. a4 
  a b a a 
  a gis cis cis 
  d d a d 
  d2. fis4 
  e b b8 a a gis 
  a2. a4 
  g a e'8 d e4 
  d2. e4 
  a, b b a8 g 
  fis2. 
}


baixo = \relative c {
  \partial 4 cis4 
  d e fis d 
  g2. gis4 
  a a8 g fis e d cis 
  d4 a d fis 
  g e a a, 
  d2. cis4 
  d cis8 b fis'4 e8 d 
  e2 a,4 a' 
  d d,8 e fis4 d 
  g2. dis4 
  e8 fis e d cis d e4 
  a,2. fis'4 
  g fis e ais, 
  b2. cis4 
  d8 cis b a g4 a 
  d2. 
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