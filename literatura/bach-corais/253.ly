% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 253.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  ais a g d' |
  % 3
  d8 c ais4 a2 |
  % 4
  s4 c ais a |
  % 5
  g a8 ais16 c ais4 a |
  % 6
  g2. a4 |
  % 7
  ais a g d' |
  % 8
  d8 c ais4 a2 |
  % 9
  s4 c ais a |
  % 10
  g a8 ais16 c ais4 a |
  % 11
  g2. g4 |
  % 12
  a f e d8 e |
  % 13
  f4 g a2 |
  % 14
  s4 a g ais |
  % 15
  a ais g fis |
  % 16
  g2. g4 |
  % 17
  d' ais c d |
  % 18
  c ais a2 |
  % 19
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'4 |
  % 2
  fis8 g4 fis8 g a ais4 |
  % 3
  a4. g8 fis2 |
  % 4
  s4 fis g f |
  % 5
  dis8 f g4 g fis |
  % 6
  d2. fis4 |
  % 7
  g fis g8 a ais4 |
  % 8
  a4. g8 fis2 |
  % 9
  s4 fis g f |
  % 10
  dis8 f g4 g fis |
  % 11
  d2. d4 |
  % 12
  e d cis d |
  % 13
  c d8 e f2 |
  % 14
  s4 f f8 dis d g4 fis8 g4 g8 c, d4 |
  % 16
  d2. d4 |
  % 17
  d g f f8 g |
  % 18
  a4 g d2 |
  % 19
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. cis'4 |
  % 2
  d d d d |
  % 3
  d d d2 |
  % 4
  s4 d d d8 c |
  % 5
  ais4 dis d4. c8 |
  % 6
  ais2. d4 |
  % 7
  d d d d |
  % 8
  d d d2 |
  % 9
  s4 d d d8 c |
  % 10
  ais4 dis d4. c8 |
  % 11
  ais2. ais4 |
  % 12
  a a a8 g f g |
  % 13
  a4 ais c2 |
  % 14
  s4 c c ais8. c16 |
  % 15
  d4 d8 c ais a16 g a4 |
  % 16
  ais2. ais4 |
  % 17
  a d c ais |
  % 18
  dis e fis2 |
  % 19
  
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
  s2. a'4 |
  % 2
  d, d'8 c ais4 a8 g |
  % 3
  fis4 g d2 |
  % 4
  s4 a ais8 c d4 |
  % 5
  dis d8 c d2 |
  % 6
  g,2. d'4 |
  % 7
  g d'8 c ais4 a8 g |
  % 8
  fis4 g d2 |
  % 9
  s4 a ais8 c d4 |
  % 10
  dis d8 c d2 |
  % 11
  g,2. g'4 |
  % 12
  cis, d a ais |
  % 13
  a g f2 |
  % 14
  s4 f c' g |
  % 15
  d' ais dis d |
  % 16
  g,2. g'4 |
  % 17
  fis g a ais |
  % 18
  c cis d2 |
  % 19
  
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
