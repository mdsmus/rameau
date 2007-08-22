% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 355.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  ais c d8 dis f4 |
  % 3
  dis2 d4 d8 dis |
  % 4
  f4 f c d |
  % 5
  ais2 a4 f |
  % 6
  ais c d d8 c |
  % 7
  c2. d4 |
  % 8
  ais c d8 dis f4 |
  % 9
  dis2 d4 d |
  % 10
  f f c d |
  % 11
  ais2 a4 f |
  % 12
  ais c d dis |
  % 13
  d8 c c4 ais2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'4 |
  % 2
  dis dis d8 c ais4 |
  % 3
  ais' f f g |
  % 4
  f8 dis f g a4 a |
  % 5
  g2 c,4 c |
  % 6
  f g8 a ais4 f |
  % 7
  f2. a4 |
  % 8
  g f f g |
  % 9
  g fis g g |
  % 10
  f f f f |
  % 11
  f e f a |
  % 12
  g f f ais8 a |
  % 13
  ais4 a f2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. ais'4 |
  % 2
  g a ais8 c d4 |
  % 3
  d c ais ais |
  % 4
  ais ais f' f |
  % 5
  f e f a, |
  % 6
  ais dis f8 a, ais4 |
  % 7
  a2. d4 |
  % 8
  d c ais8 c d4 |
  % 9
  c8 b a4 b ais |
  % 10
  a8 g a ais c4 ais8 c |
  % 11
  d4 c c d |
  % 12
  d c ais ais8 c |
  % 13
  d ais f' dis d2 |
  % 14
  
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
  s2. ais4 |
  % 2
  dis8 d c4 ais ais'8 a |
  % 3
  g4 a ais g |
  % 4
  d8 c d dis f4 d |
  % 5
  g2 f4 dis |
  % 6
  d c ais8 c d dis |
  % 7
  f2. fis4 |
  % 8
  g a ais b |
  % 9
  c c, g' g |
  % 10
  d' c8 ais a4 ais8 a |
  % 11
  g4 c f, d |
  % 12
  g a ais8 a g4 |
  % 13
  f8 dis f4 ais,2 |
  % 14
  
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
