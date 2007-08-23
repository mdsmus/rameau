% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 256.mid
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
  ais''4 c d c |
  % 2
  ais a g f |
  % 3
  ais c d dis |
  % 4
  d c ais2 |
  % 5
  ais4 c d c |
  % 6
  ais a g f |
  % 7
  ais c d dis |
  % 8
  d c ais2 |
  % 9
  d4 dis f dis |
  % 10
  d c d2 |
  % 11
  f4 f g f |
  % 12
  dis d c2 |
  % 13
  d8 dis f4 dis d |
  % 14
  ais c d2 |
  % 15
  ais d4 f |
  % 16
  dis d c d |
  % 17
  c2 ais |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 f f4. e8 |
  % 2
  d4 c8 f f e f4 |
  % 3
  d f f f |
  % 4
  f f f2 |
  % 5
  f4 f f4. e8 |
  % 6
  d4 c8 f f e f4 |
  % 7
  d f f f |
  % 8
  f f f2 |
  % 9
  ais4 ais a g8 a |
  % 10
  ais4 a ais2 |
  % 11
  ais4 ais ais a |
  % 12
  g f f2 |
  % 13
  f4 ais8 gis g4 f |
  % 14
  g8 fis g4. fis16 e fis4 |
  % 15
  d2 g4 gis |
  % 16
  g d8 dis f4 f |
  % 17
  f2 f |
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
  d'4 a ais8 a g4 |
  % 2
  f8 g a8. ais16 c8 g a4 |
  % 3
  ais a ais c |
  % 4
  c8 ais ais a d2 |
  % 5
  d4 a ais8 a g4 |
  % 6
  f8 g a8. ais16 c8 g a4 |
  % 7
  ais a ais c |
  % 8
  c8 ais ais a d2 |
  % 9
  f4 g c,8 d dis4 |
  % 10
  f f f2 |
  % 11
  d4 d dis c |
  % 12
  ais ais a2 |
  % 13
  ais8 c d4. c4 ais a8 g a ais a16 g a4 |
  % 15
  g2 ais4 ais |
  % 16
  ais ais a ais4. a16 g a4 d2 |
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
  ais'4 f ais, c |
  % 2
  d8 e f4 c f, |
  % 3
  g' f8 dis d c ais a |
  % 4
  ais4 f ais2 |
  % 5
  ais'4 f ais, c |
  % 6
  d8 e f4 c f, |
  % 7
  g' f8 dis d c ais a |
  % 8
  ais4 f ais2 |
  % 9
  ais'8 a g4 f c |
  % 10
  d8 dis f4 ais,2 |
  % 11
  ais8 c d ais dis d dis f |
  % 12
  g a ais4 f2 |
  % 13
  ais4 ais, c d |
  % 14
  dis dis d2 |
  % 15
  g g8 f dis d |
  % 16
  dis f g f dis d c ais |
  % 17
  f'4 f, ais2 |
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
