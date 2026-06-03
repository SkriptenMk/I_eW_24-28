// Simple numbering for non-book documents
#let equation-numbering = "(1)"
#let callout-numbering = "1"
#let subfloat-numbering(n-super, subfloat-idx) = {
  numbering("1a", n-super, subfloat-idx)
}

// Theorem configuration for theorion
// Simple numbering for non-book documents (no heading inheritance)
#let theorem-inherited-levels = 0

// Theorem numbering format (can be overridden by extensions for appendix support)
// This function returns the numbering pattern to use
#let theorem-numbering(loc) = "1.1"

// Default theorem render function
#let theorem-render(prefix: none, title: "", full-title: auto, body) = {
  if full-title != "" and full-title != auto and full-title != none {
    strong[#full-title.]
    h(0.5em)
  }
  body
}
// Some definitions presupposed by pandoc's typst output.
#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms.item: it => block(breakable: false)[
  #text(weight: "bold")[#it.term]
  #block(inset: (left: 1.5em, top: -0.4em))[#it.description]
]

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let fields = old_block.fields()
  let _ = fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => {
          let subfloat-idx = quartosubfloatcounter.get().first() + 1
          subfloat-numbering(n-super, subfloat-idx)
        })
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => block({
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          })

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let children = old_title_block.body.body.children
  let old_title = if children.len() == 1 {
    children.at(0)  // no icon: title at index 0
  } else {
    children.at(1)  // with icon: title at index 1
  }

  // TODO use custom separator if available
  // Use the figure's counter display which handles chapter-based numbering
  // (when numbering is a function that includes the heading counter)
  let callout_num = it.counter.display(it.numbering)
  let new_title = if empty(old_title) {
    [#kind #callout_num]
  } else {
    [#kind #callout_num: #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block,
    block_with_new_content(
      old_title_block.body,
      if children.len() == 1 {
        new_title  // no icon: just the title
      } else {
        children.at(0) + new_title  // with icon: preserve icon block + new title
      }))

  align(left, block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1)))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color,
        width: 100%,
        inset: 8pt)[#if icon != none [#text(icon_color, weight: 900)[#icon] ]#title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}


// syntax highlighting functions from skylighting:
/* Function definitions for syntax highlighting generated by skylighting: */
#let EndLine() = raw("\n")
#let Skylighting(fill: none, number: false, start: 1, sourcelines) = {
   let blocks = []
   let lnum = start - 1
   let bgcolor = rgb("#f1f3f5")
   for ln in sourcelines {
     if number {
       lnum = lnum + 1
       blocks = blocks + box(width: if start + sourcelines.len() > 999 { 30pt } else { 24pt }, text(fill: rgb("#aaaaaa"), [ #lnum ]))
     }
     blocks = blocks + ln + EndLine()
   }
   block(fill: bgcolor, width: 100%, inset: 8pt, radius: 2pt, blocks)
}
#let AlertTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let AnnotationTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let AttributeTok(s) = text(fill: rgb("#657422"),raw(s))
#let BaseNTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let BuiltInTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let CharTok(s) = text(fill: rgb("#20794d"),raw(s))
#let CommentTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let CommentVarTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))
#let ConstantTok(s) = text(fill: rgb("#8f5902"),raw(s))
#let ControlFlowTok(s) = text(weight: "bold",fill: rgb("#003b4f"),raw(s))
#let DataTypeTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let DecValTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let DocumentationTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))
#let ErrorTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let ExtensionTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let FloatTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let FunctionTok(s) = text(fill: rgb("#4758ab"),raw(s))
#let ImportTok(s) = text(fill: rgb("#00769e"),raw(s))
#let InformationTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let KeywordTok(s) = text(weight: "bold",fill: rgb("#003b4f"),raw(s))
#let NormalTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let OperatorTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let OtherTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let PreprocessorTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let RegionMarkerTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let SpecialCharTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let SpecialStringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let StringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let VariableTok(s) = text(fill: rgb("#111111"),raw(s))
#let VerbatimStringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let WarningTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))



#let article(
  title: none,
  subtitle: none,
  authors: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Set document metadata for PDF accessibility
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()
  set par(
    justify: true,
    leading: linestretch * 0.65em
  )
  set text(lang: lang,
           region: region,
           size: fontsize)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
   }

  let has-title-block = title != none or (authors != none and authors != ()) or date != none or abstract != none
  if has-title-block {
    place(
      top,
      float: true,
      scope: "parent",
      clearance: 4mm,
      block(below: 1em, width: 100%)[

        #if title != none {
          align(center, block(inset: 2em)[
            #set par(leading: heading-line-height) if heading-line-height != none
            #set text(font: heading-family) if heading-family != none
            #set text(weight: heading-weight)
            #set text(style: heading-style) if heading-style != "normal"
            #set text(fill: heading-color) if heading-color != black

            #text(size: title-size)[#title #if thanks != none {
              footnote(thanks, numbering: "*")
              counter(footnote).update(n => n - 1)
            }]
            #(if subtitle != none {
              parbreak()
              text(size: subtitle-size)[#subtitle]
            })
          ])
        }

        #if authors != none and authors != () {
          let count = authors.len()
          let ncols = calc.min(count, 3)
          grid(
            columns: (1fr,) * ncols,
            row-gutter: 1.5em,
            ..authors.map(author =>
                align(center)[
                  #author.name \
                  #author.affiliation \
                  #author.email
                ]
            )
          )
        }

        #if date != none {
          align(center)[#block(inset: 1em)[
            #date
          ]]
        }

        #if abstract != none {
          block(inset: 2em)[
          #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
          ]
        }
      ]
    )
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  doc
}

