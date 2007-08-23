% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 229.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g g f8 dis d4 |
  % 3
  f g a g |
  % 4
  g fis g ais |
  % 5
  a g f d |
  % 6
  f g a g |
  % 7
  g fis g d' |
  % 8
  d d g, c |
  % 9
  c ais a g |
  % 10
  f2 d4 g |
  % 11
  g fis g fis |
  % 12
  g fis g a |
  % 13
  ais2 a4 ais |
  % 14
  a g f d8 dis |
  % 15
  f4 f g f |
  % 16
  dis2 d4 d' |
  % 17
  c ais a fis |
  % 18
  g a8 ais c4 ais |
  % 19
  a2 g |
  % 20
  
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
  g8 f dis d c4. ais8 |
  % 3
  d4 dis8 d dis4 d |
  % 4
  dis d d g |
  % 5
  g8 fis g dis c4 c8 ais16 c |
  % 6
  d8 c ais4 dis8 d e4 |
  % 7
  d d d g |
  % 8
  g4. fis8 g4 g |
  % 9
  d d4. c8 ais d |
  % 10
  c ais c4 ais d |
  % 11
  d8 dis d c ais c d4 |
  % 12
  d c d d |
  % 13
  d2 d4 d |
  % 14
  d8 c ais4 c ais |
  % 15
  a8 ais16 c d dis f4 dis d c16 b c4 b g'4. fis8 g4. fis16 e 
  d4. e8 fis g a4. g8 |
  % 19
  g fis16 e fis4 d2 |
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
  s2. ais'8 c |
  % 2
  d4 ais a8 g f4 |
  % 3
  ais ais c4. ais8 |
  % 4
  a16*5 ais16 c4 ais8 d4 |
  % 5
  d8. c16 ais4 c8 a f4 |
  % 6
  ais8 a g4 c ais4. a16 g a ais c8 ais4 ais8 c |
  % 8
  d c16 ais a8 ais16 c ais2 |
  % 9
  a4. g4 fis8 g ais |
  % 10
  a g a4 f ais8 c |
  % 11
  d c16 ais a4 g a |
  % 12
  g a ais a2 g4 fis g4. fis8 g dis c f f4 |
  % 15
  f8 g16 a ais4 ais ais8. a16 |
  % 16
  g2 g4 ais |
  % 17
  c d d a |
  % 18
  ais c8 d dis d d4 |
  % 19
  dis8 c a d b2 |
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
  s2. g8 a |
  % 2
  ais4 g a ais4. a8 g4. fis8 g4 |
  % 4
  c d g, g |
  % 5
  d' dis a8 f ais2 dis8 d c4. cis8 |
  % 7
  d2 g,4 g8 a |
  % 8
  ais c d4 dis e |
  % 9
  fis g d dis |
  % 10
  a f ais g8 a |
  % 11
  ais c d4 dis d8 c |
  % 12
  ais c ais a g a g fis |
  % 13
  g a ais g d'4 g, |
  % 14
  d' dis a ais8 c |
  % 15
  d4 d dis ais |
  % 16
  c8 d dis c g'4 g, |
  % 17
  a ais8 c d4. c8 |
  % 18
  ais4 a8 g fis4 g |
  % 19
  c d g,2 |
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
