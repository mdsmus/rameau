% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 197.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 88 
  \skip 1*21 
  \time 5/4 
  \skip 4*5 |
  % 23
  
  \time 4/4 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  g a8 b c4 d |
  % 3
  a2 a4 f8 g |
  % 4
  a g f4 e8 d e4 |
  % 5
  d2 s4 f |
  % 6
  g g d c |
  % 7
  f g a a8 g |
  % 8
  f4 g a8 g f4 |
  % 9
  e d e2 |
  % 10
  d4 d d2 |
  % 11
  d1 |
  % 12
  a'4 a g a8 ais |
  % 13
  c4 d a a |
  % 14
  a8. g16 f8 g a g f4 |
  % 15
  e8 d e4 d f |
  % 16
  g g d c |
  % 17
  f g a a |
  % 18
  a8 g f8. g16 a4 f |
  % 19
  e d e2 |
  % 20
  d4 d d2 |
  % 21
  d1 |
  % 22
  a'4 f c' a |
  % 23
  c8 ais a4 g f |
  % 24
  a8 g f4 e d |
  % 25
  f g g d |
  % 26
  c f g a |
  % 27
  a8 g f4 g a |
  % 28
  f e d e2 d4 d d2 d1 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'4. e8 e gis a4. g4 f16 e f4 e d |
  % 4
  c8 cis d4 cis8 d4 cis8 |
  % 5
  a2 s4 d4. c16 b c4. b4 a16 ais |
  % 7
  c8 d e4 f e4. d4 cis8 d4. c8 |
  % 9
  ais a4 b8 cis2 |
  % 10
  d4 c c ais2 a8 g a2 |
  % 12
  f'4 e8 d g ais a g |
  % 13
  f2 f4 f |
  % 14
  e d8 e f cis d2 cis4 d c |
  % 16
  c8 b c4. ais4 a16 g |
  % 17
  c4 c c c8 cis |
  % 18
  d4 a d d4. c4 b8 c2 |
  % 20
  c8 ais a4 g4. ais8 |
  % 21
  a1 |
  % 22
  e'4 d c c |
  % 23
  c8 d e f4 e8 c4 |
  % 24
  e4. d4 c ais8 |
  % 25
  c4 d c8 g a b |
  % 26
  c ais a16 g a8 d c c4 |
  % 27
  f8 e d4. c16 ais a4. d16 c b8 a4 gis8 cis2 d4 c ais8 a |
  % 30
  g16 a ais4 a8 ais g a2 
}

trackC = <<

  \clef bass
  
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'8 c |
  % 2
  b4 c8 d e f16 e d4 |
  % 3
  d2 a4 a |
  % 4
  a a ais8 f g a16 g |
  % 5
  f2 s4 a |
  % 6
  e8 f g16*5 d16 e4 f16 g |
  % 7
  a8 f ais4 c a |
  % 8
  a g8 ais a16*5 g16 a8 |
  % 9
  g16 f g8 f16 e f8 e2 |
  % 10
  a8 g a fis g d g2 fis8 e fis2 |
  % 12
  d'4 c8 b c4 c |
  % 13
  c4. ais8 c4 c8 d |
  % 14
  e a,4 g8 f g a4 |
  % 15
  a4. g8 f4 a |
  % 16
  g8 f g4 g8. f16 e4 |
  % 17
  a g f a8 g |
  % 18
  f e d e f g a4 |
  % 19
  a8 e f4 g2 |
  % 20
  a8 g4 fis8 g d g2 fis8 e fis2 |
  % 22
  a4. ais8 a g f4 |
  % 23
  f c'4. ais8 a4 |
  % 24
  a a g8 a d,4 |
  % 25
  a'8 f d16 e f4 e8 fis gis |
  % 26
  a g f16 e f4 e8 f4 |
  % 27
  c'4. ais16 a g4. f16 e |
  % 28
  f8 ais16 a gis8 a d d, a'2 f8 g a4. g16 fis |
  % 30
  g4. fis8 g e fis2 
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
  s2. d4 |
  % 2
  e8. d16 c8 b a4 ais8. c16 |
  % 3
  d2 cis4 d8 e |
  % 4
  f4. f,8 g ais a4 |
  % 5
  d2 s4 d, |
  % 6
  e4. f8 g gis a4. ais8 a g f4 cis' |
  % 8
  d e f8 e d4. cis8 d4 a2 |
  % 10
  fis8 e fis d g a ais g |
  % 11
  d'2 d, |
  % 12
  d'8 e f4. e8 f g |
  % 13
  a f ais4 f f |
  % 14
  cis d4. e8 f g |
  % 15
  a4 a, ais a |
  % 16
  e8 d e f g4 a4. g8 f e f4 f'8 e |
  % 18
  d8*5 e8 f g |
  % 19
  a a, d4 c2 |
  % 20
  fis,8 g c4. ais16 a ais8 g |
  % 21
  d'2 d, |
  % 22
  cis'4 d e f |
  % 23
  a,8 ais c4 c, f |
  % 24
  cis' d8 d, e fis g4 |
  % 25
  a b c4. b8 |
  % 26
  a4. d8 ais c f4 |
  % 27
  f, ais dis8 d cis4 |
  % 28
  d4. c8 b4 a2 ais8 a g fis g a |
  % 30
  ais g d1 
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
