% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024853b5.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  a''4 b cis8 d e4 |
  % 2
  a, gis fis e |
  % 3
  fis gis a b |
  % 4
  cis8 d b4 a2 |
  % 5
  a4 b cis8 d e4 |
  % 6
  a, gis fis e |
  % 7
  fis gis a b |
  % 8
  cis8 d b4 a2 |
  % 9
  cis4 cis b cis |
  % 10
  d cis8 b b a b4 |
  % 11
  fis gis a b |
  % 12
  cis8 d b4 a8 gis a4 |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 e a4. gis4 fis e dis8 b4 |
  % 3
  d8 cis b4 e e |
  % 4
  e8 fis e4 e2 |
  % 5
  e4 e a4. gis4 fis e dis8 b4 |
  % 7
  d8 cis b4 e e |
  % 8
  e8 fis e4 e2 |
  % 9
  a4 a e8 fis gis4 |
  % 10
  fis e8 fis gis fis gis4 |
  % 11
  cis,8 d e4. d16 cis fis4 |
  % 12
  e e e8 d e4 |
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
  cis'4 b a8 b cis d |
  % 2
  e b b4 b8. a16 gis4 |
  % 3
  b8 cis d e a,4 e |
  % 4
  a4. gis8 cis2 |
  % 5
  cis4 b a8 b cis d |
  % 6
  e b b4 b8. a16 gis4 |
  % 7
  b8 cis d e a,4 e |
  % 8
  a4. gis8 cis2 |
  % 9
  e4. dis8 e d cis b |
  % 10
  a b cis dis e4 e |
  % 11
  ais,8 b4. a4 a4. b8 gis d' cis b cis4 |
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
  a'4 gis fis cis8 b |
  % 2
  cis dis e4 b e |
  % 3
  b b'8 cis16 d cis8 b a gis |
  % 4
  a d, e4 a,2 |
  % 5
  a'4 gis fis cis8 b |
  % 6
  cis dis e4 b e |
  % 7
  b b'8 cis16 d cis8 b a gis |
  % 8
  a d, e4 a,2 |
  % 9
  a'8 gis fis4 gis8 fis e4 |
  % 10
  fis8 gis a4 e e |
  % 11
  e8 d cis b cis fis e d |
  % 12
  e4 e, a a |
  % 13
  
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
