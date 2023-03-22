#!/usr/local/bin/perl -w
#

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

        if ($points[3] < 10) {
            shift @points;        
            print $count, ",", join(",", @points), "\n";
            $count ++;
        }

=cut
 
#my $s = sprintf "%8.2f", $d;

# https://www.tutorialspoint.com/perl/perl_operators.htm
my %types =  ();
$count = 0;

while (<>) {

    if ($count == 0) {
        print $_; 
        #$count ++;

    } else {
        
        chomp($_);
        @points = split(/,/, $_);
        
        
        if ($points[4]==0) {
        $types{$points[3]} += 1;

          #print $count, ",", join(",", @points), "\n";
        }
    }

        $count ++;

}

$count --;
print "\/\/ total: $count\n" ;

for(keys %types){
	print("'$_' : $types{$_}\n");
}

=pod    
  https://andreyform.blogspot.com/p/igo-primo-nextgen.html
  
  Code Speedcam
  https://andreyform.blogspot.com/p/code-speedcam.html

FULL CODE iGO

   _ID0 =  1_or_64_or_96_or_128_or_160_or_192_or_224- 32
   _ID1 =  5_or_65_or_97_or_129_or_161_or_193_or_225- 33
   _ID2 =  2_or_66_or_98_or_130_or_162_or_194_or_226- 34
   _ID3 =  4_or_67_or_99_or_131_or_163_or_195_or_227- 35
   _ID4 =  3_or_68_or_100_or_132_or_164_or_196_or_228- 36
   _ID5 =  __or_69_or_101_or_133_or_165_or_197_or_229- 37
   _ID6 =  6_or_70_or_102_or_134_or_166_or_198_or_230- 38
   _ID7 =  7_or_71_or_103_or_135_or_167_or_199_or_231- 39
   _ID8 =  8_or_72_or_104_or_136_or_168_or_200_or_232- 40
   _ID9 =  9_or_73_or_105_or_137_or_169_or_201_or_233- 41
   ID10 = 10_or_74_or_106_or_138_or_170_or_202_or_234- 42
   ID11 = 11_or_75_or_107_or_139_or_171_or_203_or_235- 43
   ID12 = 12_or_76_or_108_or_140_or_172_or_204_or_236- 44
   ID13 = 13_or_77_or_109_or_141_or_173_or_205_or_237- 45
   ID14 = 14_or_78_or_110_or_142_or_174_or_206_or_238- 46
   ID15 = 15_or_79_or_111_or_143_or_175_or_207_or_239- 47
   ID16 = 16_or_80_or_112_or_144_or_176_or_208_or_240- 48
   ID17 = 17_or_81_or_113_or_145_or_177_or_209_or_241- 49
   ID18 = 18_or_82_or_114_or_146_or_178_or_210_or_242- 50
   ID19 = 19_or_83_or_115_or_147_or_179_or_211_or_243- 51
   ID20 = 20_or_84_or_116_or_148_or_180_or_212_or_244- 52
   ID21 = 21_or_85_or_117_or_149_or_181_or_213_or_245- 53
   ID22 = 22_or_86_or_118_or_150_or_182_or_214_or_246- 54
   ID23 = 23_or_87_or_119_or_151_or_183_or_215_or_247- 55
   ID24 = 24_or_88_or_120_or_152_or_184_or_216_or_248- 56
   ID25 = 25_or_89_or_121_or_153_or_185_or_217_or_249- 57
   ID26 = 26_or_90_or_122_or_154_or_186_or_218_or_250- 58
   ID27 = 27_or_91_or_123_or_155_or_187_or_219_or_251- 59
   ID28 = 28_or_92_or_124_or_156_or_188_or_220_or_252- 60
   ID29 = 29_or_93_or_125_or_157_or_189_or_221_or_253- 61
   ID30 = 30_or_94_or_126_or_158_or_190_or_222_or_254- 62
   ID31 = 31_or_95_or_127_or_159_or_191_or_223_or_255- 63


   ID0 = 1or192or32 - стационарная камера контроля скорости
   ID1 = 5or193or33 - мобильная камера контроля скорости (засада)
   ID2 = 2or194or34 - встроенная камера контроля скорости
   ID3 = 4or227or35 - камера контроля средней скорости
   ID4 = 3 or 68or36 - контроль проезда на красный
   ID5 = _or197or37 - фото-радарный комплекс, скорость и контроль ПДД
   ID6 = 6or198or38 - железнодорожный переезд
   ID7 = 7or199or39 - камера на полосе общественного транспорта
   ID8 = 8or200or40 - аварийно-опасный участок, перекресток
   ID9 = 9or201or41 - школьная территория
   ID10=10or202or42 - въезд в населенный пункт
   ID11=11or203or43 - светофор с контролем скорости и проезда на красный
   ID12=12or204or44 - пункт оплаты
   ID13=13or205or45 - больница, медпункт
   ID14=14or206or46 - пожарная часть
   ID15=15or207or47 - контроль оплаты Платон, BelToll
   ID16=16or208or48 - пункт весового контроля
   ID17=17or209or49 - мобильная камера Тренога
   ID18=18or210or50 - лежачий полицейский
   ID19=19or211or51 - участок плохой дороги
   ID20=20or212or52 - опасный поворот
   ID21=21or213or53 - въезд в тоннель
   ID22=22or214or54 - объекты POI
   ID23=23or215or55 - стационарный пост ДПС
   ID24=24or216or56 - камера контроля остановки
   ID25=25or217or57 - съезд с автострады
   ID26=26or218or58 - информационное табло скорости
   ID27=27or219or59 - интеллектуальный светофор
   ID28=28or220or60 - ограничение высоты (узкий, или низкий проезд)
   ID29=29or221or61 - пешеходный переход
   ID30=30or222or62 - камера наблюдения или муляж
   ID31=31or223or63 - опасный участок дороги

2664,33414,34.3218734,61.7827125,,60,1,57
// total: 49698
'197' : 23
'68' : 8653
'227' : 412
'199' : 3066
'' : 1
'194' : 44
'193' : 350
'192' : 36562
'206' : 587

speed==0
'193' : 5
'199' : 3
'197' : 5
'68' : 2344
'192' : 36
    
=cut
