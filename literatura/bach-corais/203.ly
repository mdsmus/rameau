% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 203.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key d \minor
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g g g2 dis4 d2 |
  % 3
  d4 a'2 ais4 |
  % 4
  a2 g4 f2 e4 d2 |
  % 6
  d4 g2 g4 |
  % 7
  fis2 fis4 g2 g4 a2 |
  % 9
  a4 a2 a4 |
  % 10
  ais2 ais4 a2. d2 |
  % 12
  c4 ais2 a4 |
  % 13
  g a b c2 a4 ais2 |
  % 15
  a4 g2 fis4 |
  % 16
  g2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'8 c d4 b c |
  % 2
  b c8 a d c d4 |
  % 3
  d d2 d4 |
  % 4
  cis d e e8 cis |
  % 5
  d4. cis8 a2 |
  % 6
  a4 d2 d4 |
  % 7
  d dis d d |
  % 8
  c8 ais c4 fis,2 |
  % 9
  fis'4 fis2 fis4 |
  % 10
  g2 g4 g |
  % 11
  fis8 e fis4 fis8 g a2. g4 d |
  % 13
  g f2 g fis4 g f |
  % 15
  dis dis4. dis8 d4 |
  % 16
  d2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'8 a g4. f8 dis f |
  % 2
  g4 fis g8 a ais4 |
  % 3
  ais a2 g4 |
  % 4
  a2 a4 a |
  % 5
  ais8 a g a fis2 |
  % 6
  fis4 g8 a ais2 |
  % 7
  a8 ais c4 a g4. ais8 a g d'2 |
  % 9
  d4 d2 d4 |
  % 10
  d2 d4 d2. a4 d2 d d c4 d dis2 d4 d2 |
  % 15
  c4 c8 ais a4. c8 |
  % 16
  b2. 
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
  g8 a ais4 g c8 d |
  % 2
  dis4 c ais8 a g4 |
  % 3
  g' fis2 g f8 e d cis d4 |
  % 5
  g, a d,2 |
  % 6
  d'8 c ais4 g8 a ais c |
  % 7
  d4 a8 ais c a ais4 |
  % 8
  dis8 d dis4 d2 |
  % 9
  d,4 d'8 dis d c ais a |
  % 10
  g fis g a ais c d2. d8 e fis e |
  % 12
  fis d g fis g a g f |
  % 13
  dis d dis f dis d c2 d4 g8 g, a ais |
  % 15
  c d dis d c4 d |
  % 16
  g,2. 
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
