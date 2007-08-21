% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 034900b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key f \major
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  f'4 f f ais2 g4 a2 |
  % 3
  b4 c2. |
  % 4
  a4 ais c d2 ais4 c2. ais |
  % 7
  c4 a8 ais c4 d2 c4 c4. ais8 |
  % 9
  a4 g2. |
  % 10
  c4 c c ais2 a4 a g2 f2. |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  c'4 c f2 |
  % 2
  e8 d e4 f2 |
  % 3
  f4 g2. |
  % 4
  f4 f g8 a ais2 ais2. |
  % 6
  a4 f2. |
  % 7
  g4 f f f2 f4 g8 f e4 |
  % 9
  f2 e |
  % 10
  f4 g8 ais a4 g |
  % 11
  f8 e f4 f2 |
  % 12
  e4 c2. |
  % 13
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  a'4 a a g8 a |
  % 2
  ais4 c c2 |
  % 3
  d4 e2. |
  % 4
  c4 d dis f2 f4 g8 f dis d |
  % 6
  c dis dis d16 c d2 |
  % 7
  c4 c c2 |
  % 8
  ais4 a g c |
  % 9
  c c2. |
  % 10
  c4 c f8 e d4 |
  % 11
  c c c d |
  % 12
  c8 ais a2. |
  % 13
  
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
  f4 f8 e d4 g |
  % 2
  g, c f e |
  % 3
  d c2. |
  % 4
  f8 dis d4 c ais |
  % 5
  c d dis c |
  % 6
  f ais,2. |
  % 7
  e'4 f a, ais8 c |
  % 8
  d e f4 e c |
  % 9
  f c2. |
  % 10
  a'4 e f g |
  % 11
  c, f a, ais |
  % 12
  c f,2. |
  % 13
  
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
