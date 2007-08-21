% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 028600b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  c b c d |
  % 3
  e e d c |
  % 4
  b2 b4 b |
  % 5
  e d d c |
  % 6
  b c d c |
  % 7
  b b a2 |
  % 8
  
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
  a b4. a4 g8 |
  % 3
  g4 g g8 f e4 |
  % 4
  e2 e4 e |
  % 5
  e fis gis a4. gis8 a4 a8 gis a4 |
  % 7
  a4. gis8 e2 |
  % 8
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. c'4 |
  % 2
  e e e d4. c16 b c4 b4. a gis8 fis gis4 gis |
  % 5
  a a b c8 d |
  % 6
  e4 e d e |
  % 7
  f e8. d16 c2 |
  % 8
  
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
  s2. a4 |
  % 2
  a'4. gis8 a a, b4 |
  % 3
  c8 d e f g4 a |
  % 4
  e2 e,4 e'8 d |
  % 5
  c4 c b a |
  % 6
  e' a8 g f4 e |
  % 7
  d e a,2 |
  % 8
  
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
