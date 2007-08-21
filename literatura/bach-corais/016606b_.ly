% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 016606b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'4 |
  % 2
  g a ais a |
  % 3
  g a fis2 |
  % 4
  d4 f f dis |
  % 5
  d g g fis |
  % 6
  g2. d4 |
  % 7
  g a ais a |
  % 8
  g a fis2 |
  % 9
  d4 f f dis |
  % 10
  d g g fis |
  % 11
  g2. a4 |
  % 12
  ais c d d |
  % 13
  c c ais d |
  % 14
  c ais a g8 a |
  % 15
  ais4 a g2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. ais'4 |
  % 2
  d d d d |
  % 3
  ais dis d2 |
  % 4
  a4 d d c |
  % 5
  ais ais8 c d4 d |
  % 6
  d2. ais4 |
  % 7
  d d d d |
  % 8
  ais dis d2 |
  % 9
  a4 d d c |
  % 10
  ais ais8 c d4 d |
  % 11
  d2. fis4 |
  % 12
  g f f g |
  % 13
  g f f f |
  % 14
  fis g g8 fis g4 |
  % 15
  g fis d2 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. g'4 |
  % 2
  ais a g fis |
  % 3
  g c a2 |
  % 4
  fis4 a ais f |
  % 5
  f g8 a ais4 a |
  % 6
  ais2. g4 |
  % 7
  ais a g fis |
  % 8
  g c a2 |
  % 9
  fis4 a ais f |
  % 10
  f g8 a ais4 a |
  % 11
  ais2. d4 |
  % 12
  d c ais ais |
  % 13
  ais a d ais |
  % 14
  c d dis8 d16 c ais8 c |
  % 15
  d4 d8 c b2 |
  % 16
  
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
  s2. g4 |
  % 2
  g' fis g d |
  % 3
  dis c d2 |
  % 4
  d,4 d' g, a |
  % 5
  ais dis d d |
  % 6
  g,2. g4 |
  % 7
  g' fis g d |
  % 8
  dis c d2 |
  % 9
  d,4 d' g, a |
  % 10
  ais dis d d |
  % 11
  g,2. d'4 |
  % 12
  g a ais g |
  % 13
  dis f ais, ais' |
  % 14
  a g c,8 d dis4 |
  % 15
  d8 c d4 g,2 |
  % 16
  
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
