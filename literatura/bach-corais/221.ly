
\version "2.10.33"

\header {
  title = "221 - Herr, straf mich nicht in deinem Zorn"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  c b a a 
  g f e e 
  fis gis a c 
  b2 a4 a 
  c b a a 
  g f e e 
  fis gis a c 
  b2 a4 b 
  b b b g 
  a b c b 
  b b c b 
  a a gis gis 
  a b c d 
  b2 a 
}


alto = \relative c {
  \partial 4 e'4 
  a a8 g f4 f4. e4 d8 cis4 e 
  d8. e16 f8 e e fis16 gis a4 
  a gis e e 
  a a8 g f4 f4. e4 d8 cis4 e 
  d8. e16 f8 e e fis16 gis a4 
  a gis e g 
  fis g fis4. e4 d e8 e4 e 
  fis16 g a4 gis8 a4. g4 f16 e d4 e e 
  e e4. a16 gis a4. gis16 fis gis4 e2 
}


tenor = \relative c {
  \partial 4 c'4 
  e e8. d16 c4 d4. a8 a4 a a 
  a d8 c16 b c8 d e4 
  f8 d b e16 d c4 c 
  e e8. d16 c4 d4. a8 a4 a a 
  a d8 c16 b c8 d e4 
  f8 d b e16 d c4 e 
  dis e b b8 c4 d16 c b a b8 a4 g 
  b e e e8. d16 
  c4 b8 a b4 b 
  c b a4. f'8 
  e b e d cis2 
}


baixo = \relative c {
  \partial 4 a4 
  a' e f8 e d c 
  b cis d4 a c4. d16 c b8 e c b a c 
  d b e4 a, a 
  a' e f8 e d c 
  b cis d4 a c4. d16 c b8 e c b a c 
  d b e4 a, e' 
  b'8 a g fis e dis e4 
  fis gis a e 
  dis d c8 d e4 
  f8 e f4 e e8 d 
  c b a gis a4 f'8 d 
  e2 a, 
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