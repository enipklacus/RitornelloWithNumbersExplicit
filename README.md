# RitornelloWithNumbersExplicit
Lilypond snippet that makes similar ritornello to that of GuitarPro's notation.

## TL;DR

This an extended and glorified `\repeat volta` with automated `markup` and `\textEndMark`.

# Usage
To use this snippet you invoke it like a `\repeat volta`, i.e `\ritornello 3 {c1 d1 c1}`. It takes two arguments: a number (total number of repetitions/voltas) and a musical expression; in the musical expression you can add an `\alternative` or any other \volta commands. The main command inside this snippet is `\repeat volta`. I've just add some logic and formatted text.

For beginner users: download the main snippet file and put it somewhere safe. On project file you have to include it (`\include /path/to/snippet/ritornello.ly`) in the beginning of the file, after the `\version` statement.

The main reason this snippet exist is to quicken writing time and reduce engraving error committed by the user.
 
The second reason I wrote this snippet is to facilitate migration of GuitarPro users to Lilypond, featuring a ritornello function that creates a similar visual style.

# TODO:
- Change `\textEndMark` to a command that is "staff isolated". 
`\textEndMark` is a top-of-score command, which print at the last moment before new music expressions but is restricted to the staff, not going up to the highest staff.

# A little (lot) of personal explanations

This snippets was created to mimic GuitarPro's ritornello appearance (i.e, displaying the total number of returns). Lilypond's documentation explicitly states that returns must be indicated at the start of the repeated musical expression - counter to what GuitarPro does.

One thing that always annoyed me while writing the repetition through `\repeat volta` was that I had to manually change the printed number (be it `markup` or `\textEndMark`). My scores were prone to mistakes due to the double work of writing repetitions and text separately. 

I'm pretty sure advanced users already knew of this hassle and how to circunvent it. However, the current stable documentation does not mention this problem and, as it doesn't comment such issue, doesn't provide any answers to beginning users.

A snippet that automatically prints the total number was always on my mind, but I didn't have the knowledge to implement it. Still today I don't have the minimum know-how, but with help from AI (ChatGPT) and the Lilypond user community, I was able to mangle together this snippet.

Don't get me wrong, I wrote less than 5% of the Scheme code. Scheme, to me, is very cryptic and strange. I'm not a programmer and don't claim to be. However, I do know a bit of programming principles to extract functional and *safe-ish* code from an AI. And, of course, the user community is an amazing space, which provided substantial suggestions to the code. 

The main problem of this snippet is that the total number of repetition is written through a `\textEndMark`. As the `\textEndMark` always prints in the highest staff, confusing may arise while printing multiple staffs together with different repetition end points.
