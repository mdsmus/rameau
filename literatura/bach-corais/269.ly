% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 269.mid
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
  d''4 d a ais |
  % 2
  c ais8 a a2 |
  % 3
  g ais4 ais |
  % 4
  a g fis g |
  % 5
  a1 |
  % 6
  d4 d a ais |
  % 7
  c ais8 a a2 |
  % 8
  g ais4 ais |
  % 9
  a g fis g |
  % 10
  a1 |
  % 11
  a4 ais c a |
  % 12
  ais a8 g g2 |
  % 13
  f ais4 c |
  % 14
  d ais dis d |
  % 15
  c2 ais |
  % 16
  a4 ais c d |
  % 17
  c ais a2 |
  % 18
  g4 a ais c8 ais |
  % 19
  a4. g8 g2 |
  % 20
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''8 fis g4 fis g |
  % 2
  g8 fis g4 g fis |
  % 3
  d2 g4 g8 f |
  % 4
  dis d d c c4 d |
  % 5
  d1 |
  % 6
  g8 fis g4 fis g |
  % 7
  g8 fis g4 g fis |
  % 8
  d2 g4 g8 f |
  % 9
  dis d d c c4 d |
  % 10
  d1 |
  % 11
  fis4 g g f |
  % 12
  f f f e |
  % 13
  c2 f4 f |
  % 14
  f8 dis f d g4 g |
  % 15
  g f8 dis d2 |
  % 16
  f4 dis8 d c4 f8 g |
  % 17
  a4 g fis2 |
  % 18
  g4 d g g |
  % 19
  g fis d2 |
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
  ais'8 c d4 d d |
  % 2
  c d dis d8 c |
  % 3
  ais2 d4 g, |
  % 4
  g8 fis g4 a8 c ais g |
  % 5
  fis1 |
  % 6
  ais8 c d4 d d |
  % 7
  c d dis d8 c |
  % 8
  ais2 d4 g, |
  % 9
  g8 fis g4 a8 c ais g |
  % 10
  fis1 |
  % 11
  d'4 d c c |
  % 12
  ais8 c d4 c4. ais8 |
  % 13
  a2 d4 a |
  % 14
  ais ais ais8 c d ais |
  % 15
  g dis' a4 ais2 |
  % 16
  c4 ais f'8 dis d4 |
  % 17
  d d d2 |
  % 18
  d4 d d c8 d |
  % 19
  dis c a d b2 |
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
  g'8 a ais c d4 c8 ais |
  % 2
  a4 g c, d |
  % 3
  g,2 g'8 f dis d |
  % 4
  c d dis4 a g |
  % 5
  d'1 |
  % 6
  g8 a ais c d4 c8 ais |
  % 7
  a4 g c, d |
  % 8
  g,2 g'8 f dis d |
  % 9
  c d dis4 a g |
  % 10
  d'1 |
  % 11
  d4 g8 f e4 f8 e |
  % 12
  d4 c8 ais c2 |
  % 13
  f, d'4 f |
  % 14
  ais8 c d ais g a ais g |
  % 15
  dis c f4 ais,2 |
  % 16
  f'4 g a ais8 a |
  % 17
  g fis g4 d2 |
  % 18
  ais'8 a g fis g f dis d |
  % 19
  c a d4 g,2 |
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
