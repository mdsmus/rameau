
\version "2.10.33"

\header {
  title = "255 - Die Wollust dieser Welt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 a''4 
  fis d a' a 
  b2. b4 
  e, e a g 
  fis d s4 a' 
  b b a g 
  fis2. e4 
  fis gis a4. b8 
  gis2 a4 a 
  a a d c 
  b2. b4 
  b b e d 
  cis2. a4 
  b a b cis 
  d2. a4 
  a g8 fis e4 e 
  d2. 
}


alto = \relative c {
  \partial 4 e'4 
  d fis8 e d4 a'8 fis 
  g2. d4 
  cis8 d cis b a4 e' 
  d a s4 d 
  d g fis e 
  a,2. cis4 
  d e e4. fis8 
  e2 e4 e 
  fis8 e fis g a g a fis 
  g2. fis4 
  e e e e 
  e2. d4 
  g a g b8 ais 
  b2. a8 g 
  fis4 e8 d d4 cis 
  a2. 
}


tenor = \relative c {
  \partial 4 a'4 
  a a a d 
  d2. g,4 
  g4. fis8 e4 a 
  a fis s4 a 
  g8 a b4 cis8 d d cis 
  d2. cis4 
  a b a4. d8 
  b2 cis4 cis 
  d d d d 
  d2. b8 a 
  gis fis gis a b a b gis 
  a2. d4 
  d d d e 
  fis2. e4 
  d a a8 b a g 
  fis2. 
}


baixo = \relative c {
  \partial 4 cis4 
  d8 cis d e fis e fis d 
  g2. g,4 
  a8 g a b cis b cis a 
  d4 d s4 fis 
  g e a a, 
  d2. a4 
  d8 cis d b cis b cis d 
  e4 e, a a 
  d8 cis d e fis e fis d 
  g2. dis4 
  e8 dis e fis gis fis gis e 
  a2. fis4 
  g8 a g fis g fis g e 
  b'2. cis,4 
  d8 e fis g a4 a, 
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