% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 210.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 84 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'4 |
  % 2
  d e f2 |
  % 3
  e a4 b |
  % 4
  c d8 c b2 |
  % 5
  a s4 c |
  % 6
  b a g g |
  % 7
  a g f f |
  % 8
  e2 f4 e |
  % 9
  e f g2 |
  % 10
  e a4 b |
  % 11
  c d8 c b2 |
  % 12
  a s4 fis |
  % 13
  g g g fis |
  % 14
  g2 s4 e |
  % 15
  f g e2 |
  % 16
  d1 |
  % 17
  
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
  a e' e d |
  % 3
  cis2 e4 e |
  % 4
  a a a gis |
  % 5
  e2 s4 a4. g8 f e d4 g4. f4 e d8 c d |
  % 8
  c2 c4 cis8 d |
  % 9
  e4. d4 c8 d b |
  % 10
  c2 a'4 a4. gis8 a4 a gis |
  % 12
  e2 s4 c |
  % 13
  d d dis d |
  % 14
  d2 s4 cis |
  % 15
  d d2 cis4 |
  % 16
  d1 |
  % 17
  
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
  a4 a a2 |
  % 3
  a a4 e' |
  % 4
  e d8 e f4 e8 d |
  % 5
  c2 s4 e |
  % 6
  f8 e16 d c4 b c |
  % 7
  c c a a |
  % 8
  g8 a ais4 a a |
  % 9
  a a g2 |
  % 10
  g e'4 f |
  % 11
  e d8 e f4 e8 d |
  % 12
  c2 s4 a |
  % 13
  g4. f8 dis ais' a c |
  % 14
  ais2 s4 a |
  % 15
  a g8 ais a e a g |
  % 16
  fis1 |
  % 17
  
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
  s2. d8 e |
  % 2
  f e d cis d e f d |
  % 3
  a2 c8 b a gis |
  % 4
  a c f e d b e4 |
  % 5
  a,2 s4 a |
  % 6
  d8 e f2 e4 |
  % 7
  f c d a8 ais |
  % 8
  c2 f,4 a |
  % 9
  cis d8 c b a b g |
  % 10
  c2 c4 d |
  % 11
  e f8 e d4 e |
  % 12
  a,2 s4 a |
  % 13
  ais b c d |
  % 14
  g,2 s4 a |
  % 15
  d8 c ais g a2 |
  % 16
  d1 |
  % 17
  
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
