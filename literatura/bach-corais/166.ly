% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 166.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  ais g fis g |
  % 3
  a2 ais4 ais |
  % 4
  a ais c a |
  % 5
  ais2 a4 ais |
  % 6
  a g g fis |
  % 7
  g2. g4 |
  % 8
  ais g fis g |
  % 9
  a2 ais4 ais |
  % 10
  a ais c a |
  % 11
  ais2 a4 ais |
  % 12
  a g g fis |
  % 13
  g2. ais4 |
  % 14
  ais ais a ais |
  % 15
  g2 fis4 ais |
  % 16
  ais ais a ais |
  % 17
  g2 fis4 g |
  % 18
  a8 b c4 c b |
  % 19
  c a ais a |
  % 20
  g fis g2 |
  % 21
  
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
  g d d8 c ais4 |
  % 3
  dis d d g4. fis8 g4. e8 d fis |
  % 5
  d4 e fis g |
  % 6
  g8 fis e4 d2 |
  % 7
  d2. d4 |
  % 8
  g d d8 c ais4 |
  % 9
  dis d d g4. fis8 g4. e8 d fis |
  % 11
  d4 e fis g |
  % 12
  g8 fis e4 d2 |
  % 13
  d2. g4 |
  % 14
  g g4. f8 f4. dis16 d c4 d d |
  % 16
  e8 f g4 g f4. dis16 d dis4 d g |
  % 18
  f g8 gis g4 g |
  % 19
  g g fis8 g a4 |
  % 20
  d,8 dis d4 d2 |
  % 21
  
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
  d ais a g |
  % 3
  g4. fis8 g4 d' |
  % 4
  d d e8 c d c |
  % 5
  ais a g4 d' d |
  % 6
  dis8 a ais4. a16 g a4 |
  % 7
  ais2. ais4 |
  % 8
  d ais a g |
  % 9
  g4. fis8 g4 d' |
  % 10
  d d e8 c d c |
  % 11
  ais a g4 d' d |
  % 12
  dis8 a ais4. a16 g a4 |
  % 13
  ais2. d4 |
  % 14
  d d d d4. c16 ais a8 g a4 g8 a |
  % 16
  ais d c4 c d |
  % 17
  ais a a c |
  % 18
  c8 d dis4 d8 c d4 |
  % 19
  dis e d4. c8 |
  % 20
  ais4 a8 c b2 |
  % 21
  
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
  s2. g4 |
  % 2
  g8 a ais c d4 dis8 d |
  % 3
  c4 d g, g' |
  % 4
  d g8 f e a fis d |
  % 5
  g4 cis, d g, |
  % 6
  c cis d d, |
  % 7
  g2. g4 |
  % 8
  g8 a ais c d4 dis8 d |
  % 9
  c4 d g, g' |
  % 10
  d g8 f e a fis d |
  % 11
  g4 cis, d g, |
  % 12
  c cis d d, |
  % 13
  g2. g4 |
  % 14
  g8 a ais c d4 ais |
  % 15
  dis2 d4 g4. f8 e c f dis d ais |
  % 17
  dis d c a d4 e |
  % 18
  f dis8 f g4 g, |
  % 19
  c cis d8 e fis4 |
  % 20
  g8 c, d4 g,2 |
  % 21
  
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
