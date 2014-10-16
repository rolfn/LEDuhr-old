unitlength 1.5;           # Maßstab 1.5:1
font Sans_Serif 3;

set wd2 80; # half width
set ht2 50; # half height

### set f 1.925 # 231 / 120
set wd2DP1L  60;     # half width of board of Display 1  # 4.72" = 119.9mm ~= 120mm
set ht2DP1L  25.4;   # half height of board of Display 1 # 1" = 25.4mm
set wd2DP1   60;     # half width of Display 1
set ht2DP1   20.4;   # half height of Display 1
set DP1posOffs -4;

### set f 3.8446 # 193 / 50.2
set wd2DP2L  25;   # half width of board of Display 2  # 1.97" = 50.038mm
set ht2DP2L  14.1; # half height of board of Display 2 # 1.11" = 28.194mm
set wd2DP2   25;   # half width of Display 2
set ht2DP2   9.5;  # half height of Display 2
set DP2posOffs -10;

set indRad   2.5;
set DP1Rad   1.5;
set DP2Rad   0.67;
set DP1Lwd   0.15;
set DP2Lwd   0.1;

set dimDist  5;

set DP1LholeRad 1;   # ø0.07874" = ø2mm
set DP1LoffsX 3.6;   # (120mm - 112.78mm) / 2 = 3.6mm
set DP1LoffsY 2.54;  # (50.8mm - 45.72mm) / 2 = 2.54mm

set DP2LholeRad 1;   # ø0.07874" = ø2mm
set DP2LoffsX 3.156; # (50mm - 43.688mm) / 2 = 3.156mm
set DP2LoffsY 2.667; # (28.194mm - 22.86mm) / 2 = 2.667mm

set thickLine 0.5;
set midLine 0.35;
set thinLine 0.2;

# wohle front plate
moveto 0 0;
moverel -$wd2  -$ht2;
pen black $thickLine solid;
rectangle [expr 2 * $wd2] [expr 2 * $ht2];

# printed board Display 1
moveto [expr $DP1posOffs - $wd2DP1L]  [expr -$ht2DP1L - $ht2DP2L ];
pen black $thinLine solid;
rectangle [expr 2 * $wd2DP1L] [expr 2 * $ht2DP1L];
moverel $DP1LoffsX $DP1LoffsY;
circle $DP1LholeRad;
moverel [expr 2 * ($wd2DP1L - $DP1LoffsX)] 0;
circle $DP1LholeRad;
moverel 0 [expr 2 * ($ht2DP1L - $DP1LoffsY)];
circle $DP1LholeRad;
moverel [expr 2 * ($DP1LoffsX - $wd2DP1L)] 0;
circle $DP1LholeRad;

# Display 1
moveto [expr $DP1posOffs - $wd2DP1L] [expr -$ht2DP1L - $ht2DP2L + $ht2DP2 /2 ];
set DP1pos [here];
pen lightgray;
fillrectangle [expr 2 * $wd2DP1] [expr 2 * $ht2DP1];
pen black $thinLine solid;
rectangle [expr 2 * $wd2DP1] [expr 2 * $ht2DP1];

# printed board  Display 2
moveto [expr $wd2DP1L - 2 * $wd2DP2L + $DP2posOffs] [expr $ht2DP1L - $ht2DP2L];
pen black $thinLine solid;
rectangle [expr 2 * $wd2DP2L] [expr 2 * $ht2DP2L];
moverel $DP2LoffsX $DP2LoffsY;
circle $DP2LholeRad;
moverel [expr 2 * ($wd2DP2L - $DP2LoffsX)] 0;
circle $DP2LholeRad;
moverel 0 [expr 2 * ($ht2DP2L - $DP2LoffsY)];
circle $DP2LholeRad;
moverel [expr 2 * ($DP2LoffsX - $wd2DP2L)] 0;
circle $DP2LholeRad;

# Display 2
set DP2pos "[expr $wd2DP1L - 2 * $wd2DP2L  + $DP2posOffs] [expr $ht2DP1L - $ht2DP2]";
moveto $DP2pos

pen lightgray;
fillrectangle [expr 2 * $wd2DP2] [expr 2 * $ht2DP2];
pen black $thinLine solid;
rectangle [expr 2 * $wd2DP2] [expr 2 * $ht2DP2];

# Indikator
moveto [expr 10 -$wd2DP1L] $ht2DP1L;
pen orange; fillcircle $indRad;
pen black $thinLine solid; circle $indRad;

pen black midLine solid;
moveto [expr $wd2 + $dimDist] [expr -$ht2];
dimlinerel 0 [expr 2 * $ht2];
moveto [expr -$wd2] [expr $ht2 + $dimDist];
dimlinerel [expr 2 * $wd2] 0;

