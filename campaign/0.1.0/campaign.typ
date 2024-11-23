// DnD 5e-Style campaign template
// By Yan Xin (Yanwenyuan) 2024
// Inspired from https://github.com/rpgtex/DND-5e-LaTeX-Template
// also uses a modified version of my statblock library
// // requires droplet for dropcaps

#import "statblock.typ" as sb
#import "colours.typ" as colours
#import "@preview/droplet:0.3.1": dropcap

#let mainFonts = ("TeX Gyre Bonum", "KingHwa_OldSong")
#let sansFonts = ("Scaly Sans Remake", "KingHwa_OldSong")
#let sansSCFonts = ("Scaly Sans Caps", "KingHwa_OldSong")
#let dropcapFont = "Royal Initialen"
#let fontsize = 10pt

#let themeColour = state("theme_colour", colours.phbgreen)


#let conf(doc) = {
  set text(font: mainFonts, size: fontsize)
  set page(columns: 2)

  // ========================
  show heading.where(level: 1) : hd => {

    place(
      top + left,
      float: true,
      scope: "parent",
      text(smallcaps(hd) ,fill: colours.dndred, size: 2.8*fontsize, weight: "regular")
    )
  }

  show heading.where(level: 2) : hd => {
    set text(fill: colours.dndred, weight: "regular", size: 1.8*fontsize)
    block(smallcaps(hd.body))
  }

  show heading.where(level: 3) : hd => {
    set text(fill: colours.dndred, weight: "regular", size: 1.6*fontsize)
    // [#hd.fields()]
    block(
      [
        #smallcaps(hd.body)
        #v(-1em)
        #line(start: (0%, 0%), length: 100%, stroke: 1pt + colours.rulegold)
      ]
    )
  }

  show heading.where(level: 4) : hd => {
    set text(fill: colours.dndred, weight: "regular", size: 1.2*fontsize)
    block(smallcaps(hd.body))
    
  }

  // ========================
  show outline.entry.where(level: 1): entry => strong(entry)
  show outline: outl => {
    set page(columns: 1)
    set heading(level: 1)
    columns(2, outl)
  }

  // ========================
  show link: lk => {
    set text(fill: colours.dndred, style: "italic")
    lk
  }

  // ========================
  set par(first-line-indent: 1em, spacing: 0.75*fontsize, leading: 0.5*fontsize)

  set heading(numbering: (..nums) => 
    if nums.pos().len() == 1 { 
      return "Chapter " + numbering("1.", ..nums) 
    } else {
      return none
    }
  )

  doc
}


// sets a theme colours from the colours package of this module
// or any other colour you want, on you if it looks bad :)
// The colours recommended are:
//  - phbgreen
//  - phbcyan
//  - phbmauve
//  - phbtan
//  - dmglavender
//  - dmgcoral
//  - dmgslategrey (-ay)
//  - dmglilac
#let setThemeColour(colour) = {
  context themeColour.update(colour)
}


// Makes a simple title page
// 
// Parameters:
// - title: main book title
// - subtitle: (optional) subtitle
// - author: (optional)
// - date: (optional) -- just acts as a separate line, can be used for anything else
// - anythingBefore: (optional) this is put before the title
// - anythingAfter: (optional) this is put after the date
#let makeTitle(title, subtitle: [], author: [], date: [], anythingBefore: [], anythingAfter: []) = {
  set page(columns: 1)
  set align(center)
  set align(horizon)
  set par(leading: 1em)

  anythingBefore

  line(
    start: (0%, 0%), length: 60%, 
    stroke: (paint: gradient.linear(white, colours.dndred, white), thickness: 1.5pt)
  )
  {
    show: smallcaps.with()
    set text(fill: colours.dndred, size: fontsize*2.5)
    title
  }
  if subtitle != [] {
    linebreak()
    set text(fill: colours.dndred, size: fontsize*1.4)
    subtitle
  }
  line(
    start: (0%, 0%), length: 60%, 
    stroke: (paint: gradient.linear(white, colours.dndred, white), thickness: 1.5pt)
  )
  {
    set text(fill: colours.dndred, size: fontsize*1.4)
    v(2em)
    author
    v(1em)
    date
  }

  anythingAfter
}


