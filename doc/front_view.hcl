
unitlength 1;           # Maßstab 1:1
font Sans_Serif 4;
pen black 0.5 solid;

set b           160;
set h           100;

set dimDist      7.5;

set bDP1        120;
set hDP1        40.8;
set bDP2        50.2;
set hDP2        19;

set bLp1        $bDP1;
set hLp1        50;
set bLp2        $bDP2;
set hLp2        26;

moveto 0 0
moverel [ expr -$b /2 ]  [ expr -$h / 2 ];
rectangle $b $h;

#moveto 0 0
#moverel [ expr -$b /2 ]  [ expr -$h / 2 ];

set A {-90 -50}
set B {-90 50}

pen black 0.3 solid;
moveto [expr $b /2 + $dimDist] [expr -$h /2];
dimlinerel 0 $h;
moveto [expr -$b /2] [expr $h /2 + $dimDist];
dimlinerel $b 0;
pen black 0.5 solid;

set bLp2        $bDP2;
set hLp2        26;

###set tmp [ expr -1 * ( ($b - $hLp1 - $hLp2) /2 - ( $hLp1 - $hDP1) /2 ) ];

set tmp [ expr ( $hLp1 - $hDP1 ) /2 - ($b - $hLp1 - $hLp2) /2 ];

moveto 0 0;
moverel [ expr -$bDP1 /2 ]  $tmp;
pen lightgray;
fillrectangle $bDP1 $hDP1;
pen black;
rectangle $bDP1 $hDP1;

set tmp [ expr $hLp1 + ( $hLp1 - $hDP1) /2 + $tmp ];

moveto 0 0;
moverel [ expr $bDP1 /2 - $bDP2 ]  $tmp ;
pen lightgray;
fillrectangle $bDP2 $hDP2;
pen black;
rectangle $bDP2 $hDP2;

moverel [ expr $bDP2 - $bDP1 + 10 ] [ expr $hDP2 /2 ]
###pen red; fillcircle 2.5;
pen orange; fillcircle 2.5;
pen black; circle 2.5;







