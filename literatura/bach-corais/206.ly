
\version "2.10.33"

\header {
  title = "206 - So gibst du nun, mein Jesu, gute Nacht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 bes''4 
  d4. c8 bes4 d 
  c bes bes a 
  bes2 s4 d 
  f4. dis8 d4 d8 c 
  bes a g4 a4. g8 
  fis4 d s4 a' 
  c4. bes8 a4 bes 
  bes a g4. g8 
  a2 s4 a 
  bes c d d8 e16 f 
  e4. d8 cis4 d 
  d4. cis8 d4 fis, 
  g a bes g8 a16 bes 
  a4. g8 fis4 g 
  g4. fis8 g2 
}


alto = \relative c {
  \partial 4 g''4 
  a8 g a4 g g 
  g f dis8 d dis4 
  d2 s4 f 
  f4. f8 f4 d 
  d g8 f g4 dis 
  d a s4 f' 
  g8 f g4 f8 a g f 
  e4 f8*5 e8 
  f2 s4 f 
  f f f f 
  bes8 a b4 a a 
  a a a d, 
  d d d g8 f 
  dis d e4 d d 
  d d d2 
}


tenor = \relative c {
  \partial 4 d'4 
  d d d bes 
  c d g, f8 dis 
  f2 s4 bes 
  a4. a8 bes4 fis 
  g8 a bes4 dis8 d c bes 
  a4 fis s4 d' 
  c c c d 
  g, a8 bes c4. c8 
  c2 s4 c 
  d c bes d 
  g8 f e4 e f 
  e8 d e4 fis a, 
  bes a g bes 
  c8 bes a4 a bes 
  a8 g a4 b2 
}


baixo = \relative c {
  \partial 4 g'4 
  fis4. fis8 g4 g8 f 
  dis4 d c4. c8 
  bes2 s4 bes' 
  a4. a8 bes4 fis 
  g8 f dis d c4 c 
  d d, s4 d' 
  e4. e8 f4 bes, 
  c f c4. c8 
  f,2 s4 f'8 dis 
  d c bes a bes4 bes8 a 
  g4 gis a d 
  a2 d4 d8 c 
  bes a g fis g4 dis'8 d 
  c4 cis d8 c bes g 
  d'2 g, 
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