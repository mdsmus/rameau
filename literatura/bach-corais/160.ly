
\version "2.10.33"

\header {
  title = "160 - Gelobet seist du, Jesu Christ"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g g a g 
  c d c2 
  b4 d e d 
  b a g g 
  c b d a 
  g e d d 
  a' a a b 
  c a g8 a b4 
  a2 g4 g 
  g1 
}


alto = \relative c {
  \partial 4 d'4 
  e e f g 
  a b a2 
  g4 g g fis 
  g fis d e 
  e8 fis g4 g f 
  e8 d cis4 a d 
  d a'8 g fis4 gis 
  a f e8 fis g2 f4. e8 e2 d8 c d2 
}


tenor = \relative c {
  \partial 4 b'4 
  b c c c8 d 
  e4 f e2 
  e4 d c8 b a4 
  b8 c d4 b b 
  c d d d8 c 
  b4 a8 g fis4 fis8 g 
  a b cis4 d d 
  e c c d4. a8 d c b4 c2 b8 a b2 
}


baixo = \relative c {
  \partial 4 g'4 
  e c f e 
  a gis a2 
  e4 b' c d 
  g, d g e 
  a g b,8 c d4 
  g, a d d8 e 
  fis g a b c4 b 
  a a,8 b c4 b8 c 
  d4 c8 d e4 d8 c 
  g'1 
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