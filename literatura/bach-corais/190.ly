% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 190.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  e'4 e fis gis |
  % 2
  a2 gis |
  % 3
  gis4 gis a b |
  % 4
  c2 b |
  % 5
  c4 c b b |
  % 6
  a2 gis |
  % 7
  a4 a g g |
  % 8
  f2 e |
  % 9
  e'4 e d d |
  % 10
  c2 b |
  % 11
  a4 a g g |
  % 12
  f2 e |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  b'4 c d d |
  % 2
  e d e2 |
  % 3
  e4 e e8 fis gis4 |
  % 4
  a2 a4 gis |
  % 5
  g8 fis g a g4 f |
  % 6
  e fis e2 |
  % 7
  c4 f8 e d c d e |
  % 8
  d2 c |
  % 9
  g'4 g g g8 f |
  % 10
  e2 e |
  % 11
  c4 f f e2 d8 c b2 |
  % 13
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  g'4 a8 gis a4 b |
  % 2
  c b8 a b2 |
  % 3
  b4 b c d |
  % 4
  e2 e |
  % 5
  e4. d8 d4 d4. c4 b8 b2 |
  % 7
  a8 g f4 g d8 a' |
  % 8
  a4 g g2 |
  % 9
  c4 c2 b a gis4 |
  % 11
  a8 b c4 c c8 ais |
  % 12
  a c b a gis2 |
  % 13
  
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
  e8 d c4. d8 c b |
  % 2
  a g f4 e2 |
  % 3
  d'8 f e d c d c b |
  % 4
  a b c d e2 |
  % 5
  e8 d e fis g fis g gis |
  % 6
  a4 dis, e2 |
  % 7
  f8 e d c b a b cis |
  % 8
  d c b g c2 |
  % 9
  c8 d e f g a b g |
  % 10
  a, b c d e2 |
  % 11
  f,8 g a b c d e c |
  % 12
  d2 e |
  % 13
  
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
