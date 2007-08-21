% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 040600b_.mid
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
  d''4 a c d8 e |
  % 2
  f4 e d c |
  % 3
  ais2 a |
  % 4
  f'4 d c a8 ais |
  % 5
  c4. c8 a4 ais |
  % 6
  g2 f4 a |
  % 7
  g f e2 |
  % 8
  d a'4 c |
  % 9
  d a c a |
  % 10
  g f e2 |
  % 11
  d1 |
  % 12
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'8 g a4 e f8 g |
  % 2
  a4 a8. g16 f4 f |
  % 3
  d8 ais c4 c2 |
  % 4
  f4 f8 d g e c4 |
  % 5
  f e f8 a g f4 e16 d e4 c f4. e4 d cis16 b cis4 |
  % 8
  d2 c8 d e4 |
  % 9
  f8 g a f g e f4 |
  % 10
  e d d cis |
  % 11
  a1 |
  % 12
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  a'4 d c8 ais a4 |
  % 2
  d4. c4 ais a g8 f e f2 |
  % 4
  c'8 a d ais g4 f8 g |
  % 5
  a4 g f8 c' d4 |
  % 6
  c8 g c ais a4 c |
  % 7
  c8. ais16 a4 ais8 e a g |
  % 8
  f2 f4 g |
  % 9
  a d c c |
  % 10
  ais a8 ais ais g e a16 g |
  % 11
  fis1 |
  % 12
  
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
  d8 e f g a g f e |
  % 2
  d4 a' ais f |
  % 3
  g c, f2 |
  % 4
  a8 f ais4 e8 c f4. a,8 ais c d c ais4 |
  % 6
  c c, f f' |
  % 7
  c d g, a |
  % 8
  ais2 f'4 e |
  % 9
  d8 e f d e c f e |
  % 10
  d cis d ais g e a4 |
  % 11
  d,1 |
  % 12
  
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
