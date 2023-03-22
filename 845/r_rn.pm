#!/usr/local/bin/perl -w
#

while (<>) {
  
    s/\r/\n\n/g;
    print $_;
  
}
