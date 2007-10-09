
\version "2.10.33"

\header {
  title = "50 - O Welt, ich muß dich lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 a''4 
  f g a8 bes c4 
  bes2 a4 a8 bes 
  c4 c g a8 g 
  f2 e4 c 
  f g a8 bes16 c bes8 a 
  g2. a4 
  f g a8 bes c4 
  bes2 a4 a8 bes 
  c4 c g a8 g 
  f2 e4 c 
  f g a g8 a16 bes 
  a4 g f2 
}


alto = \relative c {
  \partial 4 f'4 
  d e f8 g a4 
  a g f f 
  f8 e f g e d c4 
  c b c e 
  d c c d 
  e2. e4 
  d c c d 
  d g fis f 
  f f e8 d c4 
  c b c g 
  c bes a8 c f4 
  f e c2 
}


tenor = \relative c {
  \partial 4 c'4 
  d c8 bes a4. g8 
  f4 c' c c 
  c c c c8 b 
  a g f4 g bes 
  a g f f 
  c'2. a4 
  a g f8 g a4 
  g8 a bes c d4 d 
  c8 bes c d e4 f 
  f,8 a g f g4 e 
  f8 c' d e f c bes f 
  c'4. bes8 a2 
}


baixo = \relative c {
  \partial 4 f4 
  bes a8 g f4. e8 
  d4 e f f8 g 
  a4 a,8 bes c4 a 
  d2 c4 c 
  d e f bes, 
  c2. cis4 
  d e f fis 
  g g, d' d' 
  a8 g a bes c4 f,8 e 
  d c d4 c bes 
  a g f d' 
  c8 bes c4 f,2 
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