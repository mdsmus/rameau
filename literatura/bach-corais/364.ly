% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 364.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. fis'4 |
  % 2
  b cis d e |
  % 3
  cis4. b8 a4 a |
  % 4
  b b cis8 b cis4 |
  % 5
  fis,2. fis4 |
  % 6
  b cis d e |
  % 7
  cis4. b8 a4 a |
  % 8
  b b cis8 b cis4 |
  % 9
  fis,2. fis'4 |
  % 10
  e d d cis |
  % 11
  d2. cis4 |
  % 12
  d e fis fis |
  % 13
  e4. d8 cis4 cis8 d16 e |
  % 14
  d4 cis8. b16 b4 b8 cis16 d |
  % 15
  cis4. b8 a4 g |
  % 16
  fis b b8 cis ais4 |
  % 17
  b1 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. cis'4 |
  % 2
  fis e d8 fis b gis |
  % 3
  gis fis f16 dis f8 fis4 fis |
  % 4
  fis e8 d e4 e8 fis16 e |
  % 5
  d2. cis4 |
  % 6
  fis e d8 fis b gis |
  % 7
  gis fis f16 dis f8 fis4 fis |
  % 8
  fis e8 d e4 e8 fis16 e |
  % 9
  d2. b'4 |
  % 10
  b b a a |
  % 11
  a2. a4 |
  % 12
  a a a4. gis8 |
  % 13
  a fis gis4 e fis |
  % 14
  fis fis g8 fis g4 |
  % 15
  gis8 fis f4 fis fis8 e |
  % 16
  d e fis g fis g16 fis e8 fis16 e |
  % 17
  dis1 |
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
  s2. ais'4 |
  % 2
  b4. ais8 b4. b8 |
  % 3
  b a gis cis cis4 cis |
  % 4
  b8 a g2 fis4 |
  % 5
  fis2. ais4 |
  % 6
  b4. ais8 b4. b8 |
  % 7
  b a gis cis cis4 cis |
  % 8
  b8 a g2 fis4 |
  % 9
  fis2. d'4 |
  % 10
  e8 fis g4 fis8 e16 d e8 fis16 g |
  % 11
  fis2. e4 |
  % 12
  fis e d8 a d4 |
  % 13
  cis b16 a b8 a4 cis |
  % 14
  cis8 b cis dis e d e b |
  % 15
  gis a16 b cis4 cis d8 a |
  % 16
  a4 d8 cis d e16 d cis8 fis, |
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
  s2. fis8 e |
  % 2
  d4 cis b8 a gis e' |
  % 3
  a, b cis4 fis, fis'8 e |
  % 4
  d fis g4 ais, ais |
  % 5
  b2. fis'8 e |
  % 6
  d4 cis b8 a gis e' |
  % 7
  a, b cis4 fis, fis'8 e |
  % 8
  d fis g4 ais, ais |
  % 9
  b2. b8 a |
  % 10
  g g' fis e a4 a, |
  % 11
  d2. a'8 g |
  % 12
  fis e d cis d e16 fis b,4 |
  % 13
  cis8 d e4 a, ais |
  % 14
  b8 b'4 a8 g a16 b e,4 |
  % 15
  f8 fis16 gis cis,4 fis b,8 cis |
  % 16
  d cis d e fis e fis4 |
  % 17
  b,1 |
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
