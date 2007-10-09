
\version "2.10.33"

\header {
  title = "75 - Das walt' mein Gott, Vater, Sohn und heiliger Geist"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \minor
}

soprano = \relative c {
  \partial 4 f'4 
  f e f2 
  a4 c bes a 
  g g g c, 
  d8 e f4 f e 
  f2 s4 f8 g 
  a4 g a bes 
  c2 g4 g 
  g g g g 
  a2 a4 f 
  e d d cis 
  d1 
}


alto = \relative c {
  \partial 4 d'4 
  c c c2 
  f4 g f8 g g f4 e8 d4 c c 
  bes c8 d c4 c 
  c2 s4 c 
  f g f f 
  f2 e4 g8 f 
  e4 d e e 
  e8 d e cis d4 d8 c 
  bes4 a bes a 
  a1 
}


tenor = \relative c {
  \partial 4 a'4 
  a g16 a bes8 a2 
  c4 c d8 c c4 
  c g8 f4 e8 f4 
  f8 g a4 g8 a bes4 
  a2 s4 a8 bes 
  c4 c c d 
  c2 c4 d 
  c b c c 
  cis8 b a g f4 a 
  g4. f8 e4. g8 
  fis1 
}


baixo = \relative c {
  \partial 4 d4 
  a8 bes c4 f,2 
  f'4. e8 d e f4 
  c b c a 
  bes a8 bes c4 c, 
  f2 s4 f 
  f'4. e8 f e d4 
  a8 g a bes c4 b 
  c8 e g f e d c bes 
  a b cis a d4 d4. cis8 d f, g e a4 
  d,1 
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