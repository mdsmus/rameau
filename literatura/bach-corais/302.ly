% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 302.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key d \minor
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 g''4 a2 g4 f2 |
  % 3
  d4 f2. |
  % 4
  g2 a4 ais2 d4 c2 |
  % 6
  ais4 a2. |
  % 7
  g2 g4 a2 g4 f2 |
  % 9
  d4 f2. |
  % 10
  g2 a4 ais2 d4 c2 |
  % 12
  ais4 a2. |
  % 13
  g2 c4 c2 c4 d2 |
  % 15
  c4 ais a g |
  % 16
  f2 f4 ais2 a4 ais2 |
  % 18
  c4 d2 c4 |
  % 19
  ais4. a8 g4 fis2 a4 ais2 |
  % 21
  d4 c2 ais4 |
  % 22
  a2. g 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 d'8 e f8*5 e8 d4 a |
  % 3
  ais c8 dis d c b4 |
  % 4
  e2 e8 fis g fis |
  % 5
  g8*7 fis8 |
  % 6
  g4 g2 fis4 |
  % 7
  d2 d8 e f8*5 e8 d4 a |
  % 9
  ais c8 dis d c b4 |
  % 10
  e2 e8 fis g fis |
  % 11
  g8*7 fis8 |
  % 12
  g4 g2 fis4 |
  % 13
  d2 g4. f4 e8 f4. e8 f g |
  % 15
  a g f8*5 e8 |
  % 16
  c2 d4 g2 a4. d,8 g4 |
  % 18
  a ais8 a g4. fis8 |
  % 19
  g4 d4. c8 d2 fis4 g2 |
  % 21
  f4 e8 d e fis g4 |
  % 22
  g2 fis4 d2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2 ais'4 c16*11 ais16 a4 f4. g8 a2 g8 f |
  % 4
  c'2 c4 d4. c8 ais a g fis g4 |
  % 6
  d' dis d8 a d c |
  % 7
  ais2 ais4 c16*11 ais16 a4 f4. g8 a2 g8 f |
  % 10
  c'2 c4 d4. c8 ais a g fis g4 |
  % 12
  d' dis d8 a d c |
  % 13
  ais2 c8 ais a4 |
  % 14
  ais c2 ais4 |
  % 15
  c d2 g,8 c |
  % 16
  a2 ais8 c d ais |
  % 17
  dis4. d8 d2 |
  % 18
  dis4 f dis8 d dis c |
  % 19
  d dis f f, g4 a2 d4. ais8 dis4 |
  % 21
  d8 ais g4 c8 a ais d |
  % 22
  dis d c ais c a b2. 
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
  s2 g'4 f2 c4 d2 |
  % 3
  ais4 a2 d4 |
  % 4
  c2 a4 g2 ais4 dis2 |
  % 6
  d4 c d d, |
  % 7
  g2 g'4 f2 c4 d2 |
  % 9
  ais4 a2 d4 |
  % 10
  c2 a4 g2 ais4 dis2 |
  % 12
  d4 c d d, |
  % 13
  g2 e'4 f |
  % 14
  g a ais2 |
  % 15
  f8 e d c ais4 c |
  % 16
  f,2 ais8 a g4 |
  % 17
  g' fis g f8 dis |
  % 18
  d c ais4 ais' a |
  % 19
  g f dis d2 d4 g4. dis8 |
  % 21
  ais'2 a4 g |
  % 22
  c, a d g,2. 
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
