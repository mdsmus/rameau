% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 009606b_.mid
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
  s2. f'4 |
  % 2
  f8 g a4 g f |
  % 3
  e2 d4 a' |
  % 4
  ais g a g |
  % 5
  f2. f4 |
  % 6
  f8 g a4 g f |
  % 7
  e2 d4 a' |
  % 8
  ais g a g |
  % 9
  f2. f8 g |
  % 10
  a4 a ais ais |
  % 11
  c2 g4 c |
  % 12
  a a g f |
  % 13
  e2 d4 a' |
  % 14
  ais g a g |
  % 15
  f1 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. c'4 |
  % 2
  d8 e f4 e d |
  % 3
  d cis a fis' |
  % 4
  g8 f e4 f e |
  % 5
  c2. c4 |
  % 6
  d8 e f4 e d |
  % 7
  d cis a fis' |
  % 8
  g8 f e4 f e |
  % 9
  c2. c4 |
  % 10
  f fis g g |
  % 11
  g f e g |
  % 12
  f dis d d |
  % 13
  d cis d fis |
  % 14
  g8 f e4 f e |
  % 15
  c1 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'4 |
  % 2
  ais c c8 ais a4 |
  % 3
  ais a8 g f4 d' |
  % 4
  d c c c8 ais |
  % 5
  a2. a4 |
  % 6
  ais c c8 ais a4 |
  % 7
  ais a8 g f4 d' |
  % 8
  d c c c8 ais |
  % 9
  a2. a4 |
  % 10
  d d d d |
  % 11
  c2 c4 c |
  % 12
  c c ais b |
  % 13
  e,8 f g4 f c' |
  % 14
  d c c c8 ais |
  % 15
  a1 |
  % 16
  
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
  ais, f' c d |
  % 3
  g, a d d |
  % 4
  g8 a ais4 a8 f c4 |
  % 5
  f,2. f'4 |
  % 6
  ais, f' c d |
  % 7
  g, a d d |
  % 8
  g8 a ais4 a8 f c4 |
  % 9
  f,2. f'8 e |
  % 10
  d4 c ais8 a g4 |
  % 11
  a4. ais8 c4 e |
  % 12
  f fis g gis |
  % 13
  a a, ais a |
  % 14
  g8 a ais4 a8 ais c4 |
  % 15
  f,1 |
  % 16
  
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
