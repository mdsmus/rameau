% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 001306b_.mid
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
  s2. d''4 |
  % 2
  ais c d8 dis f4 |
  % 3
  dis2 d4 d8 dis |
  % 4
  f4 f c d |
  % 5
  ais2 c4 f, |
  % 6
  ais c d d8 dis |
  % 7
  c2. d4 |
  % 8
  ais c d8 dis f4 |
  % 9
  dis2 d4 d8 dis |
  % 10
  f4 f c d |
  % 11
  ais2 a4 f |
  % 12
  ais c d dis |
  % 13
  d c ais 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. ais''4 |
  % 2
  g a ais f |
  % 3
  g f f f8 dis |
  % 4
  d dis f g a4 a |
  % 5
  g2 c,4 d |
  % 6
  d f f f |
  % 7
  f2. a4 |
  % 8
  g f f g |
  % 9
  g2 g4 f |
  % 10
  f8 g a ais c ais a g |
  % 11
  f4 g f c |
  % 12
  f g8 a ais4 a8 g |
  % 13
  f4 f8 dis d4 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. f'4 |
  % 2
  dis dis f c |
  % 3
  ais c ais ais |
  % 4
  ais ais f' f |
  % 5
  f e a, a |
  % 6
  ais a ais ais |
  % 7
  a2. d4 |
  % 8
  d c ais8 c d4 |
  % 9
  d c b ais |
  % 10
  c8 ais a g f g a4 |
  % 11
  d c c a |
  % 12
  ais dis, f8 g a4 |
  % 13
  ais a f 
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
  dis8 d c4 ais a |
  % 3
  g a ais ais,8 c |
  % 4
  d c d dis f4 d |
  % 5
  g2 f4 d |
  % 6
  g f8 dis d c ais4 |
  % 7
  f'2. fis4 |
  % 8
  g a ais b |
  % 9
  c c, g' ais |
  % 10
  a8 g f g a4 f |
  % 11
  d e f dis |
  % 12
  d c ais c |
  % 13
  d8 dis f4 ais, 
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
