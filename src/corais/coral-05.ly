\header {
  title = "Choral #05"
  composer = "Johann Sebastian Bach"
}

\relative c' {
\new StaffGroup <<
 <<

%% "SOPRANO"

  \new Staff {
    \clef soprano
    \relative c'' {
    \partial 4

    c
    c8 b a b c d e4
    d d c^\fermata c
    b a8 b c4 d
    b2 a4^\fermata d
    e e b8 c d4
    c c b^\fermata c
    d a8 b c4 b
    a a g^\fermata c
    b a8 b c4 d8 c
    b2 a4^\fermata

    \bar "|."
     }
  }



%% "CONTRALTO"
  \new Staff {
    \clef alto
    \relative c'' {
    \partial 4 
    
    a
    g f e8 d c4
    d8 e f4 f^\fermata fis
    g fis8 gis a4 a8 g
    f4 e8 d c4^\fermata g'
    g g d4. e8
    fis gis a4 gis^\fermata a
    a8 g fis4 e d8 e
    f4 f e^\fermata a
    g a gis8 b a g
    f4 e8 d cis4^\fermata

    \bar "|."
     }
  }

%% "TENOR"
  \new Staff {
    \clef tenor
    \relative c' {
    \partial 4

    e
    e8 d c4 c8 b a g
    a4 b c^\fermata d
    d d e a,
    a gis a^\fermata gis
    c g8 a b4 a8 b
    c d e4 e^\fermata e
    f f g,8 a b4
    c8 b c d e4^\fermata ees
    d d e a,
    a gis e^\fermata

    \bar "|."
     }
  }

%% "BAIXO"
  \new Staff {
    \clef bass
    \relative c' {
    \partial 4

    a
    e f8 g a b c4
    f, g c,^\fermata a'
    g d' a8 g f e
    d4 e a,^\fermata b
    c8 d e f g4 fis8 gis
    a b c d e4^\fermata a,8 g
    fis e d4 e8 fis g4
    a8 g a b c4^\fermata fis,
    g f e8 c f e
    d c e4 a,^\fermata

    \bar "|."
     }
  }

 >>
>>
}