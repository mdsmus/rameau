% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024835b3.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key fis \minor
  
  \tempo 4 = 84 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. fis'8 gis |
  % 2
  a4 gis fis fis8 gis |
  % 3
  a4 gis fis cis' |
  % 4
  b a gis gis |
  % 5
  a a b b |
  % 6
  cis cis b a |
  % 7
  gis2 fis4 cis' |
  % 8
  b a8 gis gis4 cis |
  % 9
  b a gis gis |
  % 10
  a a b b |
  % 11
  cis cis b a8 gis |
  % 12
  gis2 fis |
  % 13
  
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
  fis f fis fis |
  % 3
  fis f cis fis |
  % 4
  fis8 f fis4 f f |
  % 5
  fis fis fis8 gis16 a gis4 |
  % 6
  gis8 fis f fis gis4. fis8 |
  % 7
  fis4 f cis fis |
  % 8
  fis8 f fis4 f fis8 e |
  % 9
  dis e fis dis e4 gis8 f |
  % 10
  fis4 a8 fis d4 b'8 gis |
  % 11
  a g fis4. f8 fis4. f16 dis f4 cis2 |
  % 13
  
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
  cis4 cis8 b a4 b |
  % 3
  cis cis8 b a4 a |
  % 4
  b cis cis cis |
  % 5
  cis d d8 e16 fis e8 d |
  % 6
  cis4 b8 a d cis cis d |
  % 7
  d b gis cis a4 a |
  % 8
  b8 cis dis4 cis cis |
  % 9
  fis, b b cis |
  % 10
  cis8 a d4 d8 b e4 |
  % 11
  e8 cis fis e d cis dis4 |
  % 12
  cis8 gis cis b a2 |
  % 13
  
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
  s2. fis4 |
  % 2
  fis16 gis a b cis8 cis, d4 d |
  % 3
  cis8 b cis4 fis, fis' |
  % 4
  gis a8 b cis4 cis, |
  % 5
  fis8 e d cis d b e4 |
  % 6
  a,8 a' gis fis4 f8 fis d |
  % 7
  b gis cis4 fis, fis'8 e |
  % 8
  d cis c4 cis a |
  % 9
  b8 cis dis b e4 f8 cis |
  % 10
  fis4 fis8 d g4 gis8 e |
  % 11
  a4 ais8 fis b4 c8 gis |
  % 12
  cis4 cis, fis2 |
  % 13
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  s2. fis4 |
  % 2
  fis16 gis a b cis8 cis, d4 d |
  % 3
  cis8 b cis4 fis, fis' |
  % 4
  gis a8 b cis4 cis, |
  % 5
  fis8 e d cis d b e e, |
  % 6
  a a' gis fis4 f8 fis d |
  % 7
  b gis cis4 fis, fis'8 e |
  % 8
  d cis c4 cis a |
  % 9
  b8 cis dis b e4 f8 cis |
  % 10
  fis fis, fis' d g g, gis' e |
  % 11
  a a, ais' fis b b, c' gis |
  % 12
  cis b cis cis, fis,2 |
  % 13
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
