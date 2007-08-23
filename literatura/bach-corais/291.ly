% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 291.mid
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
  s2. a''4 |
  % 2
  fis e8 d a'4 a |
  % 3
  b2. b4 |
  % 4
  e, e a g |
  % 5
  fis e d a' |
  % 6
  b b a g |
  % 7
  fis2. e4 |
  % 8
  fis gis a b8 cis16 d |
  % 9
  cis4 b8 a a4 a |
  % 10
  a a d c |
  % 11
  b2. b4 |
  % 12
  b b e d |
  % 13
  cis2. a4 |
  % 14
  b a b cis |
  % 15
  d2. a4 |
  % 16
  a g8 fis e fis16 g e4 |
  % 17
  d2. 
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
  d cis d fis |
  % 3
  g2. e4 |
  % 4
  e8 d cis4 d e |
  % 5
  e8 d4 cis8 a4 d |
  % 6
  d g g8 fis e4 |
  % 7
  d2. e4 |
  % 8
  d d cis fis |
  % 9
  e2 e4 e |
  % 10
  fis8 e fis g a4 fis |
  % 11
  g2. a4 |
  % 12
  a gis gis8 fis fis e |
  % 13
  e2. d4 |
  % 14
  d d g8 fis g4 |
  % 15
  fis2. e4 |
  % 16
  fis8 e d4 d cis |
  % 17
  a2. 
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
  a g a d |
  % 3
  d2. d4 |
  % 4
  cis8 b a4 a a |
  % 5
  a2 fis4 a |
  % 6
  g b cis8 d d cis |
  % 7
  a2. a4 |
  % 8
  a b a a |
  % 9
  a gis cis cis |
  % 10
  d d a d |
  % 11
  d2. fis4 |
  % 12
  e b b8 a a gis |
  % 13
  a2. a4 |
  % 14
  g a e'8 d e4 |
  % 15
  d2. e4 |
  % 16
  a, b b a8 g |
  % 17
  fis2. 
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
  s2. cis4 |
  % 2
  d e fis d |
  % 3
  g2. gis4 |
  % 4
  a a8 g fis e d cis |
  % 5
  d4 a d fis |
  % 6
  g e a a, |
  % 7
  d2. cis4 |
  % 8
  d cis8 b fis'4 e8 d |
  % 9
  e2 a,4 a' |
  % 10
  d d,8 e fis4 d |
  % 11
  g2. dis4 |
  % 12
  e8 fis e d cis d e4 |
  % 13
  a,2. fis'4 |
  % 14
  g fis e ais, |
  % 15
  b2. cis4 |
  % 16
  d8 cis b a g4 a |
  % 17
  d2. 
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
