% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 206.mid
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
  s2. ais''4 |
  % 2
  d4. c8 ais4 d |
  % 3
  c ais ais a |
  % 4
  ais2 s4 d |
  % 5
  f4. dis8 d4 d8 c |
  % 6
  ais a g4 a4. g8 |
  % 7
  fis4 d s4 a' |
  % 8
  c4. ais8 a4 ais |
  % 9
  ais a g4. g8 |
  % 10
  a2 s4 a |
  % 11
  ais c d d8 e16 f |
  % 12
  e4. d8 cis4 d |
  % 13
  d4. cis8 d4 fis, |
  % 14
  g a ais g8 a16 ais |
  % 15
  a4. g8 fis4 g |
  % 16
  g4. fis8 g2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. g''4 |
  % 2
  a8 g a4 g g |
  % 3
  g f dis8 d dis4 |
  % 4
  d2 s4 f |
  % 5
  f4. f8 f4 d |
  % 6
  d g8 f g4 dis |
  % 7
  d a s4 f' |
  % 8
  g8 f g4 f8 a g f |
  % 9
  e4 f8*5 e8 |
  % 10
  f2 s4 f |
  % 11
  f f f f |
  % 12
  ais8 a b4 a a |
  % 13
  a a a d, |
  % 14
  d d d g8 f |
  % 15
  dis d e4 d d |
  % 16
  d d d2 |
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
  s2. d'4 |
  % 2
  d d d ais |
  % 3
  c d g, f8 dis |
  % 4
  f2 s4 ais |
  % 5
  a4. a8 ais4 fis |
  % 6
  g8 a ais4 dis8 d c ais |
  % 7
  a4 fis s4 d' |
  % 8
  c c c d |
  % 9
  g, a8 ais c4. c8 |
  % 10
  c2 s4 c |
  % 11
  d c ais d |
  % 12
  g8 f e4 e f |
  % 13
  e8 d e4 fis a, |
  % 14
  ais a g ais |
  % 15
  c8 ais a4 a ais |
  % 16
  a8 g a4 b2 |
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
  fis4. fis8 g4 g8 f |
  % 3
  dis4 d c4. c8 |
  % 4
  ais2 s4 ais' |
  % 5
  a4. a8 ais4 fis |
  % 6
  g8 f dis d c4 c |
  % 7
  d d, s4 d' |
  % 8
  e4. e8 f4 ais, |
  % 9
  c f c4. c8 |
  % 10
  f,2 s4 f'8 dis |
  % 11
  d c ais a ais4 ais8 a |
  % 12
  g4 gis a d |
  % 13
  a2 d4 d8 c |
  % 14
  ais a g fis g4 dis'8 d |
  % 15
  c4 cis d8 c ais g |
  % 16
  d'2 g, |
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
