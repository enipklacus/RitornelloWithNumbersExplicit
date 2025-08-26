%%CODE STARTS
\version "2.24.0"
%
%%SNIPPET STARTS
ritornello =
#(define-music-function
  (voltas music)
  (number? ly:music?)
  (let* (
         ;; List of volta numbers from 1 to (voltas - 1) so that we mark passes 1 to (voltas - 1), showing n+1 in the text.
         (volta-list (iota (- voltas 1) 1))
         ;; For each pass, generate a \volta block with aditional strings.
         (volta-marks
           (map
             (lambda (n)
               #{ \volta #(list n) {
                 \textMark \markup {\italic \concat { #(number->string (+ n 1)) "º" "v.:" } }
               } #})
             volta-list))
        )
    ;; folScore is the tag to be used in folded scores, as it prints only the total numbers of volta in the last measure.
    ;; unScore is the tag to be used in unfolded Scores, as it prints every start of volta.
    #{ % main function body
      \repeat volta #voltas {
        \tag #'unScore  { \volta #'(1) {\textMark \markup \bold \italic "Start of theme"}}
        #music      
        \tag #'folScore {\textEndMark \markup \bold {\concat { #(number->string voltas) "x" } }}
        \tag #'unScore  { #@volta-marks }
      }
      \tag #'unScore  {{\textEndMark \markup \bold \italic "End of theme"}}  
    #} ;; end of main function body
    ) ;; end of let*
  ) % end of ritornello function
%
%%SNIPPET ENDS
%
var = {\relative c'' {c1 d e d}}
test = { \ritornello 10 {\var} }
%
\score {\removeWithTag #'unScore {\test}}
\score {\removeWithTag #'folScore {\unfoldRepeats {\test}}}
%%CODE ENDS