%%SNIPPET STARTS
%
%There are three functions: ritornelloCore, ritornello and ritornelloPivot. Core is the engine behind the latter two. Ritornello is a repeat volta with markups when unfolded; Pivot is the same but with a markup after the end of the repeting (i.e, the next measure after the repeat).
%To use this snippet you need to call the function and remove certain tags: unScore (when dealing with folded scores), folScore (when dealing with unfolded scores) and sectionInd (when dealing with multi staff instruments - like guitars, which use normal staffs and tablature staffs).
%
%I've co-designed this snippet (with help from ChatGPT and the Lilypond user community - special thanks to Yoshiaki Onishi). I've written the Lilypond code; the Scheme code was made by ChatGPT and Yoshiaki made a suggestion with regards to the markup code (which is implemented).
%
#(define ritornelloCore-logged? #f)
%
ritornelloCore =
#(define-music-function
  (voltas music)
  (number? ly:music?)
  (begin
    ;; Print message only once
    (if (not ritornelloCore-logged?)
        (begin
          (set! ritornelloCore-logged? #t)
            (ly:message "\n\t\t\t\tFunction 'ritornelloCore' was called!\n\n")
            (ly:message "\tTags 'unScore', 'folScore' and 'sectionInd' are used by this snippet!")
            (ly:message "\tRemember to \\removeWithTag 'unScore' from folded musical expressions and 'folScore' from unfolded musical expressions!")
            (ly:message "\tSome multi-staff instruments must have the tag 'sectionInd' removed from some staff to avoid duplicate information!")
            (ly:message "\n\tThis message will appear only once, no matter how many times the snippet is used!")
            (ly:message "\tIf you wish to turn off this message, add '#(define ritornelloCore-logged? #t)' after the include command!\n\n")
          ))
    
  (let* (
         ;; List of volta numbers from 1 to (voltas - 1)
         (volta-list (iota (- voltas 1) 1))
         ;; For each pass, generate a \volta block with markup
         ;; The code below was suggested by Yoshiaki Onishi, as the last code was using Lilypond's internal markup structure in Scheme code.
         (volta-marks
          (map
            (lambda (n)
              (make-music
                'VoltaSpeccedMusic
                'volta-numbers
                (list n)
                'element
              (make-music
                'SequentialMusic
                'elements
              (list (make-music
                'EventChord
                'elements
              (list (make-music
                'TextScriptEvent
                'direction
                1
                'text
              ;; Change the line below to alter the volta markup messages.
              (markup #:line (#:italic (#:concat ((number->string (+ n 1)) "º" "v.:"))))
              )))))))
            volta-list))
        )
    ;; Main function body
    #{
      \repeat volta #voltas {
        \tag #'(unScore sectionInd) {
          \volta #'(1) {
            <>^\markup \bold \italic "Start of theme"
          }
        }
        #music
        \tag #'(folScore sectionInd) {
          \textEndMark \markup \bold {\concat { #(number->string voltas) "x" } }
        }
        \tag #'(unScore sectionInd) {
          #@volta-marks }
      }
    #}
  )
 )
) % end function ritornelloCore
%
ritornello =
#(define-music-function
  (voltas music)
  (number? ly:music?)
  (ritornelloCore voltas music)
) % end function ritornello
%
ritornelloPivot =
#(define-music-function
  (voltas music)
  (number? ly:music?)
  #{
    #(ritornelloCore voltas music)
    \tag #'(unScore sectionInd) { <>^\markup \italic \magnify #1 "Pivot" } % I like to have an express warning that something is a pivot. On a folded score I don't see any need to express something as a pivot after a ritornello; however, on unfolded scores they are live saviors for me.
  #} 
) % end function ritornelloPivot
%
%%SNIPPET ENDS
