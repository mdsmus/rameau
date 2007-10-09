
\version "2.10.33"

\header {
  title = "6 - Christus, der ist mein Leben"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 f'4 
  a g a bes 
  c2 a4 d 
  c bes a g 
  a2 s4 c 
  d e f e 
  d2 c4 a 
  bes a g g 
  f2. 
}


alto = \relative c {
  \partial 4 c'4 
  f g f f 
  e8 f g e f4 f 
  f4. e8 f4. e8 
  f2 s4 a4. g4 c16 bes a4 a 
  a g g f4. e8 f4 f e 
  c2. 
}


tenor = \relative c {
  \partial 4 a'4 
  c c c d 
  g, c c bes 
  c d8 bes c4 c 
  c2 s4 f 
  f e4. d8 c2 b4 e c 
  bes c cis c8. bes16 
  a2. 
}


baixo = \relative c {
  \partial 4 f,4 
  f' e dis d 
  c8 d e c f4 bes, 
  a g f8 a c4 
  f,2 s4 a' 
  b, c d8 f a g 
  f d g4 c, f, 
  g a bes c 
  f,2. 
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