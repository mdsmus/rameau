
\header { texidoc = "The dashes in a dashed bar line covers staff
  lines exactly. Dashed barlines between staves start and end on a
  half dash precisely." }

\version "2.10.0"

\paper {  ragged-right = ##t }

\relative \new StaffGroup <<
  \new Staff {
    c4 \bar "dashed" c }
  \new Staff {
    c c
  }
>>

