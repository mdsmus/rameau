% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024517b_.mid
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
  s2. a''4 |
  % 2
  a a gis e |
  % 3
  a b c c |
  % 4
  d c16 b c8 b4 b |
  % 5
  c d8 e16 f e4 c |
  % 6
  f f e8 d c d |
  % 7
  d2 c4 c |
  % 8
  b a g8 fis e fis |
  % 9
  g4 g a g |
  % 10
  f2 e4 e' |
  % 11
  d c8 b b2 |
  % 12
  a1 |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. c'8 d |
  % 2
  e4 e e b |
  % 3
  e8 fis gis4 a a |
  % 4
  a2 gis4 gis |
  % 5
  a g g f |
  % 6
  a a a e |
  % 7
  a g g a |
  % 8
  a8 g g fis e4 e |
  % 9
  e8 d cis d e4 e |
  % 10
  e d cis a' |
  % 11
  a8 b e, d f4 e8 d |
  % 12
  cis1 |
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
  s2. a'8 b |
  % 2
  c4 c b gis |
  % 3
  a d e e |
  % 4
  f a, e' e |
  % 5
  e b c a |
  % 6
  d d c c |
  % 7
  c b e e |
  % 8
  fis8 e c4 b b |
  % 9
  b ais a a |
  % 10
  a2 a4 c |
  % 11
  c8 b a4 a gis |
  % 12
  e1 |
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
  s2. a'4 |
  % 2
  a,8 b c d e f e d |
  % 3
  c d c b a e' a g |
  % 4
  f e f d e4 e |
  % 5
  a8 g f g c, d e f |
  % 6
  d e f g a b a g |
  % 7
  f e f g c,4 a' |
  % 8
  dis,8 e fis dis e fis g fis |
  % 9
  e f e d cis a b cis |
  % 10
  d e f g a4 a8 g |
  % 11
  fis gis a f d b e4 |
  % 12
  a,1 |
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
