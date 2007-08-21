% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 026000b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''8 a |
  % 2
  b4 c d c |
  % 3
  b a b b |
  % 4
  b a8 b c b a4 |
  % 5
  g8 e fis4 g g8 a |
  % 6
  b4 c d c |
  % 7
  b a b b |
  % 8
  b a8 b c b a4 |
  % 9
  g8 e fis4 g g |
  % 10
  a b c b |
  % 11
  a8. b16 b4 a a |
  % 12
  b c d c |
  % 13
  b a b g |
  % 14
  a b c8 b a4 |
  % 15
  g8 e fis4 g2 |
  % 16
  
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
  g g fis e8 fis |
  % 3
  g fis e4 dis e |
  % 4
  d8 e fis4 g4. fis8 |
  % 5
  g4 d d d |
  % 6
  g g fis e8 fis |
  % 7
  g fis e4 dis e |
  % 8
  d8 e fis4 g4. fis8 |
  % 9
  g4 d d d8 e |
  % 10
  fis4 gis a8 a, d e |
  % 11
  a, a'4 gis8 e4 d |
  % 12
  d g fis8 gis a4 |
  % 13
  g8 fis e4 dis b8 cis |
  % 14
  d e fis4 e4. d16 c |
  % 15
  g'4 d d2 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. b'8 c |
  % 2
  d4 e8 g, a b c d |
  % 3
  e b c4 fis, g8 a |
  % 4
  b c d4 e4. d16 c |
  % 5
  d8 c16 b a4 b b8 c |
  % 6
  d4 e8 g, a b c d |
  % 7
  e b c4 fis, g8 a |
  % 8
  b c d4 e4. d16 c |
  % 9
  d8 c16 b a4 b b |
  % 10
  a d e8 f4 e8 |
  % 11
  e16 d e8 f e16 d c4 a |
  % 12
  g g8 a b4 e, |
  % 13
  e'8 b c4 fis, g |
  % 14
  fis b8 a g4. fis8 |
  % 15
  d' c16 b a4 b2 |
  % 16
  
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
  s2. g4 |
  % 2
  g'8 fis e4 d a |
  % 3
  e'8 d c4 b e8 fis |
  % 4
  g4 fis e8 d c a |
  % 5
  b c d4 g, g |
  % 6
  g'8 fis e4 d a |
  % 7
  e'8 d c4 b e8 fis |
  % 8
  g4 fis e8 d c a |
  % 9
  b c d4 g, g' |
  % 10
  d8 d' c b a4 g |
  % 11
  f8 c d e a,4 fis' |
  % 12
  g8 fis e4 b c8 d |
  % 13
  e d c4 b e |
  % 14
  d dis e8 d c a |
  % 15
  b c d4 g,2 |
  % 16
  
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
