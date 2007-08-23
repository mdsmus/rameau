% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 189.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  a a fis b |
  % 3
  a a gis cis |
  % 4
  cis cis fis e |
  % 5
  e dis e cis |
  % 6
  cis cis d cis |
  % 7
  b ais b cis |
  % 8
  cis cis b a |
  % 9
  a gis a2 |
  % 10
  
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
  e8 d cis b a4 fis'8 gis4 fis16 e fis4 e e |
  % 4
  a a a gis |
  % 5
  gis fis8 a a gis gis4 |
  % 6
  fis e fis g |
  % 7
  fis8 g fis e4 d8 a'4 |
  % 8
  a a4. gis4 fis8 |
  % 9
  e fis4 e8 e2 |
  % 10
  
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
  e4 e d dis |
  % 3
  e b b a |
  % 4
  e' fis b, b |
  % 5
  b b b cis8 b |
  % 6
  a gis ais4. b4 ais8 |
  % 7
  b e cis4 b e |
  % 8
  e fis fis8 cis cis4 |
  % 9
  cis8 b b cis16 d cis2 |
  % 10
  
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
  s2. a8 b |
  % 2
  cis b a4 d8 cis b4 |
  % 3
  cis dis e a4. gis8 fis e dis4 e8 fis |
  % 5
  gis a b4 e, f |
  % 6
  fis gis fis e |
  % 7
  d8 e fis4 b, a |
  % 8
  a'8 gis fis e dis f fis4 |
  % 9
  cis8 d e4 a,2 |
  % 10
  
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
