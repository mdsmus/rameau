% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 080.mid
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
  g fis e a |
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
  d d d8 e e d |
  % 3
  d4 cis d e |
  % 4
  d8 e fis4 fis4. e8 |
  % 5
  d2. d4 |
  % 6
  d d d8 e e d |
  % 7
  d4 cis d e |
  % 8
  d8 e fis4 fis4. e8 |
  % 9
  d2. fis4 |
  % 10
  e8 g fis e d4 g |
  % 11
  g fis8 e fis4 fis |
  % 12
  g fis fis e |
  % 13
  dis2. e4 |
  % 14
  e e fis8 gis a4 |
  % 15
  a gis a d,8 cis |
  % 16
  b cis d4 d8 b cis4 |
  % 17
  d1 |
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
  g a b8 a a4 |
  % 3
  b a a ais |
  % 4
  b b b ais |
  % 5
  b2. a4 |
  % 6
  g a b8 a a4 |
  % 7
  b a a ais |
  % 8
  b b b ais |
  % 9
  b2. b8 a |
  % 10
  g b d cis b a g a |
  % 11
  b4 a8 g a4 d |
  % 12
  d c b b |
  % 13
  b2. b4 |
  % 14
  a b a8 b cis a |
  % 15
  fis'4 e e a, |
  % 16
  g a a a |
  % 17
  a1 |
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
  g fis b,8 cis d4 |
  % 3
  g, a d cis |
  % 4
  b8 cis d e fis4 fis, |
  % 5
  b2. d4 |
  % 6
  g fis b,8 cis d4 |
  % 7
  g, a d cis |
  % 8
  b8 cis d e fis4 fis, |
  % 9
  b2. b4 |
  % 10
  e fis g8 fis e4 |
  % 11
  d2 d4 d |
  % 12
  g8 fis e dis e fis g a |
  % 13
  b2. gis4 |
  % 14
  a gis fis e |
  % 15
  dis e a, d |
  % 16
  e fis8 g a4 a, |
  % 17
  d1 |
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
