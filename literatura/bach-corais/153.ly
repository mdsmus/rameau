% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 153.mid
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
  a''4 d a b |
  % 2
  a4. g8 fis4 fis |
  % 3
  a a g fis |
  % 4
  e4. d8 d2 |
  % 5
  a'4 d a b |
  % 6
  a4. g8 fis4 fis |
  % 7
  a a g fis |
  % 8
  e4. d8 d2 |
  % 9
  e4 e fis8 gis a4 |
  % 10
  a4. gis8 a4 a |
  % 11
  b4. cis8 d4 d |
  % 12
  cis4. cis8 b4 b |
  % 13
  fis fis b a |
  % 14
  a gis a2 |
  % 15
  b4 a g fis |
  % 16
  e4. d8 d2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 d d d |
  % 2
  d cis d d |
  % 3
  d d8 cis b cis d2 cis4 d2 |
  % 5
  d4 d d d |
  % 6
  d cis d d |
  % 7
  d d8 cis b cis d2 cis4 d2 |
  % 9
  cis4 cis d cis |
  % 10
  fis e8 d cis4 cis |
  % 11
  e8 fis g4 fis fis |
  % 12
  fis4. e8 d4 d |
  % 13
  d d d cis |
  % 14
  d d cis2 |
  % 15
  d4 d8 cis b cis d4 |
  % 16
  d cis d2 |
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
  fis4 fis8 g a4 g8 fis |
  % 2
  e d e4 d d |
  % 3
  fis fis g a |
  % 4
  b a8. g16 fis2 |
  % 5
  fis4 fis8 g a4 g8 fis |
  % 6
  e d e4 d d |
  % 7
  fis fis g a |
  % 8
  b a8. g16 fis2 |
  % 9
  a4 a a a |
  % 10
  b b a a |
  % 11
  g4. a8 b2. ais4 b2 |
  % 13
  a4 a g8 fis e4 |
  % 14
  d8 fis e d e2 |
  % 15
  g4 fis g a |
  % 16
  b a8. g16 fis2 |
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
  d4 b fis g |
  % 2
  a a d, d |
  % 3
  d' d e fis |
  % 4
  g8 fis a a, d2 |
  % 5
  d4 b fis g |
  % 6
  a a d, d |
  % 7
  d' d e fis |
  % 8
  g8 fis a a, d2 |
  % 9
  a4 a d fis8 e |
  % 10
  d4 e a,2 |
  % 11
  e' b8 cis d e |
  % 12
  fis2 b, |
  % 13
  d4 d g, a |
  % 14
  b2 a |
  % 15
  g4 d' e fis |
  % 16
  g8 e a a, d2 |
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
