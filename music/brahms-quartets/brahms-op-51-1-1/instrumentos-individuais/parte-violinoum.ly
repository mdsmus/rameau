\version "2.12.0"

\include "global.ly"
\include "violinoum.ly"

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
    instrument = "Violino I"
  }
  \score {
    <<
      \set Score.skipBars = ##t
      \new Staff <<
        \global
        \violinoum
      >>
    >>
    \layout { }
  }
}
