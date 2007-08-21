% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 025500b_.mid
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
  s2. c''4 |
  % 2
  b a g g |
  % 3
  a b c d |
  % 4
  c b a b8 c |
  % 5
  a2 g4 c |
  % 6
  b c d d |
  % 7
  e d8 c d4 g, |
  % 8
  a b c8 d e f |
  % 9
  d2 c |
  % 10
  
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
  g fis d e8 d |
  % 3
  c4 d e g4. fis8 g4 fis g2 fis4 d g |
  % 6
  f g g g |
  % 7
  g fis g g |
  % 8
  d d c4. a'8 |
  % 9
  g4. f8 e2 |
  % 10
  
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
  d4. c8 b4 c8 ais |
  % 3
  a g f4 g b |
  % 4
  c d d d |
  % 5
  e d8 c b4 c |
  % 6
  d e b b |
  % 7
  c c b c |
  % 8
  c b e8 f g c, |
  % 9
  c4 b g2 |
  % 10
  
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
  g' d g, c |
  % 3
  f8 e d4 c g |
  % 4
  a b8 c d4 g |
  % 5
  c, d g, e' |
  % 6
  d c g' g |
  % 7
  c8 b a4 g e |
  % 8
  fis gis a g8 f |
  % 9
  g4 g, c2 |
  % 10
  
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
