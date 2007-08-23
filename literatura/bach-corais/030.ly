% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 030.mid
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
  e'4 b' b a |
  % 2
  b e,8 fis g4 g |
  % 3
  g fis e2 |
  % 4
  g4 g g e |
  % 5
  g a b a |
  % 6
  g fis e2 |
  % 7
  g4 g g e |
  % 8
  g a b a |
  % 9
  g2 s4 d' |
  % 10
  e d8 c b a g a |
  % 11
  b4 a g fis |
  % 12
  e1 |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  b'4 b e8 dis e4 |
  % 2
  dis e8 dis e4 e |
  % 3
  e4. dis8 b2 |
  % 4
  e4 e d c |
  % 5
  d e8 fis g4. fis4 e dis8 b2 |
  % 7
  e4 g8 fis e4 c |
  % 8
  e8 d e fis g4. fis8 |
  % 9
  d2 s4 g8 f |
  % 10
  e4 fis g8 dis e d4 g fis e dis8 |
  % 12
  b1 |
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
  g'4 fis g fis8 e |
  % 2
  fis4 b8 a b4 e8 dis |
  % 3
  cis4 fis,8 b16 a g2 |
  % 4
  b4 c g g |
  % 5
  g8 a16 b c4 d8 e16 d c b c8 |
  % 6
  b4 b8. a16 g2 |
  % 7
  b8 c d4 c g |
  % 8
  g c d d8. c16 |
  % 9
  b2 s4 d |
  % 10
  c8 b a4 g8 c b a |
  % 11
  g d' e b b4 c8 b16 a |
  % 12
  gis1 |
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
  e4. d8 c2 |
  % 2
  b8 a' g fis e d c b |
  % 3
  ais4 b e,2 |
  % 4
  e'8 d c4 b c4. b8 a4 g a |
  % 6
  b2 e |
  % 7
  e4 b c8 d e d |
  % 8
  c b a4 g d' |
  % 9
  g,2 s4 b |
  % 10
  c d e4. fis8 |
  % 11
  g b, cis dis e g, a b |
  % 12
  e,1 |
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
