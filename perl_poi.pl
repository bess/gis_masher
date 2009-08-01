#!/usr/bin/perl -w
# By Tor Arntsen 2005
# Licensed under GPLv2
use strict;
if ($#ARGV != 2) {
    print STDERR "Usage: $0 lat lon \"the address\"\n";
    print STDERR "lat and lon in decimal format\n"; 
    print STDERR "(e.g. 59.10123 5.24322  which is north and east lat/lon)\n";
    print STDERR "Writes one entry into a file called geotmp.ov2\n";
    exit 1;
}

my $len = 1+length($ARGV[2]); # Include the NULL (added by 'pack')
my $siz = 13+$len; # Size of three first fields plus the string above

# Hardcoded output file.. :-)
open (OV2, "> geotmp.ov2") or die "Could not open geotmp.ov2 $!";

# Pack 1 byte of value 2, one 4-byte unsigned int ($siz),
# two 4-byte signed ints and a \0-terminated string, and
# write the whole lot to the output file:
syswrite (OV2, pack ("C I i i Z$len", 2, $siz,
                    int($ARGV[1]*1E5), int($ARGV[0]*1E5), $ARGV[2]));
close (OV2);

