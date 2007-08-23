% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 350.mid
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
  d''4 dis f f |
  % 2
  dis d c c |
  % 3
  d dis f d |
  % 4
  c4. c8 ais2 |
  % 5
  d4 dis f f |
  % 6
  dis d c c |
  % 7
  d dis f d |
  % 8
  c4. c8 ais2 |
  % 9
  c4 d dis dis |
  % 10
  d4. c8 c2 |
  % 11
  dis4 f g g |
  % 12
  f f8. dis16 dis2 |
  % 13
  d4 dis f ais, |
  % 14
  dis d c c |
  % 15
  d dis f d |
  % 16
  c c ais ais4*5 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  ais''4 ais a ais8 a |
  % 2
  g a ais4 a a |
  % 3
  ais a8 g f4 g |
  % 4
  g f f2 |
  % 5
  ais4 ais a ais8 a |
  % 6
  g a ais4 a a |
  % 7
  ais a8 g f4 g |
  % 8
  g f f2 |
  % 9
  a4 b c g |
  % 10
  g f8 dis dis2 |
  % 11
  g4 ais ais ais |
  % 12
  ais ais8 gis g2 |
  % 13
  g4 g f dis |
  % 14
  f f f f |
  % 15
  f g f f |
  % 16
  g f f f4*5 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  d'4 ais8 c d4 d |
  % 2
  dis f f f |
  % 3
  f dis d8 c ais4 |
  % 4
  ais a d2 |
  % 5
  d4 ais8 c d4 d |
  % 6
  dis f f f |
  % 7
  f dis d8 c ais4 |
  % 8
  ais a d2 |
  % 9
  f4 f, g c |
  % 10
  c8 a b4 g2 |
  % 11
  c4 d dis dis |
  % 12
  dis8 c d4 ais2 |
  % 13
  ais4 ais ais8 gis g4 |
  % 14
  c ais a a |
  % 15
  ais ais c ais |
  % 16
  ais a d d4*5 
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
  ais'4 g d g |
  % 2
  c, ais f' f |
  % 3
  ais, c d g8 f |
  % 4
  dis4 f ais,2 |
  % 5
  ais'4 g d g |
  % 6
  c, ais f' f |
  % 7
  ais, c d g8 f |
  % 8
  dis4 f ais,2 |
  % 9
  f'4 d c8 d dis f |
  % 10
  g4 g, c2 |
  % 11
  c'4 ais8 gis g f dis4 |
  % 12
  ais' ais, dis2 |
  % 13
  g4 f8 dis d4 dis |
  % 14
  a ais f' f |
  % 15
  ais a8 g a f ais4 |
  % 16
  dis, f ais, ais4*5 
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
