% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 015505b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  \tempo 4 = 100 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. c''4 |
  % 2
  c c c8 d dis4 |
  % 3
  d c ais c8 ais |
  % 4
  a g f g a4 b |
  % 5
  c8. d16 d4 c c |
  % 6
  c c c8 d dis4 |
  % 7
  d c ais c8 ais |
  % 8
  a g f g a4 b |
  % 9
  c8. d16 d4 c c |
  % 10
  f e d e |
  % 11
  f8 e d4 c c |
  % 12
  f c d a8 ais |
  % 13
  c4 ais a a |
  % 14
  g8 a ais4 a g |
  % 15
  d e f2 |
  % 16
  
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
  f e f g |
  % 3
  f f8 dis d4 c |
  % 4
  c c f8 a g f |
  % 5
  e8. f16 g8. f16 e4 f |
  % 6
  f e f g |
  % 7
  f f8 dis d4 c |
  % 8
  c c f8 a g f |
  % 9
  e8. f16 g8. f16 e4 f8 g |
  % 10
  a4 g g8 f e g |
  % 11
  c, a' d, g e4 f8 g |
  % 12
  a ais a g f4 f |
  % 13
  e d8 e fis4 f |
  % 14
  e d c8 d e4 |
  % 15
  d c8 ais a2 |
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
  s2. a'8 ais |
  % 2
  c d c ais a4 g8 a |
  % 3
  ais4 a ais g |
  % 4
  f8 g a ais c4 d |
  % 5
  g,8 c4 b8 c4 a8 ais |
  % 6
  c d c ais a4 g8 a |
  % 7
  ais4 a ais g |
  % 8
  f8 g a ais c4 d |
  % 9
  g,8 c4 b8 c4 a |
  % 10
  a8 b c4 b8 a g4 |
  % 11
  f8 c' b4 c a8 ais |
  % 12
  c4 f8 e d4 d |
  % 13
  g,8 a ais c d4 c |
  % 14
  c f,8 g a ais c4 |
  % 15
  ais8 a g4 f2 |
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
  a,8 ais c4 f, c' |
  % 3
  d8 dis f4 g e |
  % 4
  f f, f'8 e d4 |
  % 5
  c g c f |
  % 6
  a,8 ais c4 f, c' |
  % 7
  d8 dis f4 g e |
  % 8
  f f, f'8 e d4 |
  % 9
  c g c f8 e |
  % 10
  d4 e8 f g4 c,8 ais |
  % 11
  a f g4 c f |
  % 12
  f,8 g a4 ais8 c d4 |
  % 13
  e8 fis g4 d a8 ais |
  % 14
  c4 d8 e f4 e8 f |
  % 15
  g4 c, f,2 |
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
