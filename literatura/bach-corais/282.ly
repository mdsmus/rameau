% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 282.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  c''4 d e d |
  % 2
  c b a g |
  % 3
  c d e d8 e16 f |
  % 4
  e4 d8. c16 c2 |
  % 5
  c4 d e d |
  % 6
  c b a g |
  % 7
  c d e d8 e16 f |
  % 8
  e4 d8. c16 c2 |
  % 9
  e4 f g f |
  % 10
  e d e2 |
  % 11
  g4 g a g |
  % 12
  f e d2 |
  % 13
  e4 g f e8 d |
  % 14
  c4 d e2 |
  % 15
  c e4 g |
  % 16
  f e d c |
  % 17
  d2 c |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''4 g g g |
  % 2
  a d, d d |
  % 3
  g a8 b c g g4 |
  % 4
  g g g2 |
  % 5
  g4 g g g |
  % 6
  a d, d d |
  % 7
  g a8 b c g g4 |
  % 8
  g g g2 |
  % 9
  g4 a8 ais16 c ais4 a |
  % 10
  g f8 a16 gis a2 |
  % 11
  g4 c c b |
  % 12
  a g8 fis g2 |
  % 13
  g4 c8 b a b c4 |
  % 14
  a a b e, |
  % 15
  e2 g8 a ais4 |
  % 16
  a8 b c4 g g |
  % 17
  g2 g |
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
  e'4 b c d |
  % 2
  e8 fis g4 g8 fis b,4 |
  % 3
  c f g8 c, d4. c8 c b e2 |
  % 5
  e4 b c d |
  % 6
  e8 fis g4 g8 fis b,4 |
  % 7
  c f g8 c, d4. c8 c b e2 |
  % 9
  c4 c c c8 d |
  % 10
  e a, a b cis2 |
  % 11
  c8 d e4 f8 e d4 |
  % 12
  c c b2 |
  % 13
  c8 d e4 f g8 g, |
  % 14
  a e' d c b2 |
  % 15
  a ais4 e |
  % 16
  f g8 a b4 c |
  % 17
  c b e2 |
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
  c4 g' c b |
  % 2
  a g d g |
  % 3
  e d c b |
  % 4
  c g c2 |
  % 5
  c4 g' c b |
  % 6
  a g d g |
  % 7
  e d c b |
  % 8
  c g c2 |
  % 9
  c'4 a e f |
  % 10
  cis d a2 |
  % 11
  e'4 c f g |
  % 12
  a8 b c4 g2 |
  % 13
  c4 c, d e |
  % 14
  f fis g gis |
  % 15
  a2 g4 c, |
  % 16
  d e8 f g f e c |
  % 17
  g2 c |
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
