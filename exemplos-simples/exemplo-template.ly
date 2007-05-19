\header {
  file = "exemplo-template.ly"
  title = "título do exemplo - quando extraído da literatura"
  subtitle = "caso haja"
  instrument = "caso haja"
  composer = "compositor do exemplo - quando extraído da literatura"
  opus = "número do opus do exemplo - quando extraído da literatura"
  objetivo = "objetivo do exemplo: mostrar acordes de sexta aumentada"
  annotate = "serve de modelo para os exemplos que serão testados pelo programa"
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