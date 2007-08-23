% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 145.mid
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
  a8 b c4 b e |
  % 3
  d c b c8 b |
  % 4
  a4 e' d e |
  % 5
  a,8 b cis4 d c |
  % 6
  b e e8 d c4 |
  % 7
  b2. a8 b |
  % 8
  c4 c d d |
  % 9
  e e8 d c4 e |
  % 10
  d c b a8 b |
  % 11
  c4 b a2 |
  % 12
  
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
  e e e4. fis8 |
  % 3
  gis4 a gis a8 gis |
  % 4
  a4 a a g4. f8 e4 f e |
  % 6
  e e8 b' c b4 a8 |
  % 7
  gis2. e4 |
  % 8
  e f8 g a f g4 |
  % 9
  g g a g8 a |
  % 10
  b4 a gis a |
  % 11
  a8 fis gis4 e2 |
  % 12
  
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
  c8 b a4 gis a |
  % 3
  b c8 d e4 e8 d |
  % 4
  c b cis4 d8 c ais a |
  % 5
  a4 a a a |
  % 6
  gis a8 gis a b c d |
  % 7
  e2. c8 b |
  % 8
  a4 a a8 b16 c b4 |
  % 9
  c c c c |
  % 10
  f8 e e4 d c8 f |
  % 11
  e a, b d cis2 |
  % 12
  
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
  a'8 gis a4 e8 d c4 |
  % 3
  b a e' a, |
  % 4
  a'4. g8 f e d cis |
  % 5
  d4 a d, a' |
  % 6
  e'8 d c e fis gis a4 |
  % 7
  e2. a,4 |
  % 8
  a'8 g f e f d g f |
  % 9
  e d c4 f c8 b |
  % 10
  a gis a g f e f d |
  % 11
  e2 a |
  % 12
  
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
