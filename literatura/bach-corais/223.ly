% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 223.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  e fis g g |
  % 3
  e d c c |
  % 4
  g' g a b |
  % 5
  c b a a |
  % 6
  g2 s4 g |
  % 7
  a b c g |
  % 8
  a g f f |
  % 9
  e2 s4 c' |
  % 10
  a b c a |
  % 11
  g f e g |
  % 12
  e fis g c |
  % 13
  b a g g |
  % 14
  e8 f g4 a g |
  % 15
  f e d d |
  % 16
  c1 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. c'4 |
  % 2
  c c b d4. c4 b8 g4 g |
  % 4
  d' e4. fis8 g4. fis8 g8*5 fis8 |
  % 6
  d2 s4 e4. d4 e8 e4 c4. b8 c cis d cis d2 cis4 s4 g'4. f16 e 
  f4 e f |
  % 11
  e4. d4 cis8 d4 |
  % 12
  e b b g'8 a4 g fis8 d4 d |
  % 14
  c c c8 f4 e8 |
  % 15
  d4. c4 b16 a b4 |
  % 16
  g1 |
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
  s2. e8 f |
  % 2
  g4 a d, g |
  % 3
  g16*7 f16 e4 e |
  % 4
  g c c d |
  % 5
  c d e d8. c16 |
  % 6
  b2 s4 c |
  % 7
  c b a e |
  % 8
  f g a a |
  % 9
  a2 s4 c |
  % 10
  c d g, d'8 c |
  % 11
  ais4 a a g4. a4 g16 fis e4 e'8 d |
  % 13
  d4 d8. c16 b4 g |
  % 14
  g c8 ais a8. b16 c8. ais16 |
  % 15
  a8 g g4 a8 d, g f |
  % 16
  e1 |
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
  s2. c4 |
  % 2
  ais a g b |
  % 3
  c g c, c' |
  % 4
  b c8 b a4 g |
  % 5
  e' d c d |
  % 6
  g,2 s4 e' |
  % 7
  f gis, a c |
  % 8
  f4. e8 d e f d |
  % 9
  a'2 s4 e |
  % 10
  f8 e d4 c d4. cis8 d4 a b |
  % 12
  cis dis e e8 fis |
  % 13
  g4 d g, b |
  % 14
  c8 d e c f4 c4. b8 c4 f, g |
  % 16
  c,1 |
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
