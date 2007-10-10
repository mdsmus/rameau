% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 337.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  s2. a''4 |
  % 2
  a ais8 c16 d c4 ais16 a ais8 |
  % 3
  a4 a8 ais c4 f, |
  % 4
  g a g2 |
  % 5
  f4 a a ais8 c16 d |
  % 6
  c4 ais a a8 ais |
  % 7
  c4 f, g a8. ais16 |
  % 8
  g2 f4 g |
  % 9
  g a ais ais8. c16 |
  % 10
  a4 a g c8 d16 dis |
  % 11
  d4 c8 b c4 c |
  % 12
  c8 ais a4 ais c8 d16 dis |
  % 13
  d4 g, a a |
  % 14
  g g f2 |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelB = \relative c {
  s2. e'8 f16 g |
  % 2
  f4 f f8 e16 d e4 |
  % 3
  f f g8 e f4 |
  % 4
  e f d e |
  % 5
  c f f f8 g |
  % 6
  e f4 e8 f4 f |
  % 7
  f8 dis d4 e f |
  % 8
  f e c d |
  % 9
  e f4. e16 d e4 |
  % 10
  f dis d g |
  % 11
  f8 gis g f e4 g |
  % 12
  f f f f |
  % 13
  f e c f2 e4 c2 |
  % 15
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
>>


trackDchannelB = \relative c {
  s2. cis'4 |
  % 2
  d d8 ais a g16 f g4 |
  % 3
  c c8 d e4 a,8 f |
  % 4
  c'4 c ais g |
  % 5
  a c d d8 ais4 a8 g c c4 f,8 g |
  % 7
  a g f4 c' c |
  % 8
  c8 ais16 a ais8 g a4 d8 b |
  % 9
  c4 c d8 c16 ais c4 |
  % 10
  c c b c |
  % 11
  c8 f d4 c e |
  % 12
  c c d c |
  % 13
  ais ais a d |
  % 14
  d8 g, a ais a2 |
  % 15
  
}

trackD = <<

  \clef bass
  
  \context Voice = channelA \trackDchannelA
>>


trackEchannelB = \relative c {
  s2. a4 |
  % 2
  d8 c ais4 c c |
  % 3
  f, f' e d |
  % 4
  c8 ais a f ais g c c, |
  % 5
  f4 f'8 e d c ais g |
  % 6
  c4 c f, d' |
  % 7
  a ais ais'8 a g f |
  % 8
  c4 c f b,8 g |
  % 9
  c4 ais8 a g4 c |
  % 10
  f fis f dis8 f16 g |
  % 11
  gis8 g16 f g8 g, c4 c'8 ais |
  % 12
  a g f dis d c ais a |
  % 13
  ais4 c f8 e d c |
  % 14
  ais b c4 f2 |
  % 15
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
  >>
}
