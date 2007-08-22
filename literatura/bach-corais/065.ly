% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 065.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'4 |
  % 2
  g a b e |
  % 3
  d4. c8 b4 e |
  % 4
  d c b c8 d |
  % 5
  a2 g4 d |
  % 6
  g a b e |
  % 7
  d4. c8 b4 e |
  % 8
  d c b c8 d |
  % 9
  a2 g4 d' |
  % 10
  e e a, a |
  % 11
  d d g, b |
  % 12
  a g fis g8 fis |
  % 13
  e2 d4 d' |
  % 14
  c b a b8 c |
  % 15
  a2 g |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. b'8 c |
  % 2
  d4 d d e8 fis |
  % 3
  g4 fis g g |
  % 4
  fis g8 a b a g4 |
  % 5
  g fis d b8 c |
  % 6
  d4 d d e8 fis |
  % 7
  g4 fis g g |
  % 8
  fis g8 a b a g4 |
  % 9
  g fis d g |
  % 10
  g g fis fis8 g |
  % 11
  a g fis4 e e |
  % 12
  e d8 cis d4 d |
  % 13
  d cis d g8 fis |
  % 14
  e4 d8 e fis4 g |
  % 15
  g fis d2 |
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
  s2. g'8 a |
  % 2
  b4 a g g8 a |
  % 3
  b4 a8 d d4 c8 b |
  % 4
  a4 e' d e |
  % 5
  e d8 c b4 g8 a |
  % 6
  b4 a g g8 a |
  % 7
  b4 a8 d d4 c8 b |
  % 8
  a4 e' d e |
  % 9
  e d8 c b4 b |
  % 10
  c8 b a4 d d |
  % 11
  a b b g |
  % 12
  a a a g8 a |
  % 13
  b4 a8 g fis4 g |
  % 14
  g8 a b c d4 d |
  % 15
  d8 c16 b c8 a b2 |
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
  s2. g4 |
  % 2
  g' fis g c, |
  % 3
  b8 c d4 g, c |
  % 4
  d e8 fis g fis e d |
  % 5
  c4 d g, g |
  % 6
  g' fis g c, |
  % 7
  b8 c d4 g, c |
  % 8
  d e8 fis g fis e d |
  % 9
  c4 d g, g' |
  % 10
  c, cis d d8 e |
  % 11
  fis4 b, e e8 d |
  % 12
  cis b a4 d8 cis b a |
  % 13
  g4 a d b |
  % 14
  e8 fis g4 d8 c b g |
  % 15
  d'2 g, |
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
