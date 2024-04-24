- UnicodeData.txt obtained from here:
  https://www.unicode.org/Public/15.1.0/ucd/UnicodeData.txt

- To generate UnicodeData.js:
  perl ./UnicodeData.txt2js.pl < UnicodeData.txt > UnicodeData.js

- list-chars.pl is a simple script that reads zero or more UTF-8 characters from
  standard input and lists them to standard output.
  For example, this:
     echo foo | ./list-chars.pl
  prints this:
     U+0066  LATIN SMALL LETTER F
     U+006F  LATIN SMALL LETTER O
     U+006F  LATIN SMALL LETTER O
     U+000A  <control>

