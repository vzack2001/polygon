#!/usr/local/bin/perl -w
#

$maxlat = 180;
$maxlon = 180;
$minlat = 0;
$minlon = 0;

=pod    
    Формат данных файла SpeedCam.txt

        IDX, X, Y, TYPE, SPEED, DirType, Direction
         
        IDX - номер
        X - Горизонталь/долгота (E/W) координата
        Y - Вертикаль/широта (N/S) координата
        TYPE - Тип опастности:
        1 - Статическая камера
        2 - Встроенная в светофор
        3 - Камера проверяющая проезд на красный свет
        4 - Камера измеряющая скорость на отрезке дороги
        5 - Мобильная камера (засада)
        101 - ограничение скорости
        102 - лежачий полицейский
        103 - плохая дорога
        104 - опасное изменение направления движения
        105 - опасный перекресток
        106 - другая опасность
        SPEED - Ограничение скорости
        DirType - Направление действия камеры:
        0 - все направления (360)
        1 - в определенном направлении (смотреть поле DIRECTION )
        2 - два направления (DIRECTION + обратное направление)
        Direction - Градус обзора камеры (между 0 и 359, 0 - Север, 90 - Восток, 180 - Юг, 270 - Запад)

0   1 2 3    4     5       6
IDX,X,Y,TYPE,SPEED,DirType,Direction
0,20.060271,40.254669,101,40,1,309
1,20.063262,40.251125,101,40,1,292

# 9938 poligones altay.poly
$maxlat = 52.6602680;
$maxlon = 89.8656495;
$minlat = 49.0695363;
$minlon = 83.9328028;
 
# 15253 poligones altayskiy-1.poly
$maxlat = 54.4531098;
$maxlon = 89.8656495;
$minlat = 49.0695363;
$minlon = 81.579575;

R = 6,000,000 m
D = 37,699.111/360 = 104,719.75 m/grad (on equat)
r = cos(lat) * R = 
d = 24,232,521.98892/360 = 67,312.56 m/grad
=cut
 

$maxlat = 56.8344202;
$maxlon = 89.8656495;
$minlat = 49.0695363;
$minlon = 77.8891211;

#my $s = sprintf "%8.2f", $d;

$start_from = 0;
$count = 0;

while (<>) {

    if ($count == 0) {
        print $_; 
        $count ++;
    }
    chomp($_);
    
    @points = split(/,/, $_);
    
    $lon = $points[1];
    $lat = $points[2];
    $res = inbound($lat, $lon);
    if ($res) {
        if ($points[3] < 10) {
            #my $first = shift @points;        
            #print $count+$start_from, ",", join(",", @points), "\n";
            print "$_\n";
            $count ++;
        }
    }
    
    #if ($points[3] < 10) {
    #    $count ++;
    #    print "$_\n";
    #}

}

$count --;
print "\/\/ total: $count\n" ;
#print "<bounds maxlat=\"$maxlat\" maxlon=\"$maxlon\" minlat=\"$minlat\" minlon=\"$minlon\"/>\n";

sub inbound {
    #($lat, $lon)
    # $_[0] [1]   
    if (($_[0] >= $minlat) && ($_[0] < $maxlat) && ($_[1] >= $minlon) && ($_[1] < $maxlon)) {
        return 1;
    }
    return 0;
}

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