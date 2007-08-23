% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 267.mid
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
  s2. a''4 |
  % 2
  a f g a |
  % 3
  f e d a' |
  % 4
  a g c a |
  % 5
  f g a a |
  % 6
  c d f e |
  % 7
  d cis d d |
  % 8
  e d c b |
  % 9
  a b a d |
  % 10
  c b c8 ais a4 |
  % 11
  a g f a |
  % 12
  ais a a g |
  % 13
  f e d2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'4 |
  % 2
  e d d8 cis d4 |
  % 3
  d cis a e' |
  % 4
  d4. e8 f4 cis |
  % 5
  d d cis e |
  % 6
  f a g a8 g |
  % 7
  f4 e fis g |
  % 8
  g8 a b4 a gis |
  % 9
  a4. gis8 e4 e |
  % 10
  e8 f g4 g f |
  % 11
  f4. e8 f4 fis |
  % 12
  g8 f e4 d8 cis d e |
  % 13
  a, d d cis a2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'4 |
  % 2
  a a g f8 g |
  % 3
  a4 a8 g f4 a |
  % 4
  ais8 c d4 c8 d e4 |
  % 5
  a, ais e c'8 ais |
  % 6
  a4 f'8 e d4 e |
  % 7
  a, a a b |
  % 8
  c f e d |
  % 9
  c f8 e cis4 b |
  % 10
  c d c c |
  % 11
  d4. c8 gis4 dis' |
  % 12
  d4. cis8 d2 |
  % 13
  d8 a ais a fis2 |
  % 14
  
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
  cis d e d8 e |
  % 3
  f g a a, d4 c |
  % 4
  ais ais' a8 g f e |
  % 5
  d c ais4 a a'8 g |
  % 6
  f e d c b4 cis |
  % 7
  d a d g |
  % 8
  c8 b a gis a g f e |
  % 9
  f e d e a,4 gis |
  % 10
  a8 a' g f e4 f8 e |
  % 11
  d c ais c cis4 c |
  % 12
  g a ais8 a b cis |
  % 13
  d f g a d,2 |
  % 14
  
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
