
\version "2.10.33"

\header {
  title = "157 - Wo Gott zum Haus nicht gibt sein Gunst"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 f'4 
  c' c8 bes a4 g 
  a b c c 
  a c bes c 
  a g f c' 
  d d a c 
  bes bes a f' 
  e d c4. d8 
  bes a g4 f2 
}


alto = \relative c {
  \partial 4 c'4 
  f8 g a g4 f e8 
  f e d4 e g4. f8 g a4 g16 f g4. f4 e8 c4 f 
  f f c4. a'4 g16 fis g4. fis8 a4 
  a8 g f g a g f4 
  f4. e8 c2 
}


tenor = \relative c {
  \partial 4 a'8 bes 
  c d e4 c c 
  c g g c 
  c4. e8 f d c4 
  c c8 bes a4 a 
  bes f8 g a4 f'8 dis 
  d4 d d d 
  c d8 e f4 a, 
  bes4. c16 bes a2 
}


baixo = \relative c {
  \partial 4 f8 g 
  a bes c4 f, c 
  f g c, e 
  f e8 c d g e c 
  f4 c f, f' 
  bes,8 c d e f g a fis 
  g a bes c d4 d, 
  a' bes f8 e d4 
  g c, f2 
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