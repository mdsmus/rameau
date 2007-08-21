% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 030600b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key f \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 f'4 f4. g8 a ais c2 |
  % 3
  g4 a2 b4 |
  % 4
  c2 ais4 a4. g8 a ais c2 |
  % 6
  ais4 a2 g4 |
  % 7
  a2 a4 c2 ais4 a2 |
  % 9
  g4 f2 e4 |
  % 10
  f2 f4 g8 f |
  % 11
  g a ais4 a2 |
  % 12
  g4 f2 e4 |
  % 13
  f2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 c'4 c |
  % 2
  d8 e f2 e8 f |
  % 3
  g4. e8 f2. e4 g2 |
  % 5
  f g8 f g a4 g f16 e f4. e16 d |
  % 7
  cis2 d4 e4. f8 g2 f4 |
  % 9
  e2 d4 c8 ais |
  % 10
  a2 d4 d |
  % 11
  e8 f d e f2 |
  % 12
  e d4 c |
  % 13
  c2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2 a'4 a8 ais |
  % 2
  a g f4 g2 |
  % 3
  c4 c2 d4 |
  % 4
  g,2 c4 c8 a |
  % 5
  d2 c8 d e4 |
  % 6
  d d a d, |
  % 7
  e2 f4 a |
  % 8
  c8*5 a8 d c |
  % 9
  ais4 a8 f ais a g4 |
  % 10
  f2 a4 g |
  % 11
  c d8 g, a ais c4. ais8 a4 ais8 a g ais |
  % 13
  a2. 
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
  s2 f,4 f'4. e8 d4 c4. d8 |
  % 3
  e c f4. e8 d4 |
  % 4
  c2 e4 f4. e8 d4 e4. fis8 |
  % 6
  g4 d4. c8 ais4 |
  % 7
  a2 d4 a'8 a, |
  % 8
  a' g f e f f, f' e |
  % 9
  d cis d4 ais c |
  % 10
  d2 d8 c ais4. a8 g4 f8 g a ais |
  % 12
  c4 d8 c ais4 c |
  % 13
  f,2. 
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
