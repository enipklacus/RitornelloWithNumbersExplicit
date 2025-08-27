\version "2.24.0"
%
\include "../ritornello.ly"
%
pianoRightHand = {\relative c''{
  g1
  {\ritornello 2 {c1 d e d}} \break
  {\ritornello 3 {c1 d e d}} \break
  {\ritornelloPivot 2 {c1 d e d}} 
  b1 c1
 } % end relative
} % end pianoRightHand
%
pianoLeftHand = {\relative c{
  \clef bass
  g1
  {\repeat volta 2 {c1 d e d}}
  {\repeat volta 3 {g1 a b a}}
  {\repeat volta 2 {c1 d e d}} 
  b1 c1
  } % end relative
} % end pianoLeftHand
%
piano = {\new PianoStaff {
<<
  \new Staff {\pianoRightHand}
  \new Staff {\pianoLeftHand}
>>
}}
%
\score { \removeWithTag #'unScore {\piano} } % folded score
\score { \removeWithTag #'folScore {\unfoldRepeats \piano} } % unfolded score