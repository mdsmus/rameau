% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 141.mid
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
  a''4 a gis a |
  % 2
  b2 a4 b |
  % 3
  cis b a2 |
  % 4
  cis4 d e d |
  % 5
  cis b cis2 |
  % 6
  b a4 b |
  % 7
  cis b a gis |
  % 8
  a4. gis8 gis2 |
  % 9
  a4 a gis a |
  % 10
  b2 a4 b |
  % 11
  cis b8 a a2 |
  % 12
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 e e e8 fis |
  % 2
  gis2 fis4 e |
  % 3
  e e e2 |
  % 4
  a4 a a4. b4 a8 gis b4 a16 gis a4 |
  % 6
  gis2 fis4. e8 |
  % 7
  e a fis gis4 fis f8 |
  % 8
  fis f fis2 e4 |
  % 9
  fis e e e |
  % 10
  e2 cis8 fis e4. a8 gis4 e2 |
  % 12
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  cis'4 cis b cis |
  % 2
  e2 cis8 d cis b4 a gis8 cis2 |
  % 4
  e4 fis e fis8 e |
  % 5
  e4 e e2 |
  % 6
  e cis4 b |
  % 7
  a4. gis8 cis c16 cis dis8 cis |
  % 8
  cis1 |
  % 9
  cis4 cis b a2 gis4 a8 d cis b |
  % 11
  a e' e8. d16 cis2 |
  % 12
  
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
  a8 b cis d e4 a, |
  % 2
  e'2 fis4 gis |
  % 3
  a e a,2 |
  % 4
  a'8 gis fis4 cis fis8 gis |
  % 5
  a4 e8 gis a4 a, |
  % 6
  e'2 fis4 gis |
  % 7
  a8 fis dis f fis dis c cis |
  % 8
  fis, gis a b cis2 |
  % 9
  fis4 cis8 d e4 cis8 a |
  % 10
  e'2 fis4 gis |
  % 11
  a e a,2 |
  % 12
  
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
