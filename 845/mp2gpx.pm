#!/usr/local/bin/perl -w
#

$maxlat = 0;
$maxlon = 0;
$minlat = 180;
$minlon = 180;
$count = 0;

while (<>) {

#   print $_; 

   if (/data/i) {
   
     chomp($_);
     $data_str = $_;

     while ($data_str) {
#       print "---=$data_str\n";
       $where1 = index($data_str, "(");
       $where2 = index($data_str, ")");

       $point1 = substr($data_str, $where1+1, $where2 - $where1-1);
       @points = split(/,/, $point1);
       if ($count == 0) {
         $maxlat = $points[0];
         $maxlon = $points[1];
         $minlat = $points[0];
         $minlon = $points[1];
       }
       
       $count ++;
       $maxlat = max($maxlat, $points[0]);
       $maxlon = max($maxlon, $points[1]);
       $minlat = min($minlat, $points[0]);
       $minlon = min($minlon, $points[1]);
       
       print "<trkpt lat=\"$points[0]\" lon=\"$points[1]\"/>\n";
       
       
       $data_str = substr($data_str, $where2+1);
#       print "   =$data_str\n";
     }
   
#     print "$_\n" ;
   }

}

    print "$count\n" ;
    print "<bounds maxlat=\"$maxlat\" maxlon=\"$maxlon\" minlat=\"$minlat\" minlon=\"$minlon\"/>\n";

sub min {
  my ($min_val);
  $min_val = $_[0];
  if ($min_val > $_[1]) {
    $min_val = $_[1];
  }
  return $min_val;
}

sub max {
  my ($max_val);
  $max_val = $_[0];
  if ($max_val < $_[1]) {
    $max_val = $_[1];
  }
  return $max_val;
}