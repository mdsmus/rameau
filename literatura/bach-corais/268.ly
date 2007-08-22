% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 268.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. c''4 |
  % 2
  c b a g |
  % 3
  c d e e |
  % 4
  e8 d e4 e d |
  % 5
  c8 d d4 c c |
  % 6
  c b a g |
  % 7
  c d e e |
  % 8
  e8 d e4 e d |
  % 9
  c8 d d4 c c |
  % 10
  c8 d e4 d e |
  % 11
  c b a a |
  % 12
  d8 c b4 c8 b a4 |
  % 13
  g g c c |
  % 14
  d d e8 d e4 |
  % 15
  c c f f |
  % 16
  e8 d e4 d d |
  % 17
  e e f f |
  % 18
  g8 f16 e f8 g c,4 e |
  % 19
  d8 c b4 c8 b a4 |
  % 20
  g g c b |
  % 21
  a g d' e |
  % 22
  d e f e |
  % 23
  d c8 d e4 d |
  % 24
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
  a g g8 f e f |
  % 3
  g4 a8 g g4 g |
  % 4
  g8 a b4 a4. g8 |
  % 5
  g a g f e4 g |
  % 6
  a g g8 f e f |
  % 7
  g4 a8 g g4 g |
  % 8
  g8 a b4 a4. g8 |
  % 9
  g a g f e4 e |
  % 10
  f c' g8 f e4 |
  % 11
  e2 e4 e |
  % 12
  d d g8 e fis4 |
  % 13
  d d g8 f e4 |
  % 14
  a8 f g4 g8 f g4 |
  % 15
  f g f8 g a4 |
  % 16
  ais e f g |
  % 17
  g a a ais |
  % 18
  ais a8 g f4 g |
  % 19
  a g g8 e fis4 |
  % 20
  d d a' d,8 e |
  % 21
  f4 g a4. b16 c |
  % 22
  g4 b a g8 a |
  % 23
  b4 c2 b4 |
  % 24
  g2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. e'4 |
  % 2
  e e8 d c4 c |
  % 3
  c4. b8 c4 c8 d |
  % 4
  e f e d c4. b8 |
  % 5
  c4 b g e' |
  % 6
  e e8 d c4 c |
  % 7
  c4. b8 c4 c8 d |
  % 8
  e f e d c4. b8 |
  % 9
  c4 b g g |
  % 10
  a g8 a b4 b |
  % 11
  b8 a4 gis8 c4 c8 b |
  % 12
  a4 g g d'8 c |
  % 13
  b4 b8 a g4 c |
  % 14
  c b c ais |
  % 15
  a c d8 e f4 |
  % 16
  g cis, a b |
  % 17
  c c d d |
  % 18
  e8 d c ais a4 c8 b |
  % 19
  a4 d g, d'8 c |
  % 20
  b4 b e,8 fis g4 |
  % 21
  d' d8 c c b c4 |
  % 22
  b e8 d c d e f |
  % 23
  g f e f g4. f8 |
  % 24
  e2. 
}

trackD = <<

  \clef bass
  
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. c'8 b |
  % 2
  a4 e f c8 d |
  % 3
  e4 f8 g c,4 c |
  % 4
  c' gis a8 g f g |
  % 5
  e f g4 c, c'8 b |
  % 6
  a4 e f c8 d |
  % 7
  e4 f8 g c,4 c |
  % 8
  c' gis a8 g f g |
  % 9
  e f g4 c, c |
  % 10
  f e8 f g4 gis |
  % 11
  a e a, a'8 g |
  % 12
  fis4 g8 fis e c d4 |
  % 13
  g, g'8 f e4 a8 g |
  % 14
  f d g4 c,4. d16 e |
  % 15
  f4 e d d' |
  % 16
  g,8 ais a4 d, g |
  % 17
  c8 b a g f e d4 |
  % 18
  c d8 e f4 c' |
  % 19
  fis, g e8 c d4 |
  % 20
  g, g a b8 c |
  % 21
  d4 e f fis |
  % 22
  g gis a8 b c4 |
  % 23
  f,8 g a4 g8 f g4 |
  % 24
  c,2. 
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
