% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 217.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key c \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  c''4 c c a |
  % 2
  b c d c |
  % 3
  b a2. |
  % 4
  a4 b c d2 c4 b a2 g2. |
  % 7
  e'4 e e c |
  % 8
  d e f e2 d2. |
  % 10
  c4 d e d2 c4 c b2 c2. |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 g g f |
  % 2
  g g a2 |
  % 3
  g4 fis2. |
  % 4
  fis4 g g g2 g4 g g |
  % 6
  fis g2. |
  % 7
  g4 e gis a |
  % 8
  b cis d c2 g2. |
  % 10
  g4 b c c |
  % 11
  b e, a g2 g2. |
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
  g'4 c e c |
  % 2
  d e d2 |
  % 3
  d4 d2. |
  % 4
  d4 d e d2 e4 d d4. c8 b2. |
  % 7
  c4 b e e |
  % 8
  f g f g |
  % 9
  c, b2. |
  % 10
  c4 f, g a |
  % 11
  b c d d2 e2. |
  % 13
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  c4 e c f2 e4 fis2 |
  % 3
  g4 d2. |
  % 4
  d4 g e b2 c4 g' d2 g,2. |
  % 7
  c'4 gis e a2 a,4 d e |
  % 9
  f g2. |
  % 10
  e4 d c f |
  % 11
  g a fis g |
  % 12
  g, c2. |
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
