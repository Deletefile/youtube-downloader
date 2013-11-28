#!/usr/bin/perl -w
use strict;
use warnings;
use LWP::Simple;
 
my $rand_n =int(rand(9999999999999))+1000000000000;
my ($vid,$ext) = @ARGV;
 
if ($vid !~ /^([a-zA-Z0-9\-])+$/) {
        print "Invalid video id! \n";
        exit;
}
 
if ($vid =~ /^https:\/\/www\.youtube\.com\/watch\?v=(.*)&?/i) {
        $vid = $1;
}
if (!defined $ext) {
        $ext = $rand_n.'.mp3';
} elsif ($ext !~ /\.mp3$/i) {
        $ext .= '.mp3';
}
 
print "
------------------------------------
YouTube Mp3 Downloader Script
author : Reda Kassame
nerdz  : www.nerdz.eu/Deletefile./
------------------------------------
Downloading..
";
 
get('http://www.youtube-mp3.org/api/pushItem/?item=http://www.youtube.com/watch?v='.$vid.'&xy=trve&r='.$rand_n);
if (get('http://www.youtube-mp3.org/api/itemInfo/?video_id='.$vid.'&adloc=&r='.$rand_n) =~ /"([a-f0-9]{32})"/) {
        if (!getstore('http://www.youtube-mp3.org/get?video_id='.$vid.'&h='.$1,$ext)) {
                print "Invalid Connection\n";
        } else {
                print "Downloaded!\n";
        }
} else {
        print "Invalid Error\n";
}
