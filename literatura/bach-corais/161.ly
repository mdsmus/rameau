% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 161.mid
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
  d'2 e4 f2 g4 a2 |
  % 3
  d4 cis2 cis4 |
  % 4
  d2 e4 f2. f,4 g4. g8 f2. |
  % 7
  d2 e4 f2 g4 a2 |
  % 9
  d4 cis2 cis4 |
  % 10
  d2 e4 f2. f,4 g4. g8 f2. |
  % 13
  g2 g4 a2 c4 ais2 |
  % 15
  g4 a2 a4 |
  % 16
  c2 c4 d2 f4 e d |
  % 18
  cis d2 d2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a'2 cis4 d2 e4 f4. g8 |
  % 3
  a4 a2 a4 |
  % 4
  a2 a4 a4. g8 f e f2 |
  % 6
  e4 c2. |
  % 7
  a2 cis4 d2 e4 f4. g8 |
  % 9
  a4 a2 a4 |
  % 10
  a2 a4 a4. g8 f e f2 |
  % 12
  e4 c2. |
  % 13
  e4 f g g8 f4 e8 f4 f e8 d |
  % 15
  e4 f2 f4 |
  % 16
  a2 a8 g f e |
  % 17
  f g a4 ais8 g f e |
  % 18
  e g fis2 fis4 |
  % 19
  f2 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  f8 g a4 g a2 ais4 c d8 e |
  % 3
  f4 e2 e4 |
  % 4
  f2 e4 d8 cis |
  % 5
  d e d c ais a d4 |
  % 6
  c8. ais16 a2. |
  % 7
  f8 g a4 g a2 ais4 c d8 e |
  % 9
  f4 e2 e4 |
  % 10
  f2 e4 d8 cis |
  % 11
  d e d c ais a d4 |
  % 12
  c8. ais16 a2. |
  % 13
  c2 c4 c4. ais8 a4 d2 |
  % 15
  c4 c2 c4 |
  % 16
  f2 f8 dis d2 c4 ais b |
  % 18
  a a2 a2. 
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
  d8 e f g f e d4 |
  % 2
  c8 ais a g f g f e |
  % 3
  d4 a'2 a4 |
  % 4
  d8 e f e d cis d8*7 c8 ais4 |
  % 6
  c f,2. |
  % 7
  d'8 e f g f e d4 |
  % 8
  c8 ais a g f g f e |
  % 9
  d4 a'2 a4 |
  % 10
  d8 e f e d cis d8*7 c8 ais4 |
  % 12
  c f,2. |
  % 13
  c'4 d e f |
  % 14
  g a g g, |
  % 15
  c f2 f4 |
  % 16
  f f,8 g a4 ais |
  % 17
  ais' a g gis |
  % 18
  a d,2 d2. 
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
