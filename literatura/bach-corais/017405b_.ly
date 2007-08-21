% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 017405b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  cis b a g8 fis |
  % 3
  b4 b a d |
  % 4
  cis b a g8 fis |
  % 5
  b4 b a a |
  % 6
  b cis d8 e fis4 |
  % 7
  e8 d e4 d d |
  % 8
  cis b a g8 fis |
  % 9
  b4 b a d |
  % 10
  cis b a g8 fis |
  % 11
  b4 b a a |
  % 12
  b cis d8 e fis4 |
  % 13
  e8 d e4 d d |
  % 14
  d e d b8 cis |
  % 15
  d4 d cis cis |
  % 16
  d e d b8 cis |
  % 17
  d4 d cis fis |
  % 18
  g8 fis e4 fis8 e d4 |
  % 19
  d cis d cis |
  % 20
  d cis b a |
  % 21
  a gis a fis' |
  % 22
  e d cis fis |
  % 23
  g8 fis e4 fis8 e d4 |
  % 24
  d cis d d |
  % 25
  d d e d |
  % 26
  d cis d2 |
  % 27
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'4 |
  % 2
  e8 fis g fis e4 d |
  % 3
  d d d fis8 f |
  % 4
  fis e d e fis e d fis |
  % 5
  fis4 f fis fis8 e |
  % 6
  d b' a g fis g a b |
  % 7
  e, fis g4 fis fis |
  % 8
  e8 fis g fis e4 d |
  % 9
  d d d fis8 f |
  % 10
  fis e d e fis e d fis |
  % 11
  fis4 f fis fis8 e |
  % 12
  d b' a g fis g a b |
  % 13
  e, fis g4 fis a |
  % 14
  a8 g4 fis8 fis4 e |
  % 15
  e e e e |
  % 16
  fis g fis e |
  % 17
  d8 e fis4 fis fis |
  % 18
  e e a8 g fis4 |
  % 19
  e e fis g |
  % 20
  fis e8 fis gis4 fis |
  % 21
  fis e e d' |
  % 22
  ais b ais cis |
  % 23
  b b8 a a4 a |
  % 24
  e fis fis a |
  % 25
  a g8 fis g4 fis |
  % 26
  e8 d e4 fis2 |
  % 27
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'8 b |
  % 2
  cis4 d e8 a, a4 |
  % 3
  a g fis fis8 gis |
  % 4
  a4 b cis d8 cis |
  % 5
  b4 cis cis d8 cis |
  % 6
  b g' fis e d4 d |
  % 7
  d cis a a8 b |
  % 8
  cis4 d e8 a, a4 |
  % 9
  a g fis fis8 gis |
  % 10
  a4 b cis d8 cis |
  % 11
  b4 cis cis d8 cis |
  % 12
  b g' fis e d4 d |
  % 13
  d cis a fis'8 e |
  % 14
  d4 cis b8 cis d4 |
  % 15
  gis,8 a b4 a a |
  % 16
  a a a g |
  % 17
  fis b ais b |
  % 18
  b cis cis d8 cis |
  % 19
  b4 a a e' |
  % 20
  a,8 b cis4 d cis |
  % 21
  b b cis a8 b |
  % 22
  cis4 fis, fis' fis8 e |
  % 23
  d4 e d d8 cis |
  % 24
  b4 cis b d8 c |
  % 25
  b4 b b8 a a4 |
  % 26
  a a a2 |
  % 27
  
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
  a b cis d |
  % 3
  g,8 a b cis d4 b |
  % 4
  fis' g a b8 a |
  % 5
  gis4 cis, fis d |
  % 6
  g a b a8 g |
  % 7
  a4 a, d d |
  % 8
  a b cis d |
  % 9
  g,8 a b cis d4 b |
  % 10
  fis' g a b8 a |
  % 11
  gis4 cis, fis d |
  % 12
  g a b a8 g |
  % 13
  a4 a, d d'8 cis |
  % 14
  b4 ais b8 a gis fis |
  % 15
  e fis gis e a4 a8 g |
  % 16
  fis e d cis d4 e |
  % 17
  b8 cis d e fis4 dis |
  % 18
  e a8 g fis4 b8 a |
  % 19
  gis4 a d, e |
  % 20
  fis8 gis a4 f fis8 f |
  % 21
  dis4 e a, d |
  % 22
  cis b fis' ais |
  % 23
  b cis d fis, |
  % 24
  gis ais b fis |
  % 25
  g8 a b4 cis, d |
  % 26
  a' a, d2 |
  % 27
  
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
