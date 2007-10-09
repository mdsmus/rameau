
\version "2.10.33"

\header {
  title = "15 - Christ lag in Todesbanden"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  gis a8 b c4 d 
  c b a a 
  f g a g8 f 
  e d e4 d a' 
  gis a8 b c4 d 
  c b a a 
  f g a g8 f 
  e d e4 d2 
  d8 e f4 g d8 e 
  f4 g a a 
  d cis d e8 d 
  c4 b a b 
  c a8 ais c4 g 
  f e d2 
  a'4 g f e 
  d1 
}


alto = \relative c {
  \partial 4 f'4 
  f8 e4 gis8 a4 b4. a4 gis8 e4 e4. d8 cis d e4. d8 
  cis d4 cis8 a4 f' 
  f8 e4 gis8 a4 b4. a4 gis8 e4 e4. d8 cis d e4. d8 
  cis d4 cis8 a2 
  a4 d d8 c ais c 
  d a d c c4 f8 g 
  a ais4 a8 a4 e4. f4 e8 e4 f4. e8 f4 f e4. d8 cis d d2 
  d4. e8 cis d4 cis8 
  a1 
}


tenor = \relative c {
  \partial 4 d'8 c 
  b4 c8 d e4 f8 e 
  e f4 e16 d cis4 a 
  a ais a a 
  a8 f g e f4 d'8 c 
  b4 c8 d e4 f8 e 
  e f4 e16 d cis4 a 
  a ais a a 
  a8 f g e f2 
  f8 g a4 g8 a ais4 
  a8 f'4 e8 f4 c 
  f, g d'8 c b4. a4 gis8 c4 d 
  g,8 c c4 c8 d e d 
  cis a ais a16 g f2 
  a8 c ais4 a g2 fis8 e fis2 
}


baixo = \relative c {
  \partial 4 d4 
  d c8 b a a'4 gis8 
  a f d e a,4 cis 
  d8 f e d cis a d4 
  a' a, d d 
  d c8 b a a'4 gis8 
  a f d e a,4 cis 
  d8 f e d cis a d4 
  a' a, d2 
  d4. c8 ais a g4 
  d'8 c ais c f,4 f'8 e 
  d4 e fis gis 
  a8 f d e a,4 d 
  c f,8 g a ais c ais 
  a f g a ais2 
  fis4 g a2 
  d,1 
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