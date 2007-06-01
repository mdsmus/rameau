\header {
  title = "título do exemplo - quando extraído da literatura"
  subtitle = "caso haja"
  instrument = "caso haja"
  composer = "compositor do exemplo - quando extraído da literatura"
  opus = "número do opus do exemplo - quando extraído da literatura"
  objetivo = "objetivo do exemplo: mostrar acordes de sexta aumentada"
}
global = {
  %% inserir informações globais importantes como time signature,
  %% anacruse, etc.
  \time 3/4
}
\score {
  <<
    \new Staff <<
      \global
      \relative {
        %% notas
      }
    >>
    \new Staff <<
      \global
      \relative {
        %% notas
      }
    >>
  >>
}