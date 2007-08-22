% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 231.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  a b c2 |
  % 3
  b a4 a |
  % 4
  gis a b2 |
  % 5
  a s4 c |
  % 6
  c c8 b a2 |
  % 7
  d s4 b |
  % 8
  c a b a |
  % 9
  g2 s4 d' |
  % 10
  d d c2 |
  % 11
  a s4 c |
  % 12
  c b c8 b a4 |
  % 13
  a2 s4 d |
  % 14
  c b a2 |
  % 15
  g1 |
  % 16
  
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
  d d e d |
  % 3
  d2 e4 d8 c |
  % 4
  b4 e f e8 d |
  % 5
  c2 s4 a' |
  % 6
  g8 f g4. f16 e f8 g |
  % 7
  a2 s4 g |
  % 8
  g a4. g4 fis8 |
  % 9
  d2 s4 g |
  % 10
  a8 d, g4. f8 g e |
  % 11
  f2 s4 g |
  % 12
  a4. g8 g4 g |
  % 13
  fis2 s4 g4. fis8 g4 g fis |
  % 15
  d1 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. b'4 |
  % 2
  a g g a |
  % 3
  g2 g4 f8 e |
  % 4
  e4 e8 a a4 gis |
  % 5
  a2 s4 e' |
  % 6
  e8 d e4 c8 cis d e |
  % 7
  f2 s4 d |
  % 8
  e d d4. c8 |
  % 9
  b2 s4 b |
  % 10
  a b c2 |
  % 11
  c s4 e |
  % 12
  d d e8 d e4 |
  % 13
  d2 s4 d |
  % 14
  g,8 a b e a, d4 c8 |
  % 15
  b1 |
  % 16
  
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
  fis f e fis |
  % 3
  g2 cis,4 d2 c4 d e |
  % 5
  a,2 s4 a' |
  % 6
  e c f8 g f e |
  % 7
  d2 s4 g8 f |
  % 8
  e4 fis g d |
  % 9
  g,2 s4 g' |
  % 10
  fis g8 f e d e c |
  % 11
  f2 s4 e |
  % 12
  fis g c, cis |
  % 13
  d2 s4 b |
  % 14
  e d8 c d4 d, |
  % 15
  g1 |
  % 16
  
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
