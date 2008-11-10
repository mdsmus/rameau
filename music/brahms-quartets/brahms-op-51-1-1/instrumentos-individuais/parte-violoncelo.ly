\version "2.10.0"

\include "global.ly"
\include "violoncelo.ly"

%% comandos

%% para pizzicato use \pizz, para arco \arco
pizz = ^\markup{\italic{pizz.}}
arco = ^\markup{\italic{arco}}

%% score

\book {
  \header {
    title = "Quarteto n.1 em Dó menor"
    composer = "Johannes Brahms"
    opus = "Opus 51"
    copyright = "© Genos"
    instrument = "Violoncelo"
  }
  \score {
    <<
      \set Score.skipBars = ##t
      \new Staff <<
        \global
        \violoncelo
      >>
    >>
    \layout { }
  }
}
