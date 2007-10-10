
\version "2.10.33"

\header {
  title = "136 - Herr Jesu Christ, dich zu uns wend"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 
  b d b a 
  b cis d e 
  d8 c b4 a g8 a 
  b4 a g a 
  b b a d 
  d cis d b 
  c b a g 
  g fis g2 
}


alto = \relative c {
  \partial 4 d'4 
  g a4. g4 fis8 
  g4 g fis a 
  a4. g4 fis8 e d 
  d4 d d fis 
  g g g fis 
  e e fis d 
  e d8 g4 fis e8 
  d4 d d2 
}


tenor = \relative c {
  \partial 4 b'4 
  d d d d 
  d e a, c 
  d d e8 b4 a g fis8 b4 d 
  d d d a8 d 
  b g a4 a g 
  g8 a b4 e8 b b4 
  b a b2 
}


baixo = \relative c {
  \partial 4 g4 
  g fis g8 b d4 
  g8 fis e4 d a'8 g 
  fis4 g cis,8 dis e fis 
  g4 d g, d' 
  g,8 a b cis d e fis b 
  g e a a, d4 g8 f 
  e fis g4 cis,8 dis e4 
  b8 c d4 g,2 
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