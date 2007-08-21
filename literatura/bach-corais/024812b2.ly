% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024812b2.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 84 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g a b8 cis d4 |
  % 3
  d cis d b |
  % 4
  c b a b |
  % 5
  a2 g4 g |
  % 6
  g a b8 cis d4 |
  % 7
  d cis d b |
  % 8
  c b a b |
  % 9
  a2 g4 a |
  % 10
  a b c c |
  % 11
  b8 a b4 a b |
  % 12
  b b c8 d e4 |
  % 13
  e dis e fis |
  % 14
  g b, c b |
  % 15
  a2 a4 d |
  % 16
  e d c b8 c |
  % 17
  a2 g |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  e fis d8 e fis4 |
  % 3
  e8 fis g4 fis fis |
  % 4
  e d8 e fis4 g |
  % 5
  g fis d d |
  % 6
  e fis d8 e fis4 |
  % 7
  e8 fis g4 fis fis |
  % 8
  e d8 e fis4 g |
  % 9
  g fis d fis8 g |
  % 10
  a4. gis8 a gis a4 |
  % 11
  a gis e e8 dis |
  % 12
  e4 e e8 fis g fis |
  % 13
  fis g a4 g a |
  % 14
  g8 a b4 b8 a a g |
  % 15
  g2 fis4 g8 fis |
  % 16
  e4 fis g8 a d,4 |
  % 17
  e d d2 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. b'4 |
  % 2
  b8 c4 d8 b a a4 |
  % 3
  a a a b8 a |
  % 4
  g a b c d4 d |
  % 5
  d4. c8 b4 b |
  % 6
  b8 c4 d8 b a a4 |
  % 7
  a a a b8 a |
  % 8
  g a b c d4 d |
  % 9
  d4. c8 b4 d8 e |
  % 10
  fis e d4 e fis |
  % 11
  b, e8 d c4 g8 a |
  % 12
  b c d e c4 cis |
  % 13
  b b b d8 c |
  % 14
  d4 g g,8 a b4 |
  % 15
  e8 d e cis d4 d |
  % 16
  d8 c c b b a g4 |
  % 17
  g8 <fis c' >16 <e b' >16 <fis a >8 b16 s16 <b g >2 |
  % 18
  
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
  s2. g'8 fis |
  % 2
  e4 d g fis8 g |
  % 3
  a4 a, d dis |
  % 4
  e8 fis g c, c' b a g |
  % 5
  d'4 d, g g8 fis |
  % 6
  e4 d g fis8 g |
  % 7
  a4 a, d dis |
  % 8
  e8 fis g c, c' b a g |
  % 9
  d'4 d, g d |
  % 10
  d'8 c b4 a dis, |
  % 11
  e e a, e'8 fis |
  % 12
  g4 gis a ais |
  % 13
  b b, e d'8 c |
  % 14
  b a g fis e fis g e |
  % 15
  cis b cis a d4 b |
  % 16
  c d e8 fis g4 |
  % 17
  c, d g,2 |
  % 18
  
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
  s2. g'8 fis |
  % 2
  e4 d g fis8 g |
  % 3
  a4 a, d dis |
  % 4
  e8 fis g c,4 b8 a g |
  % 5
  d'4 d, g g'8 fis |
  % 6
  e4 d g fis8 g |
  % 7
  a4 a, d dis |
  % 8
  e8 fis g c,4 b8 a g |
  % 9
  d'4 d, g d' |
  % 10
  d'8 c b4 a dis, |
  % 11
  e e, a e'8 fis |
  % 12
  g4 gis a ais |
  % 13
  b b, e d8 c |
  % 14
  b a g fis e fis g e |
  % 15
  cis' b cis a d4 b |
  % 16
  c d e8 fis g4 |
  % 17
  c, d g,2 |
  % 18
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
