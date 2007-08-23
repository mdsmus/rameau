% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 340.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'8 e |
  % 2
  f4 e f g |
  % 3
  a2 a4 c |
  % 4
  b a a gis |
  % 5
  a2. d,8 e |
  % 6
  f4 e f g |
  % 7
  a2 a4 c |
  % 8
  b a a gis |
  % 9
  a2. a4 |
  % 10
  b c d8 c b4 |
  % 11
  c4. ais8 a4 a |
  % 12
  g f f e |
  % 13
  f2. a8 g |
  % 14
  f4 g a g |
  % 15
  f2 e4 f |
  % 16
  g f e2 |
  % 17
  d2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'8 cis |
  % 2
  d4 ais a d8 c |
  % 3
  c2 c4 c |
  % 4
  f fis e e |
  % 5
  e2. d8 cis |
  % 6
  d4 ais a d8 c |
  % 7
  c2 c4 c |
  % 8
  f fis e e |
  % 9
  e2. e8 fis |
  % 10
  gis4 a a g |
  % 11
  g f8 g f4 f8 dis |
  % 12
  d4 d c c |
  % 13
  c2. e4 |
  % 14
  f4. e8 f4. e4 d8 d4 cis d4. cis8 d2 cis4 |
  % 17
  a2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'8 g |
  % 2
  a4 g f f8 e |
  % 3
  f2 f4 g |
  % 4
  gis c b8 c d4 |
  % 5
  c2. a8 g |
  % 6
  a4 g f f8 e |
  % 7
  f2 f4 g |
  % 8
  gis c b8 c d4 |
  % 9
  c2. c4 |
  % 10
  d e d d |
  % 11
  c8 e d c c4 c |
  % 12
  ais gis g4. a16 ais |
  % 13
  a2. a4 |
  % 14
  a d8 c c4 d8 e |
  % 15
  a, gis a b a4 a |
  % 16
  g a a4. g8 |
  % 17
  f2. 
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
  s2. f8 e |
  % 2
  d4. cis8 d c ais c |
  % 3
  f,2 f4 e' |
  % 4
  d dis e e, |
  % 5
  a2. f'8 e |
  % 6
  d4. cis8 d c ais c |
  % 7
  f,2 f4 e' |
  % 8
  d dis e e, |
  % 9
  a2. a'2 a8 g fis4 g8 f |
  % 11
  e c d e f4 f, |
  % 12
  ais b c c, |
  % 13
  f2. cis'4 |
  % 14
  d8 c ais c f, a b cis |
  % 15
  d ais a gis a4 d |
  % 16
  e f8 g a4 a, |
  % 17
  d2. 
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
