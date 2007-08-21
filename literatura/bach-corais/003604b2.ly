% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 003604b2.mid
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
  s2. d'4 |
  % 2
  a' fis8 e d4 a' |
  % 3
  b8. cis32 d b4 a a |
  % 4
  b cis d cis |
  % 5
  b8 d cis b a4 fis |
  % 6
  b a g fis |
  % 7
  e2 d4 d |
  % 8
  a' fis8 e d4 a' |
  % 9
  b8. cis32 d b4 a a |
  % 10
  b cis d cis |
  % 11
  b8 d cis b a4 fis |
  % 12
  b a g fis |
  % 13
  e2 d |
  % 14
  a' fis |
  % 15
  a fis |
  % 16
  fis4 fis e e |
  % 17
  fis fis e fis |
  % 18
  g fis e2 |
  % 19
  d d'4 cis |
  % 20
  b a g fis |
  % 21
  e2 d4 
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
  a a b cis |
  % 3
  fis e e fis |
  % 4
  g g fis e8 a |
  % 5
  a4 gis e d |
  % 6
  d d d8 cis d4 |
  % 7
  d cis a a |
  % 8
  a a b cis |
  % 9
  fis e e fis |
  % 10
  g g fis e8 a |
  % 11
  a4 gis e d |
  % 12
  d d d8 cis d4 |
  % 13
  d cis a2 |
  % 14
  e' d |
  % 15
  e d |
  % 16
  d4 d cis cis |
  % 17
  d d cis dis |
  % 18
  e d8 cis b4 cis |
  % 19
  a2 fis'4 fis8 e |
  % 20
  d e fis4 fis8 e e d |
  % 21
  d cis16 b cis4 a 
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
  e d8 e fis gis a4 |
  % 3
  a gis cis d |
  % 4
  d e a,8 b cis4 |
  % 5
  fis,8 fis' e d cis4 a |
  % 6
  g a b8 g a4 |
  % 7
  a4. g8 fis4 fis |
  % 8
  e d8 e fis gis a4 |
  % 9
  a gis cis d |
  % 10
  d e a,8 b cis4 |
  % 11
  fis,8 fis' e d cis4 a |
  % 12
  g a b8 g a4 |
  % 13
  a4. g8 fis2 |
  % 14
  a a |
  % 15
  cis a |
  % 16
  a4 a a a |
  % 17
  a a a a |
  % 18
  b8 cis d4 d8 cis16 b a8 g |
  % 19
  fis2 fis8 gis ais4 |
  % 20
  b cis d8 e a,4 |
  % 21
  b a8 g fis4 
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
  cis d8 cis b4 fis'8 e |
  % 3
  d b e4 a, d |
  % 4
  g fis8 e fis gis a4 |
  % 5
  d, e a, d |
  % 6
  g fis e d |
  % 7
  a2 d4 d |
  % 8
  cis d8 cis b4 fis'8 e |
  % 9
  d b e4 a, d |
  % 10
  g fis8 e fis gis a4 |
  % 11
  d, e a, d |
  % 12
  g fis e d |
  % 13
  a2 d |
  % 14
  cis d |
  % 15
  a d |
  % 16
  d8 e fis g a b a g |
  % 17
  fis e fis d a a' g fis |
  % 18
  e4 b'8 a g4 a |
  % 19
  d,2 b4 fis |
  % 20
  g a b8 cis d4 |
  % 21
  g, a d, 
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
