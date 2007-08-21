% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 014500ba.mid
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
  a''4 g8 fis b4 cis |
  % 2
  d d cis2 |
  % 3
  b8 cis d4 a8 g fis4 |
  % 4
  g fis e d |
  % 5
  a' g8 fis b4 cis |
  % 6
  d d cis2 |
  % 7
  b8 cis d4 a8 g fis4 |
  % 8
  g fis e d |
  % 9
  fis gis ais b8 cis |
  % 10
  d4 cis b2 |
  % 11
  cis4 d e fis |
  % 12
  e e d2 |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  fis'4 e8 d d e4 fis8 |
  % 2
  fis4. e8 e2 |
  % 3
  e4 d e d |
  % 4
  d d d8 cis a4 |
  % 5
  fis' e8 d d e4 fis8 |
  % 6
  fis4. e8 e2 |
  % 7
  e4 d e d |
  % 8
  d d d8 cis a4 |
  % 9
  b8 fis'4 e8 fis4 fis8 e |
  % 10
  fis4 fis fis2 |
  % 11
  g4 a a a |
  % 12
  b a8 g fis2 |
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
  a'4 a4. g4 a16 g |
  % 2
  fis8 b a gis a2 |
  % 3
  b4 a a a |
  % 4
  g a8 b b a16 g fis4 |
  % 5
  a a4. g4 a16 g |
  % 6
  fis8 b a gis a2 |
  % 7
  b4 a a a |
  % 8
  g a8 b b a16 g fis4 |
  % 9
  b b cis b |
  % 10
  b ais8 e' d2 |
  % 11
  e4 fis e d |
  % 12
  d cis a2 |
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
  d4 d g, a |
  % 2
  b e a,2 |
  % 3
  g'4 fis cis d8 c |
  % 4
  b ais a gis a4 d |
  % 5
  d d g, a |
  % 6
  b e a,2 |
  % 7
  g'4 fis cis d8 c |
  % 8
  b ais a gis a4 d |
  % 9
  dis e4. d8 g4 |
  % 10
  fis8 e fis4 b,2 |
  % 11
  e4 d d8 cis d4 |
  % 12
  g a d,2 |
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
