% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 004606bs.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 106 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  ais c d a8 b |
  % 3
  c2 s4 g |
  % 4
  g a ais c |
  % 5
  a2 s4 f |
  % 6
  f g a ais |
  % 7
  c2 s4 d |
  % 8
  ais8 c d4 c c |
  % 9
  ais2 s4 d |
  % 10
  d d c c |
  % 11
  ais ais a2 |
  % 12
  s4 a ais a |
  % 13
  g g f f |
  % 14
  e2 s4 g |
  % 15
  g a8 ais c4 ais |
  % 16
  a2 g |
  % 17
  s4 g g a8 b |
  % 18
  c4 ais a2 |
  % 19
  a1 |
  % 20
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'4 |
  % 2
  g f f f |
  % 3
  g2 s4 dis |
  % 4
  e fis g a |
  % 5
  fis2 s4 d |
  % 6
  d e f dis |
  % 7
  dis2 s4 d |
  % 8
  g8 a ais4 ais a |
  % 9
  f2 s4 f |
  % 10
  g g g d |
  % 11
  d e fis2 |
  % 12
  s4 fis g f |
  % 13
  f e d d |
  % 14
  c2 s4 d |
  % 15
  d8 c f4 g8 a d, g |
  % 16
  g4 fis d2 |
  % 17
  s4 d dis f |
  % 18
  g g g8 f e4 |
  % 19
  fis1 |
  % 20
  
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
  d c ais f' |
  % 3
  dis2 s4 c |
  % 4
  c c d dis |
  % 5
  d2 s4 a |
  % 6
  ais ais c ais |
  % 7
  f'2 s4 f |
  % 8
  dis f f c |
  % 9
  d2 s4 ais |
  % 10
  ais ais ais a |
  % 11
  a g a2 |
  % 12
  s4 d d c |
  % 13
  d g, a g |
  % 14
  g2 s4 g |
  % 15
  g d' c8 a ais g |
  % 16
  dis'4 a ais2 |
  % 17
  s4 b c f |
  % 18
  dis d cis8 d4 cis8 |
  % 19
  d1 |
  % 20
  
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
  s2. d4 |
  % 2
  g a ais d |
  % 3
  c2 s4 c |
  % 4
  ais a g c, |
  % 5
  d2 s4 d8 c |
  % 6
  ais ais' a g f4 g |
  % 7
  a2 s4 ais |
  % 8
  dis, d8 dis f4 f, |
  % 9
  ais2 s4 ais'8 a |
  % 10
  g4 f e fis |
  % 11
  g g, d'2 |
  % 12
  s4 d g, a |
  % 13
  b c c b |
  % 14
  c2 s4 ais |
  % 15
  dis d e8 fis g4 |
  % 16
  c, d g,2 |
  % 17
  s4 f' dis d |
  % 18
  c g a2 |
  % 19
  d1 |
  % 20
  
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
