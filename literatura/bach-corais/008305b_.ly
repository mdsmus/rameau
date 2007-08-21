% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 008305b_.mid
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
  s2. d'4 |
  % 2
  a' a g d' |
  % 3
  c b a c |
  % 4
  a c b8 a b4 |
  % 5
  a2. b4 |
  % 6
  c b c a |
  % 7
  g f g e |
  % 8
  d2 a'4. g8 |
  % 9
  f e d4 c2 |
  % 10
  a'4 f c' a |
  % 11
  g8 f g4 a g |
  % 12
  f e8 d cis4 f |
  % 13
  e8 f e4 d2 |
  % 14
  
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
  e' f e d8 e |
  % 3
  e fis gis4 e g |
  % 4
  f f b,8 c d4 |
  % 5
  cis2. d4 |
  % 6
  e f g f |
  % 7
  e f8 e d4 c |
  % 8
  b2 e4. cis8 |
  % 9
  d c ais4 a2 |
  % 10
  e'4 f g f |
  % 11
  e8 d cis d cis4 cis |
  % 12
  d8 c ais4 a d |
  % 13
  e8 f cis4 a2 |
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
  s2. f4 |
  % 2
  a d b a8 b |
  % 3
  c d e d c4 c4. b8 a4 gis8 a4 gis8 |
  % 5
  a2. f4 |
  % 6
  g d' c c |
  % 7
  ais c g g |
  % 8
  g2 a4 a |
  % 9
  a8 g f4 f2 |
  % 10
  a4 a g c |
  % 11
  ais8 a g4 e a |
  % 12
  a g8 f e4 a |
  % 13
  a4. g8 fis2 |
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
  cis d e fis8 gis |
  % 3
  a4 e a, e' |
  % 4
  f e8 d e2 |
  % 5
  a,2. d4 |
  % 6
  c d e f |
  % 7
  g a b c |
  % 8
  g2 cis,4. a8 |
  % 9
  d4. e8 f2 |
  % 10
  cis4 d e f |
  % 11
  g8 a ais4 a a, |
  % 12
  d g, g'8 f e d |
  % 13
  cis d a4 d2 |
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