#set table(
  inset: 6pt,
  stroke: none
)
#let brand-color = (:)
#let brand-color-background = (:)
#let brand-logo = (:)

#set page(
  paper: "us-letter",
  margin: (x: 1.25in, y: 1.25in),
  numbering: "1",
  columns: 1,
)

#show: doc => article(
  title: [Optimale Finanzierung],
  authors: (
    ( name: [Jacques Mock Schindler],
      affiliation: [],
      email: [] ),
    ),
  date: [03.06.2026],
  lang: "en",
  toc_title: [Table of contents],
  toc_depth: 3,
  doc,
)

= Optimale Finanzierung
<optimale-finanzierung>
#block[
#Skylighting(([#ImportTok("import");#NormalTok(" numpy ");#ImportTok("as");#NormalTok(" np");],
[#ImportTok("import");#NormalTok(" pandas ");#ImportTok("as");#NormalTok(" pd");],
[#ImportTok("import");#NormalTok(" matplotlib.pyplot ");#ImportTok("as");#NormalTok(" plt");],));
]
#block[
#Skylighting(([#NormalTok("liabilities ");#OperatorTok("=");#NormalTok(" np.linspace(");#DecValTok("1");#NormalTok(",");#DecValTok("99");#NormalTok(", ");#DecValTok("2000");#NormalTok(")");],));
]
#Skylighting(([#NormalTok("df ");#OperatorTok("=");#NormalTok(" pd.DataFrame(liabilities, columns");#OperatorTok("=");#NormalTok("[");#StringTok("'liabilities'");#NormalTok("])");],
[#NormalTok("df[");#StringTok("'equity'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" ");#DecValTok("100");#NormalTok(" ");#OperatorTok("-");#NormalTok(" df[");#StringTok("'liabilities'");#NormalTok("]");],
[#NormalTok("df[");#StringTok("'EBIT'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" ");#DecValTok("10");],
[],
[#CommentTok("# RoI einheitlich in % (10%)");],
[#NormalTok("df[");#StringTok("'RoI'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" (df[");#StringTok("'EBIT'");#NormalTok("] ");#OperatorTok("/");#NormalTok(" (df[");#StringTok("'liabilities'");#NormalTok("] ");#OperatorTok("+");#NormalTok(" df[");#StringTok("'equity'");#NormalTok("])) ");#OperatorTok("*");#NormalTok(" ");#DecValTok("100");],
[],
[#CommentTok("# Szenario A: Günstiger Zins (5%) -> Positiver Leverage-Effekt");],
[#NormalTok("df[");#StringTok("'profit5'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" df[");#StringTok("'EBIT'");#NormalTok("] ");#OperatorTok("-");#NormalTok(" (df[");#StringTok("'liabilities'");#NormalTok("] ");#OperatorTok("*");#NormalTok(" ");#FloatTok("0.05");#NormalTok(")");],
[#NormalTok("df[");#StringTok("'RoE5'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" (df[");#StringTok("'profit5'");#NormalTok("] ");#OperatorTok("/");#NormalTok(" df[");#StringTok("'equity'");#NormalTok("]) ");#OperatorTok("*");#NormalTok(" ");#DecValTok("100");],
[],
[#CommentTok("# Szenario B: Teurer Zins (15%) -> Negativer Leverage-Effekt");],
[#NormalTok("df[");#StringTok("'profit15'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" df[");#StringTok("'EBIT'");#NormalTok("] ");#OperatorTok("-");#NormalTok(" (df[");#StringTok("'liabilities'");#NormalTok("] ");#OperatorTok("*");#NormalTok(" ");#FloatTok("0.15");#NormalTok(")");],
[#NormalTok("df[");#StringTok("'RoE15'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" (df[");#StringTok("'profit15'");#NormalTok("] ");#OperatorTok("/");#NormalTok(" df[");#StringTok("'equity'");#NormalTok("]) ");#OperatorTok("*");#NormalTok(" ");#DecValTok("100");],
[],
[#NormalTok("df ");#OperatorTok("=");#NormalTok(" df.");#BuiltInTok("round");#NormalTok("(");#DecValTok("2");#NormalTok(")");],
[#NormalTok("df");],));
#table(
  columns: 9,
  align: (auto,auto,auto,auto,auto,auto,auto,auto,auto,),
  table.header(table.cell(align: right)[], table.cell(align: right)[liabilities], table.cell(align: right)[equity], table.cell(align: right)[EBIT], table.cell(align: right)[RoI], table.cell(align: right)[profit5], table.cell(align: right)[RoE5], table.cell(align: right)[profit15], table.cell(align: right)[RoE15],),
  table.hline(),
  table.cell(align: horizon)[0], [1.00], [99.00], [10], [10.0], [9.95], [10.05], [9.85], [9.95],
  table.cell(align: horizon)[1], [1.05], [98.95], [10], [10.0], [9.95], [10.05], [9.84], [9.95],
  table.cell(align: horizon)[2], [1.10], [98.90], [10], [10.0], [9.95], [10.06], [9.84], [9.94],
  table.cell(align: horizon)[3], [1.15], [98.85], [10], [10.0], [9.94], [10.06], [9.83], [9.94],
  table.cell(align: horizon)[4], [1.20], [98.80], [10], [10.0], [9.94], [10.06], [9.82], [9.94],
  table.cell(align: horizon)[...], [...], [...], [...], [...], [...], [...], [...], [...],
  table.cell(align: horizon)[1995], [98.80], [1.20], [10], [10.0], [5.06], [423.03], [-4.82], [-403.03],
  table.cell(align: horizon)[1996], [98.85], [1.15], [10], [10.0], [5.06], [440.89], [-4.83], [-420.89],
  table.cell(align: horizon)[1997], [98.90], [1.10], [10], [10.0], [5.05], [460.35], [-4.84], [-440.35],
  table.cell(align: horizon)[1998], [98.95], [1.05], [10], [10.0], [5.05], [481.63], [-4.84], [-461.63],
  table.cell(align: horizon)[1999], [99.00], [1.00], [10], [10.0], [5.05], [505.00], [-4.85], [-485.00],
)
#Skylighting(([#NormalTok("fig, ax ");#OperatorTok("=");#NormalTok(" plt.subplots(figsize");#OperatorTok("=");#NormalTok("(");#DecValTok("10");#NormalTok(", ");#DecValTok("6");#NormalTok("))");],
[],
[#CommentTok("# Wir plotten gegen das FK auf der X-Achse!");],
[#NormalTok("ax.plot(df[");#StringTok("'liabilities'");#NormalTok("], df[");#StringTok("'RoE5'");#NormalTok("], label");#OperatorTok("=");#StringTok("'RoE (Zins: 5%)'");#NormalTok(", color");#OperatorTok("=");#StringTok("'green'");#NormalTok(", linewidth");#OperatorTok("=");#DecValTok("2");#NormalTok(")");],
[#NormalTok("ax.plot(df[");#StringTok("'liabilities'");#NormalTok("], df[");#StringTok("'RoE15'");#NormalTok("], label");#OperatorTok("=");#StringTok("'RoE (Zins: 15%)'");#NormalTok(", color");#OperatorTok("=");#StringTok("'red'");#NormalTok(", linewidth");#OperatorTok("=");#DecValTok("2");#NormalTok(")");],
[],
[#CommentTok("# Die Nulllinie für die Gesamtkapitalrendite (RoI)");],
[#NormalTok("ax.axhline(y");#OperatorTok("=");#DecValTok("10");#NormalTok(", color");#OperatorTok("=");#StringTok("'blue'");#NormalTok(", linestyle");#OperatorTok("=");#StringTok("'--'");#NormalTok(", label");#OperatorTok("=");#StringTok("'RoI (10%)'");#NormalTok(")");],
[],
[#CommentTok("# Beschriftungen vollkommen eindeutig machen");],
[#NormalTok("ax.set_xlabel(");#StringTok("\"liabilities in ");#SpecialCharTok("% o");#StringTok("f the investment\"");#NormalTok(")");],
[#NormalTok("ax.set_ylabel(");#StringTok("'return (in %)'");#NormalTok(")");],
[#NormalTok("ax.set_title(");#StringTok("'Leverage Effect: Chance vs. Risk'");#NormalTok(", fontsize");#OperatorTok("=");#DecValTok("14");#NormalTok(", fontweight");#OperatorTok("=");#StringTok("'bold'");#NormalTok(")");],
[#NormalTok("ax.legend(loc");#OperatorTok("=");#StringTok("'upper left'");#NormalTok(")");],
[#NormalTok("ax.grid(");#VariableTok("True");#NormalTok(", linestyle");#OperatorTok("=");#StringTok("':'");#NormalTok(", alpha");#OperatorTok("=");#FloatTok("0.6");#NormalTok(")");],
[],
[#NormalTok("plt.show()");],));
#box(image("draft_files/figure-typst/cell-5-output-1.png"))

#block[
#Skylighting(([#ImportTok("from");#NormalTok(" matplotlib ");#ImportTok("import");#NormalTok(" lines");],
[#KeywordTok("def");#NormalTok(" plot_leverage(roi: ");#BuiltInTok("float");#NormalTok(", interest_rate: ");#BuiltInTok("float");#NormalTok("):");],
[#NormalTok("    ");#ControlFlowTok("if");#NormalTok(" roi ");#OperatorTok(">");#NormalTok(" ");#DecValTok("1");#NormalTok(":");],
[#NormalTok("        roi ");#OperatorTok("=");#NormalTok(" roi ");#OperatorTok("/");#NormalTok(" ");#DecValTok("100");],
[#NormalTok("    ");#ControlFlowTok("if");#NormalTok(" interest_rate ");#OperatorTok(">");#NormalTok(" ");#DecValTok("1");#NormalTok(":");],
[#NormalTok("        interest_rate ");#OperatorTok("=");#NormalTok(" interest_rate ");#OperatorTok("/");#NormalTok(" ");#DecValTok("100");],
[],
[#NormalTok("    liabilities ");#OperatorTok("=");#NormalTok(" np.linspace(");#DecValTok("10");#NormalTok(",");#DecValTok("90");#NormalTok(",");#DecValTok("2000");#NormalTok(")");],
[#NormalTok("    df ");#OperatorTok("=");#NormalTok(" pd.DataFrame(liabilities, columns");#OperatorTok("=");#NormalTok("[");#StringTok("'Liabilities'");#NormalTok("])");],
[#NormalTok("    df[");#StringTok("'Assets'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" ");#DecValTok("100");#NormalTok(" ");#OperatorTok("-");#NormalTok(" df[");#StringTok("'Liabilities'");#NormalTok("]");],
[#NormalTok("    df[");#StringTok("'EBIT'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" ");#DecValTok("100");#NormalTok(" ");#OperatorTok("*");#NormalTok(" roi");],
[#NormalTok("    df[");#StringTok("'Profit'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" df[");#StringTok("'EBIT'");#NormalTok("] ");#OperatorTok("-");#NormalTok(" (df[");#StringTok("'Liabilities'");#NormalTok("] ");#OperatorTok("*");#NormalTok(" interest_rate)");],
[#NormalTok("    df[");#StringTok("'RoE'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" (df[");#StringTok("'Profit'");#NormalTok("] ");#OperatorTok("/");#NormalTok(" df[");#StringTok("'Assets'");#NormalTok("]) ");#OperatorTok("*");#NormalTok(" ");#DecValTok("100");],
[#NormalTok("    df[");#StringTok("'RoI'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" roi ");#OperatorTok("*");#NormalTok(" ");#DecValTok("100");],
[#NormalTok("    df[");#StringTok("'Interest Rate'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" interest_rate ");#OperatorTok("*");#NormalTok(" ");#DecValTok("100");],
[#NormalTok("    df ");#OperatorTok("=");#NormalTok(" df.");#BuiltInTok("round");#NormalTok("(");#DecValTok("2");#NormalTok(")");],
[],
[#NormalTok("    fig, ax ");#OperatorTok("=");#NormalTok(" plt.subplots(figsize");#OperatorTok("=");#NormalTok("(");#DecValTok("10");#NormalTok(", ");#DecValTok("6");#NormalTok("))");],
[#NormalTok("    ax.plot(df[");#StringTok("'Liabilities'");#NormalTok("], df[");#StringTok("'RoE'");#NormalTok("], label");#OperatorTok("=");#StringTok("'RoE'");#NormalTok(",");],
[#NormalTok("            color");#OperatorTok("=");#StringTok("'green'");#NormalTok(", linewidth");#OperatorTok("=");#DecValTok("2");#NormalTok(")");],
[#NormalTok("    ax.plot(df[");#StringTok("'Liabilities'");#NormalTok("], df[");#StringTok("'Interest Rate'");#NormalTok("], label");#OperatorTok("=");#StringTok("'Interest Rate'");#NormalTok(",");],
[#NormalTok("            color");#OperatorTok("=");#StringTok("'red'");#NormalTok(")");],
[#NormalTok("    ax.plot(df[");#StringTok("'Liabilities'");#NormalTok("], df[");#StringTok("'RoI'");#NormalTok("], label");#OperatorTok("=");#StringTok("'RoI'");#NormalTok(", color");#OperatorTok("=");#StringTok("'blue'");#NormalTok(")");],
[#NormalTok("    ax.axhline(y");#OperatorTok("=");#DecValTok("0");#NormalTok(", linestyle");#OperatorTok("=");#StringTok("'--'");#NormalTok(", color");#OperatorTok("=");#StringTok("'black'");#NormalTok(")");],
[#NormalTok("    ax.set_ylabel(");#StringTok("'Return (in %)'");#NormalTok(")");],
[#NormalTok("    ax.set_xlabel(");#StringTok("'Liabilities (in %)'");#NormalTok(")");],
[#NormalTok("    ax.set_title(");#StringTok("'Leverage Effect'");#NormalTok(", fontsize");#OperatorTok("=");#DecValTok("14");#NormalTok(", fontweight");#OperatorTok("=");#StringTok("'bold'");#NormalTok(")");],
[#NormalTok("    ax.legend(loc");#OperatorTok("=");#StringTok("'upper left'");#NormalTok(")");],
[#NormalTok("    plt.show()");],
[#NormalTok("    ");#BuiltInTok("print");#NormalTok("(df.head())");],));
]
#Skylighting(([#NormalTok("plot_leverage(");#DecValTok("5");#NormalTok(", ");#FloatTok("5.1");#NormalTok(")");],));
#box(image("draft_files/figure-typst/cell-7-output-1.png"))

#block[
#Skylighting(([#NormalTok("   Liabilities  Assets  EBIT  Profit   RoE  RoI  Interest Rate");],
[#NormalTok("0        10.00   90.00   5.0    4.49  4.99  5.0            5.1");],
[#NormalTok("1        10.04   89.96   5.0    4.49  4.99  5.0            5.1");],
[#NormalTok("2        10.08   89.92   5.0    4.49  4.99  5.0            5.1");],
[#NormalTok("3        10.12   89.88   5.0    4.48  4.99  5.0            5.1");],
[#NormalTok("4        10.16   89.84   5.0    4.48  4.99  5.0            5.1");],));
]
Bei der Formel in deinem Screenshot handelt es sich um die mathematische Darstellung des #strong[Leverage-Effekts] (die Hebelwirkung des Fremdkapitals auf die Eigenkapitalrentabilität).

Um die Herleitung sauber durchzuführen, lassen wir den Faktor 100 aus deiner Ausgangsformel für den Anfang weg. Wir nehmen einfach an, dass alle Zinssätze und Rentabilitäten als Dezimalzahlen (z. B. 0,10 statt 10 %) angegeben werden. Am Ende kommt genau dasselbe heraus.

=== 1. Definition der Variablen
<definition-der-variablen>
Damit die Schritte nachvollziehbar sind, definieren wir zuerst die Buchstaben aus deinem Screenshot:

- $r$ = Eigenkapitalrentabilität ($upright("RoE")$)
- $i$ = Gesamtkapitalrentabilität
- $k$ = Fremdkapitalzinssatz
- $E K$ = Eigenkapital
- $F K$ = Fremdkapital
- $G K$ = Gesamtkapital (wobei gilt: $G K = E K + F K$)

#horizontalrule

=== 2. Die Schritt-für-Schritt-Herleitung
<die-schritt-für-schritt-herleitung>
#strong[Ausgangspunkt:] Deine Definition des RoE (ohne den Faktor 100):

$ r = frac(upright("Gewinn"), E K) $

#strong[Schritt 1: Den Gewinn aufspalten] Der Gewinn, der den Eigenkapitalgebern zusteht, ist der operative Gesamtgewinn des Unternehmens abzüglich der Zinsen, die an die Fremdkapitalgeber gezahlt werden müssen:

$ upright("Gewinn") = upright("Gesamtgewinn") - upright("Fremdkapitalzinsen") $

#strong[Schritt 2: Gesamtgewinn und Zinsen durch die Rentabilitäten ausdrücken]

- Aus der Definition der Gesamtkapitalrentabilität ($i = frac(upright("Gesamtgewinn"), G K)$) folgt: $upright("Gesamtgewinn") = i dot.op G K$
- Aus dem Fremdkapitalzinssatz ($k = frac(upright("Fremdkapitalzinsen"), F K)$) folgt: $upright("Fremdkapitalzinsen") = k dot.op F K$

Wenn wir das oben einsetzen, erhalten wir für den Gewinn:

$ upright("Gewinn") = \( i dot.op G K \) - \( k dot.op F K \) $

#strong[Schritt 3: Das Gesamtkapital ($G K$) ersetzen] Da sich das Gesamtkapital aus Eigen- und Fremdkapital zusammensetzt ($G K = E K + F K$), ersetzen wir $G K$:

$ upright("Gewinn") = i dot.op \( E K + F K \) - k dot.op F K $

Jetzt lösen wir die Klammer auf (ausmultiplizieren):

$ upright("Gewinn") = i dot.op E K + i dot.op F K - k dot.op F K $

#strong[Schritt 4: In die Ausgangsformel einsetzen] Diesen Ausdruck für den Gewinn setzen wir nun oben in unsere allererste Formel ($r = frac(upright("Gewinn"), E K)$) ein:

$ r = frac(i dot.op E K + i dot.op F K - k dot.op F K, E K) $

#strong[Schritt 5: Den Bruch aufteilen und kürzen] Wir können den großen Bruch in zwei separate Brüche zerlegen:

$ r = frac(i dot.op E K, E K) + frac(i dot.op F K - k dot.op F K, E K) $

Im linken Teil kürzt sich das $E K$ komplett weg:

$ r = i + frac(i dot.op F K - k dot.op F K, E K) $

#strong[Schritt 6: Ausklammern im Zähler] Im Zähler des rechten Bruchs steckt in beiden Summanden die Variable $F K$. Diese klammern wir aus:

$ r = i + frac(F K dot.op \( i - k \), E K) $

Wenn man das $F K$ jetzt noch vor oder hinter den Bruch zieht, entspricht es exakt der Schreibweise aus deinem Screenshot:

$ r = i + frac(F K, E K) \( i - k \) $

#horizontalrule

=== Das Ergebnis
<das-ergebnis>
Die Formel zeigt dir nun perfekt das Prinzip des Leverage-Effekts: Deine Eigenkapitalrentabilität ($r$) entspricht der Gesamtkapitalrentabilität ($i$), plus einem "Bonus" (oder Malus), der davon abhängt, wie viel Fremdkapital im Verhältnis zum Eigenkapital eingesetzt wird ($frac(F K, E K)$) und wie viel höher die Gesamtkapitalrentabilität im Vergleich zum Zinssatz ist ($\( i - k \)$).

Diese Brücke zwischen deinem Python-Code und der mathematischen Herleitung schließt die Lücke zwischen Theorie (Formel) und Praxis (Simulation).

Wenn du Code schreibst, tust du im Grunde genau das Gleiche wie bei der mathematischen Umformung -- nur dass Python mit Variablen und Tabellen (DataFrames) rechnet, anstatt Terme auf dem Papier aufzulösen.

#horizontalrule

== 1. Die Übersetzung der Variablen (Notation)
<die-übersetzung-der-variablen-notation>
Ein kleiner Stolperstein in deinem Notebook ist, dass ganz unten in der Markdown-Zelle die Buchstaben leicht verändert wurden im Vergleich zu unserem ersten Screenshot. Hier ist die exakte Übersetzungstabelle, damit nichts durcheinandergerät:

#table(
  columns: (25%, 25%, 25%, 25%),
  align: (auto,auto,auto,auto,),
  table.header([Betriebswirtschaftlicher Begriff], [Variable im Python-Code], [Symbol (Formel Screenshot)], [Symbol (Formel Notebook-Ende)],),
  table.hline(),
  [#strong[Eigenkapitalrentabilität]], [#NormalTok("RoE"); / #NormalTok("RoE5"); / #NormalTok("RoE15");], [$r$], [$upright("RoE")$],
  [#strong[Gesamtkapitalrentabilität]], [#NormalTok("RoI"); (hier fix 10%)], [$i$], [$upright("RoI")$],
  [#strong[Fremdkapitalzinssatz]], [#NormalTok("interest_rate"); (5% oder 15%)], [$k$], [$i$],
  [#strong[Eigenkapital]], [#NormalTok("EK"); / #NormalTok("Assets");], [$E K$], [$upright("EK")$],
  [#strong[Fremdkapital]], [#NormalTok("FK"); / #NormalTok("Liabilities");], [$F K$], [$upright("FK")$],
)

#horizontalrule

== 2. Code-Zeilen treffen auf Herleitungsschritte
<code-zeilen-treffen-auf-herleitungsschritte>
Schauen wir uns an, wie deine Code-Logik exakt die mathematischen Schritte abbildet:

=== Brücke A: Den Gewinn berechnen
<brücke-a-den-gewinn-berechnen>
In der mathematischen Herleitung (Schritt 2) haben wir den Gewinn definiert als:

$ upright("Gewinn") = \( i dot.op G K \) - \( k dot.op F K \) $

In deinem Code wird das Gesamtkapital ($G K$) implizit auf $100$ gesetzt (#NormalTok("df['FK'] + df['EK'] = 100");). Daher entspricht dein #NormalTok("df['EBIT'] = 10"); genau dem Term $i dot.op G K$ (nämlich $10 % upright(" von ") 100$). Deine Code-Zeile lautet:

#Skylighting(([#NormalTok("df[");#StringTok("'Gewinn5'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" df[");#StringTok("'EBIT'");#NormalTok("] ");#OperatorTok("-");#NormalTok(" (df[");#StringTok("'FK'");#NormalTok("] ");#OperatorTok("*");#NormalTok(" ");#FloatTok("0.05");#NormalTok(")");],));
Das ist die exakte Eins-zu-eins-Umsetzung der mathematischen Gewinn-Formel!

=== Brücke B: Die Rentabilität berechnen
<brücke-b-die-rentabilität-berechnen>
Der Ausgangspunkt der Herleitung war:

$ r = frac(upright("Gewinn"), E K) $

Deine Code-Zeile zur Berechnung der Hebel-Kurve lautet:

#Skylighting(([#NormalTok("df[");#StringTok("'RoE5'");#NormalTok("] ");#OperatorTok("=");#NormalTok(" (df[");#StringTok("'Gewinn5'");#NormalTok("] ");#OperatorTok("/");#NormalTok(" df[");#StringTok("'EK'");#NormalTok("]) ");#OperatorTok("*");#NormalTok(" ");#DecValTok("100");],));
Das #NormalTok("* 100"); am Ende dient hier nur dazu, aus der Dezimalzahl (z. B. $0.05$) eine Prozentzahl ($5.0 %$) für die Grafik zu machen. Die mathematische Struktur ist identisch.

#horizontalrule

== 3. Die Simulation durch die Formelbrücke verstehen
<die-simulation-durch-die-formelbrücke-verstehen>
Die Formel am Ende deines Notebooks lautet:

$ upright("RoE") = upright("RoI") + upright("FK") / upright("EK") dot.op \( upright("RoI") - i \) $

Wenn du dir die Ausgabe deines DataFrames (#NormalTok("df.head()"); und die letzten Zeilen) anschaust, erklärt diese Formel die Zahlen deines Plots:

- #strong[Szenario A (Zins 5% -- Grüne Linie):] Hier ist $upright("RoI") \( 10 % \) > upright("Zins ") i \( 5 % \)$. Die Klammer $\( upright("RoI") - i \)$ ist positiv ($+ 5 %$). Wenn du nun den Hebel $upright("FK") / upright("EK")$ erhöhst (indem du dich von links nach rechts auf der X-Achse bewegst), wird dieser positive Wert immer weiter multipliziert. In Zeile 1999 hast du fast nur noch Fremdkapital ($99 : 1$). Der Hebelfaktor ist enorm hoch, weshalb dein #NormalTok("RoE5"); auf gigantische $505 %$ ansteigt.
- #strong[Szenario B (Zins 15% -- Rote Linie):] Hier ist $upright("RoI") \( 10 % \) < upright("Zins ") i \( 15 % \)$. Die Klammer $\( upright("RoI") - i \)$ ist negativ ($- 5 %$). Erhöhst du jetzt das Fremdkapital, multiplizierst du einen #emph[negativen] Effekt. Das geliehene Geld kostet dich mehr, als es einbringt. Dein #NormalTok("RoE15"); stürzt folgerichtig in den Keller ($- 485 %$).

Die Formel ist also nichts anderes als das mathematische Gesetz, das bestimmt, wie sich die Linien in deiner Grafik verhalten müssen.

#horizontalrule

Möchtest du für deinen Auftrag noch formulieren, wo genau der kritische Wendepunkt (Risiko) bei dieser Hebelwirkung liegt, wenn sich der RoI im Zeitverlauf ändert?

Auftrag: Beobachtung als Text formulieren.

$ upright("RoE") = upright("RoI") + upright("FK") / upright("EK") dot.op \( upright("RoI") - i \) $

#set bibliography(style: "../../../chicagocustom.csl")

#bibliography(("../../../references.bib"))

