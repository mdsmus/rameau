% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 246.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 93 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g g d |
  % 2
  g a b2 |
  % 3
  g8 a b cis d4 fis |
  % 4
  e2 d |
  % 5
  g,4 g g d |
  % 6
  g a b2 |
  % 7
  g8 a b cis d4 fis |
  % 8
  e2 d |
  % 9
  e4 d c e |
  % 10
  d c b2 |
  % 11
  a a4 gis |
  % 12
  a b c c |
  % 13
  b2 g4 a |
  % 14
  b c c b |
  % 15
  c2 d4. c8 |
  % 16
  b4 a g8 a b4 |
  % 17
  a2 g |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'8 c b c d4 d |
  % 2
  e16 fis g4 fis8 g2 |
  % 3
  d4 d8 g fis4 a |
  % 4
  b8 g e a16 g fis2 |
  % 5
  d8 c b c d4 d |
  % 6
  e16 fis g4 fis8 g2 |
  % 7
  d4 d8 g fis4 a |
  % 8
  b8 g e a16 g fis2 |
  % 9
  g8 e fis gis a4 e |
  % 10
  a8 gis a4 a8 gis16 fis gis4 |
  % 11
  e2 e4 e |
  % 12
  e e e e |
  % 13
  e2 e4. d16 c |
  % 14
  d8 g4 f16 e a4 g |
  % 15
  g2 g4 fis |
  % 16
  d d e8 fis g4. fis16 e fis4 d2 |
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
  b'8 c d c b c b a |
  % 2
  b4 e8 d d2 |
  % 3
  b8 a g4 a d4. cis16 b cis4 a2 |
  % 5
  b8 c d c b c b a |
  % 6
  b4 e8 d d2 |
  % 7
  b8 a g4 a d4. cis16 b cis4 a2 |
  % 9
  c4 d e8 d c b |
  % 10
  a b c d16 e f8 d b e16 d |
  % 11
  c2 c4 b |
  % 12
  c b4. a16 gis a2 gis4 b8 c16 b a4 |
  % 14
  g8 b a16 b c8 d4. f8 |
  % 15
  e2 d4 a |
  % 16
  g a b8 c d4 |
  % 17
  e8 c a d16 c b2 |
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
  g'8 a b a g a g fis |
  % 2
  e d c d g,2 |
  % 3
  g'8 fis g e fis e d e16 fis |
  % 4
  g8 e a4 d,2 |
  % 5
  g8 a b a g a g fis |
  % 6
  e d c d g,2 |
  % 7
  g'8 fis g e fis e d e16 fis |
  % 8
  g8 e a4 d,2 |
  % 9
  c'4. b8 a4. g8 |
  % 10
  f4. e8 d b e4 |
  % 11
  a,2 a8 c e d |
  % 12
  c b a gis a b c d |
  % 13
  e2 e8 c f4. e8 a g f d g4 |
  % 15
  c,2 b8 c d4 |
  % 16
  g,8 g'4 fis8 e d c b |
  % 17
  c a d4 g,2 |
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
