% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 027100b_.mid
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
  s2. fis'4 |
  % 2
  b a g fis |
  % 3
  e2 fis4 cis' |
  % 4
  d d cis8 b cis4 |
  % 5
  b2. fis4 |
  % 6
  b a g fis |
  % 7
  e2 fis4 cis' |
  % 8
  d d cis8 b cis4 |
  % 9
  b2. d4 |
  % 10
  cis8 b a4 b cis |
  % 11
  d2 d4 a |
  % 12
  b a g g |
  % 13
  fis2. d'4 |
  % 14
  cis8 d e4 d cis |
  % 15
  b2 cis4 fis, |
  % 16
  g fis e a8 g |
  % 17
  fis1 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  d d e a, |
  % 3
  b a a fis' |
  % 4
  fis fis fis fis8 e |
  % 5
  d2. d4 |
  % 6
  d d e a, |
  % 7
  b a a fis' |
  % 8
  fis fis fis fis8 e |
  % 9
  d2. fis4 |
  % 10
  g fis8 e d4 g |
  % 11
  g fis8 e fis4 fis |
  % 12
  g fis fis e |
  % 13
  dis2. e4 |
  % 14
  e a8 gis fis gis a4 |
  % 15
  a gis a a, |
  % 16
  e' a,8 b cis d e4. cis8 d4 cis2 |
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
  s2. a'4 |
  % 2
  g a b8 cis d4 |
  % 3
  d cis d cis2 b4 b ais |
  % 5
  b2. a4 |
  % 6
  g a b8 cis d4 |
  % 7
  d cis d cis2 b4 b ais |
  % 9
  b2. b8 a |
  % 10
  g4 d'8 cis b a g a |
  % 11
  b4 a8 g a4 d |
  % 12
  d c b b |
  % 13
  b2. b4 |
  % 14
  a8 b cis4 d e |
  % 15
  fis e e d8 cis |
  % 16
  b cis d4 a8 b cis4. fis,8 b4 ais2 |
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
  s2. d4 |
  % 2
  g fis e d |
  % 3
  g, a d ais |
  % 4
  b8 cis d e fis4 fis, |
  % 5
  b2. d4 |
  % 6
  g fis e d |
  % 7
  g, a d ais |
  % 8
  b8 cis d e fis4 fis, |
  % 9
  b2. b'4 |
  % 10
  e, fis g8 fis e4 |
  % 11
  d2 d4 d |
  % 12
  g8 fis e dis e fis g e |
  % 13
  b'2. gis4 |
  % 14
  a a, b cis |
  % 15
  d e a, d |
  % 16
  e fis8 g a g fis e |
  % 17
  d4 cis8 b fis'2 |
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
