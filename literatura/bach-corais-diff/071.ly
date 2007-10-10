% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 071.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  g fis8 g16 a g8 fis e fis |
  % 3
  g8. a16 a4 b b8 c |
  % 4
  d c b a g4 a8 b |
  % 5
  c2 b4 b |
  % 6
  g fis8 g16 a g8 fis e fis |
  % 7
  g8. a16 a4 b b8 c |
  % 8
  d c b a g4 a8 b |
  % 9
  c2 b4 d |
  % 10
  e d8 c b a g a |
  % 11
  b c a4 g b |
  % 12
  b b a g8 fis |
  % 13
  fis2 e |
  % 14
  g4 fis e2 |
  % 15
  d4 d g g |
  % 16
  a a b c |
  % 17
  b a g8 fis e fis |
  % 18
  g4 fis e2 |
  % 19
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'4 |
  % 2
  e dis e8 dis e dis |
  % 3
  e4. fis8 dis4 e |
  % 4
  d d e d |
  % 5
  c8 e4 dis8 e4 fis |
  % 6
  e dis e8 dis e dis |
  % 7
  e4. fis8 dis4 e |
  % 8
  d d e d |
  % 9
  c8 e4 dis8 e4 d8 g16 f |
  % 10
  e4 fis fis g |
  % 11
  g8 a fis4 d d8 e |
  % 12
  fis a g fis e dis e4 |
  % 13
  e dis e2 |
  % 14
  e4. d4 cis16 b cis4 |
  % 15
  a a d c8 d |
  % 16
  e c e d e4 e |
  % 17
  e8 dis e fis e dis e4 |
  % 18
  e dis b2 |
  % 19
  
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
  b8 c4 b16 a b8*5 b8 a16 g fis e fis4 g |
  % 4
  a g8 f e4 fis8 gis |
  % 5
  a g fis4 g b |
  % 6
  b8 c4 b16 a b8*5 b8 a16 g fis e fis4 g |
  % 8
  a g8 f e4 fis8 gis |
  % 9
  a g fis4 g g |
  % 10
  g8 c b a b4. c8 |
  % 11
  d e d c b4 g |
  % 12
  fis e a8 b c4 |
  % 13
  b8 a4 g8 g2 |
  % 14
  a4 a b a8 g |
  % 15
  fis4 fis g8 f e g |
  % 16
  c e a,4 gis a8 g |
  % 17
  fis4 e8 b' b4. c8 |
  % 18
  b4. a8 gis2 |
  % 19
  
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
  s2. dis4 |
  % 2
  e8*5 fis8 g fis |
  % 3
  e d c4 b e |
  % 4
  fis g c,8 d c b |
  % 5
  a2 e4 dis' |
  % 6
  e8*5 fis8 g fis |
  % 7
  e d c4 b e |
  % 8
  fis g c,8 d c b |
  % 9
  a2 e4 b' |
  % 10
  c d dis e |
  % 11
  d8 c d4 g, g' |
  % 12
  dis e8 d c4 b8 a |
  % 13
  b2 c |
  % 14
  cis4 d g, a |
  % 15
  d d8 c b4 c8 b |
  % 16
  a g f4 e a |
  % 17
  b cis8 dis e fis g a |
  % 18
  b4 b, e2 |
  % 19
  
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
  s2. dis4 |
  % 2
  e8*5 fis8 g fis |
  % 3
  e d c4 b e, |
  % 4
  fis g c8 d c b |
  % 5
  a2 e4 dis' |
  % 6
  e8*5 fis8 g fis |
  % 7
  e d c4 b e, |
  % 8
  fis g c8 d c b |
  % 9
  a2 e4 b' |
  % 10
  c d dis e |
  % 11
  d8 c d4 g, g' |
  % 12
  dis e8 d c4 b8 a |
  % 13
  b2 c |
  % 14
  cis4 d g, a |
  % 15
  d, d'8 c b4 c8 b |
  % 16
  a g f4 e a, |
  % 17
  b cis8 dis e fis g a |
  % 18
  b4 b, e2 |
  % 19
  
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
