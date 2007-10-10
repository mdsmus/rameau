
\version "2.10.33"

\header {
  title = "51 - Gelobet seist du, Jesu Christ"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  g g a g 
  c d c2 
  b8 c d4 e d8 c 
  b4 a g g 
  c b8 c d4 a 
  g8 fis e4 d d 
  a' a a b 
  c8 b a4 g8 a b4 
  a2 g4 g 
  g2 g 
}


alto = \relative c {
  \partial 4 d'4 
  e d8 e fis4 e 
  g g8 f e2 
  g8 a b4 c8 b a4 
  g fis d d8 e 
  fis4 g g fis8 e 
  d b cis4 a a 
  d cis fis g 
  a8 g4 fis8 e a g4 
  fis2 d8 e f4 
  e e d2 
}


tenor = \relative c {
  \partial 4 b'4 
  c b a8 d b4 
  e8 c b4 g2 
  e'4 f g d 
  d4. c8 b4 g 
  a d8 c b g d'4 
  d a8 g fis4 fis8 g 
  a b cis e d4 d 
  e8 d e d4 c8 b c 
  d2 d4 b 
  g c b2 
}


baixo = \relative c {
  \partial 4 g'8 fis 
  e fis g4 d e8 d 
  c4 g c2 
  e4 d c fis, 
  g8 b d4 g, b 
  a g8 a b c d c 
  b g a4 d d8 e 
  fis g a cis, d c b4 
  a8 b c d e fis g4 
  d2 b8 a g4 
  c8 e16 d c8 c, g'2 
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