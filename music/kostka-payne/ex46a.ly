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
    \skip 1*9  %% 1-9
}
globalTempo = {
    \override Score.MetronomeMark #'transparent = ##t
    \tempo 4 = 65  \skip 1*8 \skip 2 
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
                \key d \major
                r2 r8 < fis' fis'' > < e' e'' > < d' d'' >  |
                < d fis d' fis' b b' a, d, > 8 < a a' > < fis fis' > < a a' >  < gis d f b f' d' d'' gis, d, > 4. -\tenuto < b b' > 8  |
                < a d fis d' fis' a a' a, d, > 8 -\tenuto < d fis d' fis' > 4 < d fis d' fis' > -\tenuto < fis' fis'' > 8 -\tenuto < e' e'' > < d' d'' >  |
                < d fis d' fis' a a' a, d, > 8 < fis fis' > < d d' > < fis fis' >  < e e' cis g cis' g' b b' a, d, > 4. -\tenuto < a a' > 8  |
%% 5
                < d fis d' fis' a a' a, d, > 8 -\tenuto < d fis d' fis' > 4 < d fis d' fis' > 8 < dis a c' a' c'' a' a'' fis a, d, > 4 -\tenuto < g' g'' g > 8 < fis' fis'' a >  |
                < e g b g' b' fis' fis'' e b, d, > 4 -\tenuto-\staccato < e' e'' > < cis g ais g' ais' g' g'' e g, d, > -\tenuto < fis' fis'' fis > 8 < e' e'' g >  |
                < d fis a fis' a' e' e'' d a, d, > 4 -\tenuto-\staccato < d' d'' > < fis' b' d fis b d' gis, gis,, > 8 -\tenuto < fis' fis'' > -\tenuto < e' e'' > < d' d'' >  |
                < d fis a d' a a' a, a,, > 8 < fis fis' > < d d' > < fis fis' >  < cis g cis' g' b b' dis dis' a, a,, > 4 -\tenuto < e e' > 8 -\tenuto < a a' >  |
                < d fis d' fis' a a' fis fis' a, d, > 8 -\tenuto < d fis d' fis' > 4 < d fis d' fis' > 8 
                % warning: bar too short, padding with rests
                r2  |
                \bar "|."
            } % Voice
        >> % Staff (final)
    >> % notes

    \layout { }
} % score