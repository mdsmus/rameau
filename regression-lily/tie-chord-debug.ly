\header {

  texidoc = "Switching on debug-tie-scoring annotates the tie scoring
decisions made."
  
}

\version "2.10.0"

\paper
{
  ragged-right = ##t
  debug-tie-scoring = ##t
}

\relative g' {
  <a b e f> ~
  <a b e f>
}
