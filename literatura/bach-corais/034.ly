% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 034.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. e'4 |
  % 2
  g g a b |
  % 3
  c b a g |
  % 4
  c b c a |
  % 5
  g f e e |
  % 6
  g g a b |
  % 7
  c b a g |
  % 8
  c b c a |
  % 9
  g f e e |
  % 10
  a a g c |
  % 11
  b a g g |
  % 12
  c g a e |
  % 13
  a8 g f4 e2 |
  % 14
  a4 a g8 f e4 |
  % 15
  f d c c |
  % 16
  g'2 a4 b |
  % 17
  c g a g |
  % 18
  f4. f8 e2 |
  % 19
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. b'4 |
  % 2
  e e e f8 e |
  % 3
  e a4 gis8 e4 e8 f |
  % 4
  g a4 g16 f g4. f4 e d16 c b4 b |
  % 6
  e e e f8 e |
  % 7
  e a4 gis8 e4 e8 f |
  % 8
  g a4 g16 f g4. f4 e d16 c b4 c |
  % 10
  f f4. e16 d e8 fis |
  % 11
  g16 d g4 fis8 d4 e |
  % 12
  e4. d8 c b cis d |
  % 13
  e4. d4 cis8 c4 |
  % 14
  c8 dis4 d8 d4 c |
  % 15
  c4. b8 g4 g |
  % 16
  d' e8 d c4 d |
  % 17
  e8 f g e f4. e4 d8 d c b2 |
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
  s2. g'4 |
  % 2
  b b c d |
  % 3
  c8 e f e16 d c4 b |
  % 4
  e f8 e16 d c4 c |
  % 5
  c8. ais16 a8 b16 a gis4 g |
  % 6
  b b c d |
  % 7
  c8 e f e16 d c4 b |
  % 8
  e f8 e16 d c4 c |
  % 9
  c8. ais16 a8 b16 a gis4 a |
  % 10
  c d4. c8 g a |
  % 11
  d, d' e d16 c b4 c |
  % 12
  c c8 ais a4 a |
  % 13
  a a a a |
  % 14
  a8 c4 b16 a b4 c8 b |
  % 15
  a4 g8. f16 e4 e |
  % 16
  g c8 d e f g4 |
  % 17
  g, c c c8. ais16 |
  % 18
  a8 b16 c b8 a gis2 |
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
  s2. e4. f8 e d c a'4 gis8 |
  % 3
  a c, d e a,4 e'8 d |
  % 4
  c4 d8 g e c f4 |
  % 5
  c d e e4. f8 e d c a'4 gis8 |
  % 7
  a c, d e a,4 e'8 d |
  % 8
  c4 d8 g e c f4 |
  % 9
  c d e a8 g |
  % 10
  f e d c b c b a |
  % 11
  g b c d g,4 c8 b |
  % 12
  a b c e, f g a b |
  % 13
  cis a d d, a'4 a'8 g |
  % 14
  f4 fis g a8 g |
  % 15
  f d g g, c4 c |
  % 16
  b c8 b a4 g8 f |
  % 17
  e d e c f a c4 |
  % 18
  d2 e |
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
