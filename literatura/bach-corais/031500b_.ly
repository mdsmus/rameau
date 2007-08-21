% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 031500b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  g a8 b16 c b4. a8 |
  % 3
  g4 fis8 g16 a g4. fis8 |
  % 4
  e2 c'4 b |
  % 5
  e d fis,8 c' b a |
  % 6
  a2 g4 b |
  % 7
  g a8 b16 c b4. a8 |
  % 8
  g4 fis8 g16 a g4. fis8 |
  % 9
  e2 c'4 b |
  % 10
  e d fis,8 c' b a |
  % 11
  a2 g4 b |
  % 12
  a b8 g a4 b8 c |
  % 13
  d4 c8 b c b a4 |
  % 14
  s4 c fis, e'8 dis |
  % 15
  e d c b a g' fis e |
  % 16
  dis cis b4 s4 e |
  % 17
  c b8 a b dis, e a |
  % 18
  g4 fis8 e e2 |
  % 19
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'4 |
  % 2
  e fis8 g16 a g8 dis e fis |
  % 3
  fis e e dis e4. dis8 |
  % 4
  e2 g4. fis8 |
  % 5
  e fis fis g fis4 g |
  % 6
  g fis d e |
  % 7
  e fis8 g16 a g8 dis e fis |
  % 8
  fis e e dis e4. dis8 |
  % 9
  e2 g4. fis8 |
  % 10
  e fis fis g fis4 g |
  % 11
  g fis d g |
  % 12
  a8 fis g e fis4 e |
  % 13
  d e e8 d e4 |
  % 14
  s4 e dis8 e fis4 |
  % 15
  e8 fis g fis e4 a8 b16 c |
  % 16
  fis,8 e dis4 s4 e |
  % 17
  e4. fis8 dis fis e e |
  % 18
  e4 dis b2 |
  % 19
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. g'4 |
  % 2
  b c8 fis, g a b c |
  % 3
  b4 b b8 g a4 |
  % 4
  g2 g8 a b4 |
  % 5
  b8 a a b c4 d |
  % 6
  e d8 c b4 g |
  % 7
  b c8 fis, g a b c |
  % 8
  b4 b b8 g a4 |
  % 9
  g2 g8 a b4 |
  % 10
  b8 a a b c4 d |
  % 11
  e d8 c b4 d |
  % 12
  d d8 cis d4 gis,8 a |
  % 13
  a b gis4 a8 b c4 |
  % 14
  s4 c b4. c8 |
  % 15
  b a g gis a b c4 |
  % 16
  b fis s4 b |
  % 17
  a8 b c4 fis,8 a b a |
  % 18
  b4 a8 g g2 |
  % 19
  
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
  e8 dis e dis e fis g a |
  % 3
  b4 b, e2 |
  % 4
  e e4. d8 |
  % 5
  c c'4 b8 a4 g |
  % 6
  c, d g, e' |
  % 7
  e8 dis e dis e fis g a |
  % 8
  b4 b, e2 |
  % 9
  e e4. d8 |
  % 10
  c c'4 b8 a4 g |
  % 11
  c, d g, g' |
  % 12
  fis8 d g4 d8 e d c |
  % 13
  b4 e a a, |
  % 14
  s4 a' b8 c b a |
  % 15
  g fis e d c b a4 |
  % 16
  b b s4 gis' |
  % 17
  a8 a, a'4. fis8 g c, |
  % 18
  b a b4 e2 |
  % 19
  
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
