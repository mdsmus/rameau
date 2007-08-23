% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 101.mid
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
  s2. ais''4 |
  % 2
  ais8 c d4 c ais |
  % 3
  a2 g4 d' |
  % 4
  dis c d c |
  % 5
  ais2. ais4 |
  % 6
  ais8 c d4 c ais |
  % 7
  a2 g4 d' |
  % 8
  dis c d c |
  % 9
  ais2. ais8 c |
  % 10
  d4 d dis dis |
  % 11
  f dis8 d c4 f |
  % 12
  d d c ais |
  % 13
  a2 g4 d' |
  % 14
  dis c d c |
  % 15
  ais1 |
  % 16
  
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
  g8 a ais4 a g |
  % 3
  g fis g g |
  % 4
  g f f f |
  % 5
  f2. f4 |
  % 6
  g8 a ais4 a g |
  % 7
  g fis g g |
  % 8
  g f f f |
  % 9
  f2. f4 |
  % 10
  ais ais8 a g4 g |
  % 11
  f2 f4 f |
  % 12
  f f f8 dis d4 |
  % 13
  dis8 c d4 d g |
  % 14
  g f f8 g a4 |
  % 15
  f1 |
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
  s2. d'4 |
  % 2
  dis f f8 dis d4 |
  % 3
  dis d8 c ais4 ais |
  % 4
  ais a ais ais8 a |
  % 5
  d2. d4 |
  % 6
  dis f f8 dis d4 |
  % 7
  dis d8 c ais4 ais |
  % 8
  ais a ais ais8 a |
  % 9
  d2. d8 dis |
  % 10
  f4 g g8 f dis d |
  % 11
  c4 ais a c |
  % 12
  ais ais a a8 g |
  % 13
  g4 fis ais b |
  % 14
  c8 d dis a ais4 f'8 dis |
  % 15
  d1 |
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
  s2. ais'4 |
  % 2
  dis, ais f' g |
  % 3
  c, d dis g |
  % 4
  c, f8 dis d dis f4 |
  % 5
  ais,2. ais'4 |
  % 6
  dis, ais f' g |
  % 7
  c, d dis g |
  % 8
  c, f8 dis d dis f4 |
  % 9
  ais,2. ais4 |
  % 10
  ais'8 a g f dis d c ais |
  % 11
  a4 ais f a |
  % 12
  ais8 c d dis f fis g ais, |
  % 13
  c a d4 g, g' |
  % 14
  c8 ais a f ais dis, f f, |
  % 15
  ais1 |
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
