% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 102.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key g \major
  
  \tempo 4 = 112 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g a b4. c8 d4 d d |
  % 3
  cis d2 b4 |
  % 4
  c2 b4 a2. g4 fis2 g2. |
  % 7
  g4 g a b4. c8 d4 d d |
  % 9
  cis d2 b4 |
  % 10
  c2 b4 a2. g4 fis2 g2. |
  % 13
  a4 a b c2 c4 b4. a8 |
  % 15
  b4 a2. |
  % 16
  b4 b b c4. d8 e4 e dis |
  % 18
  dis e2 fis4 |
  % 19
  g2 b,4 c2 b4 a a |
  % 21
  d e4. d8 c4 |
  % 22
  b a2 g2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 e fis g2. g4 e |
  % 3
  e fis2 g4 |
  % 4
  e2 d4 d2. b4 d2 d2. |
  % 7
  d4 e fis g2. g4 e |
  % 9
  e fis2 g4 |
  % 10
  e2 d4 d2. b4 d2 d2. |
  % 13
  d4 d d c2 e4 e2 |
  % 15
  e4 e2. |
  % 16
  e4 gis gis a2. a4 fis |
  % 18
  fis g2 a4 |
  % 19
  b2 g4 g2 g4 fis fis |
  % 21
  g g4. fis8 e4 |
  % 22
  d d2 d2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  b'4 b d d4. c8 b4 b a |
  % 3
  a a2 g4 |
  % 4
  g2 g4 fis2. e4 a2 b2. |
  % 7
  b4 b d d4. c8 b4 b a |
  % 9
  a a2 g4 |
  % 10
  g2 g4 fis2. e4 a2 b2. |
  % 13
  fis4 fis gis a2 a4 gis4. a8 |
  % 15
  gis4 a2. |
  % 16
  gis4 b e e4. d8 c4 c b |
  % 18
  b b2 d4 |
  % 19
  d2 d4 e2 d4 d d |
  % 21
  d c4. a8 g4 |
  % 22
  g g fis b2. 
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
  g'4 e d g4. a8 b4 g a |
  % 3
  a, d2 g4 |
  % 4
  c,2 g4 d'2. e4 d2 g,2. |
  % 7
  g'4 e d g4. a8 b4 g a |
  % 9
  a, d2 g4 |
  % 10
  c,2 g4 d'2. e4 d2 g,2. |
  % 13
  d'4 d b a2 c4 e2 |
  % 15
  e4 a,2. |
  % 16
  e'4 e e a4. b8 c4 a b |
  % 18
  b e,2 d4 |
  % 19
  g2 g4 c,2 g4 d' d |
  % 21
  b c4. d8 e4 |
  % 22
  g d2 g,2. 
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
