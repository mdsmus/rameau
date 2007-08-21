% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 039800b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  fis d a' a |
  % 3
  b2 s4 b |
  % 4
  e, e a g |
  % 5
  fis e d a' |
  % 6
  b b a g |
  % 7
  fis2 s4 e |
  % 8
  fis gis a b8 cis16 d |
  % 9
  cis4 b a a |
  % 10
  a a d c8 b |
  % 11
  b2 s4 b |
  % 12
  b b e d8 cis |
  % 13
  cis2 s4 a |
  % 14
  b a b cis |
  % 15
  d2 s4 a |
  % 16
  b8 a g fis e4 e |
  % 17
  d1 |
  % 18
  
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
  d d8 e fis4 d |
  % 3
  d2 s4 d |
  % 4
  cis cis d e |
  % 5
  d cis a fis' |
  % 6
  g g8 fis e d e4 |
  % 7
  d2 s4 cis |
  % 8
  d e e fis |
  % 9
  e4. d8 cis4 cis |
  % 10
  d d d d |
  % 11
  d2 s4 g |
  % 12
  g8 fis g a b a b gis |
  % 13
  a2 s4 d, |
  % 14
  g fis fis fis |
  % 15
  fis2 s4 fis8 e |
  % 16
  d4 d cis cis |
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
  s2. fis4 |
  % 2
  a a d a |
  % 3
  g2 s4 b |
  % 4
  a a a a |
  % 5
  a4. g8 fis4 d' |
  % 6
  d g, a a |
  % 7
  a2 s4 a |
  % 8
  a b a a |
  % 9
  a gis e e |
  % 10
  fis8 e fis g a g a fis |
  % 11
  g2 s4 d' |
  % 12
  e e b e |
  % 13
  e2 s4 d |
  % 14
  d d d cis |
  % 15
  b2 s4 d8 cis |
  % 16
  b4 b8 d a4. g8 |
  % 17
  fis1 |
  % 18
  
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
  d8 e fis g fis e fis d |
  % 3
  g2 s4 g |
  % 4
  a8 g fis e fis e d cis |
  % 5
  d4 a d d |
  % 6
  g8 fis e d cis b cis a |
  % 7
  d2 s4 a |
  % 8
  d8 cis d b cis4 d |
  % 9
  e8 d e4 a, a |
  % 10
  d8 cis d e fis e fis d |
  % 11
  g2 s4 g8 fis |
  % 12
  e dis e fis gis fis gis e |
  % 13
  a2 s4 fis |
  % 14
  g8 b d e d cis b ais |
  % 15
  b,2 s4 fis' |
  % 16
  g8 a b g a4 a, |
  % 17
  d1 |
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
