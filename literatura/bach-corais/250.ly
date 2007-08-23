% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 250.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  d d a8 b cis4 |
  % 3
  d8 cis b4 a d |
  % 4
  cis b a b8 a |
  % 5
  g fis e4 d d' |
  % 6
  d d a8 b cis4 |
  % 7
  d8 cis b4 a d |
  % 8
  cis b a b8 a |
  % 9
  g fis e4 d d |
  % 10
  a' b a gis |
  % 11
  a d, a' b8 cis |
  % 12
  d4 cis d8 cis b4 |
  % 13
  a b b a |
  % 14
  b8 a g4 fis d' |
  % 15
  cis b a b8 a |
  % 16
  g fis e4 d2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a''4 |
  % 2
  a8 g fis g a fis g a |
  % 3
  fis e d e cis4 fis |
  % 4
  e8 fis g4 fis8 e d4 |
  % 5
  d cis a a' |
  % 6
  a8 g fis g a fis g a |
  % 7
  fis e d e cis4 fis |
  % 8
  e8 fis g4 fis8 e d4 |
  % 9
  d cis a d |
  % 10
  cis8 fis e d cis d b4 |
  % 11
  a d d g8 g |
  % 12
  fis4 fis fis16 gis a8 a gis |
  % 13
  a4 g g fis |
  % 14
  fis e dis fis8 gis |
  % 15
  a4 g g fis8 e |
  % 16
  d4 cis a2 |
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
  s2. fis'8 e |
  % 2
  d4 c8 b d4 e |
  % 3
  a, a8 gis a4 fis8 gis |
  % 4
  a4 e'8 d cis4 b8 cis |
  % 5
  d4 a8 g fis4 fis'8 e |
  % 6
  d4 c8 b d4 e |
  % 7
  a, a8 gis a4 fis8 gis |
  % 8
  a4 e'8 d cis4 b8 cis |
  % 9
  d4 a8 g fis4 fis8 gis |
  % 10
  a d cis b e fis e d |
  % 11
  cis4 fis,8 g a4 e'8 e |
  % 12
  d4 a b8 e fis e |
  % 13
  cis4 b8 cis d4 d8 c |
  % 14
  b4 b b b |
  % 15
  e e e d8 a |
  % 16
  b4 e,8 a fis2 |
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
  s2. d'8 cis |
  % 2
  b4 a8 g fis4 e |
  % 3
  d e a, b |
  % 4
  cis8 d e4 fis g8 a |
  % 5
  b g a a, d4 d'8 cis |
  % 6
  b4 a8 g fis4 e |
  % 7
  d e a, b |
  % 8
  cis8 d e4 fis g8 a |
  % 9
  b g a a, d4 d8 e |
  % 10
  fis4 gis a8 d, e4 |
  % 11
  a, b fis' e8 a, |
  % 12
  d4 fis b,8 cis d e |
  % 13
  a,4 e' b8 cis d4 |
  % 14
  dis e b b |
  % 15
  cis8 d e d cis a d cis |
  % 16
  b g a4 d2 |
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
