
\version "2.10.33"

\header {
  title = "303 - Herr Christ, der einge Gottes-Söhn"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 f'4 
  f8 g a4 g f 
  e2 d4 a' 
  bes g a g 
  f2. f4 
  f8 g a4 g f 
  e2 d4 a' 
  bes g a g 
  f2. f8 g 
  a4 a bes bes 
  c2 g4 c 
  a a g f 
  e2 d4 a' 
  bes g a g 
  f1 
}


alto = \relative c {
  \partial 4 c'4 
  d8 e f4 e d 
  d cis a fis' 
  g8 f e4 f e 
  c2. c4 
  d8 e f4 e d 
  d cis a fis' 
  g8 f e4 f e 
  c2. c4 
  f fis g g 
  g f e g 
  f dis d d 
  d cis d fis 
  g8 f e4 f e 
  c1 
}


tenor = \relative c {
  \partial 4 a'4 
  bes c c8 bes a4 
  bes a8 g f4 d' 
  d c c c8 bes 
  a2. a4 
  bes c c8 bes a4 
  bes a8 g f4 d' 
  d c c c8 bes 
  a2. a4 
  d d d d 
  c2 c4 c 
  c c bes b 
  e,8 f g4 f c' 
  d c c c8 bes 
  a1 
}


baixo = \relative c {
  \partial 4 f4 
  bes, f' c d 
  g, a d d 
  g8 a bes4 a8 f c4 
  f,2. f'4 
  bes, f' c d 
  g, a d d 
  g8 a bes4 a8 f c4 
  f,2. f'8 e 
  d4 c bes8 a g4 
  a4. bes8 c4 e 
  f fis g gis 
  a a, bes a 
  g8 a bes4 a8 bes c4 
  f,1 
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