% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 031.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. c''4 |
  % 2
  c a8 b c d e4 |
  % 3
  d8 e16 f d4 c c |
  % 4
  b a8 b c4 d8 c |
  % 5
  b2 a4 c |
  % 6
  c a8 b c d e4 |
  % 7
  d8 e16 f d4 c c |
  % 8
  b a8 b c4 d8 c |
  % 9
  b2 a4 d |
  % 10
  e e b8 c d4 |
  % 11
  c c b c |
  % 12
  d a8 b c4 b |
  % 13
  a16 b c8 a4 g c |
  % 14
  b a8 b c4 d8 c |
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
  s2. e'8 f |
  % 2
  g4 f g g |
  % 3
  a g8 f e4 fis |
  % 4
  g f e a |
  % 5
  a gis e e8 f |
  % 6
  g4 f g g |
  % 7
  a g8 f e4 fis |
  % 8
  g f e a |
  % 9
  a gis e g |
  % 10
  g g d8 e f4 |
  % 11
  e a gis a |
  % 12
  a8 g fis4 e d8 g |
  % 13
  g e fis4 d e |
  % 14
  d8 e fis f e4 a2 gis4 e2 |
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
  c c c c |
  % 3
  c b g a |
  % 4
  d d c8 b a4 |
  % 5
  f' e8 d cis4 c |
  % 6
  c c c c |
  % 7
  c b g a |
  % 8
  d d c8 b a4 |
  % 9
  f' e8 d cis4 b |
  % 10
  c g8 a b4 a8 b |
  % 11
  c d e4 e e |
  % 12
  a, d g,8 a b d |
  % 13
  e4 d8 c b4 g8 a |
  % 14
  b c d4 c8 b a c |
  % 15
  f d b e cis2 |
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
  s2. a'4 |
  % 2
  e f e8 d c4 |
  % 3
  f g c, a' |
  % 4
  g d' a8 g f e |
  % 5
  d4 e a, a' |
  % 6
  e f e8 d c4 |
  % 7
  f g c, a' |
  % 8
  g d' a8 g f e |
  % 9
  d4 e a, g |
  % 10
  c8 d e f g4 f |
  % 11
  a,8 b c d e4 a8 g |
  % 12
  fis e d4 e8 fis g4 |
  % 13
  c, d g, e'8 fis |
  % 14
  g4 fis8 gis a g f e |
  % 15
  d b e4 a,2 |
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
