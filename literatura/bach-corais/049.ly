% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 049.mid
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
  s2. d'4 |
  % 2
  a' a g d' |
  % 3
  c b a c |
  % 4
  b a b2 |
  % 5
  a2. b4 |
  % 6
  c b c a |
  % 7
  g8 f e4 d a' |
  % 8
  a g f8 e d4 |
  % 9
  c2 a'4 f |
  % 10
  c' a g8 f g4 |
  % 11
  a g f8 e d4 |
  % 12
  c f e8 d4 cis8 |
  % 13
  d1 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a'4 |
  % 2
  d f e fis8 gis |
  % 3
  a4. gis8 e4 a4. gis8 a4 f e8 d |
  % 5
  c2. g'4 |
  % 6
  g g g f |
  % 7
  e8 d cis4 a e'8 d |
  % 8
  e dis e f a,4 ais |
  % 9
  a2 e'4 d |
  % 10
  c8 g'4 f8 e d cis d |
  % 11
  e4 e d8 c b4 |
  % 12
  a8 b cis d e f g2 fis8 e fis2 |
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
  s2. f8 g |
  % 2
  a4 d8 c b4 a8 b |
  % 3
  c d16 e f8 e c4 e |
  % 4
  f8 e16 d c b a4 d16 b gis4 |
  % 5
  a2. d4 |
  % 6
  e d c4. d8 |
  % 7
  cis d a g f4 a |
  % 8
  g8 f4 e8 f2 |
  % 9
  f a4 a |
  % 10
  g c8 d e f e d |
  % 11
  cis4 a a8 g f4 |
  % 12
  e a2. |
  % 13
  ais4 a8 g a2 |
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
  s2. d8 e |
  % 2
  f e f d e d c b |
  % 3
  a c d e a,4 a' |
  % 4
  d,8 e f e d b e4 |
  % 5
  a,2. g'8 f |
  % 6
  e f g f e c f d |
  % 7
  ais' g a4 d, cis8 b |
  % 8
  cis a b cis d c d e |
  % 9
  f2 cis4 d |
  % 10
  e f g8 a ais4 |
  % 11
  a cis, d gis, |
  % 12
  a4. b8 cis d a4 |
  % 13
  d,1 |
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
