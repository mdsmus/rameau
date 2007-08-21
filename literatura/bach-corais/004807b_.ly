% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 004807b_.mid
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
  s2. g''4 |
  % 2
  g fis g a |
  % 3
  ais a g g |
  % 4
  a a d c |
  % 5
  ais2 a4 g |
  % 6
  g fis g a |
  % 7
  ais a g g |
  % 8
  a a d c |
  % 9
  ais2 a4 d |
  % 10
  c ais a c |
  % 11
  ais a g ais |
  % 12
  a g f8 dis d e |
  % 13
  f4 g a g8 a |
  % 14
  ais4 c d4. c8 |
  % 15
  ais4 c8 ais a2 |
  % 16
  g1 |
  % 17
  
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
  dis d d c |
  % 3
  ais8 c d c ais4 d8 e |
  % 4
  f4 f ais4. a8 |
  % 5
  a g16 fis g4 fis d |
  % 6
  dis d d c |
  % 7
  ais8 c d c ais4 d8 e |
  % 8
  f4 f ais4. a8 |
  % 9
  a g16 fis g4 fis d8 dis |
  % 10
  f4. e8 f4 g |
  % 11
  g fis d e |
  % 12
  f e8 d cis4 d |
  % 13
  d c c c |
  % 14
  d dis d8 fis g a |
  % 15
  ais a g2 fis4 |
  % 16
  d1 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. ais'4 |
  % 2
  a a g d' |
  % 3
  d8 e fis4 g ais, |
  % 4
  c d8 dis f4 c8 d |
  % 5
  g, d d'4 d ais |
  % 6
  a a g d' |
  % 7
  d8 e fis4 g ais, |
  % 8
  c d8 dis f4 c8 d |
  % 9
  g, d d'4 d ais |
  % 10
  a ais c c |
  % 11
  d d8 c ais4 c |
  % 12
  c ais a8 g f4 |
  % 13
  ais a8 g f4 g |
  % 14
  f g8 a ais4. a8 |
  % 15
  d4 c8 d dis4 d8 c |
  % 16
  b1 |
  % 17
  
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
  c, d e fis |
  % 3
  g d g, g' |
  % 4
  f8 dis d c ais d e fis |
  % 5
  g a ais c d4 dis, |
  % 6
  c d e fis |
  % 7
  g d g, g' |
  % 8
  f8 dis d c ais d e fis |
  % 9
  g a ais c d4 f,8 g |
  % 10
  a4 g f dis |
  % 11
  d8 c d4 g, c |
  % 12
  f, g a ais8 c |
  % 13
  d4 e f dis |
  % 14
  d c ais8 d e fis |
  % 15
  g f dis d c4 d |
  % 16
  g,1 |
  % 17
  
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
