//============================================================================================//
//                                          Includes                                          //
//============================================================================================//

#import "./books.typ": iboo, bsort
#import "./lang.typ": ldict

//============================================================================================//
//                                    Book Info Retrieving                                    //
//============================================================================================//

/// Returns valid language-traditions for the `lang` parameter of user-facing functions
///
/// === Examples
/// ```example
/// #block(width: 80mm)[
///   #for item in get-langs() [
///     #box[#raw("\"" + item + "\""),]
///   ]
/// ]
/// ```
///
/// -> array
#let get-langs() = {
  return ldict.at("1001").keys()
}

/// Returns valid biblical literature book sorting traditions, for the `sorting-tradition`
/// argument of the @mk-index function.
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

/// Returns valid book abbreviations for a language-tradition
///
/// === Examples
/// ```example
/// #block(width: 80mm)[
///   #for item in get-books("fr-TOB") [
///     #box[#raw("\"" + item + "\""),]
///   ]
/// ]
/// ```
///
/// -> array
#let get-books(
  /// The language-tradition (see @get-langs) -> string
  lang
) = {
  for KV in ldict.pairs() { (KV.at(1).at(lang).at(0),) }
}

#let a2d(abrv, lang: "en-USX") = {
  // abrv in lang assertion
  let valid-abrv = get-books(lang)
  let error-msg = (
    "book abbreviation not found",
    "abbreviation...: '" + abrv + "'",
    "language.......: '" + lang + "'",
    "valid '" + lang + "' abbreviations are:",
    "\"" + valid-abrv.join("\", \"") + "\"",
  ).join("\n")
  assert(valid-abrv.contains(abrv), message: error-msg)
  // normal processing
  let aarr = for (K, V) in ldict.pairs() {((..V.at(lang), K),)}
  let match = (..aarr.filter(x => x.at(0) == abrv),)
  return for M in match {
    let SORT = for P in bsort.pairs() {
      (P.at(0): P.at(1).position(x => x == int(M.at(2))))
    }
    ((
      "abrv": M.at(0),
      "full": M.at(1),
      "BUID": M.at(2),
      "lang": lang,
      "STDN": iboo.at(M.at(2)),
      "SORT": SORT,
    ),)
  }
}


//============================================================================================//
//                                Biblical Literature Indexing                                //
//============================================================================================//

/// Biblical literature indexing marking.
///
/// This function produces no visible output, but only adds to the document the appropriate
/// indexing #raw("#metadata()", lang: "typst").
///
/// This function is perhaps best used indirectly, through the various quoting functions (see
/// @iq and @bq, for instance).
///
/// -> none
#let blindex(
  /// The book abbreviation (see @get-books) -> string
  abrv,
  /// The `[chapter:verse(s)]` entry -> content
  entry,
  /// The book abbreviation language-tradition (see @get-langs) -> string
  lang: "en-USX"
) = context [#metadata((
    ABRV: abrv,
    LANG: lang,
    DATA: a2d(abrv, lang: lang),
    ENTR: entry,
    WHRE: here().position(),
  ))<bl_index>]

