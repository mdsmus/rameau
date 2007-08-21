% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 016106b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 84 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. e'4 |
  % 2
  a g f e |
  % 3
  d2 e4 b' |
  % 4
  c c b b |
  % 5
  a2. e4 |
  % 6
  a g f e |
  % 7
  d2 e4 b' |
  % 8
  c c b b |
  % 9
  a2. c4 |
  % 10
  b8 c16 d g,4 a b |
  % 11
  c2 c4 g |
  % 12
  a g a f |
  % 13
  e2 s4 c' |
  % 14
  b d c b |
  % 15
  a2 b4 e, |
  % 16
  f e d g |
  % 17
  e1. 
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
  e8 d d4 d c8 b |
  % 3
  a2 b4 e |
  % 4
  e f f e8 d |
  % 5
  cis4 d4. c8 e4 |
  % 6
  e8 d d4 d c8 b |
  % 7
  a2 b4 e |
  % 8
  e f f e8 d |
  % 9
  cis4 d4. c8 a' g |
  % 10
  f4 e e8 c f4 |
  % 11
  g4. f8 e4 c |
  % 12
  c c8 ais a4 a |
  % 13
  a2 s4 e' |
  % 14
  e d e8 fis g gis |
  % 15
  a4 a, e' e8 cis |
  % 16
  a b c4 d d8 c |
  % 17
  b4. b16 a b1 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. g'8 b |
  % 2
  a c b4 c8 g g4 |
  % 3
  a8 f d d' d b gis4 |
  % 4
  a4. c8 d d, g f |
  % 5
  e4 f8. g16 a4 g8 b |
  % 6
  a c b4 c8 g g4 |
  % 7
  a8 f d d' d b gis4 |
  % 8
  a4. c8 d d, g f |
  % 9
  e4 f8. g16 a4 e' |
  % 10
  d d8 c c4 d |
  % 11
  g, a8 b c4 c |
  % 12
  f, g e f8 g |
  % 13
  a2 s4 a |
  % 14
  b b b8 a e' d |
  % 15
  c cis d4 g, a8 g |
  % 16
  f g a4 a b |
  % 17
  b8 gis e c' b1 
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
  s2. e4 |
  % 2
  f g a,8 b c4 |
  % 3
  f2 e4 e |
  % 4
  a8 g f e d b e4 |
  % 5
  a,2. e'4 |
  % 6
  f g a,8 b c4 |
  % 7
  f2 e4 e |
  % 8
  a8 g f e d b e4 |
  % 9
  a,2. a'4 |
  % 10
  d, e f d |
  % 11
  c2 c4 e |
  % 12
  f c cis d |
  % 13
  a2 s4 a |
  % 14
  e' b c8 d e4 |
  % 15
  f2 e4 a |
  % 16
  d, a8 g f fis g4 |
  % 17
  gis a e'1 
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  s2. e4 |
  % 2
  f g a,8 b c4 |
  % 3
  f,2 e4 e' |
  % 4
  a8 g f e d b e4 |
  % 5
  a,2. e'4 |
  % 6
  f g a,8 b c4 |
  % 7
  f,2 e4 e' |
  % 8
  a8 g f e d b e4 |
  % 9
  a,2. a'4 |
  % 10
  d, e f d |
  % 11
  c2 c4 e |
  % 12
  f c cis d |
  % 13
  a2 s4 a |
  % 14
  e' b c8 d e4 |
  % 15
  f2 e4 a |
  % 16
  d, a8 g f fis g4 |
  % 17
  gis a e1 
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  s8*7 g'''8. c,16 f8. e32 d e8. a,16 d8. c32 b c8. e16 d c b c 
  b a gis a gis fis e8 b''8. d16 c b a gis a8. c16 b a g f g8. 
  ais16 a g f e f8 e4 s8 g8. c,16 f8. e32 d e8. a,16 d8. c32 b 
  c8. e16 d c b c b a gis a gis fis e8 b''8. d16 c b a gis a8. 
  c16 b a g f g8. ais16 a g f e f8 e4 a16*5 c16 b a g f g8. ais16 
  a g f e f8. a16 g f e f e d c g' a b c8 g8. c,16 f8. e16 d e8 
  g16 f e d cis d8. f16 e d c b d c8 d16 c b a8 a'8. c16 b a g 
  a g f e16*9 g16 f e d cis d8. f16 e d cis d b cis |
  % 16
  d a d8. c32 b c8. e16 d c b c d8. f16 e d c e a4 gis8*7 
}

trackG = <<
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
    \context Staff=trackG \trackG
  >>
}
