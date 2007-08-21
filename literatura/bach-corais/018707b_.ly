% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 018707b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key g \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g8 a ais4 a2 g4 fis8 g g4. fis16 g a2. |
  % 4
  a8 ais ais4. a16 ais c2 d4 ais a2 g2. |
  % 7
  a4 a ais c2 ais4 a g2 f2. |
  % 10
  c'4 d e f |
  % 11
  e2 d |
  % 12
  cis4 d2. |
  % 13
  d2 d4 c8 ais |
  % 14
  a ais c4 d c |
  % 15
  ais a2. |
  % 16
  d2 d4 c |
  % 17
  d dis d c |
  % 18
  ais a2. |
  % 19
  a8 ais ais4. a16 ais c2 d4 ais a2 g2. |
  % 22
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 g8 fis g4 g |
  % 2
  fis g c, d |
  % 3
  cis d2. |
  % 4
  fis4 g2 g4 |
  % 5
  a fis d dis |
  % 6
  d d2. |
  % 7
  f4 f f e |
  % 8
  f g f2 |
  % 9
  e4 c2. |
  % 10
  a'4 g2 f4 |
  % 11
  ais a f ais |
  % 12
  a a2. |
  % 13
  ais2 ais4 a8 g |
  % 14
  f g a4 a fis |
  % 15
  g fis2. |
  % 16
  g4 a ais a |
  % 17
  g fis g fis |
  % 18
  g fis2. |
  % 19
  fis8 g g4. fis16 g a8 g |
  % 20
  fis g a4 g2 |
  % 21
  fis4 d2. |
  % 22
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'8 c d4 d dis |
  % 2
  d8 c ais4 a g8 a |
  % 3
  ais4 fis2. |
  % 4
  d'2 d4 c8 ais |
  % 5
  a g a4 g2 |
  % 6
  fis4 ais2. |
  % 7
  d4 d d c8 ais |
  % 8
  a4 g a d |
  % 9
  c a2. |
  % 10
  a4 b cis d2 cis4 d e2 fis2. |
  % 13
  f2 f4 f2 dis4 d2 |
  % 15
  d4 d2. |
  % 16
  d4 c ais c2 c4 ais a |
  % 18
  g d'2. |
  % 19
  d2 d4 c |
  % 20
  dis d d dis |
  % 21
  d8 c b2. |
  % 22
  
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
  g'8 a ais a g4 c, |
  % 2
  d dis a ais |
  % 3
  g d'2. |
  % 4
  d4 g f e |
  % 5
  fis d g c, |
  % 6
  d g,2. |
  % 7
  d'8 e f e d4 a' |
  % 8
  d, e f ais, |
  % 9
  c f,2. |
  % 10
  f'2 e4 d |
  % 11
  g8 f g a ais4 g |
  % 12
  a d,2. |
  % 13
  ais8 c d c ais4 f'2 f4 fis d |
  % 15
  g d2. |
  % 16
  ais'4 fis g a2 a,4 ais2 |
  % 18
  c4 d2. |
  % 19
  d'4 c ais a |
  % 20
  g fis g c, |
  % 21
  d g,2. |
  % 22
  
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
