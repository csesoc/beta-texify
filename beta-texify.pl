#!/usr/bin/perl
use strict;
# Converts plain text into a beta friendly tex markup

# Print usage if no arguments given
die "Usage: $0 FILES...\n" if @ARGV == 0;

foreach my $file (<*>){
    # Skip any directories 
    next if -d $file;

    # Word out the rename
    my $new_file = $file;
    if ($file =~ /\..*$/){
        $new_file =~ s/\..*$/\.tex/;
    } else {
        $new_file = $new_file.".tex";
    }

    # Skip any that already exist
    next if -e $new_file;

    open(INPUT, "<", $file);
    open(OUTPUT, ">", $new_file);

    for my $line (<INPUT>){
        print OUTPUT translate_line($line);
    }

    close (INPUT);
    close(OUTPUT)
}

sub translate_line ($){
    my $line = $_[0];

    # Replace the underscores
    $line =~ s/_/\\_/g;
    # Add newline command to any double newlines
    $line =~ s/^$/\\newline\\newline\n/;
    # Now the fun part, apostrophes
    # If they occur after a letter, they probably are baktics
    $line =~ s/(\w)'/$1`/g;

    return $line;
}
