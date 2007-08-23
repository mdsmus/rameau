% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 066.mid
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
  s2. d'8 e |
  % 2
  f4 g a g |
  % 3
  c b8 a a4 g |
  % 4
  c b a g |
  % 5
  f e d d8 e |
  % 6
  f4 g a g |
  % 7
  c b8 a a4 g |
  % 8
  c b a g |
  % 9
  f e d d |
  % 10
  g g e a |
  % 11
  a gis a a |
  % 12
  d d e8 d c4 |
  % 13
  d8 c b4 a b |
  % 14
  c b a g |
  % 15
  a8 g f4 e d8 e |
  % 16
  f4 g a8 g f4 |
  % 17
  g8 f e4 d d' |
  % 18
  d d e d |
  % 19
  c b a2 |
  % 20
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a'4 |
  % 2
  d e f e |
  % 3
  e e e e |
  % 4
  e e f8 e d4 |
  % 5
  a8 d4 cis8 a4 a |
  % 6
  d e f e |
  % 7
  e e e e |
  % 8
  e e f8 e d4 |
  % 9
  a8 d4 cis8 a4 a |
  % 10
  d c8 b c d e4 |
  % 11
  e e e e |
  % 12
  a g g a8 g |
  % 13
  f4 b,8 c16 d c4 e |
  % 14
  e d c8 d e4 |
  % 15
  a, d cis a |
  % 16
  d e e8 cis d4 |
  % 17
  e8 d cis4 a a' |
  % 18
  g g g a8 d, |
  % 19
  e4. d8 cis2 |
  % 20
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. f8 g |
  % 2
  a b c4 c c8 b |
  % 3
  a4 gis c b |
  % 4
  a b8 cis d4 d,8 e |
  % 5
  f g a4 f f8 g |
  % 6
  a b c4 c c8 b |
  % 7
  a4 gis c b |
  % 8
  a b8 cis d4 d,8 e |
  % 9
  f g a4 f f8 e |
  % 10
  d4 g g c |
  % 11
  b8 a b4 c c |
  % 12
  c b c8 b a4 |
  % 13
  b8 a gis4 e gis |
  % 14
  a8 g f g a b cis d |
  % 15
  e4 a, a f8 e |
  % 16
  d f ais4 a ais2 e8 f16 g f4 d |
  % 18
  b'8 c d b c b a4 |
  % 19
  a gis e2 |
  % 20
  
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
  d c f c |
  % 3
  c8 d e4 a, e' |
  % 4
  a g f b,8 cis |
  % 5
  d4 a d d |
  % 6
  d c f c |
  % 7
  c8 d e4 a, e' |
  % 8
  a g f b,8 cis |
  % 9
  d4 a d d8 c |
  % 10
  b a g4 c b8 a |
  % 11
  e'4 e, a a'8 g |
  % 12
  fis4 g c, f8 e |
  % 13
  d4 e a, e' |
  % 14
  a d,8 e f4 e8 d |
  % 15
  cis4 d a d8 c |
  % 16
  ais a g4 f ais8 a |
  % 17
  g4 a d, fis' |
  % 18
  g8 a b g c,4 f |
  % 19
  e8 d e4 a,2 |
  % 20
  
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
