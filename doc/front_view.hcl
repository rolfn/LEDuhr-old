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
set DP1Lwd   0.15;
set DP2Lwd   0.1;
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

proc drawSmall7Seg {pos} {
  proc drawSeg {x} {
    pen orange;
    global DP2Lwd;
    fillpolygon $x;
    pen black $DP2Lwd solid;
    polygon $x;
  }
  proc draw7Seg {xoffs} {
    offset $xoffs 0;
    # "A"
    drawSeg "2.43 2.92 3.07 2.39 8.82 2.39 9.25 2.91 8.31 3.74 3.14 3.74"
    # "B"
    drawSeg "9.40 3.10 9.86 3.62 9.14 8.66 8.37 9.35 7.77 8.70 8.46 3.90"
    # "C"
    drawSeg "8.31 9.64 7.55 10.31 6.86 15.10 7.59 15.92 8.18 15.42 8.91 10.30"
    # "D"
    drawSeg "0.60 16.08 1.07 16.57 6.82 16.61 7.40 16.07 6.70 15.25 1.52 15.25"
    # "E"
    drawSeg "1.50 9.65 0.69 10.31 0.00 15.38 0.46 15.90 1.42 15.07 2.07 10.30"
    # "F"
    drawSeg "2.28 3.08 1.66 3.61 0.94 8.69 1.52 9.34 2.32 8.66 3.00 3.88"
    # "G"
    drawSeg "1.66 9.50 2.24 10.17 7.41 10.16 8.20 9.48 7.62 8.82 2.45 8.82"
    offset [expr -1 * $xoffs] 0; # reset offset;
  }

  global DP2Rad DP2Lwd;
  pen black $DP2Lwd solid;

  moveto $pos;   # linke obere Ecke Display 2

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

  moveto $pos;

  offset $pos;
  set x [X $pos];
  set y [Y $pos];

  set o 1.04;

  draw7Seg 1.04;  # 7-Segment No. 1
  draw7Seg [expr $o + 12.7]; # 7-Segment No. 2
  draw7Seg [expr $o + 25.4]; # 7-Segment No. 3
  draw7Seg [expr $o + 38.1]; # 7-Segment No. 4

  offset [expr -1 * $x] [expr -1 * $y]; # reset global offset;

}

proc drawBig7Seg {pos} {
  proc drawSeg {x} {
    pen orange;
    global DP1Lwd;
    fillpolygon $x;
    pen black $DP1Lwd solid;
    polygon $x;
  }
  proc draw7Seg {xoffs} {
    offset $xoffs 0;
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
    offset [expr -1 * $xoffs] 0; # reset offset;
  }

  global DP1Rad DP1Lwd;

  pen black $DP1Lwd solid;

  moveto $pos;   # linke obere Ecke Display 1
  moverel 8.7 13.6; circle $DP1Rad;
  moverel -2.54 14.96; circle $DP1Rad;
  moverel 88.4 -22; circle $DP1Rad;

  moveto $pos;
  moverel 65.22 13.6
  pen orange; fillcircle $DP1Rad;
  pen black; circle $DP1Rad;
  moverel -2.54 14.96;
  pen orange; fillcircle $DP1Rad;
  pen black; circle $DP1Rad;

  moveto $pos;

  offset $pos;
  set x [X $pos];
  set y [Y $pos];

  draw7Seg 12.63; # 7-Segment No. 1
  draw7Seg 37.63; # 7-Segment No. 2
  draw7Seg 68.23; # 7-Segment No. 3
  draw7Seg 93.23; # 7-Segment No. 4

  offset [expr -1 * $x] [expr -1 * $y]; # reset global offset;

}


drawBig7Seg $DP1pos;
drawSmall7Seg $DP2pos;

circle $DP1pos 1;
circle $DP2pos 1;

