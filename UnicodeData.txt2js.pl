#!perl -w

use feature ':5.26';
use strict;
use utf8;
use warnings;

print "// derived from UnicodeData.txt (as of version 15.1, late 2023)\n";
print "var unicodeData = [\n";

my $is_first_line = 1;

while (<>) {
  chomp;

  my ($hex, $name) = split /;/, $_, 3; # only interested in first two fields

  die "Invalid line: [$_]"
    unless $hex =~ m/^[0-9A-F]{4,}$/;

  next if $name =~ m/^<.*>$/;  # control characters, ranges with boring names

  die "Invalid line: [$_]"
    unless $name =~ m/^[-A-Z0-9 ]+$/;

  my $prefix = ($is_first_line ? ' ' : ',');
  $is_first_line = '';

  print "${prefix}'U+$hex $name'\n";
}
print "];\n";

__END__