/// Index-making function.
///
/// This function produces a biblical literature index, at the point of call in the document,
/// based on the document's #raw("#metadata()", lang: "typst") entries placed directly through
/// @blindex calls, or indirectly through one of the quoting functions (see @iq and @bq, for
/// instance).
///
/// Since indices are placed at the point of call, the user has full control on the location of
/// the index location within the document. Moreover, there's no restriction on the number of
/// times this function can be called, thus allowing multiple indices to be produced.
///
/// The index language, ordering of books (according to various traditions), and apprearance is
/// controlable through the function arguments.
///
#let mk-index(
  /// The language-tradition code for printing full index book names (see @get-langs). This can
  /// be freely specified regardless of the tradition-language used to marking index entries
  /// along the document, since during index-marking, language-tradition book abbreviations are
  /// converted into generic internal representation keys that are language-tradition
  /// independent, while during index making, the generic internal representations are converted
  /// back to whatever specified language-tradition -> string
  lang: "en-USX",
  /// The book sorting tradition (see @get-sorting-traditions). This parameter controls the
  /// _sorting order_ of book entries. Now,  -> string
  sorting-tradition: "USX",
  /// The number of columns for the index (note that `typst` doesn't yet automatically balance
  /// columns inside a `#columns` body -> int
  cols: 2,
  /// The `gutter` argument for the `#columns` function call -> length
  gutter: 8pt,
  /// Book-Text-Page for font weights customizations -> dict
  wgt: (bk: "bold", tx: "regular", pg: "extrabold"),
  /// Index leaders' pattern -> content
  pattern: [.],
  /// Flags whether to fully merge index book headings. In some traditions, a single book entry
  /// may contain multiple books of other traditions. For instance, in some Catholic traditions,
  /// the 6th chapter of the book of "Baruch" is a separate book---the "Letter of Jeremiah"---in
  /// other traditions. Thus, quoting/indexing a passage by the Baruch's abbreviation in one
  /// such tradition, one can be referring to either book in another tradition. Therefore, if
  /// this argument is `true`, all possible book names will appear joined in a single entry, as
  /// in: "Baruch / Letter of Jeremiah"; otherwise, only the first one: "Baruch". -> bool
  merged-book-headings-full: true,
  /// The book merging arguments for `join`. The entry `at(0)` is the positional argument for
  /// `join`, while optional entry `at(1)` is the named `last` argument for `join` -> array
  mbhf-join: (" / ",),
) = context {
  let BIG  =  10000   // just above highest buid number, which is 9999
  let HUGE = 100000   // an order of magnitude (base 10) above BIG
  let idxDict = (:)
  let rawList = query(<bl_index>) // An array of metadata
  for __e in rawList { // __e is a metadata entry
    let __r = __e.value // __r is the record placed by blindex(...)
    let booSort = __r.DATA.at(0).SORT.at(sorting-tradition)
    if booSort != none {
      let booHArr = () // Most generic book heading (as some are mergings)
      if (__r.DATA.len() > 1) and (merged-book-headings-full) { // Merged book display
        for __d in __r.DATA {
          booHArr.push(__d.full)
        }
      } else { // Single book display
        booHArr.push(ldict.at(__r.DATA.at(0).BUID).at(lang).at(1))
      }
      let booHead = if mbhf-join.len() > 1 {
        booHArr.join(mbhf-join.at(0), last: mbhf-join.at(1))
      } else {
        booHArr.join(mbhf-join.at(0))
      }
      let the_Key = if booSort != none { str(booSort + HUGE) } else { str(BIG + HUGE) }
      let the_Val = (__r.ENTR, __r.WHRE.page)
      // Populates idxDict
      if the_Key in idxDict {
        if the_Val not in idxDict.at(the_Key).at(1) {
          idxDict.at(the_Key).at(1).push(the_Val)
        }
      } else {
        idxDict.insert(the_Key, (booHead, (the_Val,)))
      }
    }
  }
  [#idxDict]
  let sorKeys = idxDict.keys().sorted()
  columns(cols, gutter: gutter)[
    #for SK in sorKeys {
      text(weight: wgt.bk, idxDict.at(SK).at(0))
      linebreak()
      for VL in idxDict.at(SK).at(1) {
        box(width: 1.2em)
        text(weight: wgt.tx, VL.at(0)) // ENTRY
        box(width: 0.3em)
        box(width: 1fr, repeat(align(center, box(width: 0.5em, pattern))))
        box(width: 1.8em, align(center, text(weight: wgt.pg, [#VL.at(1)]))) // PAGE
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

#let ver(body, fmt: pkg-pars.fmt.ver, spc: [#h(0.2em)]) = {
  box(baseline: fmt.size - 0.85em)[#text(..fmt)[#body#spc]]
}

// "raw" Quoting of Biblical Literature
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
#let lc(abrv, pssg, lang: "en-USX", version: none, cite: none,
        lan: "en",
        fmt: pkg-pars.fmt.cit,
        sep: [ ---]) = {
  set text(lang: lan)
  if version == none {
    text(..fmt)[#sep~#a2d(abrv, lang: lang).at(0).full~#pssg#{if cite != none [ #cite]}]
  }
  else {
    text(..fmt)[#sep~#a2d(abrv, lang: lang).at(0).full~#pssg (#version#{if cite != none [ #cite]})]
  }
}

/// Inline quoting of biblical literature
#let iq(body, abrv, pssg, lang: "en-USX", version: none, cite: none, qlang: "en", clang: "en",
        quo: (fmt: pkg-pars.fmt.quo, bkg: pkg-pars.bkg.quo, quo: pkg-pars.quo, opq: ["], clq: ["]),
        cit: (fmt: pkg-pars.fmt.cit, )) = {
  rq(body, lan: qlang, ..quo)
  lc(abrv, pssg, lang: lang, version: version, cite: cite, lan: clang, ..cit)
  blindex(abrv, pssg, lang: lang)
}

/// Block quoting of biblical literature
#let bq(body, abrv, pssg, lang: "en-USX", version: none, cite: none, qlang: "en", clang: "en",
        quo: (fmt: pkg-pars.fmt.quo, bkg: none, quo: pkg-pars.quo, opq: [], clq: []),
        cit: (fmt: pkg-pars.fmt.cit, ),
        blk: (wid: 90%, ins: 4pt, bkg: pkg-pars.bkg.quo, cit: pkg-pars.bkg.cit)) = {
  align(center,
    stack(dir: ttb,
      block(width: blk.wid, fill: blk.bkg, inset: blk.ins,
            align(left)[#rq(body, ..quo)]),
      block(width: blk.wid, fill: blk.cit, inset: blk.ins,
            align(right)[#lc(abrv, pssg, lang: lang, version: version, cite: cite, ..cit, sep: [])]),
      blindex(abrv, pssg, lang: lang)
    )
  )
}


