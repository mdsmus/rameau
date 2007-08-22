% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 067.mid
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
  d8 dis f4 dis d8 c |
  % 14
  ais4 c d2 |
  % 15
  ais d8 dis f4 |
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
  f'4 f f f |
  % 2
  f8 e f4 e c |
  % 3
  g' f f dis |
  % 4
  f f8 dis d2 |
  % 5
  f4 f f f |
  % 6
  f8 e f4 e c |
  % 7
  g' f f dis |
  % 8
  f f8 dis d2 |
  % 9
  ais'4 a8 g f g16 gis g4 |
  % 10
  g g fis2 |
  % 11
  f4 ais ais a |
  % 12
  g f8 g a2 |
  % 13
  ais4 ais ais8 a ais a |
  % 14
  g f dis4 d8 e fis4 |
  % 15
  g2 g4 gis |
  % 16
  g8 a ais4 a8 g f4 |
  % 17
  f4. dis8 d2 |
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
  d'4 c ais a |
  % 2
  ais c c8 ais a4 |
  % 3
  d c ais8 a ais4 |
  % 4
  ais a f2 |
  % 5
  d'4 c ais a |
  % 6
  ais c c8 ais a4 |
  % 7
  d c ais8 a ais4 |
  % 8
  ais a f2 |
  % 9
  f'4 dis a8 b c4 |
  % 10
  ais dis a2 |
  % 11
  ais8 c d4 dis8 d c4 |
  % 12
  ais8 c d e f2 |
  % 13
  f8 dis d4 c f, |
  % 14
  g a ais a |
  % 15
  g2 ais4 b |
  % 16
  c g a ais |
  % 17
  ais a f2 |
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
  ais'4 a ais f |
  % 2
  g a8 ais c c, f4 |
  % 3
  g a ais g |
  % 4
  f8 dis f4 ais,2 |
  % 5
  ais'4 a ais f |
  % 6
  g a8 ais c c, f4 |
  % 7
  g a ais g |
  % 8
  f8 dis f4 ais,2 |
  % 9
  ais4 c d dis8 f |
  % 10
  g f dis4 d2 |
  % 11
  d4 ais dis f |
  % 12
  g8 a ais4 f2 |
  % 13
  ais4 ais, c d |
  % 14
  dis8 d c4 ais8 c d4 |
  % 15
  g,2 g'4 d |
  % 16
  dis e f8 dis d ais |
  % 17
  f'2 ais, |
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
