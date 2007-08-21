% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 001405b_.mid
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
  ais4 b c d |
  % 3
  c b c c |
  % 4
  ais8 a g a ais c d4 |
  % 5
  c8 ais c4 ais g8 a |
  % 6
  ais4 b c d |
  % 7
  c b c c |
  % 8
  ais8 a g a ais c d4 |
  % 9
  c8 ais c4 ais c |
  % 10
  d c8 ais a4 ais |
  % 11
  c8 ais a4 g g |
  % 12
  c b c d8 c |
  % 13
  ais a g4 f f |
  % 14
  ais c d c8 ais |
  % 15
  a g a4 g 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  g g g g |
  % 3
  dis d c g'8 a |
  % 4
  ais ais,4 c8 d dis f g |
  % 5
  a ais4 a8 f4 dis |
  % 6
  f g g g |
  % 7
  dis d c g'8 a |
  % 8
  ais ais,4 c8 d dis f g |
  % 9
  a ais4 a8 f4 f8 dis |
  % 10
  d e f g c,4 f |
  % 11
  dis a8 d d4 d |
  % 12
  g8 gis g f dis4 d8 fis |
  % 13
  g d4 cis8 d4 d |
  % 14
  d g fis8 d g4 |
  % 15
  g fis d 
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
  d4 d dis d |
  % 3
  g,8 g'4 f8 dis4 dis |
  % 4
  f g f8 dis d ais |
  % 5
  f'4 g8 f16 dis d4 ais8 c |
  % 6
  d4 d dis d |
  % 7
  g,8 g'4 f8 dis4 dis |
  % 8
  f g f8 dis d ais |
  % 9
  f'4 g8 f16 dis d4 c4. ais8 a g f4. g8 |
  % 11
  a g4 fis8 ais4 b |
  % 12
  c d g,8 a ais a |
  % 13
  g a ais a a4 ais |
  % 14
  ais8 a g4 a8 ais16 c d4 |
  % 15
  d4. c8 b4 
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
  s2. g'4 |
  % 2
  g8 gis g f dis d c b |
  % 3
  c dis g4 c, c |
  % 4
  d dis d8 c ais dis4 d8 dis f ais,4 dis |
  % 6
  g8 gis g f dis d c b |
  % 7
  c dis g4 c, c |
  % 8
  d dis d8 c ais dis4 d8 dis f ais,4 a |
  % 10
  ais8 c d e f dis d4 |
  % 11
  c d g, g'8 f |
  % 12
  dis4 d c g |
  % 13
  g'8 f e a, d4 ais'8 a |
  % 14
  g f dis d c ais a g |
  % 15
  d'2 g,4 
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
