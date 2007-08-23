% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 074.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  d c ais a |
  % 3
  g2 a4 e' |
  % 4
  f f e8 d e4 |
  % 5
  d2. a4 |
  % 6
  d c ais a |
  % 7
  g2 a4 e' |
  % 8
  f f e8 d e4 |
  % 9
  d2. f4 |
  % 10
  e8 d c4 d e |
  % 11
  f2 f4 c |
  % 12
  d c ais8 a ais4 |
  % 13
  a2. f'4 |
  % 14
  e8 f g4 f e |
  % 15
  d2 e4 a, |
  % 16
  ais a g c |
  % 17
  a1 |
  % 18
  
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
  f8 g a4 d,8 e f4 |
  % 3
  f e f a |
  % 4
  a a a a8 g |
  % 5
  f2. f4 |
  % 6
  f8 g a4 d,8 e f4 |
  % 7
  f e f a |
  % 8
  a a a a8 g |
  % 9
  f2. a4 |
  % 10
  g g8 f f4 ais |
  % 11
  ais a8 g a4 a |
  % 12
  a8 g a4 g8 fis g4 |
  % 13
  fis2. g4 |
  % 14
  g c c c |
  % 15
  c b c a |
  % 16
  ais a g c |
  % 17
  a1 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'4 |
  % 2
  d8 e f4 g c, |
  % 3
  d c c e |
  % 4
  e d d cis |
  % 5
  a2. d4 |
  % 6
  d8 e f4 g c, |
  % 7
  d c c e |
  % 8
  e d d cis |
  % 9
  a2. d8 c |
  % 10
  ais4 c c ais8 c |
  % 11
  d4 c8 ais c4 f8 dis |
  % 12
  d4 d d d |
  % 13
  d2. d4 |
  % 14
  c8 d e4 f g |
  % 15
  a g g c, |
  % 16
  ais c c8 ais16 a g8 c |
  % 17
  c1 |
  % 18
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. d'8 c |
  % 2
  ais4 a g f |
  % 3
  ais, c f cis |
  % 4
  d8 e f g a4 a, |
  % 5
  d2. d'8 c |
  % 6
  ais4 a g f |
  % 7
  ais, c f cis |
  % 8
  d8 e f g a4 a, |
  % 9
  d2. d4 |
  % 10
  g a ais8 a g4 |
  % 11
  f2 f4 f |
  % 12
  ais fis g g, |
  % 13
  d'2. b4 |
  % 14
  c c'8 b a4 g |
  % 15
  f g c, f |
  % 16
  g a8 ais c4 c, |
  % 17
  f1 |
  % 18
  
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
