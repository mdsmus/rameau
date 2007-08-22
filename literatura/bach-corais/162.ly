% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 162.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 86 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  a g8 f e4 a |
  % 3
  g e f a |
  % 4
  a g8 f e4 a |
  % 5
  g e f a |
  % 6
  b cis d a8 b |
  % 7
  c4 b a b |
  % 8
  c b a a |
  % 9
  g8 f e4 f g |
  % 10
  g a g8 f e4 |
  % 11
  f f e b' |
  % 12
  c b a e |
  % 13
  a a gis2 |
  % 14
  
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
  f e8 d cis4 d |
  % 3
  d8 e d cis d4 d |
  % 4
  d8*5 c8 c f4 e16 d e8 cis d4 f |
  % 6
  f8 e e d d4 c8 d |
  % 7
  e4. d8 cis4 d |
  % 8
  e d c8 d dis4 |
  % 9
  d e d d8 e16 f |
  % 10
  e4 d8 c d4 e4. cis8 d4 cis fis |
  % 12
  e8 fis gis a16 b e,4. e8 |
  % 13
  e4 dis e2 |
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
  s2. cis'4 |
  % 2
  d8 c ais g a4 a8 f |
  % 3
  d ais' a4 a f |
  % 4
  f8 d g4. e8 f a |
  % 5
  c ais ais a a4 d |
  % 6
  d a a8 gis a4 |
  % 7
  a gis e f |
  % 8
  g8 e f g a ais c4 |
  % 9
  ais8 a ais a a4 g |
  % 10
  c8 e, fis g16 a d,4 a' |
  % 11
  a a a a |
  % 12
  gis8 a b4 c8 d c b |
  % 13
  c a fis b b2 |
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
  s2. a'8 g |
  % 2
  f d g4. e8 f d |
  % 3
  ais g a4 d d8 c |
  % 4
  ais4 b c8*5 e8 cis a d4 d' |
  % 6
  gis, g fis f |
  % 7
  e8 d e4 a, d |
  % 8
  c d8 e f4 fis |
  % 9
  g cis, d b |
  % 10
  c4. a8 b4 cis |
  % 11
  d8 e f g a4 dis, |
  % 12
  e4. d8 c b a g |
  % 13
  fis4 b e2 |
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
