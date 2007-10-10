
\version "2.10.33"

\header {
  title = "224 - Das walt Gott Vater und Gott Sohn"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 f'4 
  a c c a 
  f g a f 
  c' c d e 
  f8 e d4 c c 
  a c d c 
  bes a g c 
  a8 bes c4 bes a8 g 
  f4 g f2 
}


alto = \relative c {
  \partial 4 c'4 
  f f e e4. d8 c4 c c 
  f g a8 b c4 
  c4. b8 g4 g4. f16 e f4 f f 
  g8 c, c f4 e8 g4 
  f f f e 
  d16 e f4 e8 c2 
}


tenor = \relative c {
  \partial 4 a'4 
  c c g a 
  a g f a 
  a c f e 
  a d,8 g16 f e4 c 
  c c4. bes4 a8 
  g4 a8. bes16 c4 c 
  c c d c8 bes 
  a g16 f c'8. bes16 a2 
}


baixo = \relative c {
  \partial 4 f4 
  f a,8 bes c4 cis 
  d e f f 
  f4. e8 d4 a'8 g 
  f4 g c, e 
  f a,8 f bes4 f'4. e8 f4 c e 
  f a, bes c 
  d c f2 
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