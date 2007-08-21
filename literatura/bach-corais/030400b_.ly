% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 030400b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 96 
  \skip 1*8 
  \time 1/4 
  \skip 4 |
  % 10
  
  \time 3/4 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  a''4 g8 fis b4 b |
  % 2
  cis cis d d |
  % 3
  b4. a8 g4 a |
  % 4
  g8 fis e fis d2 |
  % 5
  a'4 g8 fis b4 b |
  % 6
  cis cis d d |
  % 7
  b4. a8 g4 a |
  % 8
  g8 fis e fis d2 |
  % 9
  d8 e fis4 fis fis |
  % 10
  e e e8 fis g4 |
  % 11
  g g8 fis fis4 fis |
  % 12
  fis b4. a8 g4 |
  % 13
  a4. g8 fis4 g |
  % 14
  fis e d d |
  % 15
  d8 e fis4 fis fis |
  % 16
  e e e8 fis g4 |
  % 17
  g g fis2 |
  % 18
  fis4 b4. a8 g4 |
  % 19
  a4. g8 fis4 g |
  % 20
  fis e d2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  fis'4 d d g8 fis |
  % 2
  e4 a8 g fis4 fis |
  % 3
  d g8 fis e4 e |
  % 4
  d cis a2 |
  % 5
  e'4 d fis e8 d |
  % 6
  cis4 fis fis fis |
  % 7
  g8 fis e4 d e |
  % 8
  e8 d d cis a2 |
  % 9
  a4 d d d |
  % 10
  cis8 b cis d e4 e |
  % 11
  e e d8 cis d e |
  % 12
  fis4 g4. fis8 e4 |
  % 13
  e8 d cis4 d d |
  % 14
  d cis a a |
  % 15
  a d d d |
  % 16
  d cis8 b cis d e4 |
  % 17
  e e e d |
  % 18
  s4 d g8 fis e4. g8 fis e d a d4. e8 cis4 a2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  d'4 a b e8 d |
  % 2
  cis b a4 a a |
  % 3
  g8 a b4 b a |
  % 4
  a a8 g fis2 |
  % 5
  a4 a a8 fis g b4 gis8 ais4 b b |
  % 7
  d cis b8 g e a |
  % 8
  a4 a fis2 |
  % 9
  fis8 g a4 a a8 b |
  % 10
  cis d e d cis4 b |
  % 11
  b b8 cis d e fis e |
  % 12
  d cis b a g a b4 |
  % 13
  a a a g8 a |
  % 14
  b4 e, fis fis |
  % 15
  fis b b a |
  % 16
  b a8 gis a4 a |
  % 17
  b cis a2 |
  % 18
  a4 d8 cis b4. b8 |
  % 19
  a4. cis8 d4 d, |
  % 20
  a' a8 g fis2. 
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
  d4 d g8 fis e4 |
  % 2
  a8 g fis e d4 d |
  % 3
  g8 fis e4 e8 d cis4 |
  % 4
  d a d2 |
  % 5
  cis4 d dis e |
  % 6
  f fis b, b |
  % 7
  g a b cis |
  % 8
  d a d2 |
  % 9
  d4 d8 cis d e fis g |
  % 10
  a4 a, a' e8 dis |
  % 11
  e fis g a b4 b, |
  % 12
  b'8 a g fis e4 e8 d |
  % 13
  cis b a4 d8 cis b a |
  % 14
  g4 a d d |
  % 15
  d8 cis b4 b'8 a g fis |
  % 16
  gis4 e a cis, |
  % 17
  d8 cis b a d2 |
  % 18
  s4 b e e8 d |
  % 19
  cis a d4. cis8 b4 |
  % 20
  a8 g a4 d2. 
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
