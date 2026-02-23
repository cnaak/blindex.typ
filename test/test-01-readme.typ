#import "lib.typ": *

// Custom configuration
#let CFG = (
  quo: (
    fmt: (font: "Crimson Pro", style: "normal", weight: "regular"),
    fil: rgb("c0c0c0FF"),
    quo: PARS.quo,
    opq: ['],
    clq: ['],
  ),
  cit: (
    fmt: (font: "Crimson Pro", style: "normal", weight: "regular"),
    fil: none,
  ),
  CIT: (
    fmt: (font: "Crimson Pro", style: "normal", weight: "regular"),
    fil: rgb("c0c0c0FF"),
  ),
)

// Custom package functions
#let iQ = iQuot.with(quo: CFG.quo, cit: CFG.cit)
#let bQ = bQuot.with(quo: CFG.quo, cit: CFG.CIT)

// Bibliography data
#let bib = ```
LXX-SBB-2012:
  type: book
  title:
    value: "Septuaginta"
  publisher: Sociedade Bíblica do Brasil, SBB
  editor: Rahlfs, Alfred
  date: 2012-01-11
  edition: 1
  ISBN: 978-3438052278
  language: el

NASB95:
  type: book
  title:
    value: New American Standard Bible
  publisher: The Lockman Foundation
  address: La Habra, CA
  date: 1995
```

// Document settings
#set page(paper: "a6", fill: none, footer: context [
    #set align(center)
    #set text(9pt)
    #counter(page).display("— 1 —")
  ])

#set par(justify: true)

// Document text
// -------------

= Quick Intro

`blindex` is an index-making of Biblical literature citations in Typst package.

With the default settings, inline citations are made with the
```typst #iQuot(body, abrv, lang, pssg)```
function, with named options, and the result appears as follows: #iQuot([For God so loved
the world, that He gave His only begotten Son, that whoever believes in Him shall not
perish, but have eternal life.], "Jhn", "en-3", [3:16], version: "NASB95", cite: [@NASB95]).

```typst #iQuot()``` named options include:
- `version` -- specifies the biblical translation/version;
- `cite` -- specifies the chapter and verse;
- `qlang` and `clang` -- specify the quote and citation languages;
- `quo` -- specifies the quote text formatting; and
- `cit` -- specifies the citation text formatting.

Therefore, by simply ommiting the `version` and the `cite` options causes an output as in
#iQuot([He who believes in Him is not judged; he who does not believe has been judged
already, because he has not believed in the name of the only begotten Son of God.], "Jhn",
"en-3", [3:18]). Additionally, open and closing quotes are controlled through the `quo`
parameter as in #iQuot([This is the judgment, that the Light has come into the world, and
men loved the darkness rather than the Light, for their deeds were evil.], "Jhn", "en-3",
[3:19], quo: (opq: [], clq: [])).

Moreover, block quotations can be 

/*
A citation for package testing, with verse numbers, no quotes, and no fill:

#bQuot(
  [#ver(14)καὶ εἶπε Κύριος ὁ Θεὸς τῷ ὄφει· ὅτι ἐποίησας τοῦτο, ἐπικατάρατος σὺ ἀπὸ πάντων τῶν κτηνῶν καὶ ἀπὸ πάντων τῶν θηρίων τῶν ἐπὶ
  τῆς γῆς· ἐπὶ τῷ στήθει σου καὶ τῇ κοιλίᾳ πορεύσῃ καὶ γῆν φαγῇ πάσας τὰς ἡμέρας τῆς ζωῆς σου. #ver(15)καὶ ἔχθραν θήσω ἀνὰ μέσον σοῦ
  καὶ ἀνὰ μέσον τῆς γυναικὸς καὶ ἀνὰ μέσον τοῦ σπέρματός σου καὶ ἀνὰ μέσον τοῦ σπέρματος αὐτῆς· αὐτός σου τηρήσει κεφαλήν, καὶ σὺ
  τηρήσεις αὐτοῦ πτέρναν.], "Gen", "en-logos", [3:14--15], "LXX", quotes: (quotes: (double: ("", ""))), fill: false, fill-below: false)

In the context of telling God's prophecies appart from those of false prophets, the Septuagint @LXX-SBB-2012 uses the phrase
#iQuot([ὁμοίως λαλήσαντι], "Deut", "en-logos", [18:22], "LXX") (_homoios lalesanti_), which can be translated as "speaking in the same
manner" or "speaking thus." This phrase emphasizes that legitimate prophecies from God should be understood and interpreted based on the
exact way it was spoken.

Here's the LXX text with the relevant phrase highlighted (formatted without verse numbers and with default options):

#bQuot(
  [ἐὰν δὲ μὴ γένηται, ἐν τῷ λαλῆσαι αὐτὸν ἐν τῷ ὀνόματι κυρίου, οὐκ ἐκείνου λαλήσαντος, ἐν τῷ *ὁμοίως λαλήσαντι*, ἀπαρχὴ ἐν τῷ λαλεῖν
  αὐτὸν, ἀπαρχὴ ἐν τῷ μὴ ἀληθεῦσαι τὸν λόγον αὐτοῦ, ἐν τῷ λαλῆσαι αὐτὸν ἐν τῷ ὀνόματι κυρίου.], "Deut", "en-logos", [18:22], "LXX",
  quotes: (quotes: (double: ("\u{300E}", "\u{300F}"))), fill: true, fill-below: true)

This further supports the logical conclusion that God's prophecies should be interpreted "as stated," without introducing arbitrary
flexibility or vagueness.

*/

#bibliography(bytes(bib.text), title: "References", style: "turabian-fullnote-8")

#pagebreak(weak: true)

= Biblical Citations

Here's a two-column, automatically-generated list of biblical citations, sorted by the LXX ordering:

#mkIndex(cols: 2, sorting-tradition: "LXX")

