//============================================================================================//
//                                          Includes                                          //
//============================================================================================//

#import "./books.typ": iboo, bsort
#import "./lang.typ": ldict

//============================================================================================//
//                                    Book Info Retrieving                                    //
//============================================================================================//

/// Returns valid `language-tradition` values, to be passed as the corresponding named argument in user-facing functions.
///
/// === Examples
/// ```example
/// #block(width: 80mm)[
///   #for item in get-language-traditions() [
///     #box[#raw("\"" + item + "\""),]
///   ]
/// ]
/// ```
///
/// -> array
#let get-language-traditions() = {
  return ldict.at("1001").keys()
}

/// Returns valid biblical literature book `sorting-tradition` values, to be passed as the corresponding named argument in user-facing functions like @mk-index.
///
/// === Examples
/// ```example
/// #block(width: 80mm)[
///   #for item in get-sorting-traditions() [
///     #box[#raw("\"" + item + "\""),]
///   ]
/// ]
/// ```
///
/// -> array
#let get-sorting-traditions() = {
  return bsort.keys()
}

/// Returns valid `book-abbrev` values, to be passed as the corresponding argument in user-facing functions.
///
/// === Examples
/// ```example
/// #block(width: 80mm)[
///   #for item in get-book-abbrevs("fr-TOB") [
///     #box[#raw("\"" + item + "\""),]
///   ]
/// ]
/// ```
///
/// -> array
#let get-book-abbrevs(
  /// The language-tradition for which to retrieve book abbreviations from (see @get-language-traditions) -> string
  language-tradition
) = {
  for KV in ldict.pairs() { (KV.at(1).at(language-tradition).at(0),) }
}

/// Helper function (not user-facing) that converts a biblical literature book abbreviation (according to a given language-tradition) into an indexing dictionary.
///
/// -> dictionary
#let abbrev-to-dict(
  /// The biblical literature book abbreviation (according to a given language-tradition) -> string
  book-abbrev,
  /// The language-tradition in which the `book-abbrev` points to the intended book -> string
  language-tradition: "en-USX"
) = {
  // book-abbrev in language-tradition assertion
  let valid-book-abbrev = get-book-abbrevs(language-tradition)
  let error-msg = (
    "book abbreviation not found",
    "abbreviation...: '" + book-abbrev + "'",
    "language.......: '" + language-tradition + "'",
    "valid '" + language-tradition + "' abbreviations are:",
    "\"" + valid-book-abbrev.join("\", \"") + "\"",
  ).join("\n")
  assert(valid-book-abbrev.contains(book-abbrev), message: error-msg)
  // normal processing
  let abbrev-array = for (K, V) in ldict.pairs() {((..V.at(language-tradition), K),)}
  let match = (..abbrev-array.filter(x => x.at(0) == book-abbrev),)
  return for M in match {
    let SORT = for P in bsort.pairs() {
      (P.at(0): P.at(1).position(x => x == int(M.at(2))))
    }
    ((
      "book-abbrev": M.at(0),
      "full": M.at(1),
      "BUID": M.at(2),
      "lang": language-tradition,
      "STDN": iboo.at(M.at(2)),
      "SORT": SORT,
    ),)
  }
}


//============================================================================================//
//                                Biblical Literature Indexing                                //
//============================================================================================//

/// Biblical literature indexing marking function.
///
/// This function produces no visible output, but only adds to the document the appropriate indexing #raw("#metadata()", lang: "typst").
///
/// This function is perhaps best used indirectly, through the various quoting functions (see @iq and @bq, for instance).
///
/// -> none
#let blindex(
  /// The book abbreviation (see @get-book-abbrevs) -> string
  book-abbrev,
  /// The `[chapter:verse(s)]` entry -> content
  chapter-verse,
  /// The book abbreviation language-tradition (see @get-language-traditions) -> string
  language-tradition: "en-USX"
) = context [#metadata((
    ABRV: book-abbrev,
    LANG: language-tradition,
    DATA: abbrev-to-dict(book-abbrev, language-tradition: language-tradition),
    ENTR: chapter-verse,
    WHRE: here().position(),
  ))<bl_index>]

