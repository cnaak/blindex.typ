#set page(paper: "a7", fill: rgb("#eec"))
#import "lib.typ": iQuot, mkIndex

The Septuagint (LXX) starts with #iQuot([ΕΝ ἀρχῇ ἐποίησεν ὁ Θεὸς τὸν οὐρανὸν καὶ τὴν γῆν.],
"Gen", "en-logos", [1.1], "LXX", label("2012-LXX-SBB")).

#pagebreak()

Moreover, the book of Odes begins with: #iQuot([ᾠδὴ Μωυσέως ἐν τῇ ἐξόδῳ], "Ode", "en-logos",
[1.0], "LXX", label("2012-LXX-SBB")).

#pagebreak()

= Biblical Citations
Books are sorted following the LXX ordering.

#mkIndex(cols: 1, sorting-tradition: "LXX")

#pagebreak()

#bibliography("test-01-readme.yml", title: "References", style: "ieee")
