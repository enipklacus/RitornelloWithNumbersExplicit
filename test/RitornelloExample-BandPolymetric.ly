%%CODE BEGINS
%
\version "2.24.0"
%
\include "../ritornello.ly"
%
guitarOneNotes = {\relative c' {
    b1
    \ritornello 2 { e1 b } % end ritornelo
    %
    \ritornello 3 { g1 a } % end ritornelo
    %
    \tag #'(section) { \textMark \markup \box \bold "Bridge" }
    b1
  } % end relative
} % end guitarOneNotes
%
guitarOne = {
<<
  \new Staff \removeWithTag #'() {\transpose c c' {{\guitarOneNotes}}}
  \new TabStaff \removeWithTag #'(section sectionInd) {\guitarOneNotes}
>>
} % end guitarOne
%
guitarTwoNotes = {\relative c, {
    <fis b fis'>1
    \ritornello 4 {
      \repeat unfold 2 {g8 fis e e}
      \repeat unfold 2 {c' b a a}
    } % end ritornelo
%    <fis b fis'>1~ {\repeat unfold 4 {q~}} q
    \tag #'(section) { \textMark \markup \box \bold "Bridge" }
    <a e'>1
  } % end relative
} % end guitarNotes
%
guitarTwo = {
<<
  \new Staff \removeWithTag #'() {\transpose c c' {{\guitarTwoNotes}}}
  \new TabStaff \removeWithTag #'(section sectionInd) {\guitarTwoNotes}
>>
} % end guitarTwo
%
drumsUp = {\drummode {
    {\repeat unfold 4 {\repeat tremolo 4 {sn16}}}
  \ritornelloPivot 6 {
    \time 3/4 hh4 hh8 <sn> hh4
    \time 2/4 hh4 <hh sn>4
  } % end ritornello
  \time 2/4 hh4 hh4
  \tag #'section { \textMark \markup \box \bold "Bridge" }
  \time 4/4 hh1
 } % end drummode
} % end drumsUp
%
drumsDown = {\drummode {
  {\repeat unfold 4 {bd4}}
  \repeat volta 6 {
  bd4 r r | bd4 r 
  } % end ritornello
  r8 bd8 r8 bd8 | bd1
 } % end drummode
} % end drumsDown
%
drumkit = {
  \new DrumStaff \with { \consists Merge_rests_engraver } {
    <<
    \new DrumVoice = "up"   {\voiceOne \drumsUp }
    \new DrumVoice = "down" {\voiceTwo \drumsDown }
    >>
  } % end DrumStaff
} % end drumkit
%
conductorSection = { % Staff to insert comments and sections for the conductor's score. I could use a Devnull staff, but I could see the need to insert a specific staff somewhere.
\new Staff \with { \RemoveAllEmptyStaves } {
  \textMark \markup \box \bold \magnify #1.75 "A"
  s1 
  s1*2 \break
  s1*6
  \textMark \markup \box \bold \magnify #1.75 "B"
  } % end Devnull 
} % end conductorSection
%
conductorScore = {
<<
  \conductorSection
  \guitarOne
  \guitarTwo
  \drumkit
>>
} % end conductorScore
%
\score { \removeWithTag #'unScore {\guitarOne} }
\score { \removeWithTag #'unScore {\guitarTwo} }
\score { \removeWithTag #'unScore {\drumkit} }
%\score { \removeWithTag #'unScore {<< \guitarOne \guitarTwo >> } }
\score { {\unfoldRepeats {\removeWithTag #'(folScore section) {\conductorScore}}} \layout { \enablePolymeter } }
%
%%CODE ENDS