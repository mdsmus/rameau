% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 207.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d'4 d d a'2 a4 ais2 |
  % 3
  ais4 a2. |
  % 4
  f4 g a ais2. a4 g4. f8 f2 g4 |
  % 7
  a2 g4 g2 a4 f2 |
  % 9
  f4 e2. |
  % 10
  d4 e f g2. f4 e4. d8 d2. |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a'4 a d e |
  % 2
  d a'2 g8 fis |
  % 3
  g2 f |
  % 4
  f4. e8 dis d d4 |
  % 5
  e8 f g4. f8 f4 |
  % 6
  e c2 e4 |
  % 7
  f2 e8 d cis d |
  % 8
  e4 e2 d8 cis |
  % 9
  d4 d cis2 |
  % 10
  d4 a d e4. d8 e4. d8 d4 |
  % 12
  cis a2. |
  % 13
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  f8 g a g a4. g8 |
  % 2
  f e d4 d'2 |
  % 3
  d4 d2. |
  % 4
  a8 d4 c8 c4 ais8 a |
  % 5
  g4 c c d |
  % 6
  c8. ais16 a2 c4 |
  % 7
  c2 c8 ais ais4 |
  % 8
  a8 b cis4 a a |
  % 9
  b e, a2 |
  % 10
  a4 a a ais |
  % 11
  a a a ais |
  % 12
  a8. g16 fis2. |
  % 13
  
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
  d8 e f e f d cis4 |
  % 2
  d fis, g8 a ais4 |
  % 3
  g d'2. |
  % 4
  d4 e fis g |
  % 5
  c,8 d e4 f ais, |
  % 6
  c f,2 c'4 |
  % 7
  f,8 g a ais c d e d |
  % 8
  cis4 a d8 e f4 |
  % 9
  gis, a2. |
  % 10
  f'8 e d cis d2 |
  % 11
  cis8 b cis a d4 g, |
  % 12
  a d,2. |
  % 13
  
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
