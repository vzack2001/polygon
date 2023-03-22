#!/usr/local/bin/perl -w
#

while (<>) {
  
    $to_print = 1;

    #s/\r/\n\n/g;

#    <tag k="name:fi" v="Novokuznetsk"/> 
    if (/\s*<tag\s+k=\"name:/i) {
        $to_print = 0;
    }

    if ($to_print) {
        print $_;
    }
  
}
