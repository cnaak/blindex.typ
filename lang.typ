//============================================================================================//
//                                          Imports                                           //
//============================================================================================//

#import "./books.typ": iboo


//============================================================================================//
//                                   blindex Languages File                                   //
//============================================================================================//

// Declaration and structuring of the {ldict} language dictionary
#let ldict = (:)

// Populate ldict with book keys
#for K in iboo.keys() { ldict.insert(K, (:)) }

// Helper functions
#let lang-import(path-to-file, onto: ldict) = {
  let path-parts = path-to-file.split("/")
  let iso-639-2-lang = path-parts.at(1)
  let lang-file-name = path-parts.at(2)
  let lang-name = lang-file-name.split(".").at(0)
  include path-to-file // defines lang-dict
  for key in iboo.keys() {
    onto.at(key).insert(lang-name, lang.dict.at(key))
  }
}

// (language, tradition) imports
#lang-import("lang/en/en-3.typ")      // Default, 3-char English, "en-3", language
#lang-import("lang/en/en-logos.typ")  // English, Logos bible, "en-logos", language

#lang-import("lang/pt/br-pro.typ")    // Brazilian Portuguese, Protestant, "br-pro", language
#lang-import("lang/pt/br-cat.typ")    // Brazilian Portuguese, Catholic, "br-cat", language

#lang-import("lang/fr/fr-TOB.typ")    // Français, Œcuménique, "fr-TOB", language

