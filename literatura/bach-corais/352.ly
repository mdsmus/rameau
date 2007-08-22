% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 352.mid
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
  s2. b''4 |
  % 2
  c b a b8 c |
  % 3
  d4 e d c |
  % 4
  b2 s4 d |
  % 5
  c b c8 b a4 |
  % 6
  g f e b' |
  % 7
  c b a b8 c |
  % 8
  d4 e d c |
  % 9
  b2 s4 d |
  % 10
  c b c8 b a4 |
  % 11
  g f e g |
  % 12
  f e d e8 d |
  % 13
  c d d4 e b' |
  % 14
  c b8 a g4 a8 b |
  % 15
  c4 d b e |
  % 16
  d8 c b c d4 a |
  % 17
  g f e d |
  % 18
  g a b8 c d4 |
  % 19
  c b a c |
  % 20
  b a g8 f e f |
  % 21
  g4 f e1. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. gis''4 |
  % 2
  a8 e f e4 d8 g4. f8 g e f4 e8 dis |
  % 4
  e2 s4 f |
  % 5
  e8 fis g4 g f |
  % 6
  e4. d16 c b4 gis' |
  % 7
  a8 e f e4 d8 g4. f8 g e f4 e8 dis |
  % 9
  e2 s4 f |
  % 10
  e8 fis g4 g f |
  % 11
  e4. d16 c b4 e8 d |
  % 12
  c d4 c8 a g4 gis8 |
  % 13
  a4. b8 c b e4 |
  % 14
  e8 a g f e4 d |
  % 15
  c8 e a4 a8 gis g fis |
  % 16
  g4 g g4. f8 |
  % 17
  e4. d8 d cis a b |
  % 18
  c4 c b8 e d e |
  % 19
  e a4 gis8 a4 g8 a |
  % 20
  b g e f b, d g f |
  % 21
  f e e d d e16 d c4 |
  % 22
  b1 |
  % 23
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. e'4 |
  % 2
  e8 c d e a,4 g |
  % 3
  a ais a8 gis a4 |
  % 4
  a gis s4 a8 b |
  % 5
  c4 d e8 d c4 |
  % 6
  ais8 a4 b8 gis4 e' |
  % 7
  e8 c d e a,4 g |
  % 8
  a ais a8 gis a4 |
  % 9
  a gis s4 a8 b |
  % 10
  c4 d e8 d c4 |
  % 11
  ais8 a4 b8 gis4 b |
  % 12
  a8 g4 a8 f4 e |
  % 13
  e a a8 gis gis4 |
  % 14
  a16 b c4 d8 e e, fis gis |
  % 15
  a4. f'8 e4 g,8 a |
  % 16
  b c d4 d d |
  % 17
  e8 a, a4 a f |
  % 18
  e4. fis8 g4 a8 b |
  % 19
  c e f e c4 e |
  % 20
  d cis8 d e b c4 |
  % 21
  d8 a a b4 e,8 a4 |
  % 22
  a gis8 fis gis2 |
  % 23
  
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
  a4. g8 f4. e8 |
  % 3
  d4. cis8 d4 a |
  % 4
  e'2 s4 d |
  % 5
  a' g8 f e4 f8 e |
  % 6
  d cis d4 e e |
  % 7
  a4. g8 f4. e8 |
  % 8
  d4. cis8 d4 a |
  % 9
  e'2 s4 d |
  % 10
  a' g8 f e4 f8 e |
  % 11
  d cis d4 e e |
  % 12
  a,8 b c4. b8 c b |
  % 13
  a g f4 e e' |
  % 14
  a,4. b8 c4. b8 |
  % 15
  a a' f d e4 c |
  % 16
  g' g,8 a b c d4. cis8 d4 a d |
  % 18
  c8 b a4 e' fis8 gis |
  % 19
  a c, d e f4 e8 fis |
  % 20
  g4. f8 e d c a |
  % 21
  b cis d gis, a b c d |
  % 22
  e1 |
  % 23
  
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
