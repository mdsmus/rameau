% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 040100b_.mid
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
  s2. f'4 |
  % 2
  f f c' c |
  % 3
  d2 c4 c |
  % 4
  f, g a ais |
  % 5
  a g8 f f4 f |
  % 6
  f f c' c |
  % 7
  d2 c4 c |
  % 8
  f, g a ais |
  % 9
  a g8 f f4 a |
  % 10
  a a g a |
  % 11
  f8 e d4 c c' |
  % 12
  d c c a8 ais |
  % 13
  c4 ais a d |
  % 14
  c8 ais a4 g a |
  % 15
  c a g2 |
  % 16
  f1 |
  % 17
  
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
  c16 d dis8 dis d e c f e |
  % 3
  a4 g8 f e4 e4. d4 c8 c d16 e f4. e16 d e4 c c |
  % 6
  c16 d dis8 dis d e c f e |
  % 7
  a4 g8 f e4 e4. d4 c8 c d16 e f4. e16 d e4 c f |
  % 10
  f f f e |
  % 11
  d8 c4 b8 g4 dis' |
  % 12
  d8 e f g16 a g4 f |
  % 13
  a4. g4 fis8 g4 |
  % 14
  g f g4. f16 e |
  % 15
  f4 f2 e4 |
  % 16
  c1 |
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
  s2. a'8 ais |
  % 2
  c4. ais16 a g4 c2 b4 g a |
  % 4
  a g f4. d'8 |
  % 5
  c4 c8. ais16 a4 a8 ais |
  % 6
  c4. ais16 a g4 c2 b4 g a |
  % 8
  a g f4. d'8 |
  % 9
  c4 c8. ais16 a4 c |
  % 10
  c d d a |
  % 11
  a8 g a g16 f e4 f |
  % 12
  f8 g a ais c4. d8 |
  % 13
  dis4 d d d8 f |
  % 14
  e4. d4 c8 c4 |
  % 15
  c8 a f a d4 c8 ais |
  % 16
  a1 |
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
  s2. f,8 g |
  % 2
  a4 ais2 a8 g |
  % 3
  f4 g c a |
  % 4
  d e f8 e d ais |
  % 5
  c4 c, f f8 g |
  % 6
  a4 ais2 a8 g |
  % 7
  f4 g c a |
  % 8
  d e f8 e d ais |
  % 9
  c4 c, f f'4. e8 d c b4 cis |
  % 11
  d8 e f g c,4 a |
  % 12
  ais f'4. e8 f4 |
  % 13
  f8 fis g g, d'4 ais8 b |
  % 14
  c4 d e f |
  % 15
  a,8 ais16 c d8 c ais4 c |
  % 16
  f,1 |
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
