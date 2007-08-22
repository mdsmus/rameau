% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 052.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  e fis gis a |
  % 3
  b cis8 b a4 cis8 d |
  % 4
  e4 e8 d cis d e4 |
  % 5
  d2 cis4 cis |
  % 6
  d cis b a8 b |
  % 7
  cis4 cis a cis8 d |
  % 8
  e4 e cis8 d e4 |
  % 9
  d2 cis4 cis |
  % 10
  d cis b a8 b |
  % 11
  cis4 cis a b |
  % 12
  cis cis fis, gis |
  % 13
  a8 gis fis4 e e |
  % 14
  a b cis b8 cis |
  % 15
  d4 cis b2 |
  % 16
  a1 |
  % 17
  
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
  e4. dis8 e4 e8 fis |
  % 3
  gis fis gis4 fis a |
  % 4
  b8 a gis fis e4 e |
  % 5
  fis e e e |
  % 6
  b' e, e8 d cis b |
  % 7
  a a' g fis16 g fis4 a |
  % 8
  gis8 a b4 a8 b cis4. b16 ais b4 ais gis |
  % 10
  fis4. e8 d4 cis |
  % 11
  cis cis cis e |
  % 12
  e fis fis8 dis e2 dis4 b cis |
  % 14
  cis8 d4 e8 e fis gis a |
  % 15
  a2. gis4 |
  % 16
  e1 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. cis'4 |
  % 2
  b a b cis |
  % 3
  d cis cis fis |
  % 4
  e b b a |
  % 5
  a gis a a |
  % 6
  a8 gis a4 gis8 gis' fis e |
  % 7
  e4 e d e |
  % 8
  e e e8 d cis fis |
  % 9
  fis4. f8 fis4 cis8 b |
  % 10
  a b cis4 fis,8 gis a4 |
  % 11
  gis gis fis gis |
  % 12
  a a b4. b8 |
  % 13
  a16 b cis4 b16 a gis4 gis |
  % 14
  fis8 fis'4 e16 d cis8 b16 cis d8 e |
  % 15
  a, fis'4 fis8 b, cis16 d e8 d |
  % 16
  cis1 |
  % 17
  
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
  s2. a'4 |
  % 2
  gis fis e8 d cis4 |
  % 3
  b f fis fis' |
  % 4
  gis8 fis e4 a cis, |
  % 5
  b e a, a |
  % 6
  b cis8 d e4 fis8 gis |
  % 7
  a4 a, d a'8 b |
  % 8
  cis4 gis a ais |
  % 9
  b b, fis' f |
  % 10
  fis8 gis a4 d,8 e fis4. f16 dis f8 cis fis4 e |
  % 12
  a8 gis fis e dis b e dis |
  % 13
  cis a b4 e cis |
  % 14
  fis gis a4. gis8 |
  % 15
  fis4 e8 d e4 e, |
  % 16
  a1 |
  % 17
  
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
