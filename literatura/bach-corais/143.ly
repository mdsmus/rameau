% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 143.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key f \major
  
  \tempo 4 = 112 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 f'4 f2 f4 a2 |
  % 3
  ais4 c2 d4 |
  % 4
  c2. f,2 f4 a2 |
  % 6
  ais4 c2 d4 |
  % 7
  c2. c2 d4 c2 |
  % 9
  ais4 a4. ais8 a g |
  % 10
  f2 f4 g2 g4 a2 |
  % 12
  g4 f2 g4 |
  % 13
  a2. c2 d4 c2 |
  % 15
  ais4 a4. ais8 a g |
  % 16
  f2 f4 g2 g4 a2 |
  % 18
  g4 f2 g4 |
  % 19
  a2. d,2 d4 e2 |
  % 21
  e4 f8 e f g a ais |
  % 22
  c2. a2 a4 g2 |
  % 24
  g4 f1. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 c'4 d2 d4 e2 |
  % 3
  e4 f2. |
  % 4
  f f4 |
  % 5
  e d c2 |
  % 6
  d4 c e g |
  % 7
  e2. f2 f4 e f |
  % 9
  g cis, d e |
  % 10
  d2 f4 f |
  % 11
  e8 d e4 f2 |
  % 12
  e4 f4. g8 f e |
  % 13
  f2. f2 f4 g f |
  % 15
  g g f e |
  % 16
  d2 f |
  % 17
  e8 d e4 f2 |
  % 18
  e a,4 d |
  % 19
  cis2. d2 d c8 d |
  % 21
  e2 d |
  % 22
  c2. c4 |
  % 23
  f8 e f4 f2 |
  % 24
  e4 f8 dis d c d ais |
  % 25
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
  s2 a'4 a2 ais4 c2 |
  % 3
  ais4 a2 ais4 |
  % 4
  a2. a2 ais4 a g |
  % 6
  f g c b |
  % 7
  g2. a2 ais4 c d |
  % 9
  e a, ais cis |
  % 10
  a2 c4 d |
  % 11
  ais c c2 |
  % 12
  c4 c a c |
  % 13
  c2. a2 ais4 g2 |
  % 15
  e'4 e d cis |
  % 16
  a2 c4 d |
  % 17
  ais c c2 |
  % 18
  c4 a2 ais4 |
  % 19
  e2. s8 f |
  % 20
  g a ais a g4 a8 ais |
  % 21
  c ais a4. g8 f4 |
  % 22
  g2. a4 |
  % 23
  ais c d ais |
  % 24
  c2 ais8 a ais g |
  % 25
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
  s2 f4 d |
  % 2
  c ais a ais8 a |
  % 3
  g a f f' dis d c ais |
  % 4
  f'2. d4 |
  % 5
  c ais f' e |
  % 6
  d e c g |
  % 7
  c2. f2 ais a4 |
  % 9
  g2 f4 e |
  % 10
  d2 a4 ais |
  % 11
  g c f,8 g a ais |
  % 12
  c ais a4 f c |
  % 13
  f2. f'4 |
  % 14
  e d e d |
  % 15
  c f8 g a4 a, |
  % 16
  d2 a4 ais |
  % 17
  g c f,8 g a ais |
  % 18
  c a d4 c ais |
  % 19
  a2. ais4 |
  % 20
  a g c ais |
  % 21
  a d8 c d e f d |
  % 22
  e2. f,4 |
  % 23
  g a ais g |
  % 24
  c a ais2 |
  % 25
  f2. 
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
