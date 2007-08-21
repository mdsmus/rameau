% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 031700b_.mid
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
  a''4 a b cis |
  % 2
  d d cis b |
  % 3
  d a fis g |
  % 4
  fis e d2 |
  % 5
  a'4 a b cis |
  % 6
  d d cis b |
  % 7
  d a fis g |
  % 8
  fis e d2 |
  % 9
  d4 e fis4. e8 |
  % 10
  d4 e fis d' |
  % 11
  cis d e4. d8 |
  % 12
  cis4 b a a |
  % 13
  a d cis a |
  % 14
  b8 a g4 fis e |
  % 15
  fis g a4. g8 |
  % 16
  fis4 e d2 |
  % 17
  d4 e fis4. e8 |
  % 18
  d4 e fis d' |
  % 19
  cis d e4. d8 |
  % 20
  cis4 b a a |
  % 21
  a d cis a |
  % 22
  b8 a g4 fis e |
  % 23
  fis g a4. g8 |
  % 24
  fis4 e d2 |
  % 25
  d4 e fis4. e8 |
  % 26
  d4 e fis a |
  % 27
  a a fis g |
  % 28
  fis e d2 |
  % 29
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  fis'4 fis g g |
  % 2
  a a8 gis a4 g |
  % 3
  fis e e8 d4 cis8 |
  % 4
  d4. cis8 a2 |
  % 5
  fis'4 fis g g |
  % 6
  a a8 gis a4 g |
  % 7
  fis e e8 d4 cis8 |
  % 8
  d4. cis8 a2 |
  % 9
  a4 a8 e'4 d cis8 |
  % 10
  b4 b cis d8 e |
  % 11
  fis4 fis8 b4 a16 gis a2 gis4 e e |
  % 13
  fis fis e d8 e |
  % 14
  fis4. e4 dis8 e4. d4 cis d e d cis8 a2 |
  % 17
  a4 a8 e'4 d cis8 |
  % 18
  b4 b cis d8 e |
  % 19
  fis4 fis8 b4 a16 gis a2 gis4 e e |
  % 21
  fis fis e d8 e |
  % 22
  fis4. e4 dis8 e4. d4 cis d e d cis8 a2 |
  % 25
  a4 a8 e'4 d cis8 |
  % 26
  d4 b8 e d4 d4. e8 fis e d4. e4 d cis8 a2 |
  % 29
  
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
  fis8 e d4 e e |
  % 3
  d e8 a, a4 g |
  % 4
  a4. a16 g fis2 |
  % 5
  d'4 d d e |
  % 6
  fis8 e d4 e e |
  % 7
  d e8 a, a4 g |
  % 8
  a4. a16 g fis2 |
  % 9
  fis4 a a a8 g |
  % 10
  fis4 b ais b4. a8 fis'4 e cis8 d |
  % 12
  e4. d8 cis4 cis |
  % 13
  d a a8 g fis4 |
  % 14
  b b b b8 a |
  % 15
  a4 g fis8 a b4 |
  % 16
  a4. g8 fis2 |
  % 17
  fis4 a a a8 g |
  % 18
  fis4 b ais b4. a8 fis'4 e cis8 d |
  % 20
  e4. d8 cis4 cis |
  % 21
  d a a8 g fis4 |
  % 22
  b b b b8 a |
  % 23
  a4 g fis8 a b4 |
  % 24
  a4. g8 fis2 |
  % 25
  a4 a a a |
  % 26
  a8 fis g a a4 fis8 g |
  % 27
  a b cis4 d8 cis b4 |
  % 28
  a4. g8 fis2 |
  % 29
  
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
  d4 d g8 fis e4 |
  % 2
  d8 cis b4 a e' |
  % 3
  b cis d e |
  % 4
  fis8 g a4 d,2 |
  % 5
  d4 d g8 fis e4 |
  % 6
  d8 cis b4 a e' |
  % 7
  b cis d e |
  % 8
  fis8 g a4 d,2 |
  % 9
  d4 cis d a |
  % 10
  b8 a g4 fis b |
  % 11
  fis' d cis fis |
  % 12
  e e, a a'8 g |
  % 13
  fis e d4 a d |
  % 14
  dis e b cis |
  % 15
  d e fis g |
  % 16
  a a, d2 |
  % 17
  d4 cis d a |
  % 18
  b8 a g4 fis b |
  % 19
  fis' d cis fis |
  % 20
  e e, a a'8 g |
  % 21
  fis e d4 a d |
  % 22
  dis e b cis |
  % 23
  d e fis g |
  % 24
  a a, d2 |
  % 25
  fis4 cis d a'8 g |
  % 26
  fis d4 cis8 d4 d8 e |
  % 27
  fis g a4 b8 a g4 |
  % 28
  a a, d2 |
  % 29
  
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
