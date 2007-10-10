
\version "2.10.33"

\header {
  title = "176 - Erstanden ist der heilig Christ"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key f \major
}

soprano = \relative c {
  \partial 4 f'4 f4. g8 a bes c2 
  g4 a2 b4 
  c2 bes4 a4. g8 a bes c2 
  bes4 a2 g4 
  a2 a4 c2 bes4 a2 
  g4 f2 e4 
  f2 f4 g8 f 
  g a bes4 a2 
  g4 f2 e4 
  f2. 
}


alto = \relative c {
  \partial 4 c'4 c 
  d8 e f2 e8 f 
  g4. e8 f2. e4 g2 
  f g8 f g a4 g f16 e f4. e16 d 
  cis2 d4 e4. f8 g2 f4 
  e2 d4 c8 bes 
  a2 d4 d 
  e8 f d e f2 
  e d4 c 
  c2. 
}


tenor = \relative c {
  \partial 4 a'4 a8 bes 
  a g f4 g2 
  c4 c2 d4 
  g,2 c4 c8 a 
  d2 c8 d e4 
  d d a d, 
  e2 f4 a 
  c8*5 a8 d c 
  bes4 a8 f bes a g4 
  f2 a4 g 
  c d8 g, a bes c4. bes8 a4 bes8 a g bes 
  a2. 
}


baixo = \relative c {
  \partial 4 f,4 f'4. e8 d4 c4. d8 
  e c f4. e8 d4 
  c2 e4 f4. e8 d4 e4. fis8 
  g4 d4. c8 bes4 
  a2 d4 a'8 a, 
  a' g f e f f, f' e 
  d cis d4 bes c 
  d2 d8 c bes4. a8 g4 f8 g a bes 
  c4 d8 c bes4 c 
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