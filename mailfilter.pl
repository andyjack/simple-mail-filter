#!/usr/bin/perl

use strict;
use warnings;
use Term::ANSIColor qw(:constants :constants256);

while(<>) {
    my ($date) = /^(.+?) mail /;
    my ($rbl,$rbl_host,$rbl_recip) = /blocked using (.+?);.+?from=<(.+?)>.+?to=<(.+?)>/;
    my ($recip,$msgid) = /lda\((.+?)\):.*?msgid=(.+?): saved mail to/;
    if ( $rbl ) {
        #next if $rbl eq 'zen.spamhaus.org';
        print "$date ";
        print BOLD, RED, "BLOCKED  ", RESET;
        print " $rbl :: $rbl_host -> $rbl_recip\n";
    }
    elsif ( $recip && $msgid ) {
        my $host;
        if ( $msgid =~ /@/ ) {
            ($host) = $msgid =~ /@(.+?)>/;
        }
        else {
            $host = '*no host in msgid*';
        }
        print "$date ";
        print BOLD, RGB050, "DELIVERED", RESET;
        print " $host -> $recip\n";
    }
}
