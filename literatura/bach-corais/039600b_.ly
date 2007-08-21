% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 039600b_.mid
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
  s2. e''4 |
  % 2
  a, b c c |
  % 3
  d d e e |
  % 4
  d e c c |
  % 5
  b2 s4 e |
  % 6
  c b c a |
  % 7
  gis a b e |
  % 8
  d c b4. b8 |
  % 9
  a1 |
  % 10
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a''4 |
  % 2
  e e e8 f g4 |
  % 3
  a g g g |
  % 4
  a e e e |
  % 5
  e2 s4 b'4. a8 gis4 a8 g f4. e8 e fis gis4 a4. gis8 a4 a gis |
  % 9
  e1 |
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
  s2. c'4 |
  % 2
  c b4. a8 g c4 b16 a b4 c c2 b a gis4 s4 e' |
  % 6
  e e e d4. b8 c4 b a |
  % 8
  d e f8 d b e16 d |
  % 9
  cis1 |
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
  s2. a8 b |
  % 2
  c b a gis a4 e |
  % 3
  f g c, c' |
  % 4
  fis, gis a8 b c d |
  % 5
  e2 s4 gis, |
  % 6
  a e'8 d c4 d8 c |
  % 7
  b e c a e'4 c |
  % 8
  b a d e |
  % 9
  a,1 |
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
