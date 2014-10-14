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
set DP1Rad   1.5;
set DP2Rad   0.67;
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
#moveto [expr $wd2DP1L - 2 * $wd2DP2L ] [expr $ht2DP1L - $ht2DP2 ];
#set DP2pos [here];
set DP2pos "[expr $wd2DP1L - 2 * $wd2DP2L ] [expr $ht2DP1L - $ht2DP2 ]";
moveto $DP2pos

pen lightgray;
fillrectangle [expr 2 * $wd2DP2] [expr 2 * $ht2DP2];
pen black 0.15 solid;
rectangle [expr 2 * $wd2DP2] [expr 2 * $ht2DP2];

# Indikator
moveto [expr 10 -$wd2DP1L] $ht2DP1L;
pen orange; fillcircle $indRad;
pen black 0.15 solid; circle $indRad;

pen black 0.3 solid;
moveto [expr $wd2 + $dimDist] [expr -$ht2];
dimlinerel 0 [expr 2 * $ht2];
moveto [expr -$wd2] [expr $ht2 + $dimDist];
dimlinerel [expr 2 * $wd2] 0;

pen black 0.5 solid;

proc drawSeg {x} {
  pen orange;
  fillpolygon $x;
  pen black 0.15 solid;
  polygon $x;
}

proc drawSmall7Seg {offs} {
  pen black 0.15 solid;
  global DP2Rad;

  moveto $offs;   # linke obere Ecke Display 2

  moverel 25.63 5.63; circle $DP2Rad;
  moverel -1.15 7.92; circle $DP2Rad;
  moverel -14.06 2.52; circle $DP2Rad;
  moverel 25.53 0; circle $DP2Rad;
  moverel 12.7 0;
  pen orange; fillcircle $DP2Rad;
  pen black; circle $DP2Rad;
  moverel -25.4 0;
  pen orange; fillcircle $DP2Rad;
  pen black; circle $DP2Rad;
}

proc drawBig7Seg {offs} {
  proc draw7Seg {} {
    # "A"
    drawSeg "6.03 5.71 7.99 8.12 19.10 8.12 21.99 5.63 21.51 5.06 6.66 5.03"
    # "B"
    drawSeg "22.27 6.05 19.39 8.46 17.56 18.61 18.81 20.02 20.57 18.61 22.77 6.58"
    # "C"
    drawSeg "18.74 20.75 16.82 22.32 15.17 32.28 17.11 34.67 17.82 34.20 19.94 22.27"
    # "D"
    drawSeg "0.76 35.11 1.10 35.61 16.04 35.64 16.77 35.09 14.75 32.65 3.44 32.73"
    # "E"
    drawSeg "3.88 20.75 2.10 22.27 0.00 34.14 0.42 34.72 3.38 32.10 5.11 22.2"
    # "F"
    drawSeg "5.53 6.03 4.85 6.58 2.75 18.61 3.96 19.99 5.76 18.45 7.63 8.46";
    # "G"
    drawSeg "4.30 20.41 5.50 21.91 16.61 21.88 18.34 20.39 17.16 18.89 6.03 18.89"
  }

  pen black 0.15 solid;

  global DP1Rad;

  moveto $offs;   # linke obere Ecke Display 1
  moverel 8.7 13.6; circle $DP1Rad;
  moverel -2.54 14.96; circle $DP1Rad;
  moverel 88.7 -22; circle $DP1Rad;

  moveto $offs;
  moverel 65.22 13.6
  pen orange; fillcircle $DP1Rad;
  pen black; circle $DP1Rad;
  moverel -2.54 14.96;
  pen orange; fillcircle $DP1Rad;
  pen black; circle $DP1Rad;

  moveto $offs;

  offset $offs;
  set x [X $offs];
  set y [Y $offs];
  set x [expr $x + 12.63];
  offset 12.63 0; draw7Seg; # Start 7-Segment No. 1
  set x [expr $x + 25];
  offset 25 0; draw7Seg;    # Start 7-Segment No. 2
  set x [expr $x + 30.6];
  offset 30.6 0; draw7Seg;  # Start 7-Segment No. 3
  set x [expr $x + 25];
  offset 25 0; draw7Seg;    # Start 7-Segment No. 4

  offset [expr -1 * $x] [expr -1 * $y]; # reset offset;

}


drawBig7Seg $DP1pos;
drawSmall7Seg $DP2pos;

circle $DP1pos 1;
circle $DP2pos 1;

