% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 154.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  g d f g |
  % 3
  a a g a |
  % 4
  g d f g |
  % 5
  a a g a |
  % 6
  b c a g |
  % 7
  g f e f |
  % 8
  g d f g |
  % 9
  a a g2 |
  % 10
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4. c4 b16 cis d8 c b4 |
  % 3
  e d8 c b4 d4. c4 b16 cis d8 c b4 |
  % 5
  e d d f |
  % 6
  f4. e4 d8 d4 |
  % 7
  e4. d8 cis4 d8 c |
  % 8
  b c4 b16 cis d8 c b4 |
  % 9
  e d8 c b2 |
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
  s2. f4 |
  % 2
  g g a g2 fis4 d f |
  % 4
  g g a g2 fis8 c' b4 c |
  % 6
  d g, a16 b c4 b8 |
  % 7
  c ais a4 a a |
  % 8
  g g a g2 fis4 d2 |
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
  s2. d4 |
  % 2
  e g d e8 d |
  % 3
  c4 d g, d' |
  % 4
  e g d e8 d |
  % 5
  c4 d g, f'8 e |
  % 6
  d4 c f8 fis g4 |
  % 7
  c,8 cis d4 a d |
  % 8
  e g d e8 d |
  % 9
  c4 d g,2 |
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
