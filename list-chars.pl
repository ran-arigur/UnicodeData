#!/usr/bin/perl


# A simple script that reads zero or more UTF-8 characters from standard input
# and lists them to standard output.
# For example, this:
#    echo foo | ./list-chars.pl
# prints this:
#    U+0066  LATIN SMALL LETTER F
#    U+006F  LATIN SMALL LETTER O
#    U+006F  LATIN SMALL LETTER O
#    U+000A  <control>


use Ruakh::Prelude;

my @names;
{
  $logger->info("Reading UnicodeData.txt . . .");

  my $filename = $0 =~ s{/[^/]+$}{/UnicodeData.txt}r;

  open my $fh, '<', $filename
    or die "Couldn't open $filename: $!";

  while (<$fh>) {
    chomp;

    my ($hex, $name) = split /;/, $_, 3; # only interested in first two fields

    die "Invalid line: [$_]"
      unless $hex =~ m/^[0-9A-F]{4,}$/;

    die "Invalid line: [$_]"
      unless $name =~ m/^<.*>$/ || $name =~ m/^[-A-Z0-9 ]+$/;

    my $ord = hex $hex;

    $names[$ord] = $name;
  }

  $logger->info(". . . done. Proceeding with main work . . .");
}

binmode STDIN, ':utf8';

while (<>) {
  my @chars = split //, $_;

  foreach my $char (@chars) {
    my $ord = ord $char;
    printf "U+%04X  %s\n", $ord, ($names[$ord] // '');
  }
}

$logger->info(". . . done!");
