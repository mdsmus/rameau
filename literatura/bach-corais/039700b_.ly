% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 039700b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  f'4. g8 a4 ais |
  % 2
  c c d e |
  % 3
  f2 f,4. g8 |
  % 4
  a4 ais c c |
  % 5
  ais a g2 |
  % 6
  a f4 f |
  % 7
  ais a g2 |
  % 8
  f1 |
  % 9
  f4. g8 a4 ais |
  % 10
  c c d e |
  % 11
  f2 f,4. g8 |
  % 12
  a4 ais c c |
  % 13
  ais a g2 |
  % 14
  a f4 f |
  % 15
  ais a g2 |
  % 16
  f1 |
  % 17
  c'2 g4 a |
  % 18
  ais ais a4. g8 |
  % 19
  g2 c |
  % 20
  d4 e f a, |
  % 21
  g4. g8 f2 |
  % 22
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  c'4 d8 e f4 f |
  % 2
  f8 g a4 a8 g ais a |
  % 3
  f2 d4. e8 |
  % 4
  f4 g fis8 g a4 |
  % 5
  a8 g g f c2 |
  % 6
  c d8 e f4 |
  % 7
  f8 e f4 f e |
  % 8
  c1 |
  % 9
  c4 d8 e f4 f |
  % 10
  f8 g a4 a8 g ais a |
  % 11
  f2 d4. e8 |
  % 12
  f4 g fis8 g a4 |
  % 13
  a8 g g f c2 |
  % 14
  c d8 e f4 |
  % 15
  f8 e f4 f e |
  % 16
  c1 |
  % 17
  f2 f8 e dis d |
  % 18
  d4 g g fis |
  % 19
  d2 f4. dis8 |
  % 20
  d f ais4 a8 g f4 |
  % 21
  f e c2 |
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
  a'4 ais c d |
  % 2
  c f f8 g g cis, |
  % 3
  d2 a4 ais |
  % 4
  f d' dis d |
  % 5
  d c8 d e2 |
  % 6
  f4 dis d d8 c |
  % 7
  ais c d4 d c8 ais |
  % 8
  a1 |
  % 9
  a4 ais c d |
  % 10
  c f f8 g g cis, |
  % 11
  d2 a4 ais |
  % 12
  f d' dis d |
  % 13
  d c8 d e2 |
  % 14
  f4 dis d d8 c |
  % 15
  ais c d4 d c8 ais |
  % 16
  a1 |
  % 17
  a8 ais c2 c4 |
  % 18
  ais ais dis d8. c16 |
  % 19
  ais2 a8 c f2 g4 f8 e d4 |
  % 21
  d c8 ais a2 |
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
  f,4 f'2 d4 |
  % 2
  a a' b cis8 a |
  % 3
  d2 d, |
  % 4
  d'4 c8 ais a g fis d |
  % 5
  g4 a8 ais c2 |
  % 6
  f, ais8 c ais a |
  % 7
  g4 d8 c ais4 c |
  % 8
  f,1 |
  % 9
  f4 f'2 d4 |
  % 10
  a a' b cis8 a |
  % 11
  d2 d, |
  % 12
  d'4 c8 ais a g fis d |
  % 13
  g4 a8 ais c2 |
  % 14
  f, ais8 c ais a |
  % 15
  g4 d8 c ais4 c |
  % 16
  f,1 |
  % 17
  a'4. ais8 c4 fis, |
  % 18
  g8 f dis d c4 d |
  % 19
  g,2 a |
  % 20
  ais8 ais' a g d' d, d' c |
  % 21
  ais g c c, f2 |
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
