% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 326.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''8 b |
  % 2
  cis4 d e d |
  % 3
  cis b cis cis |
  % 4
  cis b8 cis d cis b4 |
  % 5
  a b a a8 b |
  % 6
  cis4 d e d |
  % 7
  cis b cis cis |
  % 8
  cis b8 cis d cis b4 |
  % 9
  a b a a |
  % 10
  b cis d cis |
  % 11
  b cis b b |
  % 12
  cis d e d |
  % 13
  cis b cis a |
  % 14
  b cis d8 cis b4 |
  % 15
  a8 fis gis4 a2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'4 |
  % 2
  a a gis fis8 gis |
  % 3
  a4 gis a e |
  % 4
  fis fis8 e d e e4 |
  % 5
  e8 a gis fis e4 e |
  % 6
  a a gis fis8 gis |
  % 7
  a4 gis a e |
  % 8
  fis fis8 e d e e4 |
  % 9
  e8 a gis fis e4 e |
  % 10
  e e d8 e fis4 |
  % 11
  fis8 e e d16 cis d4 e |
  % 12
  e fis gis fis |
  % 13
  e d8 fis16 f fis4 fis |
  % 14
  fis e d e |
  % 15
  e8 fis e4 e2 |
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
  s2. cis'8 d |
  % 2
  e4 fis b,8 cis d4 |
  % 3
  e e e a, |
  % 4
  a2. d8 b |
  % 5
  e d16 cis d4 cis cis8 d |
  % 6
  e4 fis b,8 cis d4 |
  % 7
  e e e a, |
  % 8
  a2. d8 b |
  % 9
  e d16 cis d4 cis cis |
  % 10
  gis ais b ais |
  % 11
  b ais fis b |
  % 12
  a a b a8 b |
  % 13
  cis4 fis,8 gis a4 cis |
  % 14
  fis,8 gis a4 a gis |
  % 15
  a8 d b4 cis2 |
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
  s2. a4 |
  % 2
  a'8 gis fis4 e b |
  % 3
  cis8 d e4 a, a'8 gis |
  % 4
  fis e d cis b a gis4 |
  % 5
  cis8 a e'4 a, a |
  % 6
  a'8 gis fis4 e b |
  % 7
  cis8 d e4 a, a'8 gis |
  % 8
  fis e d cis b a gis4 |
  % 9
  cis8 a e'4 a, a |
  % 10
  e' d8 cis b4 e8 fis |
  % 11
  g4 fis b, gis' |
  % 12
  a8 gis fis4 e fis8 gis |
  % 13
  a4 b fis fis8 e |
  % 14
  d4 cis b8 cis d4 |
  % 15
  cis8 d e4 a,2 |
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
