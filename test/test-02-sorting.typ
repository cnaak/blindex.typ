#set page(
  paper: "a6",
  footer: context [
    #set align(center)
    #set text(8pt)
    #counter(page).display("— 1 —")
  ]
)

#set text(size: 9pt)

#import "blindex.typ": *

#let bib = ```
NASB95:
  type: book
  title:
    value: New American Standard Bible (NASB)
  publisher: The Lockman Foundation
  address: La Habra, CA 90632-2279
  date: 1995

WEBU:
  type: book
  title:
    value: World English Bible
  publisher: eBible.org
```

As it is written:

#bq([#ver(11)The word of the LORD came to me saying, “What do you see, Jeremiah?” And I
said, “I see a rod of an almond tree.” #ver(12)Then the LORD said to me, “You have seen
well, for I am watching over My word to perform it.”], "Jer", "en-3", [1.11,12], version:
[NASB95], cite: [@NASB95])

Also, David says: #iq([The LORD is my shepherd, I shall not want.], "Psa", "en-3", [23.1],
version: "NASB95").

Moreover,

#bq([#ver(1)Then the inhabitants of Jerusalem made Ahaziah, his youngest son, king in his
place, for the band of men who came with the Arabs to the camp had slain all the older sons. So
Ahaziah the son of Jehoram king of Judah began to reign. #ver(3)He also walked in the ways of
the house of Ahab, for his mother was his counselor to do wickedly. #ver(4)He did evil in the
sight of the LORD like the house of Ahab, for they were his counselors after the death of his
father, to his destruction.], "2Ch", "en-3", [22.1,3--4], version: "NASB95")

Furthermore, #bq([There came out of them a sinful root, Antiochus Epiphanes, son of Antiochus
the king, who had been a hostage at Rome, and he reigned in the one hundred thirty seventh year
of the kingdom of the Greeks.], "1Ma", "en-3", [1.10], version: [WEBU], cite: [@WEBU])

Finally, #bq([but these have been written so that you may believe that Jesus is the Christ,
the Son of God; and that believing you may have life in His name.], "Jhn", "en-3", [20.31],
version: "NASB95")

#bibliography(bytes(bib.text), style: "turabian-fullnote-8")

#{
  //import "./books.typ": bsort
  [= Biblical Indices
  The indices are by available orderings, which by default exclude eventually missing books in
  that ordering (tradition).
  ]
  for ordering in bsort.keys() {
    //pagebreak()
    [== "#ordering" book ordering]
    mk-index(cols: 1, sorting-tradition: ordering, exclude-missing: true)
    v(2em)
  }
}

