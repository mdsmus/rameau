% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 096.mid
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
  a'4 a b cis |
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
  a'4 a b cis |
  % 10
  d2 cis |
  % 11
  d8 e f4 e e |
  % 12
  d1 |
  % 13
  a4 a ais a |
  % 14
  g8 a16 ais g4 f2 |
  % 15
  a4 b c a |
  % 16
  d c8 b b2 |
  % 17
  a a4 d |
  % 18
  g, f8 e e2 |
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
  f'4 f e d |
  % 2
  d cis a2 |
  % 3
  f'4 f f8 d g4 |
  % 4
  a g a2 |
  % 5
  a4 a ais a8 g |
  % 6
  f1 |
  % 7
  f4 f e d |
  % 8
  d cis a2 |
  % 9
  f'4 f f8 d g4 |
  % 10
  a g a2 |
  % 11
  a4 a ais a8 g |
  % 12
  f1 |
  % 13
  f8 g a4 a8 g f4 |
  % 14
  f e c2 |
  % 15
  f4 f g e |
  % 16
  a8 e e f e f e d |
  % 17
  cis2 d4 d |
  % 18
  d8 cis d4 d8 cis16 b cis4 |
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
  d'4 d d8 cis d4 |
  % 2
  a8 ais a g f2 |
  % 3
  d'4 d d8 b e4 |
  % 4
  d8 e16 f e8 d e2 |
  % 5
  a,4 d d cis |
  % 6
  a1 |
  % 7
  d4 d d8 cis d4 |
  % 8
  a8 ais a g f2 |
  % 9
  d'4 d d8 b e4 |
  % 10
  d8 e16 f e8 d e2 |
  % 11
  a,4 d d cis |
  % 12
  a1 |
  % 13
  d4 d d c |
  % 14
  c8 a ais g a2 |
  % 15
  c4 d e cis |
  % 16
  a8 b c a a4 gis |
  % 17
  a2 f8 g a f |
  % 18
  g4 a8 ais a e a g |
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
  d8 e f d ais'4 a8 g |
  % 2
  a4 a, d2 |
  % 3
  d8 e f d g4 f8 e |
  % 4
  f g16 a ais4 a2 |
  % 5
  f8 e d f g e a4 |
  % 6
  d,1 |
  % 7
  d8 e f d ais'4 a8 g |
  % 8
  a4 a, d2 |
  % 9
  d8 e f d g4 f8 e |
  % 10
  f g16 a ais4 a2 |
  % 11
  f8 e d f g e a4 |
  % 12
  d,1 |
  % 13
  d8 e f d g4 a8 ais |
  % 14
  c4 c, f2 |
  % 15
  f8 e d f e f g e |
  % 16
  fis gis a d, e4 e, |
  % 17
  a2 d8 e f d |
  % 18
  ais'4 a8 g a4 a, |
  % 19
  d1 |
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
