#!/usr/bin/env perl

use strict;
use warnings;

my %reverts;
my %removedReverts;
my @lines;

sub parseLine {
    my $line = shift;
    chomp $line;
    if ($line =~ /^([0-9a-f]+) (.*)$/) {
        return $1, $2;
    } else {
        die "Wrong format of line: '$line'";
    }
}

while (<>) {
    my ($hash, $msg) = parseLine($_);
    if (exists $reverts{$msg}) {
        $removedReverts{$msg} = $reverts{$msg};
        delete $reverts{$msg};
        next;
    }
    if ($msg =~ /^Revert "(.*)"$/) {
        $reverts{$1} = $hash;
    }
    push @lines, "$hash $msg\n";
}

LINE: for my $line (@lines) {
    for my $hash (values %removedReverts) {
        next LINE if ($line =~ /^$hash /);
    }
    print $line;
}


#while(<>) {
#    next if isReverted($_);
#    if (/Revert "(.*)"$/) {
#        push @reverts, $1;
#    }
#}
#
#sub isReverted {
#    while 
#}
