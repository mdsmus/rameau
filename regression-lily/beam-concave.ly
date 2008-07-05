\version "2.10.0"
\header{

  texidoc = "Fully concave beams should be horizontal. Informally spoken,
  concave refers to the shape of the notes that are opposite a
  beam. If an up-beam has high notes on its center stems, then we call
  it concave.

  If a beam is fails a test, the desired slope is printed next to it.

" 
}


resetMeasure = \set Score.measurePosition = #(ly:make-moment 0 1)

%% examples from Ross.
rossFourBeams =\relative c'' {
  \time 2/4
  c8[ e b c]
  b[ c d b]
  c[ f b, c]

  a[ f a f] a[ a' a, a']
  a[ d, e g] a[ f f g]
  c,[ b f' e]
  b[ e g, e']
  c'[ c, c c]
  c[ c c c']
  f,,[ b a g]
  f[g g e]
  a[ d, b' g]
}
rossThreeBeams = \relative c'' {
  \time 6/8
  e[ a, c] f[ d g]
  f,[ b g] a[ b f]
  d'[ c b a b e]
  c[ b a c b a]
  d,[ g a g f e ]
  a[ g f a g f]
  d'[ g, a b c d]
  f[ e d c b f']
}

rossBeams = \relative c'' {
  \rossFourBeams
  \rossThreeBeams
}

\layout{
  ragged-right = ##t
  #(define debug-beam-quanting #t)
}




#(define (<> x y) (not (= x  y)))
\new Voice {
  \override Beam #'positions = #(ly:make-simple-closure
				 (ly:make-simple-closure
				  (append
				   (list chain-grob-member-functions `(,cons 0 0))
				   (check-slope-callbacks =))))
  \rossBeams
  
}
