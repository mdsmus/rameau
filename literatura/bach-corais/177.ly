
\version "2.10.33"

\header {
  title = "177 - Danket dem Herrn heut und allzeit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 cis''4 
  cis8 d e4 cis a 
  b cis d cis 
  b a a4. b8 
  cis4 cis b8 a b4 
  a2. cis4 
  b cis a fis 
  gis a b cis 
  a a a4. b8 
  cis4 cis b8 a b4 
  a2. 
}


alto = \relative c {
  \partial 4 a''4 
  a b a a 
  g8 fis e4 fis e 
  e8 d cis4 fis2 
  e4 e e4. d8 
  cis2. a'4 
  gis gis fis8 e dis4 
  e4. dis8 e4 f 
  cis fis e fis8 gis 
  a4 e e4. d8 
  cis2. 
}


tenor = \relative c {
  \partial 4 e'4 
  e e e e8 d 
  d4 a a a 
  gis a d2 
  cis8 b a4 a gis 
  e2. e'4 
  e8 d cis4 cis b 
  b a gis gis 
  a d cis8 d cis b 
  a4 a a gis 
  e2. 
}


baixo = \relative c {
  \partial 4 a4 
  a' gis a fis 
  g a d, a 
  e' fis8 e d e fis gis 
  a4 cis,8 d e4 e 
  a,2. a4 
  e' f fis b8 a 
  gis4 fis e cis 
  fis8 e fis gis a b a gis 
  fis4 cis8 d e4 e 
  a,2. 
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