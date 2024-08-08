//============================================================================================//
//                                          Imports                                           //
//============================================================================================//

#import "./books.typ": iBoo


//============================================================================================//
//                                   blindex Languages File                                   //
//============================================================================================//

// Declaration and structuring of the {lDict} language dictionary
#let lDict = (:)

// Populate lDict with book keys
#for K in iBoo.keys() { lDict.insert(K, (:)) }


//--------------------------------------------------------------------------------------------//
//                         Default, 3-char English, "en-3", language                          //
//--------------------------------------------------------------------------------------------//

#{
  let LANG = "en-3"
  lDict.at("1001").insert(LANG, ("Gen", "Genesis"             ))
  lDict.at("1002").insert(LANG, ("Exo", "Exodus"              ))
  lDict.at("1003").insert(LANG, ("Lev", "Leviticus"           ))
  lDict.at("1004").insert(LANG, ("Num", "Numbers"             ))
  lDict.at("1005").insert(LANG, ("Det", "Deuteronomy"         ))
  lDict.at("1101").insert(LANG, ("Jos", "Joshua"              ))
  lDict.at("1102").insert(LANG, ("Jdg", "Judges"              ))
  lDict.at("1103").insert(LANG, ("Rth", "Ruth"                ))
  lDict.at("1104").insert(LANG, ("1Sm", "1 Samuel"            ))
  lDict.at("1105").insert(LANG, ("2Sm", "2 Samuel"            ))
  lDict.at("1106").insert(LANG, ("1Ki", "1 Kings"             ))
  lDict.at("1107").insert(LANG, ("2Ki", "2 Kings"             ))
  lDict.at("1108").insert(LANG, ("1Ch", "1 Chronicles"        ))
  lDict.at("1109").insert(LANG, ("2Ch", "2 Chronicles"        ))
  lDict.at("1110").insert(LANG, ("Ezr", "Ezra"                ))
  lDict.at("1111").insert(LANG, ("Neh", "Nehemiah"            ))
  lDict.at("1112").insert(LANG, ("Est", "Esther"              ))
  lDict.at("1201").insert(LANG, ("Job", "Job"                 ))
  lDict.at("1202").insert(LANG, ("Psa", "Psalms"              ))
  lDict.at("1203").insert(LANG, ("Pro", "Proverbs"            ))
  lDict.at("1204").insert(LANG, ("Ecc", "Ecclesiastes"        ))
  lDict.at("1205").insert(LANG, ("SOS", "Song of Solomon"     ))
  lDict.at("1301").insert(LANG, ("Isa", "Isaiah"              ))
  lDict.at("1302").insert(LANG, ("Jer", "Jeremiah"            ))
  lDict.at("1303").insert(LANG, ("Lam", "Lamentations"        ))
  lDict.at("1304").insert(LANG, ("Eze", "Ezekiel"             ))
  lDict.at("1305").insert(LANG, ("Dan", "Daniel"              ))
  lDict.at("1306").insert(LANG, ("Hos", "Hosea"               ))
  lDict.at("1307").insert(LANG, ("Jol", "Joel"                ))
  lDict.at("1308").insert(LANG, ("Ams", "Amos"                ))
  lDict.at("1309").insert(LANG, ("Oba", "Obadiah"             ))
  lDict.at("1310").insert(LANG, ("Jon", "Jonah"               ))
  lDict.at("1311").insert(LANG, ("Mic", "Micah"               ))
  lDict.at("1312").insert(LANG, ("Nah", "Nahum"               ))
  lDict.at("1313").insert(LANG, ("Hab", "Habakkuk"            ))
  lDict.at("1314").insert(LANG, ("Zep", "Zephaniah"           ))
  lDict.at("1315").insert(LANG, ("Hag", "Haggai"              ))
  lDict.at("1316").insert(LANG, ("Zec", "Zechariah"           ))
  lDict.at("1317").insert(LANG, ("Mal", "Malachi"             ))
  lDict.at("1401").insert(LANG, ("Mat", "Matthew"             ))
  lDict.at("1402").insert(LANG, ("Mrk", "Mark"                ))
  lDict.at("1403").insert(LANG, ("Luk", "Luke"                ))
  lDict.at("1404").insert(LANG, ("Jhn", "John"                ))
  lDict.at("1501").insert(LANG, ("Act", "Acts"                ))
  lDict.at("1601").insert(LANG, ("Rom", "Romans"              ))
  lDict.at("1602").insert(LANG, ("1Co", "1 Corinthians"       ))
  lDict.at("1603").insert(LANG, ("2Co", "2 Corinthians"       ))
  lDict.at("1604").insert(LANG, ("Gal", "Galatians"           ))
  lDict.at("1605").insert(LANG, ("Eph", "Ephesians"           ))
  lDict.at("1606").insert(LANG, ("Php", "Philippians"         ))
  lDict.at("1607").insert(LANG, ("Col", "Colossians"          ))
  lDict.at("1608").insert(LANG, ("1Th", "1 Thessalonians"     ))
  lDict.at("1609").insert(LANG, ("2Th", "2 Thessalonians"     ))
  lDict.at("1610").insert(LANG, ("1Ti", "1 Timothy"           ))
  lDict.at("1611").insert(LANG, ("2Ti", "2 Timothy"           ))
  lDict.at("1612").insert(LANG, ("Tit", "Titus"               ))
  lDict.at("1613").insert(LANG, ("Phm", "Philemon"            ))
  lDict.at("1700").insert(LANG, ("Heb", "Hebrews"             ))
  lDict.at("1701").insert(LANG, ("Jas", "James"               ))
  lDict.at("1702").insert(LANG, ("1Pe", "1 Peter"             ))
  lDict.at("1703").insert(LANG, ("2Pe", "2 Peter"             ))
  lDict.at("1704").insert(LANG, ("1Jn", "1 John"              ))
  lDict.at("1705").insert(LANG, ("2Jn", "2 John"              ))
  lDict.at("1706").insert(LANG, ("3Jn", "3 John"              ))
  lDict.at("1707").insert(LANG, ("Jud", "Jude"                ))
  lDict.at("1801").insert(LANG, ("Rev", "Revelation"          ))
  lDict.at("3101").insert(LANG, ("1Es", "1 Esdras"            ))
  lDict.at("3102").insert(LANG, ("Jdt", "Judith"              ))
  lDict.at("3103").insert(LANG, ("Tob", "Tobit"               ))
  lDict.at("3104").insert(LANG, ("1Ma", "1 Maccabees"         ))
  lDict.at("3105").insert(LANG, ("2Ma", "2 Maccabees"         ))
  lDict.at("3106").insert(LANG, ("3Ma", "3 Maccabees"         ))
  lDict.at("3107").insert(LANG, ("4Ma", "4 Maccabees"         ))
  lDict.at("3108").insert(LANG, ("AEs", "Additions to Esther" ))
  lDict.at("3201").insert(LANG, ("APs", "Additional Psalm"    ))
  lDict.at("3202").insert(LANG, ("Ode", "Ode"                 ))
  lDict.at("3203").insert(LANG, ("Wis", "Wisdom of Solomon"   ))
  lDict.at("3204").insert(LANG, ("Sir", "Sirach"              ))
  lDict.at("3205").insert(LANG, ("PsS", "Psalms of Solomon"   ))
  lDict.at("3206").insert(LANG, ("Bar", "Baruch"              ))
  lDict.at("3207").insert(LANG, ("LJe", "Letter of Jeremiah"  ))
  lDict.at("3208").insert(LANG, ("Sus", "Susanna"             ))
  lDict.at("3209").insert(LANG, ("Bel", "Bel and the Dragon"  ))
  lDict.at("3210").insert(LANG, ("Sg3", "Song of Three Youths"))
  lDict.at("5101").insert(LANG, ("3Es", "3 Esdras"            ))
  lDict.at("5102").insert(LANG, ("4Es", "4 Esdras"            ))
  lDict.at("5103").insert(LANG, ("PMa", "Prayer of Manasseh"  ))
}


