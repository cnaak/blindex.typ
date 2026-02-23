#set page(
  paper: "a6",
  fill: rgb("#aaa"),
  footer: context [
    #set align(center)
    #set text(9pt)
    #counter(page).display("— 1 —")
  ]
)

#set par(justify: true)
#set text(font: "EB Garamond", weight: "regular", lang: "en")
#import "lib.typ": *

#let my-fill = rgb("0004")

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
```

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

#bibliography(bytes(bib.text), title: "References", style: "turabian-fullnote-8")

#pagebreak(weak: true)

= Biblical Citations

Here's a two-column, automatically-generated list of biblical citations, sorted by the LXX ordering:

#mkIndex(cols: 2, sorting-tradition: "LXX")

