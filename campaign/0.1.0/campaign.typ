// DnD 5e-Style campaign template
// By Yan Xin (Yanwenyuan) 2024
// Inspired from https://github.com/rpgtex/DND-5e-LaTeX-Template
// also uses a modified version of my statblock library
// // requires droplet for dropcaps

#import "statblock.typ" as sb
#import "colours.typ" as colours
#import "@preview/droplet:0.3.1": dropcap

#let mainFonts = ("TeX Gyre Bonum", "KingHwa_OldSong")
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


// Makes a simple title page
// 
// Parameters:
// - title: main book title
// - subtitle: (optional) subtitle
// - author: (optional)
// - date: (optional) -- just acts as a separate line, can be used for anything else
#let makeTitle(title, subtitle: [], author: [], date: []) = {
  set page(columns: 1)
  set align(center)
  set align(horizon)
  set par(leading: 1em)

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

