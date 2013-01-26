#!/usr/bin/perl
use strict;
# Converts plain text into a beta friendly tex markup

foreach my $line (<>){
    # Replace the underscores
    $line =~ s/_/\\_/g;

    # Add newline command to any double newlines
    $line =~ s/^$/\\newline\\newline\n/;

    # Now the fun part, apostrophes
    # If they occur after a letter, they probably are baktics
    $line =~ s/(\w)'/$1`/g;

    print $line;
}


