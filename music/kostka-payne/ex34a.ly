% This LilyPond file was generated by Rosegarden 1.5.1
\version "2.10.0"
% point and click debugging is disabled
#(ly:set-option 'point-and-click #f)
\header {
    copyright = "Unknown"
    subtitle = "blank"
    title = "Untitled"
    tagline = "Created using Rosegarden 1.5.1 and LilyPond"
}
#(set-global-staff-size 20)
#(set-default-paper-size "a4")
global = { 
    \time 4/4
    \skip 1*15  %% 1-15
}
globalTempo = {
    \override Score.MetronomeMark #'transparent = ##t
    \tempo 4 = 160  \skip 1*14 \skip 4 
}
\score {
    <<
        % force offset of colliding notes in chords:
        \override Score.NoteColumn #'force-hshift = #1.0

        \context Staff = "track 1" << 
            \set Staff.instrument = "untitled"
            \set Score.skipBars = ##t
            \set Staff.printKeyCancellation = ##f
            \new Voice \global
            \new Voice \globalTempo

            \context Voice = "voice 1" {
                \override Voice.TextScript #'padding = #2.0                \override MultiMeasureRest #'expand-limit = 1

                \time 4/4
                \clef "alto"
                \key bes \major
                \times 2/3 { < g' g g' g, > 8 -\tenuto < g g' a, > -\tenuto < g g' bes, > } < g' g g' c > 16 -\tenuto r32 < g g' d > 16 -\tenuto < g g' ees > -\tenuto r32 \times 2/3 { < g g' d > 8 -\tenuto < g g' > < g g' > } < g' g g' bes, > 16. -\tenuto < g g' > 16 -\tenuto < g g' > -\tenuto r32  |
                < g' g g' g,, g, > 16 -\tenuto r64 < g g' g,, g, > 16 -\tenuto r32 < g g' g,, g, > 16 -\tenuto r32 < g g' g,, g, > 16 -\tenuto r32 < g g' g,, g, > 16 -\tenuto < g g' g,, g, > -\tenuto r32 < a' a g' a' g,, g, > 16 -\tenuto r64 < a g' a' g,, g, > 16 -\tenuto r32 < a g' a' g,, g, > 16 -\tenuto r32 < a g' a' g,, g, > 16 -\tenuto r32 < a g' a' g,, g, > -\tenuto a' -\tenuto < a g' a' g,, g, > 16 -\tenuto r32 
                % warning: bar too short, padding with rests
                r8  |
                < bes' bes g' bes' g, > 16 -\tenuto r64 < bes g' bes' a, > 16 -\tenuto r32 < bes g' bes' bes, > 16 -\tenuto r32 < bes g' bes' c > 16 -\tenuto r32 < bes g' bes' d > 16 -\tenuto < bes g' bes' ees > -\tenuto r32 \times 2/3 { < bes g' bes' d > 8 -\tenuto < bes g' bes' > < bes g' bes' > } < bes' bes g' bes' bes, > 16. -\tenuto < bes g' bes' > 16 -\tenuto < bes g' bes' > -\tenuto r32 
                % warning: bar too short, padding with rests
                r16  |
                < bes' bes g' bes' g,, g, > 16 -\tenuto r64 < bes g' bes' g,, g, > 16 -\tenuto r32 < bes g' bes' g,, g, > 16 -\tenuto r32 < bes g' bes' g,, g, > 16 -\tenuto r32 < bes g' bes' g,, g, > 16 -\tenuto < bes g' bes' g,, g, > -\tenuto r32 < c'' c' a' c'' g,, g, > 16 -\tenuto r64 < c' a' c'' g,, g, > 16 -\tenuto r32 < c' a' c'' g,, g, > 16 -\tenuto r32 < c' a' c'' g,, g, > 16 -\tenuto r32 < c' a' c'' g,, g, > 16 -\tenuto < c' a' c'' g,, g, > -\tenuto r32 
                % warning: bar too short, padding with rests
                r8  |
%% 5
                \times 2/3 { < d'' d' bes' d'' g, > 8 -\tenuto < d' bes' d'' a, > -\tenuto < d' bes' d'' bes, > } < d'' d' bes' d'' c > 16 -\tenuto r32 < d' bes' d'' d > 16 -\tenuto < d' bes' d'' ees > -\tenuto r32 \times 2/3 { < d' bes' d'' d > 8 -\tenuto < d' bes' d'' > < d' bes' d'' > } < d'' d' bes' d'' bes, > 16. -\tenuto < d' bes' d'' > 16 -\tenuto < d' bes' d'' > -\tenuto r32  |
                < d'' f' g' b' d'' g,, g, > 16 -\tenuto r64 < f' g' b' d'' g,, g, > 16 -\tenuto r32 < f' g' b' d'' g,, g, > 16 -\tenuto r32 < f' g' b' d'' g,, g, > 16 -\tenuto r32 < f' g' b' d'' g,, g, > 16 -\tenuto < f' g' b' d'' g,, g, > -\tenuto r32 \times 2/3 { < g'' f' g' b' d'' g,, g, > 8 -\tenuto < f' g' b' d'' g,, g, > < f' g' b' d'' g,, g, > } < f' g' b' d'' g,, g, > 16 -\tenuto r32 < f' g' b' d'' g,, g, > -\tenuto d'' -\tenuto < f' g' b' d'' g,, g, > 16 -\tenuto r32 
                % warning: bar too short, padding with rests
                r16  |
                \times 2/3 { < ees'' ees' g' c'' c, > 8 -\tenuto < ees' g' c'' d, > < ees' g' c'' ees, > } \times 2/3 { < ees' g' c'' f, > < ees' g' c'' g, > < ees' g' c'' aes, > } \times 2/3 { < ees' g' c'' g, > -\tenuto < ees' g' c'' > < ees' g' c'' > } \times 2/3 { < ees' g' c'' ees, > -\tenuto < ees' g' c'' > < ees' g' c'' > }  |
                \times 2/3 { < c' c'' c, c > 8 -\tenuto < c' c'' > < c' c'' > } \times 2/3 { < c' c'' > < c' c'' > < c' c'' > } \times 2/3 { < c' c'' des, des > -\tenuto < c' c'' > < c' c'' > } \times 2/3 { < c' c'' d, d > -\tenuto < c' c'' > < c' c'' > }  |
                \times 2/3 { < c' c'' ees, ees > 8 -\tenuto < c' c'' > < c' c'' > } \times 2/3 { < c' c'' e, e > -\tenuto < c' c'' > < c' c'' > } \times 2/3 { < c' c'' f, f > -\tenuto < c' c'' > < c' c'' > } < c'' c' c'' g, g > 16. -\tenuto < c' c'' > 16 -\tenuto < c' c'' > -\tenuto r32  |
%% 10
                < c'' c' ees' aes' c'' aes, aes > 16 -\tenuto r64 < c' ees' aes' c'' aes, aes > 16 -\tenuto r32 < c' ees' aes' c'' aes, aes > 16 -\tenuto r32 < c' ees' aes' c'' aes, aes > 16 -\tenuto r32 < c' ees' aes' c'' aes, aes > 16 -\tenuto < c' ees' aes' c'' aes, aes > -\tenuto r32 \times 2/3 { < c' ees' aes' c'' aes, aes > 8 -\tenuto < c' ees' aes' c'' aes, aes > -\tenuto < c' ees' aes' c'' aes, aes > } < aes' c' ees' aes' c'' aes, aes > 16 -\tenuto r32 < c' ees' aes' c'' aes, aes > 16 -\tenuto < c' ees' aes' c'' aes, aes > -\tenuto r32 
                % warning: bar too short, padding with rests
                r16  |
                \times 2/3 { < des'' des' e' g' bes' aes, aes > 8 -\tenuto < des' e' g' bes' aes, aes > < des' e' g' bes' aes, aes > } < des' e' g' bes' aes, aes > 16 -\tenuto r32 < des' e' g' bes' aes, aes > -\tenuto bes' -\tenuto < des' e' g' bes' aes, aes > 16 -\tenuto r32 \times 2/3 { < g' des' e' g' bes' aes, aes > 8 -\tenuto < des' e' g' bes' aes, aes > -\tenuto < des' e' g' bes' aes, aes > } < bes' des' e' g' bes' aes, aes > 16 -\tenuto r32 < des' e' g' bes' aes, aes > 16 -\tenuto < des' e' g' bes' aes, aes > -\tenuto r32  |
                \times 2/3 { < aes' c' ees' aes' aes, aes > 8 -\tenuto < c' ees' aes' aes, aes > -\tenuto < c' ees' aes' aes, aes > } \times 2/3 { < c' ees' aes' aes, aes > < c' ees' aes' aes, aes > < c' ees' aes' aes, aes > } \times 2/3 { < c' ees' aes' aes, aes > < c' ees' aes' aes, aes > < c' ees' aes' aes, aes > } \times 2/3 { < c' ees' aes' aes, aes > < c' ees' aes' aes, aes > < c' ees' aes' aes, aes > }  |
                < c' ees' aes' c ees aes > 4 -\tenuto r16 aes' aes' bes' ) c'' 4 bes' 8 aes'  |
                g' 8 -\tenuto < bes e' g' des, des > 4 des' 8 d' 4 < a c' d' ges' d, d > 8 r  |
%% 15
                < g bes d' g' g,, g, > 4 
                % warning: bar too short, padding with rests
                r4 r2  |
                \bar "|."
            } % Voice
        >> % Staff (final)
    >> % notes

    \layout { }
} % score