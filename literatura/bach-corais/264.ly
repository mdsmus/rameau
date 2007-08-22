% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 264.mid
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
  d''4 d8 dis f dis d4 |
  % 2
  c4. c8 c2 |
  % 3
  d4 dis8 d c4. ais8 |
  % 4
  ais2 a8 g a ais |
  % 5
  c ais a4 g4. g8 |
  % 6
  g2 a4 ais8 a |
  % 7
  g4. f8 f2 |
  % 8
  d'4 d8 dis f4 dis8 d |
  % 9
  c4. c8 c2 |
  % 10
  d4 dis8 d c4. ais8 |
  % 11
  ais2 dis8 d dis f |
  % 12
  d c d dis c4. ais8 |
  % 13
  ais1 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 g f ais8 a |
  % 2
  g4 f8 e f2 |
  % 3
  f4 dis8 f g4 f16 dis d dis |
  % 4
  d2 c4 f |
  % 5
  f f f8 e d4 |
  % 6
  e2 e4 d |
  % 7
  d c c2 |
  % 8
  c4 ais c f |
  % 9
  g8 f g4 f2 |
  % 10
  f4 dis8 f g4 a |
  % 11
  g2 g4 f |
  % 12
  f ais ais a |
  % 13
  f1 |
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
  ais'4 ais8 c d c ais4 |
  % 2
  ais a8 g a2 |
  % 3
  ais4 ais ais a |
  % 4
  f2 f4 c' |
  % 5
  c c c c8 b |
  % 6
  c2 a8 g f4 |
  % 7
  f e a2 |
  % 8
  a'4 g f ais, |
  % 9
  dis4. dis8 dis2 |
  % 10
  d8 c ais4 ais a8 d |
  % 11
  d2 c4 c |
  % 12
  c ais g' f8 dis |
  % 13
  d1 |
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
  ais'8 a g4 d g8 f |
  % 2
  e d c4 f2 |
  % 3
  ais8 a g f dis4 f |
  % 4
  ais,2 f'8 e f g |
  % 5
  a g a ais c4 g |
  % 6
  c,2 cis4 d8 c |
  % 7
  ais4 c f2 |
  % 8
  fis4 g a ais |
  % 9
  ais8 a ais g a2 |
  % 10
  ais8 a g f e4 fis |
  % 11
  g2 c8 ais a f |
  % 12
  ais a g f dis4 f |
  % 13
  ais,1 |
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
