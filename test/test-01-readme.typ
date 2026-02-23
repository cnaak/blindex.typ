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

LSG1910:
  type: book
  title:
    value: Louis Segond
  date: 1910

KJV:
  type: book
  title:
    value: King James Version
  publisher: Brown Books Publishing
  date: 2004
  address: Dallas, TX
```

// Document settings
#set page(paper: "us-letter", fill: none, footer: context [
    #set align(center)
    #set text(9pt)
    #counter(page).display("— 1 —")
  ])

#set par(justify: true)

#set heading(numbering: "1.1.1")

#show raw: set text(font: "Inconsolata", size: 1em, stretch: 90%)

// Document text
// -------------

= Description

`blindex` --- Index-making of Biblical literature citations in Typst.

= Quick Intro

== Inline citations with `#iQuot`

Inline biblical literature citations are made by calling the

```typst #iQuot(body, abrv, lang, pssg[, options])```

function, which, without passing any option, results in: #iQuot([For God so loved the world,
that He gave His only begotten Son, that whoever believes in Him shall not perish, but have
eternal life.], "Jhn", "en-3", [3:16]).

```typst #iQuot()``` options include:
- `version` -- specifies the biblical translation/version;
- `cite` -- specifies the chapter and verse;
- `qlang` and `clang` -- specify the quote and citation languages;
- `quo` -- specifies the quote text formatting; and
- `cit` -- specifies the citation text formatting.

=== Colors

Controls for text and background colors are available:

```typst
#iQuot([…], "Jhn", "en-3", [3:18], quo: (fmt: (fill: red), bkg: none))
```

which renders as: #iQuot([He who believes in Him is not judged; he who does not believe has
been judged already, because he has not believed in the name of the only begotten Son of
God.], "Jhn", "en-3",
[3:18], quo: (fmt: (fill: red), bkg: none)).

=== Versioning and Bibliographycal Citations

Controls for version rendering and citation are available through the `version` and `cite`
options:

```typst
#iQuot([…], "Jhn", "en-3", [3:19], version: "NASB95", cite: [@NASB95])
```

which renders as: #iQuot([This is the judgment, that the Light has come into the world, and
men loved the darkness rather than the Light, for their deeds were evil.], "Jhn", "en-3",
[3:19], version: "NASB95", cite: [@NASB95]).

=== Multilingual Examples

Take, for instance the following all-English citation with default options: #iQuot([Seek the
#smallcaps[Lord] while He may be found; Call upon Him while He is near.], "Isa", "en-3",
[55:6]). Multilingual support is flexibly achieved with the `qlang` and/or `clang` options
--- for quote and citation languages, respectively --- as

```typst
#iQuot([…], "Isa", "en-3", [55:6], version: "LSG", cite: [@LSG1910], qlang: "fr")
```

produces: #iQuot([Cherchez l’Éternel pendant qu’il se trouve; Invoquez-le, tandis qu’il est
près.], "Isa", "en-3", [55:6], version: "LSG", cite: [@LSG1910], qlang: "fr") --- note the
proper French-style quotation marks and the English-formatted citation.  On the other hand,
for an all-French citation, the following

```typst
#iQuot([…], "Es", "fr-TOB", [55:6], qlang: "fr", clang: "fr")
```

renders as #iQuot([Cherchez l’Éternel pendant qu’il se trouve; Invoquez-le, tandis qu’il est
près.], "Es", "fr-TOB", [55:6], qlang: "fr", clang: "fr").

=== Fine-Tuning Quotes

Manual specification of opening and closing quotes can be tweaked as:

```typst
#iQuot([…], "Jhn", "en-3", [3:20], quo: (opq: [], clq: []))
```

which renders as: #iQuot([For everyone who does evil hates the Light, and does not come to
the Light for fear that his deeds will be exposed.], "Jhn", "en-3", [3:20], quo: (opq: [],
clq: [])) --- note the absence of opening and closing quotes due to the `quo.opq` and
`quo.clq` parameters specified as empty `typst` `contents`.

== Block Quotations

Block quotations, for "displayed" blocks of biblical citations are available through the

```typst
#bQuot(body, abrv, lang, pssg[, options])
```

function, which has a similar syntax as it's inline couterpart, and some block-related
additional option arguments. A plain example is:

#bQuot([For there is one God, and one mediator between God and men, the man Christ Jesus;
Who gave himself a ransom for all, to be testified in due time.], "1Ti", "en-3", [2:5,6],
version: "KJV", cite: [@KJV])

As blocks of text are usually meant for larger portions, such as paragraphs or passages, a
convenience function ```typst #ver()``` is also provided for conveninent verse-number
formatting:

#bQuot([#ver(18)For the wrath of God is revealed from heaven against all ungodliness and
unrighteousness of men, who hold the truth in unrighteousness; #ver(20)For the invisible
things of him from the creation of the world are clearly seen, being understood by the
things that are made, even his eternal power and Godhead; so that they are without excuse:
#ver(21)Because that, when they knew God, they glorified him not as God, neither were
thankful; but became vain in their imaginations, and their foolish heart was darkened.
#ver(22)Professing themselves to be wise, they became fools,], "Rom", "en-3", [1:18,20--22],
version: "KJV")

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

= Biblical Citations

Here's a two-column, automatically-generated list of biblical citations, sorted by the LXX ordering:

#mkIndex(lang: "fr-TOB", cols: 2, sorting-tradition: "Oecumenic-Bible", exclude-missing: false)

// #lDict.at("1001").at("fr-TOB").at(1)

