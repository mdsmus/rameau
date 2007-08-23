% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 164.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 ais''4 ais2 a4 g2 |
  % 3
  f4 ais c2 |
  % 4
  d d4 d2 d4 c2 |
  % 6
  d4 dis d2 |
  % 7
  c ais4 c2 d4 c2 |
  % 9
  ais4 g a2 |
  % 10
  ais f'4 d2 ais4 c2 |
  % 12
  dis4 d c2 |
  % 13
  ais2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 f'4 g2 f4 dis2 |
  % 3
  d4 d g f |
  % 4
  f2 a4 g2 g4 g f |
  % 6
  f f f2 |
  % 7
  f g4 f2 f8 ais g4 f8 dis |
  % 9
  d4 g g fis |
  % 10
  g2 f4 f2 g4 f2 |
  % 12
  f4 f g f8 dis |
  % 13
  d2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2 d'4 d2 d4 ais2 |
  % 3
  ais4 ais2 a4 |
  % 4
  ais2 a4 ais2 ais4 ais a |
  % 6
  ais c ais2 |
  % 7
  a d4 c2 ais4 ais a |
  % 9
  ais ais8 d dis4 d |
  % 10
  d2 c4 d2 d4 a2 |
  % 12
  a4 ais2 a4 |
  % 13
  f2. 
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
  s2 ais8 a g a |
  % 2
  ais c d ais dis f g a |
  % 3
  ais a g f dis d dis f |
  % 4
  ais,2 fis4 g8 d' |
  % 5
  g f dis d dis c f dis |
  % 6
  d c ais a ais c d dis |
  % 7
  f2 g4 a8 f |
  % 8
  g a ais g dis d dis f |
  % 9
  g d dis ais c a d d, |
  % 10
  g2 a'4 ais8 c |
  % 11
  ais a g f dis g f dis |
  % 12
  d c ais d dis c f f, |
  % 13
  ais2. 
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
