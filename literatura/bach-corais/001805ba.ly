% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 001805ba.mid
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
  a a g a |
  % 3
  f e d a'8 b |
  % 4
  c4 d a b |
  % 5
  c b a a |
  % 6
  a a g a |
  % 7
  f e d a'8 b |
  % 8
  c4 d a b |
  % 9
  c b a c |
  % 10
  c c8 ais a g f g |
  % 11
  a4 g f a |
  % 12
  a a g f8 e |
  % 13
  e2 d4 a' |
  % 14
  a g a b |
  % 15
  c8 b a4 g d' |
  % 16
  e d a8 b c4 |
  % 17
  b a b2 |
  % 18
  a1 |
  % 19
  
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
  f f f e4. d4 cis8 d4 f |
  % 4
  e d8 e f4 f |
  % 5
  e d cis e |
  % 6
  f f f e4. d4 cis8 d4 f |
  % 8
  e d8 e f4 f |
  % 9
  e d cis a' |
  % 10
  g8 f e d c4 d8 e |
  % 11
  f4 e f c8 d |
  % 12
  e4 d d d |
  % 13
  d cis d e |
  % 14
  f4. e8 f a g f |
  % 15
  e d c4 b g' |
  % 16
  g f8 e d4 e |
  % 17
  e8 d c4 f e8 d |
  % 18
  cis1 |
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
  s2. a'4 |
  % 2
  d d d a |
  % 3
  a4. g8 f4 d' |
  % 4
  c8 b a4 d d |
  % 5
  gis,8 a4 gis8 a4 a |
  % 6
  d d d a |
  % 7
  a4. g8 f4 d' |
  % 8
  c8 b a4 d d |
  % 9
  gis,8 a4 gis8 a4 e' |
  % 10
  c g a a8 ais |
  % 11
  c4. ais8 a4 a |
  % 12
  a8 g f4 g8 a ais4 |
  % 13
  a4. g8 f4 a |
  % 14
  d8 c ais4 c d |
  % 15
  g,4. fis8 g4 b |
  % 16
  c8 b a gis a4 a |
  % 17
  gis a2 gis4 |
  % 18
  a1 |
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
  s2. cis4 |
  % 2
  d8 e f4 b, cis |
  % 3
  d a d d |
  % 4
  a'8 g f e d c b a |
  % 5
  e'2 a,4 cis |
  % 6
  d8 e f4 b, cis |
  % 7
  d a d d |
  % 8
  a'8 g f e d c b a |
  % 9
  e'2 a,4 a' |
  % 10
  e8 d c4 f8 e d4 |
  % 11
  a8 ais c4 f, f' |
  % 12
  cis d8 c ais a g4 |
  % 13
  a2 d4 cis |
  % 14
  d g f8 e d4 |
  % 15
  c d g, g' |
  % 16
  c, d8 e f4 c8 d |
  % 17
  e4 f8 e d4 e |
  % 18
  a,1 |
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
