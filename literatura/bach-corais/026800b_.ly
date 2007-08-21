% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 026800b_.mid
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
  s2. b''4 |
  % 2
  b b b e |
  % 3
  d d c c |
  % 4
  b g a a |
  % 5
  b c d8 c b4 |
  % 6
  a a g a |
  % 7
  a a a b8 a |
  % 8
  g4 g a g |
  % 9
  fis2 fis4 fis |
  % 10
  g g a a |
  % 11
  b c d8 c b4 |
  % 12
  a2 g |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. g''4 |
  % 2
  g8 e b' a g4 a8 g |
  % 3
  fis e fis gis a4 e8 fis |
  % 4
  g4 d d8 e fis e |
  % 5
  d4 g8 e fis a g4. fis16 e fis4 d e |
  % 7
  fis8 g fis e fis4 fis2 e4. fis8 b, e4 dis8 e cis dis4 b |
  % 10
  b e8 d e fis16 g a8 fis |
  % 11
  d e16 fis g8 fis16 e fis8 a4 g8 |
  % 12
  g4 fis d2 |
  % 13
  
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
  d8 e fis4 e e |
  % 3
  a,8 g a b c b a4 |
  % 4
  d b a d8 c |
  % 5
  b a g4 a8 fis g b |
  % 6
  e c a d16 c b4 cis |
  % 7
  d8 cis d e d4 b |
  % 8
  b b a8 fis g4 |
  % 9
  c cis b b8 a |
  % 10
  g fis g b c4. d16 c |
  % 11
  b4. a16 g a8 fis' d e |
  % 12
  e c a d16 c b2 |
  % 13
  
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
  g4 dis e c |
  % 3
  c4. b8 a gis a4 |
  % 4
  g g' fis8 e d4 |
  % 5
  g8 fis e4 d e8 d |
  % 6
  c a d4 g, g' |
  % 7
  fis8 e d cis d4 dis |
  % 8
  e8 fis g e cis dis e c |
  % 9
  a4 ais b dis |
  % 10
  e8 d c b a g fis d |
  % 11
  g g' e a fis d g e |
  % 12
  c a d4 g,2 |
  % 13
  
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
