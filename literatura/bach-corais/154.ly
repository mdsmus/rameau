
\version "2.10.33"

\header {
  title = "154 - Der du bist drei in Einigkeit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 a''4 
  g d f g 
  a a g a 
  g d f g 
  a a g a 
  b c a g 
  g f e f 
  g d f g 
  a a g2 
}


alto = \relative c {
  \partial 4 d'4. c4 b16 cis d8 c b4 
  e d8 c b4 d4. c4 b16 cis d8 c b4 
  e d d f 
  f4. e4 d8 d4 
  e4. d8 cis4 d8 c 
  b c4 b16 cis d8 c b4 
  e d8 c b2 
}


tenor = \relative c {
  \partial 4 f4 
  g g a g2 fis4 d f 
  g g a g2 fis8 c' b4 c 
  d g, a16 b c4 b8 
  c ais a4 a a 
  g g a g2 fis4 d2 
}


baixo = \relative c {
  \partial 4 d4 
  e g d e8 d 
  c4 d g, d' 
  e g d e8 d 
  c4 d g, f'8 e 
  d4 c f8 fis g4 
  c,8 cis d4 a d 
  e g d e8 d 
  c4 d g,2 
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