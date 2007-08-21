% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 032000b_.mid
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
  f'4 a b c2. c4 ais |
  % 3
  c d c d |
  % 4
  e d e f2. a,2 |
  % 6
  ais4 c ais a |
  % 7
  g2 a4 ais |
  % 8
  a g f2 |
  % 9
  g4 a2 g4 |
  % 10
  a2 b4 c2. e2 |
  % 12
  f4 d2 f4 |
  % 13
  e2 d4 cis2 a4 d2 |
  % 15
  a4 ais a g |
  % 16
  f2 e8 f d2. fis2 |
  % 18
  fis4 g fis g |
  % 19
  a ais c ais |
  % 20
  a8 ais g4 c2 |
  % 21
  c4 c d e |
  % 22
  f e d e2 c4 f c |
  % 24
  a d2 c4 |
  % 25
  ais c a g2. c4 a |
  % 27
  f d' e f |
  % 28
  a,2 g8 f f2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  c'4 f f g2. f4 g |
  % 3
  f f2 f4 |
  % 4
  g8 a ais2 a2. f2 |
  % 6
  f4 f8 d e4 f |
  % 7
  e2 fis4 g |
  % 8
  f e f8 e d4 |
  % 9
  e f2 g4 |
  % 10
  f2 f4 g2. c2 |
  % 12
  c4 ais f ais |
  % 13
  ais2 ais4 a2 e4 a4. g8 |
  % 15
  f e d4. cis8 d4 |
  % 16
  d2 cis4 a2. c4 a |
  % 18
  d d c ais |
  % 19
  d2 d4 d |
  % 20
  c ais g' e |
  % 21
  f g f e |
  % 22
  d e8 f g4 g2 e4 f2 |
  % 24
  f4 f2 f4 |
  % 25
  g2 f4 f |
  % 26
  e2 f |
  % 27
  f4 f g a |
  % 28
  f2 e4 c2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  a'4 c d e2. c4 d |
  % 3
  c ais f ais |
  % 4
  ais8 c d4 c c2. d2 |
  % 6
  d4 c2 c4 |
  % 7
  c2 c4 d |
  % 8
  c c c ais8 a |
  % 9
  ais4 c2 c4 |
  % 10
  c2 d4 e2. g2 |
  % 12
  f4 f8 e d cis d4 |
  % 13
  g2 f4 e2 cis4 d2 |
  % 15
  c4 ais f'8 e d e |
  % 16
  f4 d a f2. a2 |
  % 18
  a4 ais c d |
  % 19
  a g fis g |
  % 20
  fis g g2 |
  % 21
  a4 c b c |
  % 22
  c2 b4 c2 g4 c2 |
  % 24
  c4 ais2 c4 |
  % 25
  d c c c2. c2 |
  % 27
  c4 ais ais c |
  % 28
  c d8 c ais c a2. 
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
  f,4 f' d c |
  % 2
  c' ais a g |
  % 3
  a ais a ais |
  % 4
  g2 c,4 f2 f,4 d' c |
  % 6
  ais a g f |
  % 7
  c' ais a g |
  % 8
  a ais a ais |
  % 9
  g f f' e |
  % 10
  f e d c2. c'4 ais |
  % 12
  a ais ais, a' |
  % 13
  g f g a |
  % 14
  a, g' f e |
  % 15
  d g a ais |
  % 16
  a g a d,2. a4 d |
  % 18
  c ais a g |
  % 19
  fis' e d g |
  % 20
  d g, e' c |
  % 21
  f e d c |
  % 22
  d g g, c2 c4 a2 |
  % 24
  f4 ais ais' a |
  % 25
  g e f c |
  % 26
  c' ais a f |
  % 27
  a ais g f4. a,8 ais4 c f,2. 
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
