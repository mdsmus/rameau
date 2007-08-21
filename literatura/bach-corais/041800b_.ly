% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 041800b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. e'4 |
  % 2
  a b c d |
  % 3
  b4. a8 g4 g |
  % 4
  a a b b |
  % 5
  e,2. e4 |
  % 6
  a b c d8 c |
  % 7
  b4. a8 g4 g |
  % 8
  a a b b |
  % 9
  e,2. e'4 |
  % 10
  d c c b |
  % 11
  c2. b4 |
  % 12
  c d e e |
  % 13
  d4. c8 b4 b |
  % 14
  c b a a |
  % 15
  b4. a8 g4 g8 f |
  % 16
  e4 a a8 b gis4 |
  % 17
  a1 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. c'8 d |
  % 2
  e4 e e d |
  % 3
  d8 e fis4 e e |
  % 4
  e d d8 f e d |
  % 5
  c2. b4 |
  % 6
  e fis8 gis a4 a8 g |
  % 7
  f e d4 e d |
  % 8
  e e d8 e fis4 |
  % 9
  b,2. c4 |
  % 10
  a' a g g |
  % 11
  g2. g8 f |
  % 12
  e4 d c e |
  % 13
  a8 g a fis g4 g |
  % 14
  g8 f g e c4 c |
  % 15
  b8 cis dis4 e d |
  % 16
  d8 c c d e f e4 |
  % 17
  e1 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'8 b |
  % 2
  c4 b a a |
  % 3
  b2 b4 c |
  % 4
  c8 b a4 g8 a b4 |
  % 5
  a2. gis4 |
  % 6
  a d e a,4. gis8 a4 b b |
  % 8
  a8 b a g fis g a4 |
  % 9
  gis2. a4 |
  % 10
  a d d8 e f d |
  % 11
  e2. d4 |
  % 12
  c g' g c,8 b |
  % 13
  a4 d d d |
  % 14
  g, c c8 b a g |
  % 15
  fis g a4 b g |
  % 16
  g a8 b c d b4 |
  % 17
  cis1 |
  % 18
  
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
  s2. a4 |
  % 2
  a' gis a8 g fis4 |
  % 3
  g dis e c |
  % 4
  f fis g gis |
  % 5
  a2. e8 d |
  % 6
  c4 b a8 g' f e |
  % 7
  d e f4 e b |
  % 8
  c cis d dis |
  % 9
  e2. a8 g |
  % 10
  f4 fis g g, |
  % 11
  c2. g'4 |
  % 12
  a b c8 b a g |
  % 13
  fis e fis d g4 g8 f |
  % 14
  e d e c f g f e |
  % 15
  dis e fis4 e b |
  % 16
  c f e8 d e e, |
  % 17
  a1 |
  % 18
  
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
