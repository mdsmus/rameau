% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 311.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. c''4 |
  % 2
  a c d c |
  % 3
  ais2 a4 a |
  % 4
  g a g g |
  % 5
  f2. c'4 |
  % 6
  a c d c |
  % 7
  ais2 a4 a |
  % 8
  g a g g |
  % 9
  f2. g4 |
  % 10
  g a ais c8 ais |
  % 11
  a2 g4 g |
  % 12
  a8 b c4 d8 c b4 |
  % 13
  c2. c4 |
  % 14
  a c d c |
  % 15
  ais2 a4 a |
  % 16
  g a g g |
  % 17
  f1 |
  % 18
  
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
  f8 g a4 ais8 a g a |
  % 3
  ais a g4 f f |
  % 4
  e f f e |
  % 5
  c2. g'4 |
  % 6
  f8 g a4 ais8 a g a |
  % 7
  ais a g4 f f |
  % 8
  e f f e |
  % 9
  c2. c8 d |
  % 10
  e4 c d c |
  % 11
  c4. d8 e4 e |
  % 12
  f g a g |
  % 13
  g2. e4 |
  % 14
  c f f dis |
  % 15
  d4. e8 fis4 d |
  % 16
  e f f e |
  % 17
  c1 |
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
  s2. c'4 |
  % 2
  c dis f e |
  % 3
  f c c c |
  % 4
  c c c8 ais16 a ais4 |
  % 5
  a2. c4 |
  % 6
  c dis f e |
  % 7
  f c c c |
  % 8
  c c c8 ais16 a ais4 |
  % 9
  a2. g4 |
  % 10
  c f, ais8 a g4 |
  % 11
  a8 g f4 c' c |
  % 12
  c8 d e4 d4. e16 f |
  % 13
  e2. g,4 |
  % 14
  a a ais a |
  % 15
  ais8 c d4 d f |
  % 16
  c c c8 ais16 a ais4 |
  % 17
  a1 |
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
  s2. e4 |
  % 2
  f8 dis d c ais4 c |
  % 3
  d e f f |
  % 4
  ais8 a g f c'4 c, |
  % 5
  f2. e4 |
  % 6
  f8 dis d c ais4 c |
  % 7
  d e f f |
  % 8
  ais8 a g f c'4 c, |
  % 9
  f2. e8 d |
  % 10
  c c' ais a g f e4 |
  % 11
  f a,8 ais c4 c |
  % 12
  f8 e d c f4 g |
  % 13
  c,2. c4 |
  % 14
  f8 dis4 d16 c ais8 a' g fis |
  % 15
  g a ais c d4 d8 c |
  % 16
  ais a g f c'4 c, |
  % 17
  f1 |
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
