% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024437b_.mid
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
  s2. a''4 |
  % 2
  f g a8 ais c4 |
  % 3
  ais2 a4 a8 ais |
  % 4
  c4 c g a8 g |
  % 5
  f2 e4 c |
  % 6
  f g a8 ais16 c ais8 a |
  % 7
  g2. a4 |
  % 8
  f g a8 ais c4 |
  % 9
  ais2 a4 a8 ais |
  % 10
  c4 c g a8 g |
  % 11
  f2 e4 c |
  % 12
  f g a g8 a16 ais |
  % 13
  a4 g f2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'4 |
  % 2
  d e f8 g a4 |
  % 3
  a g f f |
  % 4
  f8 e f g e d c4 |
  % 5
  c b c e |
  % 6
  d c c d |
  % 7
  e2. e4 |
  % 8
  d c c d |
  % 9
  d g fis f |
  % 10
  f f e8 d c4 |
  % 11
  c b c g |
  % 12
  c ais a8 c f4 |
  % 13
  f e c2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. c'4 |
  % 2
  d c8 ais a4. g8 |
  % 3
  f4 c' c c |
  % 4
  c c c c8 b |
  % 5
  a g f4 g ais |
  % 6
  a g f f |
  % 7
  c'2. a4 |
  % 8
  a g f8 g a4 |
  % 9
  g8 a ais c d4 d |
  % 10
  c8 ais c d e4 f |
  % 11
  f,8 a g f g4 e |
  % 12
  f8 c' d e f c ais f |
  % 13
  c'4. ais8 a2 |
  % 14
  
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
  s2. f4 |
  % 2
  ais a8 g f4. e8 |
  % 3
  d4 e f f8 g |
  % 4
  a4 a,8 ais c4 a |
  % 5
  d2 c4 c |
  % 6
  d e f ais, |
  % 7
  c2. cis4 |
  % 8
  d e f fis |
  % 9
  g g, d' d' |
  % 10
  a8 g a ais c4 f,8 e |
  % 11
  d c d4 c ais |
  % 12
  a g f d' |
  % 13
  c8 ais c4 f,2 |
  % 14
  
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
