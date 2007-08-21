% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 035800b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  a''4 a g f |
  % 2
  e2 d |
  % 3
  a'4 b c a |
  % 4
  d2 cis |
  % 5
  d8 e f4 e e |
  % 6
  d1 |
  % 7
  a4 a g f |
  % 8
  e2 d |
  % 9
  a'4 b c a |
  % 10
  d2 cis |
  % 11
  d8 e f4 e e |
  % 12
  d1 |
  % 13
  a4 a ais a |
  % 14
  g g f2 |
  % 15
  a4 b c8 b a4 |
  % 16
  d c8 b b2 |
  % 17
  a a4 a |
  % 18
  g f e2 |
  % 19
  d1 |
  % 20
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 d e d |
  % 2
  d cis a2 |
  % 3
  d4 g, g'8 f e4 |
  % 4
  a b a2 |
  % 5
  g4 a8 ais g ais a g |
  % 6
  f1 |
  % 7
  d4 d e d |
  % 8
  d cis a2 |
  % 9
  d4 g, g'8 f e4 |
  % 10
  a b a2 |
  % 11
  g4 a8 ais g ais a g |
  % 12
  f1 |
  % 13
  f4 f8 dis d e f4 |
  % 14
  f e c2 |
  % 15
  c4 f e8 d c4 |
  % 16
  f e8 f e4. d8 |
  % 17
  cis2 d4 d8 cis |
  % 18
  d e e d d cis16 b cis4 |
  % 19
  a1 |
  % 20
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  f8 g a4 ais8 a a4 |
  % 2
  ais a8 g f2 |
  % 3
  f'8 e d4 c cis |
  % 4
  d8 e f4 e2 |
  % 5
  d4 d d cis |
  % 6
  a1 |
  % 7
  f8 g a4 ais8 a a4 |
  % 8
  ais a8 g f2 |
  % 9
  f'8 e d4 c cis |
  % 10
  d8 e f4 e2 |
  % 11
  d4 d d cis |
  % 12
  a1 |
  % 13
  d4 c ais8 c d4 |
  % 14
  d c8 ais a2 |
  % 15
  a4 g8 f g4 a |
  % 16
  a8 gis a2 gis4 |
  % 17
  a2 f8 g a4 |
  % 18
  d,8 a' a4 b8 e, a g |
  % 19
  fis1 |
  % 20
  
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
  d8 e f4 cis d |
  % 2
  g, a d,2 |
  % 3
  d'8 e f4 e8 f g4 |
  % 4
  fis8 gis gis4 a2 |
  % 5
  ais4 a8 g a4 a, |
  % 6
  d1 |
  % 7
  d8 e f4 cis d |
  % 8
  g, a d,2 |
  % 9
  d'8 e f4 e8 f g4 |
  % 10
  fis8 gis gis4 a2 |
  % 11
  ais4 a8 g a4 a, |
  % 12
  d1 |
  % 13
  d8 e f4 g d8 c |
  % 14
  ais g c4 f,2 |
  % 15
  f'4 e8 d e4 f |
  % 16
  b, c8 d e2 |
  % 17
  a, d8 e f4 |
  % 18
  b,8 cis d4 gis, a |
  % 19
  d,1 |
  % 20
  
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