pen black $thickLine solid;

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
    drawSeg {2.43 2.92 3.07 2.39 8.82 2.39 9.25 2.91 8.31 3.74 3.14 3.74};
    # "B"
    drawSeg {9.40 3.10 9.86 3.62 9.14 8.66 8.37 9.35 7.77 8.70 8.46 3.90};
    # "C"
    drawSeg {8.31 9.64 7.55 10.31 6.86 15.10 7.59 15.92 8.18 15.42 8.91 10.30};
    # "D"
    drawSeg {0.60 16.08 1.07 16.57 6.82 16.61 7.40 16.07 6.70 15.25 1.52 15.25};
    # "E"
    drawSeg {1.50 9.65 0.69 10.31 0.00 15.38 0.46 15.90 1.42 15.07 2.07 10.30};
    # "F"
    drawSeg {2.28 3.08 1.66 3.61 0.94 8.69 1.52 9.34 2.32 8.66 3.00 3.88};
    # "G"
    drawSeg {1.66 9.50 2.24 10.17 7.41 10.16 8.20 9.48 7.62 8.82 2.45 8.82};

    offset [expr -$xoffs] 0; # reset offset;
  }

  global DP2Rad DP2Lwd;
  pen black $DP2Lwd solid;

  moveto $pos;   # upper left corner Display 2

  moverel 25.63 5.63;  circle $DP2Rad;
  moverel -1.15 7.92;  circle $DP2Rad;
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

  set d {1.04 13.74 26.44 39.14}; # local offsets for each 7-Seg

  foreach i $d {
    draw7Seg $i;
  }

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
    drawSeg {6.03 5.71 7.99 8.12 19.10 8.12 21.99 5.63 21.51 5.06 6.66 5.03};
    # "B"
    drawSeg {22.27 6.05 19.39 8.46 17.56 18.61 18.81 20.02 20.57 18.61 22.77 6.58};
    # "C"
    drawSeg {18.74 20.75 16.82 22.32 15.17 32.28 17.11 34.67 17.82 34.20 19.94 22.27};
    # "D"
    drawSeg {0.76 35.11 1.10 35.61 16.04 35.64 16.77 35.09 14.75 32.65 3.44 32.73};
    # "E"
    drawSeg {3.88 20.75 2.10 22.27 0.00 34.14 0.42 34.72 3.38 32.10 5.11 22.2};
    # "F"
    drawSeg {5.53 6.03 4.85 6.58 2.75 18.61 3.96 19.99 5.76 18.45 7.63 8.46};
    # "G"
    drawSeg {4.30 20.41 5.50 21.91 16.61 21.88 18.34 20.39 17.16 18.89 6.03 18.89};

    offset [expr -$xoffs] 0; # reset offset;
  }

  global DP1Rad DP1Lwd;

  pen black $DP1Lwd solid;

  moveto $pos;   # upper left corner Display 2
  moverel 8.7 13.6; circle $DP1Rad;
  moverel -2.54 14.96; circle $DP1Rad;
  moverel 88.4 -22; circle $DP1Rad;

  moveto $pos;
  moverel 65.22 13.6;
  pen orange; fillcircle $DP1Rad;
  pen black; circle $DP1Rad;
  moverel -2.54 14.96;
  pen orange; fillcircle $DP1Rad;
  pen black; circle $DP1Rad;

  moveto $pos;

  offset $pos;
  set x [X $pos];
  set y [Y $pos];

  set d {12.63 37.63 68.23 93.23}; # local offsets for each 7-Seg

  foreach i $d {
    draw7Seg $i;
  }

  offset [expr -1 * $x] [expr -1 * $y]; # reset global offset;

}


drawBig7Seg $DP1pos;
drawSmall7Seg $DP2pos;

###circle $DP1pos 1;
###circle $DP2pos 1;

pen black midLine solid;
dimline -$wd2 [expr [Y $DP1pos] - 2 * $dimDist] [X $DP1pos] [expr [Y $DP1pos] - 2 * $dimDist];
dimlinerel [expr 2 * $wd2DP1L] 0;
dimline -$wd2 [Y $DP2pos] $DP2pos;  ###circle 5;

moverel [expr 2 * $wd2DP2 + $dimDist] 0;
dimlinerel 0 [expr 2 * $ht2DP2];
moverel $dimDist [expr -$ht2DP2 - $ht2DP2L];
dimlinerel 0 [expr 2 * $ht2DP2L];

moveto $DP1pos;
moverel [expr 2 * $wd2DP1 + $dimDist] 0;
dimlinerel 0 [expr 2 * $ht2DP1];
moverel $dimDist [expr -$ht2DP1 - $ht2DP1L];
dimlinerel 0 [expr 2 * $ht2DP1L];



