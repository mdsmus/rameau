% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 027900b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  ais b8 cis d4 e |
  % 3
  d cis b b |
  % 4
  g a b a8 g |
  % 5
  fis2 e4 b' |
  % 6
  ais b8 cis d4 e |
  % 7
  d cis b b |
  % 8
  g a b a8 g |
  % 9
  fis2 e4 s4 |
  % 10
  e g a e |
  % 11
  g a b b |
  % 12
  e dis e fis |
  % 13
  d cis b b8 c |
  % 14
  d4 b d a |
  % 15
  g fis e2 |
  % 16
  b'4 a g fis |
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
  s2. g''4 |
  % 2
  fis fis8 ais b4 cis |
  % 3
  b ais fis fis |
  % 4
  e d d e |
  % 5
  e dis b g' |
  % 6
  fis fis8 ais b4 cis |
  % 7
  b ais fis fis |
  % 8
  e d d e |
  % 9
  e dis b s4 |
  % 10
  b e8 d e4 c |
  % 11
  b a g d' |
  % 12
  g fis e b' |
  % 13
  b ais fis g |
  % 14
  a d, d c |
  % 15
  b8 e4 d8 d4 c |
  % 16
  b8 cis dis4 e8 c' dis,4 |
  % 17
  b1 |
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
  s2. e'8 d |
  % 2
  cis4 d8 e fis4 fis |
  % 3
  fis fis8 e dis4 b |
  % 4
  b a g8 a b4 |
  % 5
  c b8 a g4 e'8 d |
  % 6
  cis4 d8 e fis4 fis |
  % 7
  fis fis8 e dis4 b |
  % 8
  b a g8 a b4 |
  % 9
  c b8 a g4 s4 |
  % 10
  g g c a |
  % 11
  g d' d b |
  % 12
  b a b b |
  % 13
  fis' fis8 e d4 b |
  % 14
  a g g fis |
  % 15
  g a a2 |
  % 16
  fis g8 e b' a |
  % 17
  gis1 |
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
  s2. e4 |
  % 2
  fis8 e d cis b4 ais |
  % 3
  b fis' b, dis |
  % 4
  e fis g e |
  % 5
  a, b e e |
  % 6
  fis8 e d cis b4 ais |
  % 7
  b fis b dis |
  % 8
  e fis g e |
  % 9
  a, b e, s4 |
  % 10
  e'8 d c b a b c d |
  % 11
  e4 fis g g |
  % 12
  e fis g d8 e |
  % 13
  fis4 fis, b e |
  % 14
  fis g b,8 c d4 |
  % 15
  e fis8. gis16 a2 |
  % 16
  dis,4 b e8 a, b4 |
  % 17
  e1 |
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
