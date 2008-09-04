
\version "2.10.33"

\header {
  title = "205 - Herr Gott, dich loben wir"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c' {
  \partial 4 e4 
  g a c a
  a2 r4 c
  c b a a
  g2. \repeat volta 2 { c4
  c c b a  %% 05
  b a a a
  a g a b
  c a g } \repeat volta 2 { e
  g a b b
  a2. } b4  %% 10
  b b8 c d4 a
  a g a b
  c a g \repeat volta 2 { c4
  c c b a
  b a a a  %% 15
  a g a b
  c a g } \repeat volta 2 { a
  a a g b
  b a a a
  a g a8 b c4  %% 20
  g g e } f
  d f e d
  e fis g g
  g g a4. f8
  g4 f e c  %% 25
  d f e d
  f d c g'
  g g a4. f8
  g4 f e f
  f f e d  %% 30
  f d c g'
  g g a4. f8
  g4 f e e8 f
  g4 a a a
  c a a a  %% 35
  a g a8 b c4
  g g e \repeat volta 2 { a
  a a g b
  b b a a
  a g a c  %% 40
  g g e } f8 e
  d4 f g a
  g f e f
  f g a g8 f
  g4 f e g  %% 45
  e c d2
  e1~
  e  
}


alto = \relative c' {
  \partial 4 b4
  e f~ f8 e d4
  c2 r4 e8 fis
  g a~ a g~ g fis16 e fis4
  d2. \repeat volta 2 { g4~
  g8 fis16 e fis8 a~ a g16 fis e8 d  %% 05
  d g~ g fis16 e fis4 e8 g~
  g f~ f e16 d c4 d16 e f8
  e16 fis g8~ g fis d4 } \repeat volta 2 { c4
  d e8 d16 c f e d8~ d e16 d
  c2. } g'8 a  %% 10
  g4 g g~ g8 f16 e
  f4. e16 d c8 d16 e f4
  e16 fis g8~ g fis d4 \repeat volta 2 { g8 f
  e fis g a~ a g~ g fis
  g fis e4 fis d  %% 15
  c16 a d8~ d c~ c d16 c b8 d
  g4. fis8 d4 } \repeat volta 2 { f
  e16 f g8~ g fis~ fis e16 fis g4
  g8 f g4~ g8 f c f16 e
  f4. e8 f4 f~  %% 20
  f8 e d4 c} c~
  c8 b c d~ d c d4~
  d8 c16 b c8 b16 a b4 d
  e8 f g e c f f16 e d cis
  d8 a a d~ d cis a4  %% 25
  g c8 d~ d c~ c b
  a16 b c8~ c b g4 c
  c8 d e4~ e8 d16 cis d4~
  d8 e~ e d~ d cis d4~
  d8 c b d~ d c~ c b  %% 30
  c4. b8 g4 c
  c8 d e d16 e f4 f
  e4. d8 cis4 c
  b8 c16 d e8 d c d16 e f4
  e~ e16 d c b c4 e~  %% 35
  e8 f g4 f g8 f
  e4 d c \repeat volta 2 { e
  f e8 d16 c b4 b8 c16 e
  e4~ e16 fis g8~ g fis f4
  f c c c8 d  %% 40
  e4 e16 cis d8~ d cis} d4
  a8 bes16 c d4~ d8 e~ e d~
  d cis d4 cis d
  d~ d8 e f e d4
  d d16 cis d8 cis4 d  %% 45
  c g a gis8 a
  b c d4 c2~
  c4 b8 a b2

}


tenor = \relative c {
  \partial 4 

}


baixo = \relative c {
  \partial 4 

}


\score {
  <<
    \new StaffGroup <<
      \override StaffGroup.SystemStartBracket #'style = #'line 
      \new Staff {
        <<
          \global
          \new Voice = "soprano" { \voiceOne \soprano }
          \new Voice = "alto" { \voiceTwo \alto }
        >>
      }
      \new Staff {
        <<
          \global
          \clef "bass"
          \new Voice = "tenor" {\voiceOne \tenor }
          \new Voice = "baixo" { \voiceTwo \baixo \bar "|."}
        >>
      }
    >>
  >>
  \layout {}
  \midi {}
}