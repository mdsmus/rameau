% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024522b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \major
  
  \tempo 4 = 94 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. e'8 fis |
  % 2
  gis4 a b b |
  % 3
  a gis fis b |
  % 4
  cis dis e dis8 cis |
  % 5
  cis2 b4 e,8 fis |
  % 6
  gis4 a b b |
  % 7
  a gis fis b |
  % 8
  cis dis e dis8 cis |
  % 9
  cis2 b4 b |
  % 10
  e dis8 cis cis4 b |
  % 11
  a gis8 fis fis4 b |
  % 12
  a gis fis8 gis a4 |
  % 13
  gis fis e2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. b'4 |
  % 2
  e e e e |
  % 3
  e8 dis e4 dis fis |
  % 4
  fis ais b8 fis fis gis |
  % 5
  gis4 ais fis b, |
  % 6
  e e e e |
  % 7
  e8 dis e4 dis fis |
  % 8
  fis ais b8 fis fis gis |
  % 9
  gis4 ais fis gis |
  % 10
  cis b4. a4 gis fis8 e4 dis d |
  % 12
  c b a8 b c4 |
  % 13
  b8 e4 dis8 b2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. gis'8 a |
  % 2
  b4 cis d cis8 b |
  % 3
  cis4 b b dis |
  % 4
  cis fis b,8 cis dis e |
  % 5
  e dis cis4 dis gis,8 a |
  % 6
  b4 cis d cis8 b |
  % 7
  cis4 b b dis |
  % 8
  cis fis b,8 cis dis e |
  % 9
  e dis cis4 dis e |
  % 10
  gis gis gis8 fis fis dis |
  % 11
  e b b4 b gis8 fis |
  % 12
  e4 f fis fis |
  % 13
  gis8. a16 b8 fis gis2 |
  % 14
  
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
  s2. e,4 |
  % 2
  e' cis gis cis |
  % 3
  fis, gis8 a b4 b' |
  % 4
  ais gis8 fis gis ais b4 |
  % 5
  e, fis b, e, |
  % 6
  e' cis gis cis |
  % 7
  fis, gis8 a b4 b' |
  % 8
  ais gis8 fis gis ais b4 |
  % 9
  e, fis b, e8 dis |
  % 10
  cis4 gis a b |
  % 11
  cis8 dis e4 b b |
  % 12
  c cis d dis |
  % 13
  e b e,2 |
  % 14
  
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
