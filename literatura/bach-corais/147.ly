
\version "2.10.33"

\header {
  title = "147 - Wenn ich in Angst und Not mein' Augen heb empor"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key ees \major
}

soprano = \relative c {
  \partial 4 ees'4 
  bes' bes c d 
  ees2 s4 d 
  ees d c c 
  bes2 s4 bes 
  c bes aes g 
  f2 s4 g 
  ees f g8 aes bes4 
  aes2 g4 d' 
  ees d c c 
  bes2 s4 ees 
  d c bes c 
  bes aes g8 aes bes4 
  aes g f2 
  ees1 
}


alto = \relative c {
  \partial 4 bes'4 
  ees ees ees f 
  g2 s4 f 
  c' bes8 d, g4 f8 ees 
  d2 s4 ees 
  ees d ees8 bes bes4 
  bes2 s4 d4. c4 bes8 bes4 ees 
  ees8 f16 ees d4 ees f 
  g8 f f4 g f8 ees 
  d2 s4 g 
  g ees ees ees 
  f8 g4 f ees8 ees4 
  ees2 ees4 d 
  bes1 
}


tenor = \relative c {
  \partial 4 g'8 aes 
  bes c cis4 c8 bes aes4 
  bes2 s4 bes4. a8 bes2 a4 
  f2 s4 bes4. aes4 g f ees8 
  d2 s4 g 
  g f ees bes' 
  c bes bes d 
  c bes bes a 
  f2 s4 c'4. bes4 aes g8 g4 
  d'8 c c4 c bes 
  ees,8 f g ees c'4 bes8 aes 
  g1 
}


baixo = \relative c {
  \partial 4 ees8 f 
  g4 g aes8 g f4 
  ees2 s4 bes 
  c g' ees f 
  bes,2 s4 g 
  aes bes c8 d ees4 
  bes2 s4 b 
  c d ees g, 
  f bes ees, bes''4. a8 bes4 ees, f 
  bes,2 s4 c 
  g' aes ees c 
  d8 e f4 c g 
  c bes aes bes 
  ees,1 
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