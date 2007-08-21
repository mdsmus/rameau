% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 042200b_.mid
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
  g''4 g a g |
  % 2
  a8 b c4 c b |
  % 3
  c2 d4 e |
  % 4
  c2 b8 c d4 |
  % 5
  a2 d4 d |
  % 6
  c b a a8. g16 |
  % 7
  g2 c4 c |
  % 8
  b c a d |
  % 9
  d cis d2 |
  % 10
  d4 e c2 |
  % 11
  b8 c d4 a2 |
  % 12
  d4 d c b8 a |
  % 13
  a4 a8. g16 g2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'8 f g e4 d g8 |
  % 2
  f4 g g2 |
  % 3
  g g8 f e4 |
  % 4
  e2 e4 d |
  % 5
  d2 d4 e |
  % 6
  e8 d4 g8 g4 fis |
  % 7
  d2 g8 fis g a |
  % 8
  g4 g2 f4 |
  % 9
  e2 fis |
  % 10
  g4 g f2 |
  % 11
  d8 e d e fis2 |
  % 12
  fis4 g8 fis e fis g4 |
  % 13
  g fis d2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  c'4 c c b8 c |
  % 2
  f4 e d8 e f g16 f |
  % 3
  e2 b4 b |
  % 4
  a2 g4 g |
  % 5
  fis2 fis4 g4. a8 b d e4 a,16 b c8 |
  % 7
  b2 g4 e' |
  % 8
  d c c a |
  % 9
  ais a a2 |
  % 10
  b4 ais8 c16 ais a2 |
  % 11
  g4 g d'2 |
  % 12
  d8 c b4 c d |
  % 13
  d a16 b c8 b2 |
  % 14
  
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
  c8 d e c f4. e8 |
  % 2
  d4 e8 f g2 |
  % 3
  c, g'4 gis |
  % 4
  a2 e4 b8 c |
  % 5
  d2 b4 e4. fis8 g b, c a d4 |
  % 7
  g,2 e'8 d e fis |
  % 8
  g f e c f e f d |
  % 9
  g e a a, d2 |
  % 10
  g4 c, f2 |
  % 11
  f8 e b c d2 |
  % 12
  b4 e a, b8 c |
  % 13
  d2 g, |
  % 14
  
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
