% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 041000b_.mid
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
  g''4 a ais ais |
  % 2
  c ais a a |
  % 3
  ais c d d |
  % 4
  dis d8 c c2 |
  % 5
  ais d4 c |
  % 6
  d d c ais |
  % 7
  c c c d |
  % 8
  dis dis d c8 d |
  % 9
  d2 c |
  % 10
  g4 a ais ais |
  % 11
  c c d d |
  % 12
  d d dis d |
  % 13
  c ais8 a a2 |
  % 14
  g1 |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 d d d |
  % 2
  g8 fis g4 g fis |
  % 3
  g f f f |
  % 4
  dis8 f g4 f2 |
  % 5
  f f4 f |
  % 6
  f ais ais8 a ais4 |
  % 7
  ais a a g |
  % 8
  g g g8 f dis4 |
  % 9
  gis g8 f dis2 |
  % 10
  dis4 d d8 dis f4 |
  % 11
  g f f f |
  % 12
  d g g8 c4 b8 |
  % 13
  c fis, g4 g fis |
  % 14
  d1 |
  % 15
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'4 a4. g16 fis g4 |
  % 2
  g8 a ais g d'4 d |
  % 3
  d c4. ais16 a ais4 |
  % 4
  ais ais ais a |
  % 5
  d2 ais4 c2 ais4 g'8 dis f4 |
  % 7
  f f f f |
  % 8
  dis8 d c4 b c |
  % 9
  c b g2 |
  % 10
  c4 c ais ais2 a4 ais ais |
  % 12
  a8 c c ais4 gis16 g f4 |
  % 13
  g8 a ais dis d4. c8 |
  % 14
  b1 |
  % 15
  
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
  g'4 fis g4. f8 |
  % 2
  dis4 d8 c d4 d |
  % 3
  g a ais4. a8 |
  % 4
  g4 dis f f, |
  % 5
  ais2 ais'4 a |
  % 6
  ais8 a g f dis c d ais |
  % 7
  f'4 f, f' b, |
  % 8
  c8 d dis f g4 gis8 g |
  % 9
  f4 g c,2 |
  % 10
  c'4 fis, g d |
  % 11
  dis f ais,2 |
  % 12
  fis4 g c d |
  % 13
  dis d8 c d4 d, |
  % 14
  g1 |
  % 15
  
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
