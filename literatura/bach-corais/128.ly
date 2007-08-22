% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 128.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g d' d |
  % 2
  c d b g |
  % 3
  b b a a |
  % 4
  g a fis d |
  % 5
  a' a b8 a g fis |
  % 6
  e4. d8 d2 |
  % 7
  d'4 d d e |
  % 8
  c d b g |
  % 9
  b b a a |
  % 10
  g a fis d |
  % 11
  g a b8 c d c |
  % 12
  b4 a8 g g2 |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 d d8 a'4 g8 |
  % 2
  a4 a8 fis g4 d |
  % 3
  g g g fis4. e16 d e8 cis d4 a |
  % 5
  d d d d4. b8 cis4 a2 |
  % 7
  a'4 a gis8 a b4. a16 g a4 g d |
  % 9
  g g8 fis e cis fis4. e16 d e8 cis d4 a |
  % 11
  d8 b fis'4 g8 fis g2 fis4 d2 |
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
  b'4 b a b |
  % 2
  e d d b |
  % 3
  d d d d |
  % 4
  d8 b a4 a fis |
  % 5
  fis8 g a fis g4 a |
  % 6
  a4. g16 fis fis2 |
  % 7
  fis'4 fis f e |
  % 8
  e d d b |
  % 9
  d8 b e d cis a d4 |
  % 10
  d8 b a4 a fis |
  % 11
  g d' d8 c b c |
  % 12
  d4 d8. c16 b2 |
  % 13
  
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
  g'4 g fis g2 fis8 d g4 g, |
  % 3
  g8 a b c d e fis d |
  % 4
  b e cis a d4 d, |
  % 5
  d'8 e fis d g4 d |
  % 6
  a' a, d2 |
  % 7
  d8 d'4 c8 b a gis e |
  % 8
  a g fis d g4 g, |
  % 9
  g' g g fis8 d |
  % 10
  b e cis a d4 d, |
  % 11
  b'8 e d c b a g e' |
  % 12
  d4 d, g2 |
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
