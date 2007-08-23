% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 152.mid
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
  a''4 a b b |
  % 2
  cis cis d2 |
  % 3
  e4 e d d |
  % 4
  cis b8 cis16 d b2 |
  % 5
  a a4 a |
  % 6
  b b a g |
  % 7
  fis2 a4 a |
  % 8
  g g fis e8 fis16 g |
  % 9
  e2 d |
  % 10
  d'4 d cis cis |
  % 11
  b b a2 |
  % 12
  a4 a g fis |
  % 13
  e e d2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  fis'8 g a4 a g |
  % 2
  g8 e a g fis2 |
  % 3
  a4 a a gis8 fis |
  % 4
  e4 e fis e |
  % 5
  e2 fis8 g a4 |
  % 6
  a g g8 fis fis e |
  % 7
  d2 cis4 fis |
  % 8
  fis8 e16 d e4. d8 d4 |
  % 9
  d cis a2 |
  % 10
  fis'4 fis fis e |
  % 11
  fis e e2 |
  % 12
  fis4 fis fis8 e4 d8 |
  % 13
  d cis16 b cis4 a2 |
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
  d'4 d d e |
  % 2
  e a, a2 |
  % 3
  cis4 cis cis b |
  % 4
  b8 a a4 a gis |
  % 5
  cis2 d4 d |
  % 6
  d e e8 cis d a |
  % 7
  a2 a4 b |
  % 8
  b a a b |
  % 9
  a g fis2 |
  % 10
  b4 b a a |
  % 11
  a gis cis2 |
  % 12
  cis4 d d8 a a b |
  % 13
  b g e a fis2 |
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
  d8 e fis d g fis g e |
  % 2
  a g fis e d2 |
  % 3
  a8 b cis a b cis d b |
  % 4
  cis d e cis d b e4 |
  % 5
  a,2 d8 e fis d |
  % 6
  g fis e d cis a b cis |
  % 7
  d2 fis8 e dis b |
  % 8
  e d cis a d fis g e |
  % 9
  a g a a, d2 |
  % 10
  b8 cis d e fis gis a fis |
  % 11
  dis b e4 a,2 |
  % 12
  fis'8 e d cis b cis d b |
  % 13
  g e a4 d,2 |
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
