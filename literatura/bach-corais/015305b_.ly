% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 015305b_.mid
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
  b g a b |
  % 11
  c2 c4 g |
  % 12
  a g a f |
  % 13
  e2. c'4 |
  % 14
  b8 c d4 c b |
  % 15
  a2 b4 e, |
  % 16
  f e d g |
  % 17
  e1 |
  % 18
  
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
  e e d cis |
  % 3
  d2 cis4 e |
  % 4
  dis e fis e8 d |
  % 5
  c2. b4 |
  % 6
  e e d cis |
  % 7
  d2 cis4 e |
  % 8
  dis e fis e8 d |
  % 9
  c2. e8 fis |
  % 10
  g4 d e f |
  % 11
  g f e g |
  % 12
  f e8 d e4 d |
  % 13
  cis2. d4 |
  % 14
  d g4. fis8 g4 |
  % 15
  g fis g g |
  % 16
  d c c b8 c |
  % 17
  d4 c b2 |
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
  s2. gis'4 |
  % 2
  a ais a g |
  % 3
  a8 g16 f g8 d a'4 b |
  % 4
  a a a gis |
  % 5
  a2. gis4 |
  % 6
  a ais a g |
  % 7
  a8 g16 f g8 d a'4 b |
  % 8
  a a a gis |
  % 9
  a2. a4 |
  % 10
  d b c d |
  % 11
  c8 ais a4 g c |
  % 12
  c cis8 d a4 a |
  % 13
  a2. a4 |
  % 14
  g8 a b4 c d |
  % 15
  e d d c8 b |
  % 16
  a4 g a g8 a |
  % 17
  b4 a gis2 |
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
  s2. d4 |
  % 2
  c cis d e |
  % 3
  f ais, a g' |
  % 4
  fis e dis e |
  % 5
  a,2. d4 |
  % 6
  c cis d e |
  % 7
  f ais, a g' |
  % 8
  fis e dis e |
  % 9
  a,2. a'4 |
  % 10
  g f e d |
  % 11
  e f c e |
  % 12
  f ais cis, d |
  % 13
  a2. fis'4 |
  % 14
  g g, a b |
  % 15
  c d g, c |
  % 16
  d e fis g |
  % 17
  gis a e2 |
  % 18
  
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