#let dropParagraph(smallCapitals: "", body) = {
  if smallCapitals != "" {
    dropcap(
      [#smallcaps(smallCapitals) #body], 
      height: 4, gap: 0.3em, font: dropcapFont
    )
  } 
  else {
    dropcap(body, height: 4, gap: 0.3em, font: dropcapFont)
  }
}


#let bump() = h(1em)


#let namedPar(title, content) = [
  _*#title*__*.*_ #content
]


#let namedParBlock(title, content) = block[
  _*#title*__*.*_ #content
]


#let readAloud(content) = {
  let corner(alignment, dxMod: 1, dyMod: 1) = place(
      alignment,
      dx: dxMod * (1em + 2pt),
      dy: dyMod * (1em + 2pt),
      circle(fill: colours.dndred, radius: 2pt),
    )

  block(
    width: 100%,
    inset: 1em, 
    fill: colours.bgtan,
    above: 1em,
    below: 1em,
    stroke: (
      right: 1pt + colours.dndred,
      left: 1pt + colours.dndred,
    ),
    breakable: true
  )[
    #set text(font: sansFonts)
    #set par(leading: 0.5 * fontsize, first-line-indent: 0em, spacing: 0.8*fontsize)
    #content 
    #corner(top + left, dxMod: -1, dyMod: -1)
    #corner(top + right, dxMod: 1, dyMod: -1)
    #corner(bottom + left, dxMod: -1, dyMod: 1)
    #corner(bottom + right, dxMod: 1, dyMod: 1)
  ]
}


#let commentBox(title: [], content) = context {
  let col = themeColour.get();

  block(
    width: 100%,
    inset: 1em, 
    fill: col,
    above: 1em,
    below: 1em,
    breakable: true,
  )[
    #set par(leading: 0.5 * fontsize, first-line-indent: 0em, spacing: 0.8*fontsize)
    #set text(font: sansSCFonts)
    *#title*
    // #v(-0.5em)

    #set text(font: sansFonts)
    #content
  ]
}

#let fancyCommentBox(title: [], content) = context {
  let col = themeColour.get();

  block(
    width: 100%,
    inset: 1em, 
    fill: col,
    above: 1em + 6pt,
    below: 1em + 6pt,
    breakable: true,
    stroke: (
      top: 1pt + black,
      bottom: 1pt + black
    )
  )[
    #set par(leading: 0.5 * fontsize, first-line-indent: 0em, spacing: 0.8*fontsize)
    #set text(font: sansSCFonts)
    *#title*

    #set text(font: sansFonts)
    #content

    #place(  // box shadow
      bottom,
      dx: -1em + 3pt, dy: 1em + 4.4pt,
      rect(width: 100% + 2em - 6pt, height: 4pt, stroke: none, fill: gradient.linear(
        colours.shadow, white, angle: 90deg
      ))
    )
    #place(  // bottom left
      bottom,
      dx: -1em, dy: 1em + 4.4pt,
      polygon(fill: black, stroke: none, (0pt, 0pt), (6pt, 0pt), (6pt, 4pt))
    )
    #place(  // bottom right
      bottom + right,
      dx: 1em, dy: 1em + 4.4pt,
      polygon(fill: black, stroke: none, (0pt, 0pt), (6pt, 0pt), (0pt, 4pt))
    )
    #place(  // top left
      top,
      dx: -1em, dy: - 1em - 4.4pt,
      polygon(fill: black, stroke: none, (6pt, 0pt), (6pt, 4pt), (0pt, 4pt))
    )
    #place(  // top right
      top + right ,
      dx: 1em, dy: - 1em - 4.4pt,
      polygon(fill: black, stroke: none, (0pt, 0pt), (0pt, 4pt), (6pt, 4pt))
    )
  ]
}

