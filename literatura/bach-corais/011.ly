% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 011.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 100 
  \skip 1*21 
  \time 3/4 
  \skip 1*12 
  \time 4/4 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. e''4 |
  % 2
  e c d e |
  % 3
  f2 d4 d |
  % 4
  d c c b |
  % 5
  c2 s4 d |
  % 6
  d d d e |
  % 7
  c2 c4 c |
  % 8
  b c d d |
  % 9
  c2. e4 |
  % 10
  e c d e |
  % 11
  f2 d4 d |
  % 12
  d c c b |
  % 13
  c2 s4 d |
  % 14
  d d d e |
  % 15
  c2 c4 c |
  % 16
  b c d d |
  % 17
  c2. b4 |
  % 18
  b b b b |
  % 19
  c2 c4 b |
  % 20
  b b b b |
  % 21
  c2 c4 e |
  % 22
  e d c d2 e4 f2. e2 e4 |
  % 25
  d2 d4 cis2 cis4 d4*5 e4 |
  % 28
  e d c d2 e4 f2. e2 e4 |
  % 31
  d2 d4 cis2 cis4 d4*5 e4 |
  % 34
  e c d e |
  % 35
  f2 d4 d |
  % 36
  d c c b |
  % 37
  c2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. g''4 |
  % 2
  g g g g |
  % 3
  f8 g a4 ais a |
  % 4
  g g a g |
  % 5
  g2 s4 g8 fis |
  % 6
  g4. fis8 g4 g |
  % 7
  g f8 e f4 g |
  % 8
  g8 f e4 a g8 f |
  % 9
  e2. g4 |
  % 10
  g g g g |
  % 11
  f8 g a4 ais a |
  % 12
  g g a g |
  % 13
  g2 s4 g8 fis |
  % 14
  g4. fis8 g4 g |
  % 15
  g f8 e f4 g |
  % 16
  g8 f e4 a g8 f |
  % 17
  e2. g4 |
  % 18
  g a g gis |
  % 19
  a2 a4 a |
  % 20
  a g d g |
  % 21
  g2 g4 g |
  % 22
  g2 g4 g |
  % 23
  a b c b |
  % 24
  a g2 c4 |
  % 25
  b a g a |
  % 26
  ais g f2 |
  % 27
  ais4 a2 a4 |
  % 28
  b2 a4 a2 g4 a2 |
  % 30
  g4 g2 g4 |
  % 31
  f g a g |
  % 32
  a ais a ais |
  % 33
  g fis2 a4 |
  % 34
  g g g g |
  % 35
  a2 g4 g |
  % 36
  g g g8 a g f |
  % 37
  e2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. c'4 |
  % 2
  c8 d e4 d c |
  % 3
  c f f a, |
  % 4
  b c f8 e d4 |
  % 5
  e2 s4 b8 a |
  % 6
  b a b c d4 c8 ais |
  % 7
  ais4 a8 g a4 e' |
  % 8
  d c2 b4 |
  % 9
  g2. c4 |
  % 10
  c8 d e4 d c |
  % 11
  c f f a, |
  % 12
  b c f8 e d4 |
  % 13
  e2 s4 b8 a |
  % 14
  b a b c d4 c8 ais |
  % 15
  ais4 a8 g a4 e' |
  % 16
  d c2 b4 |
  % 17
  g2. d'4 |
  % 18
  d8 e fis4 e e |
  % 19
  e2 e4 f |
  % 20
  f e8 f g4 f2 e8 d e4 c |
  % 22
  c d e d2 g4 c,2 |
  % 24
  d4 e2 g4 |
  % 25
  g f e f |
  % 26
  e2 d |
  % 27
  e4 f2 c4 |
  % 28
  b e2 a,4 |
  % 29
  b c2 b8 a |
  % 30
  b4 c2 a4 |
  % 31
  a2 d4 e2 e4 a, d |
  % 33
  ais a2 c4 |
  % 34
  c c b c |
  % 35
  c8 e d c b4 b |
  % 36
  b c8 d e4 d8 g, |
  % 37
  g2. 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. c4 |
  % 2
  c c' b ais |
  % 3
  a g8 f ais4 fis |
  % 4
  g8 f e4 f g |
  % 5
  c,2 s4 g |
  % 6
  g'8 fis g a b g c4 |
  % 7
  f,2 f4 e8 f |
  % 8
  g4 a8 g f4 g8 g, |
  % 9
  c2. g4 |
  % 10
  c c' b ais |
  % 11
  a g8 f ais4 fis |
  % 12
  g8 f e4 f g |
  % 13
  c,2 s4 g |
  % 14
  g'8 fis g a b g c4 |
  % 15
  f,2 f4 e8 f |
  % 16
  g4 a8 g f4 g8 g, |
  % 17
  c2. g4 |
  % 18
  g'8 fis e dis e d c b |
  % 19
  a2 a4 d |
  % 20
  e8 f g a g f e d |
  % 21
  c2 c4 c |
  % 22
  c' b a b |
  % 23
  a g a2 |
  % 24
  b4 c2 c,4 |
  % 25
  g' a ais a |
  % 26
  g a ais a |
  % 27
  g d2 a'4 |
  % 28
  gis2 a4 f2 e4 d2 |
  % 30
  g4 c,2 cis4 |
  % 31
  d e f e |
  % 32
  f g fis g |
  % 33
  g, d'2 a8 b |
  % 34
  c d e c f g f e |
  % 35
  d e f d g a g f |
  % 36
  e d e f g f g g, |
  % 37
  <c, c' >2. 
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
  >>
}
