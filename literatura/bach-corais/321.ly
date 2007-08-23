% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 321.mid
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
  s2. g''8 a |
  % 2
  ais4 a g g |
  % 3
  ais a g d' |
  % 4
  c ais a a |
  % 5
  ais ais c c |
  % 6
  d d c ais |
  % 7
  a2 g4 d' |
  % 8
  c ais a d |
  % 9
  c ais a a |
  % 10
  ais ais c c |
  % 11
  d d c ais |
  % 12
  a2 g |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'8 fis |
  % 2
  g4 fis g dis |
  % 3
  e fis d d8 dis |
  % 4
  f dis d e fis4 fis |
  % 5
  g g g a |
  % 6
  ais ais a g |
  % 7
  g fis g f |
  % 8
  f d d f |
  % 9
  g f8 e f4 e |
  % 10
  fis g g a |
  % 11
  a8 c ais a g fis g4 |
  % 12
  g fis d2 |
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
  s2. ais'8 c |
  % 2
  d4 d8 c ais4 c |
  % 3
  g d' ais f8 g |
  % 4
  a4 ais8 c d4 d |
  % 5
  d dis dis8 d c4 |
  % 6
  f g dis d |
  % 7
  dis d8 c ais4 ais |
  % 8
  a g fis ais |
  % 9
  ais8 g c4 c cis |
  % 10
  d8 c ais a g g' f dis |
  % 11
  d4 d g,8 a ais g |
  % 12
  e'4 d8 c b2 |
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
  s2. ais'8 a |
  % 2
  g4 d dis c |
  % 3
  cis d g, ais |
  % 4
  f' g d d |
  % 5
  g8 f dis d c4 f8 dis |
  % 6
  d c ais a g fis g4 |
  % 7
  c d g, ais |
  % 8
  f' g d ais' |
  % 9
  e c f a |
  % 10
  d, dis e f |
  % 11
  fis g dis d |
  % 12
  cis d g,2 |
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
