% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 251.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  a a8 ais16 c ais8 g d'4. c16 ais a8 g fis4 a |
  % 4
  ais c8 d16 dis d8 ais f'4. e16 d c8 ais a4 d |
  % 6
  cis d e8 f16 g f8 e |
  % 7
  e2 d4 g, |
  % 8
  a a8 ais16 c ais8 g d'4. c16 ais a8 g fis4 a |
  % 10
  ais c8 d16 dis d8 ais f'4. e16 d c8 ais a4 d |
  % 12
  cis d e8 f16 g f8 e |
  % 13
  e2 d4 d |
  % 14
  ais8 a b d g dis c4 |
  % 15
  d8 f dis d dis4 a |
  % 16
  d g, c8 d16 dis d8 c |
  % 17
  ais4 a8 g g2 |
  % 18
  
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
  dis d d4. d8 |
  % 3
  g4 fis8 g d4 fis |
  % 4
  g f f4. f8 |
  % 5
  ais4 c8 e, f4 f |
  % 6
  g f e d |
  % 7
  e8 f g4 fis d |
  % 8
  dis d d4. d8 |
  % 9
  g4 fis8 g d4 fis |
  % 10
  g f f4. f8 |
  % 11
  ais4 c8 e, f4 f |
  % 12
  g f e d |
  % 13
  e8 f g4 fis a |
  % 14
  g g g4. dis8 |
  % 15
  gis4 g g fis |
  % 16
  g8 f e4 fis8 g a4 |
  % 17
  a8 g fis4 d2 |
  % 18
  
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
  c8 ais a4 g4. a8 |
  % 3
  ais4 c8 ais a4 d |
  % 4
  d c ais4. c8 |
  % 5
  d4 g,8 c c4 ais |
  % 6
  ais a a a8 d |
  % 7
  d cis16 b cis4 a ais |
  % 8
  c8 ais a4 g4. a8 |
  % 9
  ais4 c8 ais a4 d |
  % 10
  d c ais4. c8 |
  % 11
  d4 g,8 c c4 ais |
  % 12
  ais a a a8 d |
  % 13
  d cis16 b cis4 a d |
  % 14
  d d c4. c8 |
  % 15
  c4 b c d |
  % 16
  d c c8 ais a d |
  % 17
  d4 c8 ais ais2 |
  % 18
  
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
  g fis g4. f8 |
  % 3
  dis d dis c d4 d |
  % 4
  g a ais4. a8 |
  % 5
  g f e c f4 ais |
  % 6
  e f cis d |
  % 7
  a' a, d g |
  % 8
  g fis g4. f8 |
  % 9
  dis d dis c d4 d |
  % 10
  g a ais4. a8 |
  % 11
  g f e c f4 ais |
  % 12
  e f cis d |
  % 13
  a' a, d fis |
  % 14
  g f dis4. gis8 |
  % 15
  f d g4 c, c' |
  % 16
  ais8 a ais c a g fis4 |
  % 17
  g d g,2 |
  % 18
  
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
