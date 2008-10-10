\version "2.10.0"
\include "violinoum.ly"
\include "violinodois.ly"
\include "viola.ly"
\include "violoncelo.ly"

%% comandos

%% para pizzicato use \pizz, para arco \arco
pizz = ^\markup{\italic{pizz.}}
arco = ^\markup{\italic{arco}}

%% global

global = {
  %% aqui as configurações globais (andamento, compasso, etc)
  \key c \minor
  \time 3/2
  \repeat volta 2 {
    s1*3/2*31
    \mark \default
    s1*3/2*26
    \mark \default
    s1*3/2*22
  }
  \alternative {
    {
      %% casa 1:
      s1*3/2*3
    }
    %% casa 2:
    {
      s1*3/2
    }
  }
  s1*3/2*3
  \bar "||"
  \key c \major
  s1*3/2*25
  \bar "||"
  \key e \major
  s1*3/2*21
  \bar "||"
  \key c \minor
  s1*3/2*40
  \mark \default
  s1*3/2*24
  \mark \default
  s1*3/2*26
  \bar "||"
  \time 2/2
  s1*2/2*38
  \bar "|."
}

%% score

\book {
  \header {
    title = "Quarteto n.1 em Dó menor"
    composer = "Johannes Brahms"
    opus = "Opus 51"
    copyright = "© Genos"
  }
  \score {
    \new StaffGroup <<
      \new Staff <<
        \set Staff.midiInstrument = "violin"
        \global
        \violinoum
      >>
      \new Staff <<
        \set Staff.midiInstrument = "violin"
        \global
        \violinodois
      >>
      \new Staff <<
        \set Staff.midiInstrument = "viola"
        \global
        \viola
      >>
      \new Staff <<
        \set Staff.midiInstrument = "cello"
        \global
        \violoncelo
      >>
    >>
%    \midi { }
    \layout { }
  }
}
