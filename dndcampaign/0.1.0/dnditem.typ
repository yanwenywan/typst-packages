
#import "colours.typ" as colours 

#let fonts = ("TeX Gyre Bonum", "KingHwa_OldSong")
#let fontsize = 10pt


#let conf(
  content
) = {
  set text(
    font: fonts,
    size: fontsize
  )

  set par(spacing: 0.9em, first-line-indent: 0pt)

  set heading(outlined: false)

  show heading.where(level : 1): hd => [
    #set text(size: 1.2*fontsize, weight: "regular", fill: colours.dndred)
    #smallcaps(hd.body)
    #line(
      start: (0pt, -fontsize),
      length: 66%,
      stroke: 1pt + gradient.linear(colours.dndred, white)
    )
    #v(-fontsize/2)
  ]

  show heading.where(level: 2): hd => [
    #set text(weight: "regular", fill: dndred)
    #smallcaps(hd)
    #line(
      start: (0pt, -fontsize),
      length: 66%,
      stroke: 1pt + gradient.linear(dndred, white)
    )
    #v(-fontsize*0.75)
  ]
  show heading.where(level: 3) : hd => text(
    size: fontsize, weight: "bold", style: "italic",
    hd.body + [.]
  )

  content
}

#let flavourtext(content) = [
  #set text(style: "italic")
  #block(inset: (left: 1em), content)
]

#let smalltext(content) = {
  v(-fontsize*0.5)
  set text(size: fontsize * 0.9, style: "italic", fill: colours.dndred)
  content
}