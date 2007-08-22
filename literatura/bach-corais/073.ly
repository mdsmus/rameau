% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 073.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g fis g a |
  % 3
  ais a g g |
  % 4
  a a d c |
  % 5
  ais2 a4 g |
  % 6
  g fis g a |
  % 7
  ais a g g |
  % 8
  a a d c |
  % 9
  ais2 a4 d |
  % 10
  c ais a8 ais c4 |
  % 11
  ais a g ais |
  % 12
  a g f8 e d e |
  % 13
  f4 g a a |
  % 14
  ais c d4. c8 |
  % 15
  ais4 c8 ais a2 |
  % 16
  g1 |
  % 17
  
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
  dis d8 c ais4 dis |
  % 3
  d d d d |
  % 4
  dis d d g8 fis |
  % 5
  g2 fis4 d |
  % 6
  dis d8 c ais4 dis |
  % 7
  d d d d |
  % 8
  dis d d g8 fis |
  % 9
  g2 fis4 g |
  % 10
  g8 f f dis dis d c a' |
  % 11
  fis g4 fis8 d4 g8 f |
  % 12
  e d d cis d e f cis |
  % 13
  d f4 e8 f4 f |
  % 14
  f8 g a4 a d,2 c8 d dis4 d8 c |
  % 16
  b1 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. ais'4 |
  % 2
  a a g c |
  % 3
  fis,8 g4 fis8 ais4 ais |
  % 4
  c c b c |
  % 5
  d e8 g, d'4 ais |
  % 6
  a a g c |
  % 7
  fis,8 g4 fis8 ais4 ais |
  % 8
  c c b c |
  % 9
  d e8 g, d'4 d |
  % 10
  dis8 f g ais, c d g, c |
  % 11
  d dis a d ais4 d |
  % 12
  cis8 d e4 a,4. g8 |
  % 13
  a c d c c4 c |
  % 14
  d dis f fis |
  % 15
  g g,2 fis4 |
  % 16
  d1 |
  % 17
  
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
  s2. g'4 |
  % 2
  c, d dis d8 c |
  % 3
  d4 d g, g' |
  % 4
  g fis f dis |
  % 5
  d cis d g |
  % 6
  c, d dis d8 c |
  % 7
  d4 d g, g' |
  % 8
  g fis f dis |
  % 9
  d cis d ais'4. a8 g4. f8 dis4 |
  % 11
  d8 c d4 g, g'4. f8 e4 d8*5 a8 ais c f,4 f'8 dis |
  % 14
  d dis d c ais c ais a |
  % 15
  g ais dis d c a d4 |
  % 16
  g,1 |
  % 17
  
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
