% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 208.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key e \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  e'4 e e b'2 b4 a b |
  % 3
  g8 a b4 a a |
  % 4
  b2 g4 fis |
  % 5
  g a b a |
  % 6
  g g2 fis4 |
  % 7
  g2 a4 b2 b4 a2 |
  % 9
  a4 g2 g4 |
  % 10
  fis2. e4 |
  % 11
  fis dis e2 |
  % 12
  e4 a2 a4 |
  % 13
  b2 b4 g2 g4 fis2. e8 fis g a b4 |
  % 16
  b2 a4 b2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  b'4 b b fis'2 g fis4 |
  % 3
  e fis e8 g fis e |
  % 4
  fis2 b,8 cis d2 e8 fis g4. fis4 e8 e d c4 d |
  % 7
  d2 fis4 g2 g4 fis8 e fis4 |
  % 9
  dis e8 dis e2. dis2 e4 |
  % 11
  c b b2 |
  % 12
  b4 e d c |
  % 13
  d e fis2 |
  % 14
  e8 dis e4 e dis2 b4 e fis |
  % 16
  e4. g8 fis e dis2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  g'4 g g fis |
  % 2
  dis' e e b |
  % 3
  b b c8 e dis e |
  % 4
  dis2 e4 a, |
  % 5
  b c d4. c8 |
  % 6
  b4 c4. b8 a4 |
  % 7
  b2 d4 d2 e8 d c4 b |
  % 9
  b b2 b4 |
  % 10
  b2. g4 |
  % 11
  a fis g2 |
  % 12
  g fis4 fis |
  % 13
  g b2 b b4 b2. g4 b b8 a |
  % 16
  g fis e dis e4 fis2. 
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
  e4 g e dis |
  % 2
  b e cis dis |
  % 3
  e d c8 b c4 |
  % 4
  b2 e4 d8 c |
  % 5
  b4 a g d' |
  % 6
  e c a d |
  % 7
  g,2 d'4 g |
  % 8
  fis e2 dis4 |
  % 9
  b e g e |
  % 10
  b2. c4 |
  % 11
  a b e2 |
  % 12
  e4 cis d8 c b a |
  % 13
  g4 g'8 fis e dis e4 |
  % 14
  e,8 fis g a b2. e,4 e' dis |
  % 16
  e8 d c b c4 b2. 
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
