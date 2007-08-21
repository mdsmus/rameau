% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 008008b_.mid
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
  a2 d,4 a' |
  % 12
  b cis d cis |
  % 13
  d cis b2 |
  % 14
  a4 b b a |
  % 15
  b8 a g4 fis d' |
  % 16
  cis b a b8 a |
  % 17
  g fis e4 d2 |
  % 18
  
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
  a8 g fis e d4 e |
  % 3
  a,8 a'4 gis8 e4 b' |
  % 4
  e,8 fis g4 fis8 e d cis |
  % 5
  b4 cis a a' |
  % 6
  a8 g fis e d4 e |
  % 7
  a,8 a'4 gis8 e4 b' |
  % 8
  e,8 fis g4 fis8 e d cis |
  % 9
  b4 cis a d |
  % 10
  cis8 fis e4 e8 fis e4 |
  % 11
  e2 d4 d8 c |
  % 12
  b d g4 fis fis |
  % 13
  fis e8 a fis4 e8 d |
  % 14
  cis4 e d8 e fis4 |
  % 15
  fis fis8 e dis4 fis |
  % 16
  e d8 g g fis16 e fis4 |
  % 17
  g8 b, cis4 a2 |
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
  s2. fis'8 e |
  % 2
  d e fis g a4 g |
  % 3
  fis b,8 e cis4 fis,8 gis |
  % 4
  a4 e'8 d cis4 b8 cis |
  % 5
  d4 a8 g fis4 fis'8 e |
  % 6
  d e fis g a4 g |
  % 7
  fis b,8 e cis4 fis,8 gis |
  % 8
  a4 e'8 d cis4 b8 cis |
  % 9
  d4 a8 g fis4 fis8 g |
  % 10
  a d cis b cis4 b |
  % 11
  cis2 fis,8 g a4 |
  % 12
  d e a, a |
  % 13
  a8 gis a4 a gis |
  % 14
  e g8 a b cis d c |
  % 15
  b4 b b b8 a |
  % 16
  g a b4 e8 cis d4 |
  % 17
  d a8 g fis2 |
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
  s2. d'8 cis |
  % 2
  b4 a8 g fis g fis e |
  % 3
  d4 e a, b |
  % 4
  cis8 d e4 fis g8 a |
  % 5
  b g a a, d4 d'8 cis |
  % 6
  b4 a8 g fis g fis e |
  % 7
  d4 e a, b |
  % 8
  cis8 d e4 fis g8 a |
  % 9
  b g a a, d4 d8 e |
  % 10
  fis4 gis a8 d, e4 |
  % 11
  a,2 b4 fis' |
  % 12
  g e d fis |
  % 13
  b, cis d e |
  % 14
  a, e'8 fis g4 d |
  % 15
  dis e b b |
  % 16
  e8 fis g e cis a d cis |
  % 17
  b g a4 d,2 |
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
