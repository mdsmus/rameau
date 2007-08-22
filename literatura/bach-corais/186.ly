% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 186.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'4 |
  % 2
  f f g g |
  % 3
  a a ais a |
  % 4
  g2 f4 c |
  % 5
  f f g g |
  % 6
  a a g f |
  % 7
  e2 d4 a' |
  % 8
  f g e a |
  % 9
  f g e e |
  % 10
  f f g g |
  % 11
  a a g f |
  % 12
  e2 d |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a'4 |
  % 2
  d8 e f4 f e8 d |
  % 3
  c4 d d8 g4 f e16 d e4 c a8 g |
  % 5
  f4 d' d c |
  % 6
  c f f8 e4 d8 |
  % 7
  d4 cis a e'4. d8 d e cis4 e |
  % 9
  d8 c d4 c c |
  % 10
  c d d e4. d16 e f4 e4. d8 |
  % 12
  d4 cis a2 |
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
  s2. f4 |
  % 2
  a c d c8 ais |
  % 3
  a g f4. e8 c'4 |
  % 4
  d8 g, c ais a4 f8 g |
  % 5
  a4 ais b8 a g4 |
  % 6
  f c' c8. ais16 a4 |
  % 7
  ais a8 g f4 a |
  % 8
  a ais a a |
  % 9
  a g g g |
  % 10
  a a ais4. c16 b |
  % 11
  a4 d8 c ais4 a |
  % 12
  ais a8 g fis2 |
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
  s2. d4 |
  % 2
  d a ais c |
  % 3
  f8 e d4 g, a |
  % 4
  ais c f, f'8 e |
  % 5
  d c ais a g f e4 |
  % 6
  f8 g a ais c4 d |
  % 7
  g, a d, c' |
  % 8
  d g, a c2 b4 c c8 ais |
  % 10
  a f d' c ais a g c |
  % 11
  f e d4. cis8 d4 |
  % 12
  g, a d,2 |
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
