% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 079.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  c''4 c d e2 d4 c2 |
  % 3
  b4 c2. |
  % 4
  c4 c c d |
  % 5
  c b a2 |
  % 6
  gis4 a2 b4 |
  % 7
  c2 d4 e4. f8 g4 f e |
  % 9
  d e2. |
  % 10
  e4 e e d2 d4 e d |
  % 12
  c b2. |
  % 13
  b4 b cis d |
  % 14
  c b a2 |
  % 15
  gis4 a2 b4 |
  % 16
  c2 d4 e2 e4 e dis2 e2. |
  % 19
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'8 f g4 g g2 f4 e d2 e2. |
  % 4
  f4 g f f |
  % 5
  e d e f |
  % 6
  e e2 e4 |
  % 7
  e2 g4 g2 g4 c b |
  % 9
  a gis2. |
  % 10
  a4 g8 f g a b4 |
  % 11
  g a b2 |
  % 12
  a4 gis2. |
  % 13
  g8 a g f e4 d |
  % 14
  e f e f |
  % 15
  e e2 gis4 |
  % 16
  a2 g4 g2 fis4 fis gis |
  % 18
  a gis2. |
  % 19
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  c'4 c b c |
  % 2
  b a g a |
  % 3
  g g2. |
  % 4
  a4 g a gis |
  % 5
  a b c b2 c gis4 |
  % 7
  a8 b c4 b c2 d4 c e |
  % 9
  f b,2. |
  % 10
  c4 c c d8 c |
  % 11
  d e f4 e2 |
  % 12
  e4 e2. |
  % 13
  e4 e a, a2 gis4 a d |
  % 15
  b c2 e4 |
  % 16
  e f d c2 c4 b2 |
  % 18
  b4 b2. |
  % 19
  
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
  a'4 e g c,2 d4 e f |
  % 3
  g c,2. |
  % 4
  f4 e f b, |
  % 5
  c d c d |
  % 6
  e a,2 e'4 |
  % 7
  a2 g4 c2 b4 a g |
  % 9
  f e2. |
  % 10
  a4 e c g' |
  % 11
  b a gis2 |
  % 12
  a4 e2. |
  % 13
  e8 d e f g4 f |
  % 14
  e d c d |
  % 15
  e a,2 e'4 |
  % 16
  a2 b4 c |
  % 17
  b a b2 |
  % 18
  b,4 e2. |
  % 19
  
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
