% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 031300b_.mid
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
  s2. d''4 |
  % 2
  d d d c |
  % 3
  ais2 a4 d |
  % 4
  d8 dis f4 dis d |
  % 5
  c2 d4 d |
  % 6
  d d d c |
  % 7
  ais2 a4 d |
  % 8
  d8 dis f4 dis d |
  % 9
  c2 d4 d |
  % 10
  c ais a g |
  % 11
  a ais a d |
  % 12
  ais ais c d |
  % 13
  dis d c c |
  % 14
  d4. c8 b2 |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. g''8 fis |
  % 2
  g4 fis8 g a g4 fis8 |
  % 3
  g fis g4 fis f |
  % 4
  g f c'4. ais8 |
  % 5
  ais4 a ais g8 fis |
  % 6
  g4 fis8 g a g4 fis8 |
  % 7
  g fis g4 fis f |
  % 8
  g f c'4. ais8 |
  % 9
  ais4 a ais ais8 a |
  % 10
  g4 g4. fis8 g4 |
  % 11
  c,8 a' d, e fis4 a2 g8 f4 dis8 gis g |
  % 13
  g4 g a a8 g |
  % 14
  fis g4 fis8 g2 |
  % 15
  
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
  d c16 ais a4. ais8 c d |
  % 3
  d4 d d d8 c |
  % 4
  ais4 ais4. a16 g f8 f' |
  % 5
  g4 f f ais,8 c |
  % 6
  d c16 ais a4. ais8 c d |
  % 7
  d4 d d d8 c |
  % 8
  ais4 ais4. a16 g f8 f' |
  % 9
  g4 f f f |
  % 10
  dis8 d e4 a,8 d16 c ais8 c16 ais |
  % 11
  a8 d16 c ais a g8 d'4 d |
  % 12
  d dis8 f g4 f8 d4 c8 d e fis a, d dis |
  % 14
  d c16 ais a8 d d2 |
  % 15
  
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
  ais c d e fis g a d, |
  % 3
  g a ais c d4 ais8 a |
  % 4
  g f dis d c f ais, d |
  % 5
  dis c f4 ais, g8 a |
  % 6
  ais c d e fis g a d, |
  % 7
  g a ais c d4 ais8 a |
  % 8
  g f dis d c f ais, d |
  % 9
  dis c f4 ais, ais |
  % 10
  c4. cis8 d4 dis8 e |
  % 11
  f fis g cis, d4 fis |
  % 12
  g8 f dis d c4. b8 |
  % 13
  c c'4 ais8 a g fis g |
  % 14
  d2 g |
  % 15
  
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
