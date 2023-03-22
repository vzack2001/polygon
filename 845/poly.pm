#!/usr/local/bin/perl -w
#

=pod    
    Формат данных файла *.poly
    
    ,X,Y
    
        X - Горизонталь/долгота (E/W) координата
        Y - Вертикаль/широта (N/S) координата
----
Relation 145194

1
   87.9850057   51.9019916 
   87.9895228   51.9020784  
----
=cut

$maxlat = 0;
$maxlon = 0;
$minlat = 180;
$minlon = 180;
$count = 0;

#$args = join(" ", @ARGV);
#print "# $args\n";

while (<>) {

    #print $_; 
    $data_str = $_;
    chomp($data_str);

    @points = split(/\s+/, $data_str);
    $arrSize = @points;
    if ($arrSize == 3) {
        #0 1         2
        #,87.9850057,51.9019916 
        $count ++;
        $maxlon = max($maxlon, $points[1]);
        $maxlat = max($maxlat, $points[2]);
        $minlon = min($minlon, $points[1]);
        $minlat = min($minlat, $points[2]);
    }
    
    #$res = join(",", @points);
    #print "$res\n";
    #
    #$arrSize = @points;
    #if ($arrSize != 3) {
    #    print "$arrSize $data_str\n";
    #}
}

print "# $count points\n" ;
print "\$maxlat = $maxlat;\n\$maxlon = $maxlon;\n\$minlat = $minlat;\n\$minlon = $minlon;\n";
# download OSM-data link
print "https://overpass-api.de/api/map?bbox=$minlon,$minlat,$maxlon,$maxlat";


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

=pod    


# 7766 poligones novosib-1.poly
$maxlat = 56.0598686;
$maxlon = 85.1159569;
$minlat = 53.4943074;
$minlon = 80.9517245;

# 7478 poligones novosib-2.poly
$maxlat = 57.2378336;
$maxlon = 83.6049411;
$minlat = 53.29141;
$minlon = 75.08801;

# 9938 poligones altay.poly
$maxlat = 52.6602680;
$maxlon = 89.8656495;
$minlat = 49.0695363;
$minlon = 83.9328028;

# 15253 poligones
$maxlat = 54.4531098;
$maxlon = 89.8656495;
$minlat = 49.0695363;
$minlon = 81.579575;

# 6302 poligones
$maxlat = 54.4531098;
$maxlon = 89.8656495;
$minlat = 49.0695363;
$minlon = 77.8891211;

# 10530 poligones + kemerovo-1.poly
$maxlat = 55.9714621;
$maxlon = 89.8656495;
$minlat = 49.0695363;
$minlon = 77.8891211;

# 5045 poligones + kemerovo-2.poly
$maxlat = 56.8344202;
$maxlon = 89.8656495;
$minlat = 49.0695363;
$minlon = 77.8891211;

=cut
