% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 224.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. f'4 |
  % 2
  a c c a |
  % 3
  f g a f |
  % 4
  c' c d e |
  % 5
  f8 e d4 c c |
  % 6
  a c d c |
  % 7
  ais a g c |
  % 8
  a8 ais c4 ais a8 g |
  % 9
  f4 g f2 |
  % 10
  
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
  f f e e4. d8 c4 c c |
  % 4
  f g a8 b c4 |
  % 5
  c4. b8 g4 g4. f16 e f4 f f |
  % 7
  g8 c, c f4 e8 g4 |
  % 8
  f f f e |
  % 9
  d16 e f4 e8 c2 |
  % 10
  
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
  c c g a |
  % 3
  a g f a |
  % 4
  a c f e |
  % 5
  a d,8 g16 f e4 c |
  % 6
  c c4. ais4 a8 |
  % 7
  g4 a8. ais16 c4 c |
  % 8
  c c d c8 ais |
  % 9
  a g16 f c'8. ais16 a2 |
  % 10
  
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
  f a,8 ais c4 cis |
  % 3
  d e f f |
  % 4
  f4. e8 d4 a'8 g |
  % 5
  f4 g c, e |
  % 6
  f a,8 f ais4 f'4. e8 f4 c e |
  % 8
  f a, ais c |
  % 9
  d c f2 |
  % 10
  
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
