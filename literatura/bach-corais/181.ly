% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 181.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  b b8 c d c b4 |
  % 3
  a b8 a g4 b |
  % 4
  b b8 c d c b4 |
  % 5
  a b g b |
  % 6
  c b a g8 a |
  % 7
  b4 fis e b' |
  % 8
  c b a g8 a |
  % 9
  b4 fis e b' |
  % 10
  b a g8 fis e fis |
  % 11
  g4 g a a |
  % 12
  b1 |
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
  fis g a4. g4 fis16 e fis4 d g |
  % 4
  a g fis g2 fis4 e g4. a4 g fis8 e4. dis16 cis dis4 e gis |
  % 8
  a d,8 e fis4 e |
  % 9
  e dis e g |
  % 10
  fis8 e fis dis b2 |
  % 11
  e4 e e8 g fis e |
  % 12
  fis1 |
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
  s2. e'4 |
  % 2
  b e d d |
  % 3
  e d8 c b4 d8 e |
  % 4
  fis4 e d e |
  % 5
  e b b e4. d8 d4 e8 b b4 |
  % 7
  b4. a8 g4 d' |
  % 8
  e8 fis g4 d8 c b8*5 a8 g4 e' |
  % 10
  b fis e8 fis g a |
  % 11
  b4 b c8 e dis e |
  % 12
  dis1 |
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
  s2. e4 |
  % 2
  dis e fis g |
  % 3
  c, d g, g' |
  % 4
  dis e b e8 d |
  % 5
  cis4 dis e e4. fis8 g4 cis,8 dis e fis |
  % 7
  g a b b, c4 b |
  % 8
  a b8 c d4 e |
  % 9
  g,8 a b4 e, e' |
  % 10
  dis8 cis dis b e8*5 fis8 g e c b c4 |
  % 12
  b1 |
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
