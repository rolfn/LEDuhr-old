unitlength 1;           # Maßstab 1:1
font Sans_Serif 4;
pen black 0.5 solid;


set wd2 80; # halbe Breite
set ht2 50; # halbe Höhe

### set f 1.925 # 231 / 120
set wd2DP1L  60;     # halbe Breite LP von Display 1
set ht2DP1L  25.5;   # halbe Höhe   LP von Display 1
set wd2DP1   60;     # halbe Breite von Display 1
set ht2DP1   20.4;   # halbe Höhe   von Display 1

### set f 3.8446 # 193 / 50.2
set wd2DP2L  25.1;   # halbe Breite LP von Display 2
set ht2DP2L  13.395; # halbe Höhe   LP von Display 2
set wd2DP2   25.1;   # halbe Breite von Display 2
set ht2DP2   9.5;    # halbe Höhe   von Display 2

set indRad   2.5;
set dimDist  7.5;

# Gesamte Frontplatte
moveto 0 0;
moverel -$wd2  -$ht2;
pen black 0.5 solid;
rectangle [expr 2 * $wd2] [expr 2 * $ht2];

# Leiterplatte Display 1
moveto -$wd2DP1L  [expr -$ht2DP1L - $ht2DP2L ];
pen black 0.15 solid;
rectangle [expr 2 * $wd2DP1L] [expr 2 * $ht2DP1L];

# Display 1
moveto -$wd2DP1L [expr -$ht2DP1L - $ht2DP2L + $ht2DP2 /2 ];
set DP1pos [here];
pen lightgray;
fillrectangle [expr 2 * $wd2DP1] [expr 2 * $ht2DP1];
pen black 0.15 solid;
rectangle [expr 2 * $wd2DP1] [expr 2 * $ht2DP1];

# Leiterplatte Display 2
moveto [expr $wd2DP1L - 2 * $wd2DP2L ] [expr $ht2DP1L - $ht2DP2L];
pen black 0.15 solid;
rectangle [expr 2 * $wd2DP2L] [expr 2 * $ht2DP2L];

# Display 2
moveto [expr $wd2DP1L - 2 * $wd2DP2L ] [expr $ht2DP1L - $ht2DP2 ];
set DP2pos [here];
pen lightgray;
fillrectangle [expr 2 * $wd2DP2] [expr 2 * $ht2DP2];
pen black 0.15 solid;
rectangle [expr 2 * $wd2DP2] [expr 2 * $ht2DP2];

# Indikator
moveto [expr 10 -$wd2DP1L] $ht2DP1L;
pen orange; fillcircle $indRad;
pen black 0.15 solid; circle $indRad;

circle $DP1pos 1;
circle $DP2pos 1;

pen black 0.3 solid;
moveto [expr $wd2 + $dimDist] [expr -$ht2];
dimlinerel 0 [expr 2 * $ht2];
moveto [expr -$wd2] [expr $ht2 + $dimDist];
dimlinerel [expr 2 * $wd2] 0;

pen black 0.5 solid;

proc drawBig7Seg {offs} {
  #pen black 0.3 solid;
  #unitlength 0.519480519481;
  #moverel $dx $dy;
  offset $offs;
  #circle 2;
  set a "17.66 6.13 19.58 8.67 30.18 8.57 32.83 6.03 32.47 5.45 18.23 5.35";
  pen orange;
  fillpolygon $a;
  pen black 0.15 solid;
  polygon $a;
  set b "33.19 6.39 30.39 9.09 28.67 19.74 29.87 21.30 31.63 19.74 33.66 6.96";
  pen orange;
  fillpolygon $b;
  pen black 0.15 solid;
  polygon $b;
##################################
# 57.2  42.5
# 54  45.8
# 50.9  66.1
# 54.5  71
# 55.8  70
# 59.5  45.6
##################################
  set c "29.71 22.08 28.05 23.79 26.44 34.34 28.31 36.88 28.99 36.36 30.91 23.69";
  pen orange;
  fillpolygon $c;
  pen black 0.15 solid;
  polygon $c;
  set e "15.584 22.13 14.026 23.636 12 36.36 12.467 36.99 15.169 34.338 16.83 23.584";
  pen orange;
  fillpolygon $e;
  pen black 0.15 solid;
  polygon $e;
  set f "16.623 7.013 14.54 19.74 15.844 21.3 17.558 19.74 19.22 8.88 17.3 6.338";
  pen orange;
  fillpolygon $f;
  pen black 0.15 solid;
  polygon $f;
}

moveto $DP1pos;
drawBig7Seg $DP1pos;


