# Blindex: Index-making of Biblical literature citations in Typst

`blindex` is a `typst` package specifically designed for the generation of indices of Biblical
literature citations in documents.

## Index Sorting Options

The generated indices are gathered and sorted by Biblical literature books, which can be ordered
according to various Biblical literature book ordering conventions, including:

- `"LXX"` -- The Septuagint;
- `"Greek-Bible"` -- Septuagint + New Testament (King James);
- `"Hebrew-Tanakh"` -- The Hebrew (Torah + Neviim + Ketuvim);
- `"Hebrew-Bible"` -- The Hebrew Tanakh + New Testament (King James);
- `"Protestant-Bible"` -- The Protestant Old + New Testaments;
- `"Catholic-Bible"` -- The Catholic Old + New Testaments;
- `"Orthodox-Bible"` -- The Orthodox Old + New Testaments;
- `"Oecumenic-Bible"` -- The Jewish Tanakh + Old Testament Deuterocanonical + New Testament;
- `"code"` -- All registered Biblical literature books: All Protestant + All Apocripha.

## Biblical Literature Abbrevations

It is common practice among theologians to refer to biblical literature books by their
abbreviations. Practice shows that abbreviation conventions are language- and tradition-
dependent. Therefore, `blindex` usage reflects this fact, while offering a way to input
arbitrary language-tradition abbreviations, in the `lang.typ` source file.

### Language and Traditions (Variants)

The `blindex` implementation generalizes the concept of __tradition__ (in the context of
biblical literature book abbreviation bookkeeping) as language **variants**, since the software
can have things such as a "default" of "n-char" variants.

As of the current release, supported languages include:

Language           | Variant           | Description                | Name
---                | ---               | ---                        | ---
English            | 3-char            | A 3-char abbreviations     | `en-3`
English            | Logos             | Used in `logos.com`        | `en-logos`
Portuguese (BR)    | Protestant        | Protestant for Brazil      | `br-pro`
Portuguese (BR)    | Catholic          | Catholic for Brazil        | `br-cat`

Language files declares **one** `typst` dictionary named `aDict`, whose keys are string book
ID's, and (`abbr: "str"`, `full: "string"`) dictionary values with the corresponding book's
abbreviation and full name in the stated language/tradition.

## Low-Level Indexing Command

The `blindex` library has a low-level, not typesetting index entry marking function
`blindex(abrv, lang, entry)`, whose arguments are (abbreviation, language, entry), as in:

```typst
"the citation..." #blindex("1Thess", "en", [1.1--3]) citation's typesetting...
```

Indices can be generated (typeset) in arbitrary amounts and locations throughout the document,
just by calling:

```typst
#mkIndex()
```

Optional arguments control style and sorting convention parameters, as shown below.

## Higher-Level Quoting-Indexing Commands

The library also offers higher-level functions to assemble the entire (i) citation typesetting,
(ii) index entry, and (iii) citation's typesetting (with some typesetting (styling) options),
that reduces argument redundancy. Commands are `#iQuot(...)` and `#bQuot(...)`, respectively for
inline and block quoting of Biblical literature, with automatic indexing and bibliography
citation. Mandatory arguments are:

```typst
paragraph text...
#iQuot(body, abrv, lang, pssg, version, cited)
more text...

// Displayed block quote of Biblical literature:
#bQuot(body, abrv, lang, pssg, version, cited)
```

## Higher-Level Example

```typst
#set page(paper: "a7", fill: rgb("#eec"))
#import "@preview/blindex:0.1.0": *

The Septuagint (LXX) starts with #iQuot([ΕΝ ἀρχῇ ἐποίησεν ὁ Θεὸς τὸν οὐρανὸν καὶ τὴν γῆν.],
"Gen", "en", [1.1], "LXX", label("2012-LXX-SBB")).

#pagebreak()

Moreover, the book of Odes begins with: #iQuot([ᾠδὴ Μωυσέως ἐν τῇ ἐξόδῳ], "Ode", "en", [1.0],
"LXX", label("2012-LXX-SBB")).

#pagebreak()

= Biblical Citations
Books are sorted following the LXX ordering.

#mkIndex(cols: 1, sorting-tradition: "LXX")

#pagebreak()

#bibliography("./tmp-01.yml", title: "References", style: "ieee")
```

The listing of the bibliography file, `./tmp-01.yml`, as shown in the example, is:

```yml
2012-LXX-SBB:
  type: book
  title:
    value: "Septuaginta: Edição Acadêmica Capa dura – Edição de luxo"
    sentence-case: "Septuaginta: edição acadêmica capa dura – edição de luxo"
    short: Septuaginta
  publisher: Sociedade Bíblica do Brasil, SBB
  editor: Rahlfs, Alfred
  affiliated:
    - role: collaborator
      names: [ "Hanhart, Robert", ]
  pages: 2240
  date: 2012-01-11
  edition: 1
  ISBN: 978-3438052278
  language: el
```

This example results in a 4-page document like this one:

![Compiled Higher-Level Example](https://github.com/cnaak/packages/blob/main/packages/preview/blindex/0.1.0/thumbnail.png)

## Citing

This package can be cited with the following bibliography database entry:

```yaml
blindex-package:
  type: Web
  author: Naaktgeboren, C.
  title:
    value: "Blindex: Index-making of Biblical literature citations in Typst"
    short: "Blindex: Index-making in Typst"
  url: https://github.com/cnaak/packages/tree/main/packages/preview/blindex
  version: 0.1.0
  date: 2024-08
```

