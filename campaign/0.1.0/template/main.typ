
// #import "@preview/dndcampaign:0.1.0": *
#import "../campaign.typ": *

#show: conf.with()

#makeTitle(
  [The Holy Path],
  subtitle: [A sample dndcampaign document],
  author: [Yanwenyuan],
  date: [2024]
)

#outline(indent: 1em)

// #set heading(numbering: "1.")

= A New Adventure

#dropParagraph(smallCapitals: "This package is designed to aid you in")[
  writing _ahem_ possibly beautiful typeset documents for the fifth edition of the world's greatest roleplaying game (or any roleplaying game, for that matter).  It starts by
  adjusting the section formatting from the
  defaults in typst to something a bit more familiar
  to the reader. The chapter formatting is
  displayed above.
]

// unfortunately typst's paragraph indenting doesn't indent the paragraph after a drop cap paragraph
#bump() Most of this text is copied from #link("https://www.overleaf.com/latex/templates/d-and-d-5e-latex-template/vmfdkjfhfynv.pdf")[The DnD 5e LaTeX book] but adjusted for typst, to give an example of how this works. 

Top level titles are placed at the top as _chapter titles_. Please ensure you pagebreak before a new chapter title else it will be placed wonky.

== Section 

Sections break up chapters into large groups of
associated text. These are second level titles.

=== Subsection

Subsections further break down the information
for the reader. These are third level titles.

==== Subsubsection

Subsubsections are the furthest division of text
that still have a block header. These are fourth level titles. Titles below these are not styled, use at your own risk.

#namedPar("Paragraph")[
  The `namedPar(title)[]` function creates a named paragraph, formatted how you'd expect it to be in the books. If this paragraph is below a block, then the auto-indenting wont work (due to typst's seeming lack of universal indent, PR if I'm wrong), use `bump()` at the start to bump it up.
  ]

#namedParBlock("Paragraph")[If you like your named paragraphs to not be indented, use `namedParBlock()`. This is a block though and requires the subsequent paragraph to be bumped.]

== Special Sections


This module also includes sections for items and spells. These are work in progress.

// this is also necessary for good top level title alignment
#pagebreak()

= Text Boxes

text
