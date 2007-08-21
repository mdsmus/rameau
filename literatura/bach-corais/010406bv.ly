% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 010406bv.mid
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
  s2. g''8 a |
  % 2
  b4 c d c |
  % 3
  b a b b |
  % 4
  b a8 b c b a4 |
  % 5
  g a g g8 a |
  % 6
  b4 c d c |
  % 7
  b a b b |
  % 8
  b a8 b c b a4 |
  % 9
  g a g g |
  % 10
  a b c b |
  % 11
  a b a a |
  % 12
  b c d c |
  % 13
  b a b g |
  % 14
  a b c8 b a4 |
  % 15
  g8 e fis4 g2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  g g fis e8 fis |
  % 3
  g4 fis g d |
  % 4
  e e8 d c d d4 |
  % 5
  d8 g fis e d4 d |
  % 6
  g g fis e8 fis |
  % 7
  g4 fis g d |
  % 8
  e e8 d c d d4 |
  % 9
  d8 g fis e d4 d |
  % 10
  d d c8 d e4 |
  % 11
  e8 d d c16 b c4 d |
  % 12
  d e fis e |
  % 13
  d c8 e16 dis e4 e |
  % 14
  e d c d |
  % 15
  d8 e d4 d2 |
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
  s2. b'8 c |
  % 2
  d4 e a,8 b c4 |
  % 3
  d d d g, |
  % 4
  g2. c8 a |
  % 5
  d c16 b c4 b b8 c |
  % 6
  d4 e a,8 b c4 |
  % 7
  d d d g, |
  % 8
  g2. c8 a |
  % 9
  d c16 b c4 b b |
  % 10
  fis gis a gis |
  % 11
  a gis e a |
  % 12
  g g a g8 a |
  % 13
  b4 e,8 fis g4 b |
  % 14
  e,8 fis g4 g fis |
  % 15
  g8 c a4 b2 |
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
  g'8 fis e4 d a |
  % 3
  b8 c d4 g, g'8 fis |
  % 4
  e d c b a g fis4 |
  % 5
  b8 g d'4 g, g |
  % 6
  g'8 fis e4 d a |
  % 7
  b8 c d4 g, g'8 fis |
  % 8
  e d c b a g fis4 |
  % 9
  b8 g d'4 g, g |
  % 10
  d' c8 b a4 d8 e |
  % 11
  f4 e a, fis' |
  % 12
  g8 fis e4 d e8 fis |
  % 13
  g4 a e e8 d |
  % 14
  c4 b a8 b c4 |
  % 15
  b8 c d4 g,2 |
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