/// Index-making (producing, typesetting) function.
///
/// This function produces a biblical literature index, at the point of call in the document, based on the document's #raw("#metadata()", lang: "typst") entries placed directly through @blindex calls, or indirectly through one of the quoting functions (see @iq and @bq, for instance).
///
/// Since indices are produced and placed at the point of call of this function, the user has full control on the index location within the document. Moreover, there's no restriction on the number of times this function can be called, thus allowing multiple indices to be produced. This may be useful in polyglot documents, since it enables the production of indices of multiple languages.
///
/// The index language, ordering of books (according to various traditions), and apprearance is controlable through the function arguments.
///
#let mk-index(
  /// The language-tradition code for printing full index book names (see @get-language-traditions). This can be freely specified regardless of the tradition-language used to marking index entries along the document, since during index-marking, language-tradition book abbreviations are converted into generic internal representation keys that are language-tradition independent, while during index making, the generic internal representations are converted back to whatever specified language-tradition -> string
  language-tradition: "en-USX",
  /// The book sorting tradition (see @get-sorting-traditions). This parameter controls the _sorting order_ of biblical literature book entries. It is worth noting that most sorting traditions do not define book placements for all biblical literature books (owing to the inclusion of deuterocanonical and apocripha books only in certain sorting traditions). Therefore, apocripha or deutorocanonical books may _not be listed at all_ in some book sorting traditions, since their placement is not defined. The library includes the `code` and `USX` sorting traditions, which are all-inclusive, meaning indices made with these sorting traditions are guaranteed to include every indexed biblical literature citation in the document. -> string
  sorting-tradition: "USX",
  /// The number of columns for the index rendering. It is worth noting that while `typst` does not implement automatic column balancing, some situations may call for manual column balancing, which can be accomplished externally to this function call -> int
  cols: 2,
  /// The `gutter` argument for the `#columns` function call -> length
  gutter: 8pt,
  /// Font weight customizations for the book, text, and page elements of the index. -> dictionary
  book-text-page-weights: (book: "bold", text: "regular", page: "extrabold"),
  /// The pattern for the index leaders -> content
  pattern: [.],
  /// Flags whether to fully merge index book headings for books merged on given language-traditions. In some traditions, a single book entry
  /// may contain multiple books of other traditions. For instance, in some Catholic traditions,
  /// the 6th chapter of the book of "Baruch" is listes as a separate book---the "Letter of Jeremiah"---in
  /// other traditions. Since index metadata entries are made through the book abbreviation `book-abbrev` (see @get-book-abbrevs), there might be a 1:many associations between abbreviation and actual book(s). Whenever this happens, the stored #raw("#metadata()", lang: "typst") actually contains an _array_ of books, and this option controls whether or not all books get merged or just the first one (usually the most-encompassing) is displayed, i.e., using the example above, whether only "Baruch" or "Baruch / Letter of Jeremiah" is listed as a book heading in the index. -> bool
  merged-book-headings-full: false,
  /// The book merging arguments for `join`. The entry `at(0)` is the positional argument for `join`, while optional entry `at(1)` is the named `last` argument for `join` -> array
  merged-book-headings-join: (" / ",),
) = context {
  let BIG  =  10000   // just above highest buid number, which is 9999
  let HUGE = 100000   // an order of magnitude (base 10) above BIG
  let index-dict = (:)
  let raw-blindex-metadata = query(<bl_index>) // An array of metadata
  for raw-entry in raw-blindex-metadata { // raw-entry is a metadata entry
    let raw-entry-value = raw-entry.value // raw-entry-value is the record placed by blindex(...)
    let book-entry-sorting-rank = raw-entry-value.DATA.at(0).SORT.at(sorting-tradition)
    if book-entry-sorting-rank != none {
      let book-headings = () // Most generic book headings (as some are mergings)
      if (raw-entry-value.DATA.len() > 1) and (merged-book-headings-full) { // Merged book display
        for dummy in raw-entry-value.DATA {
          book-headings.push(ldict.at(raw-entry-value.DATA.at(0).BUID).at(language-tradition).at(1))
        }
      } else { // Single book display
        book-headings.push(ldict.at(raw-entry-value.DATA.at(0).BUID).at(language-tradition).at(1))
      }
      let book-heading = if merged-book-headings-join.len() > 1 {
        book-headings.join(merged-book-headings-join.at(0), last: merged-book-headings-join.at(1))
      } else {
        book-headings.join(merged-book-headings-join.at(0))
      }
      let index-dict-key = if book-entry-sorting-rank != none { str(book-entry-sorting-rank + HUGE) } else { str(BIG + HUGE) }
      let index-dict-value = (raw-entry-value.ENTR, raw-entry-value.WHRE.page)
      // Populates index-dict
      if index-dict-key in index-dict {
        if index-dict-value not in index-dict.at(index-dict-key).at(1) {
          index-dict.at(index-dict-key).at(1).push(index-dict-value)
        }
      } else {
        index-dict.insert(index-dict-key, (book-heading, (index-dict-value,)))
      }
    }
  }
  let sorted-index-keys = index-dict.keys().sorted()
  columns(cols, gutter: gutter)[
    #for sorted-key in sorted-index-keys {
      text(weight: book-text-page-weights.book, index-dict.at(sorted-key).at(0))
      linebreak()
      for index-entry-values in index-dict.at(sorted-key).at(1) {
        box(width: 1.2em)
        text(weight: book-text-page-weights.text, index-entry-values.at(0)) // ENTRY
        box(width: 0.3em)
        box(width: 1fr, repeat(align(center, box(width: 0.5em, pattern))))
        box(width: 1.8em, align(center, text(weight: book-text-page-weights.page, [#index-entry-values.at(1)]))) // PAGE
        linebreak()
      }
    }
  ]
}


//============================================================================================//
//                                Biblical Literature Quoting                                 //
//============================================================================================//

//--------------------------------------------------------------------------------------------//
//                                       Quote Settings                                       //
//--------------------------------------------------------------------------------------------//

#let pkg-pars = (
  fmt: (
    ver: (
      font: ("Noto Sans", ),
      style: "normal",
      weight: "black",
      size: 0.6em,
    ),
    quo: (
      font: ("EB Garamond", "Libertinus Serif"),
      style: "normal",
      weight: "regular",
    ),
    cit: (
      font: ("Crimson Pro", "Libertinus Serif"),
      style: "normal",
      weight: "regular",
    ),
  ),
  quo: (
    double: true,
    enabled: true,
    alternative: false,
    quotes: (
      single: auto, // ("\u{2018}", "\u{2019}"),
      double: auto, // ("\u{201C}", "\u{201D}"),
    )
  ),
  bkg: (
    quo: rgb("D0D0D0FF"),
    cit: none,
  ),
)

//--------------------------------------------------------------------------------------------//
//                                      Quote Functions                                       //
//--------------------------------------------------------------------------------------------//

/// Verse number formatting function
///
/// === Examples
/// ```example
/// #block(width: 80mm)[
///   #text(font: "Libertinus Serif")[
///     #ver(1)In the beginning God created the heavens and the earth.
///   ]
/// ]
/// ```
///
/// -> content
#let ver(
  /// The verse mark to render -> int | string | content
  body,
  /// The list of formatting named args that can be passed to a ```typst #set text(..fmt)``` or a
  /// ```typst #text(..fmt)``` function call -> dictionary
  fmt: pkg-pars.fmt.ver,
  /// The contents added meant for spacing between the rendered verse mark and the following
  /// contents in the calling context.
  /// Note that in the provided example no space was left between the function call closing
  /// parenthesis and the following contents, so that the exact spacing `content` is produced
  /// -> content
  spc: [#h(0.2em)]) = {
  box(baseline: fmt.size - 0.85em)[#text(..fmt)[#body#spc]]
}

/// Bare but consistent rendering of provided biblical literature excerpts. This is meant to be
/// used directly only when repeating parts of an recently quoted passage (so as to forfeit
/// immediate book-chapter-verse[-citations] etc... re-renderings); however, internally and
/// indirectly, this function is called from every other passage-quoting functions.
///
/// === Examples
///
/// With default arguments:
///
/// ```example
/// #block(width: 80mm)[
///   #text(font: "Libertinus Serif")[
///     we've seen that
///     #q-bare([all kindreds of the earth
///       shall wail because of him]),
///     (speaking of Jesus), therefore...
///   ]
/// ]
/// ```
///
/// With styling arguments:
///
/// ```example
/// #block(width: 80mm)[
///   #text(font: "Libertinus Serif")[
///     when scripture affirms
///     #q-bare(
///       [all kindreds],
///       fmt: (style: "italic"),
///       bkg: none),
///     none is excluded...
///   ]
/// ]
/// ```
///
/// -> content
#let q-bare(
  /// The excerpt or passage to be consistently rendered -> content
  body,
  /// The excerpt's language, to be passed as argument to the internal `#text` function
  /// -> string
  lan: "en",
  /// Text formatting directives, used as ```typst #text(..fmt)```
  /// -> dictionary
  fmt: pkg-pars.fmt.quo,
  /// Highlight (background) formatting directives that feed the internal call to the
  /// `#highlight`'s `fill` function
  /// -> dictionary
  bkg: pkg-pars.bkg.quo,
) = {
  [#highlight(fill: bkg, text(..fmt)[#body])]
}

#let rq(body,
        lan: "en",
        fmt: pkg-pars.fmt.quo,
        bkg: pkg-pars.bkg.quo,
        quo: pkg-pars.quo,
        opq: ["],
        clq: ["]) = {
  set text(lang: lan)
  set smartquote(..quo)
  [#opq#highlight(fill: bkg, text(..fmt)[#body])#clq]
}

// "line" Citation of Biblical Literature
#let lc(book-abbrev, pssg, language-tradition: "en-USX", version: none, cite: none,
        lan: "en",
        fmt: pkg-pars.fmt.cit,
        sep: [ ---]) = {
  set text(lang: lan)
  if version == none {
    text(..fmt)[#sep~#abbrev-to-dict(book-abbrev, language-tradition: language-tradition).at(0).full~#pssg#{if cite != none [ #cite]}]
  }
  else {
    text(..fmt)[#sep~#abbrev-to-dict(book-abbrev, language-tradition: language-tradition).at(0).full~#pssg (#version#{if cite != none [ #cite]})]
  }
}

/// Inline quoting of biblical literature
#let iq(body, book-abbrev, pssg, language-tradition: "en-USX", version: none, cite: none, qlanguage-tradition: "en", clanguage-tradition: "en",
        quo: (fmt: pkg-pars.fmt.quo, bkg: pkg-pars.bkg.quo, quo: pkg-pars.quo, opq: ["], clq: ["]),
        cit: (fmt: pkg-pars.fmt.cit, )) = {
  rq(body, lan: qlanguage-tradition, ..quo)
  lc(book-abbrev, pssg, language-tradition: language-tradition, version: version, cite: cite, lan: clanguage-tradition, ..cit)
  blindex(book-abbrev, pssg, language-tradition: language-tradition)
}

/// Block quoting of biblical literature
#let bq(body, book-abbrev, pssg, language-tradition: "en-USX", version: none, cite: none, qlanguage-tradition: "en", clanguage-tradition: "en",
        quo: (fmt: pkg-pars.fmt.quo, bkg: none, quo: pkg-pars.quo, opq: [], clq: []),
        cit: (fmt: pkg-pars.fmt.cit, ),
        blk: (wid: 90%, ins: 4pt, bkg: pkg-pars.bkg.quo, cit: pkg-pars.bkg.cit)) = {
  align(center,
    stack(dir: ttb,
      block(width: blk.wid, fill: blk.bkg, inset: blk.ins,
            align(left)[#rq(body, ..quo)]),
      block(width: blk.wid, fill: blk.cit, inset: blk.ins,
            align(right)[#lc(book-abbrev, pssg, language-tradition: language-tradition, version: version, cite: cite, ..cit, sep: [])]),
      blindex(book-abbrev, pssg, language-tradition: language-tradition)
    )
  )
}


