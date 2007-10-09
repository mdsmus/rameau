% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 339.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. e'4 |
  % 2
  a b c b |
  % 3
  a b gis4. fis8 |
  % 4
  e4 g g f |
  % 5
  e a a gis |
  % 6
  a2. e4 |
  % 7
  a b c b |
  % 8
  a b gis4. fis8 |
  % 9
  e4 g g f |
  % 10
  e a a gis |
  % 11
  a2. b4 |
  % 12
  c d e e |
  % 13
  d d c e |
  % 14
  d c b a |
  % 15
  c b a8*5 
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
  e16 d f4 e16 d c8 a'4 g fis16 e fis8 fis fis e d c |
  % 4
  b4 e8 d cis4 d |
  % 5
  b8 c d e fis4 e |
  % 6
  e2. e4 |
  % 7
  e16 d f4 e16 d c8 a'4 g fis16 e fis8 fis fis e d c |
  % 9
  b4 e8 d cis4 d |
  % 10
  b8 c d e fis4 e |
  % 11
  e2. gis4 |
  % 12
  a b c8 g c ais |
  % 13
  a4 b g g |
  % 14
  f fis gis a |
  % 15
  dis,8 fis f e16 d cis8*5 
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
  c8 b16 a gis8 e' e4 dis |
  % 3
  e b b4. a8 |
  % 4
  gis4 e a a |
  % 5
  gis8 a b c d c b4 |
  % 6
  cis2. c4 |
  % 7
  c8 b16 a gis8 e' e4 dis |
  % 8
  e b b4. a8 |
  % 9
  gis4 e a a |
  % 10
  gis8 a b c d c b4 |
  % 11
  cis2. e4 |
  % 12
  e16 c f4 e16 d c8 d e4 |
  % 13
  f8 d g f e4 c |
  % 14
  c8 b a gis16 a e8 d' c b |
  % 15
  a4. gis8 e8*5 
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
  f4 e a, b |
  % 3
  cis dis e2 |
  % 4
  e4 cis a d |
  % 5
  d8 c f e dis4 e |
  % 6
  a,2. a'8 g |
  % 7
  f4 e a, b |
  % 8
  cis dis e2 |
  % 9
  e4 cis a d |
  % 10
  d8 c f e dis4 e |
  % 11
  a,2. e'4 |
  % 12
  a g8 f e d c4 |
  % 13
  d8 e16 f g8 g, c4 c |
  % 14
  d dis e f |
  % 15
  fis8 dis e e, a8*5 
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  s2. a'8 g |
  % 2
  f4 e a, b |
  % 3
  cis dis e2 |
  % 4
  e4 cis a d |
  % 5
  d8 c f e dis4 e |
  % 6
  a,2. a'8 g |
  % 7
  f4 e a, b |
  % 8
  cis dis e2 |
  % 9
  e4 cis a d |
  % 10
  d8 c f e dis4 e |
  % 11
  a,2. e'4 |
  % 12
  a g8 g, c b a g |
  % 13
  f e g4 c, c' |
  % 14
  d dis e f |
  % 15
  fis8 dis e e, a8*5 
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
