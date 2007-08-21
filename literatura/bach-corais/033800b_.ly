% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 033800b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  c b a a |
  % 3
  g f e e |
  % 4
  fis gis a c |
  % 5
  b2 a4 a |
  % 6
  c b a a |
  % 7
  g f e e |
  % 8
  fis gis a c |
  % 9
  b2 a4 b |
  % 10
  b b b g |
  % 11
  a b c b |
  % 12
  b b c b |
  % 13
  a a gis gis |
  % 14
  a b c d |
  % 15
  b2 a |
  % 16
  
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
  a a8 g f4 f4. e4 d8 cis4 e |
  % 4
  d8. e16 f8 e e fis16 gis a4 |
  % 5
  a gis e e |
  % 6
  a a8 g f4 f4. e4 d8 cis4 e |
  % 8
  d8. e16 f8 e e fis16 gis a4 |
  % 9
  a gis e g |
  % 10
  fis g fis4. e4 d e8 e4 e |
  % 12
  fis16 g a4 gis8 a4. g4 f16 e d4 e e |
  % 14
  e e4. a16 gis a4. gis16 fis gis4 e2 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. c'4 |
  % 2
  e e8. d16 c4 d4. a8 a4 a a |
  % 4
  a d8 c16 b c8 d e4 |
  % 5
  f8 d b e16 d c4 c |
  % 6
  e e8. d16 c4 d4. a8 a4 a a |
  % 8
  a d8 c16 b c8 d e4 |
  % 9
  f8 d b e16 d c4 e |
  % 10
  dis e b b8 c4 d16 c b a b8 a4 g |
  % 12
  b e e e8. d16 |
  % 13
  c4 b8 a b4 b |
  % 14
  c b a4. f'8 |
  % 15
  e b e d cis2 |
  % 16
  
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
  s2. a4 |
  % 2
  a' e f8 e d c |
  % 3
  b cis d4 a c4. d16 c b8 e c b a c |
  % 5
  d b e4 a, a |
  % 6
  a' e f8 e d c |
  % 7
  b cis d4 a c4. d16 c b8 e c b a c |
  % 9
  d b e4 a, e' |
  % 10
  b'8 a g fis e dis e4 |
  % 11
  fis gis a e |
  % 12
  dis d c8 d e4 |
  % 13
  f8 e f4 e e8 d |
  % 14
  c b a gis a4 f'8 d |
  % 15
  e2 a, |
  % 16
  
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
