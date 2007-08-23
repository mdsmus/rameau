% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 297.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d''4 d a ais |
  % 2
  c ais8 a a4 g |
  % 3
  ais ais a g |
  % 4
  fis g a2 |
  % 5
  d4 d a ais |
  % 6
  c ais8 a a4 g |
  % 7
  ais ais a g |
  % 8
  fis g a2 |
  % 9
  a4 ais c a |
  % 10
  ais a8 g g4 f |
  % 11
  ais c d d |
  % 12
  dis d8 c c4 ais |
  % 13
  d d c d |
  % 14
  ais c d2 |
  % 15
  d4 d c ais |
  % 16
  a a g2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''4 g a g |
  % 2
  g g fis d |
  % 3
  d dis dis8 d d c |
  % 4
  c4 d d2 |
  % 5
  d4 g fis g |
  % 6
  g g fis d |
  % 7
  d dis dis8 d d c |
  % 8
  c4 d d2 |
  % 9
  fis4 g g f |
  % 10
  f f e c |
  % 11
  f g8 a ais4 ais |
  % 12
  ais ais a f |
  % 13
  f f f8 dis d4 |
  % 14
  d g fis2 |
  % 15
  g4 g a g |
  % 16
  g fis d2 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'8 c d4 d d |
  % 2
  c8 d dis4 d8 c ais4 |
  % 3
  g g g8 fis g4 |
  % 4
  a ais fis2 |
  % 5
  ais8 c d4 d d |
  % 6
  c8 d dis4 d8 c ais4 |
  % 7
  g g g8 fis g4 |
  % 8
  a ais fis2 |
  % 9
  d'4 d c c |
  % 10
  ais8 c d4 c8 ais a4 |
  % 11
  ais dis f f |
  % 12
  dis8 f g4 f8 dis d4 |
  % 13
  ais ais a a |
  % 14
  g8 ais a g a2 |
  % 15
  ais8 c d4 dis d |
  % 16
  dis d8 c b2 |
  % 17
  
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
  g'8 a ais4 fis g |
  % 2
  dis c d g, |
  % 3
  g'8 f dis d c d dis4 |
  % 4
  a g d'2 |
  % 5
  g,8 a ais c d4 g |
  % 6
  dis c d g, |
  % 7
  g'8 f dis d c d dis4 |
  % 8
  a g d'2 |
  % 9
  d4 g8 f e4 f8 dis |
  % 10
  d c ais4 c f |
  % 11
  d c ais ais'8 a |
  % 12
  g4 dis f ais, |
  % 13
  ais8 c d dis f4 fis |
  % 14
  g8 f dis4 d2 |
  % 15
  g8 a ais4 fis g |
  % 16
  c, d g,2 |
  % 17
  
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
