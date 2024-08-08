#set page(paper: "a6")

#import "lib.typ": *

As it is written:

#bQuot([*11* The word of the LORD came to me saying, “What do you see,
Jeremiah?” And I said, “I see a rod of an almond tree.” *12* Then the LORD said to me, “You have
seen well, for I am watching over My word to perform it.”], "Jer", "en-3", [1.11,12], "NASB95",
label("2012-LXX-SBB"), fill: false)

#pagebreak()

Also, David says: #iQuot([The LORD is my shepherd, I shall not want.], "Psa", "en-3", [23.1],
"NASB95", label("2012-LXX-SBB")).

#pagebreak()

Moreover,

#bQuot([*1* Then the inhabitants of Jerusalem made Ahaziah, his youngest son, king in his place,
for the band of men who came with the Arabs to the camp had slain all the older sons. So Ahaziah
the son of Jehoram king of Judah began to reign. *3* He also walked in the ways of the house of
Ahab, for his mother was his counselor to do wickedly. *4* He did evil in the sight of the LORD
like the house of Ahab, for they were his counselors after the death of his father, to his
destruction.], "2Ch", "en-3", [22.1,3--4], "NASB95", label("2012-LXX-SBB"), fill: true)

#pagebreak()

Furthermore, #bQuot([There sprang from these a sinful offshoot, Antiochus Epiphanes, son of King
Antiochus, once a hostage at Rome. He became king in the one hundred and thirty-seventh year of
the kingdom of the Greeks.], "1Ma", "en-3", [1.10], "USCCB", label("2012-LXX-SBB"), fill: false,
quotes: true)

#pagebreak()

Finally, #bQuot([but these have been written so that you may believe that Jesus is the Christ,
the Son of God; and that believing you may have life in His name.], "Jhn", "en-3", [20.31],
"NASB95", label("2012-LXX-SBB"), fill: true, fill-below: true)

#{
  //import "./books.typ": bSort
  for ordering in bSort.keys() {
    pagebreak()
    align(center)[= Biblical Index
      "#ordering" book ordering (excluding missing ones)]
    mkIndex(cols: 1, sorting-tradition: ordering, exclude-missing: true)
  }
}

#pagebreak()

#bibliography("test-01-readme.yml")

