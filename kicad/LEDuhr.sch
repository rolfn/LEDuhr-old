EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:LEDuhr-cache
EELAYER 24 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "LED-DCF77-Wecker"
Date "16 Sep 2014"
Rev ""
Comp "Rolf Niepraschk"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ATMEGA328P-M IC?
U 1 1 5417539F
P 2700 2400
F 0 "IC?" H 1950 3650 40  0000 L BNN
F 1 "ATMEGA328P-M" H 3100 1000 40  0000 L BNN
F 2 "MLF/QFN32" H 2700 2400 30  0000 C CIN
F 3 "" H 2700 2400 60  0000 C CNN
	1    2700 2400
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 54175CA2
P 4550 1950
F 0 "R1" V 4630 1950 40  0000 C CNN
F 1 "4k7" V 4557 1951 40  0000 C CNN
F 2 "" V 4480 1950 30  0000 C CNN
F 3 "" H 4550 1950 30  0000 C CNN
	1    4550 1950
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 54175D1A
P 4750 1950
F 0 "R3" V 4830 1950 40  0000 C CNN
F 1 "4k7" V 4757 1951 40  0000 C CNN
F 2 "" V 4680 1950 30  0000 C CNN
F 3 "" H 4750 1950 30  0000 C CNN
	1    4750 1950
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 54175EB1
P 1700 2100
F 0 "C?" H 1700 2200 40  0000 L CNN
F 1 "100nF" H 1706 2015 40  0000 L CNN
F 2 "" H 1738 1950 30  0000 C CNN
F 3 "" H 1700 2100 60  0000 C CNN
	1    1700 2100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54175F80
P 1700 2450
F 0 "#PWR?" H 1700 2450 30  0001 C CNN
F 1 "GND" H 1700 2380 30  0001 C CNN
F 2 "" H 1700 2450 60  0000 C CNN
F 3 "" H 1700 2450 60  0000 C CNN
	1    1700 2450
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5417621F
P 4950 1950
F 0 "R2" V 5030 1950 40  0000 C CNN
F 1 "10k" V 4957 1951 40  0000 C CNN
F 2 "" V 4880 1950 30  0000 C CNN
F 3 "" H 4950 1950 30  0000 C CNN
	1    4950 1950
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH S1
U 1 1 5417640C
P 4950 3150
F 0 "S1" H 5100 3260 50  0000 C CNN
F 1 "Reset" H 4950 3070 50  0000 C CNN
F 2 "" H 4950 3150 60  0000 C CNN
F 3 "" H 4950 3150 60  0000 C CNN
	1    4950 3150
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 54176674
P 4950 3650
F 0 "#PWR?" H 4950 3650 30  0001 C CNN
F 1 "GND" H 4950 3580 30  0001 C CNN
F 2 "" H 4950 3650 60  0000 C CNN
F 3 "" H 4950 3650 60  0000 C CNN
	1    4950 3650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54176921
P 1700 4000
F 0 "#PWR?" H 1700 4000 30  0001 C CNN
F 1 "GND" H 1700 3930 30  0001 C CNN
F 2 "" H 1700 4000 60  0000 C CNN
F 3 "" H 1700 4000 60  0000 C CNN
	1    1700 4000
	1    0    0    -1  
$EndComp
$Comp
L CRYSTAL_SMD Q1
U 1 1 54175672
P 4300 1950
F 0 "Q1" H 4300 2040 40  0000 C CNN
F 1 "16MHz" H 4330 1840 40  0000 L CNN
F 2 "" H 4300 1950 60  0000 C CNN
F 3 "" H 4300 1950 60  0000 C CNN
	1    4300 1950
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 54177F07
P 4450 2250
F 0 "#PWR?" H 4450 2250 30  0001 C CNN
F 1 "GND" H 4450 2180 30  0001 C CNN
F 2 "" H 4450 2250 60  0000 C CNN
F 3 "" H 4450 2250 60  0000 C CNN
	1    4450 2250
	1    0    0    -1  
$EndComp
$Comp
L LED D3
U 1 1 54178829
P 4300 1350
F 0 "D3" H 4300 1450 40  0000 C CNN
F 1 "LED" H 4300 1250 40  0000 C CNN
F 2 "" H 4300 1350 60  0000 C CNN
F 3 "" H 4300 1350 60  0000 C CNN
	1    4300 1350
	0    1    1    0   
$EndComp
$Comp
L R R6
U 1 1 5417890E
P 4050 1400
F 0 "R6" V 4130 1400 40  0000 C CNN
F 1 "330" V 4057 1401 40  0000 C CNN
F 2 "" V 3980 1400 30  0000 C CNN
F 3 "" H 4050 1400 30  0000 C CNN
	1    4050 1400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54178B51
P 4300 1650
F 0 "#PWR?" H 4300 1650 30  0001 C CNN
F 1 "GND" H 4300 1580 30  0001 C CNN
F 2 "" H 4300 1650 60  0000 C CNN
F 3 "" H 4300 1650 60  0000 C CNN
	1    4300 1650
	1    0    0    -1  
$EndComp
$Comp
L C C10
U 1 1 5417921A
P 950 1350
F 0 "C10" H 950 1450 40  0000 L CNN
F 1 "100nF" H 956 1265 40  0000 L CNN
F 2 "" H 988 1200 30  0000 C CNN
F 3 "" H 950 1350 60  0000 C CNN
	1    950  1350
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 541792CB
P 1150 1350
F 0 "C3" H 1150 1450 40  0000 L CNN
F 1 "100nF" H 1156 1265 40  0000 L CNN
F 2 "" H 1188 1200 30  0000 C CNN
F 3 "" H 1150 1350 60  0000 C CNN
	1    1150 1350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54179B9D
P 1150 1850
F 0 "#PWR?" H 1150 1850 30  0001 C CNN
F 1 "GND" H 1150 1780 30  0001 C CNN
F 2 "" H 1150 1850 60  0000 C CNN
F 3 "" H 1150 1850 60  0000 C CNN
	1    1150 1850
	1    0    0    -1  
$EndComp
Text GLabel 3750 1600 2    47   Input ~ 0
MOSI
Text GLabel 3750 1700 2    47   Input ~ 0
MISO
Text GLabel 4150 2300 2    47   Input ~ 0
SCK
Text GLabel 4150 2400 2    47   Input ~ 0
RESET
Text GLabel 3750 1300 2    47   Input ~ 0
PB0
Text GLabel 3750 1400 2    47   Input ~ 0
PB1
Text GLabel 3750 1500 2    47   Input ~ 0
PB2
Text GLabel 5100 2550 2    47   Input ~ 0
SDA
Text GLabel 5100 2650 2    47   Input ~ 0
SCL
Text GLabel 3750 2900 2    47   Input ~ 0
PD0
Text GLabel 3750 3000 2    47   Input ~ 0
PD1
Text GLabel 3750 3100 2    47   Input ~ 0
PD2
Text GLabel 3750 3200 2    47   Input ~ 0
PD3
Text GLabel 3750 3300 2    47   Input ~ 0
PD4
Text GLabel 3750 3400 2    47   Input ~ 0
PD5
Text GLabel 3750 3500 2    47   Input ~ 0
PD6
Text GLabel 3750 3600 2    47   Input ~ 0
PD7
Text GLabel 3750 2150 2    47   Input ~ 0
PC0
Text GLabel 3750 2250 2    47   Input ~ 0
PC1
Text GLabel 3750 2350 2    47   Input ~ 0
PC2
Text GLabel 3750 2450 2    47   Input ~ 0
PC3
$Comp
L CONN_01X01 P2
U 1 1 5417FAFD
P 5450 1100
F 0 "P2" H 5450 1200 50  0000 C CNN
F 1 "GND" V 5550 1100 50  0000 C CNN
F 2 "" H 5450 1100 60  0000 C CNN
F 3 "" H 5450 1100 60  0000 C CNN
	1    5450 1100
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X01 P1
U 1 1 54180876
P 5250 1100
F 0 "P1" H 5250 1200 50  0000 C CNN
F 1 "VCC" V 5350 1100 50  0000 C CNN
F 2 "" H 5250 1100 60  0000 C CNN
F 3 "" H 5250 1100 60  0000 C CNN
	1    5250 1100
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 54180B2F
P 5450 1400
F 0 "#PWR?" H 5450 1400 30  0001 C CNN
F 1 "GND" H 5450 1330 30  0001 C CNN
F 2 "" H 5450 1400 60  0000 C CNN
F 3 "" H 5450 1400 60  0000 C CNN
	1    5450 1400
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X01 P3
U 1 1 54180C09
P 5650 1100
F 0 "P3" H 5650 1200 50  0000 C CNN
F 1 "MOSI" V 5750 1100 50  0000 C CNN
F 2 "" H 5650 1100 60  0000 C CNN
F 3 "" H 5650 1100 60  0000 C CNN
	1    5650 1100
	0    -1   -1   0   
$EndComp
Text GLabel 5650 1400 3    47   Input ~ 0
MOSI
$Comp
L CONN_01X01 P4
U 1 1 54180D9B
P 5850 1100
F 0 "P4" H 5850 1200 50  0000 C CNN
F 1 "MISO" V 5950 1100 50  0000 C CNN
F 2 "" H 5850 1100 60  0000 C CNN
F 3 "" H 5850 1100 60  0000 C CNN
	1    5850 1100
	0    -1   -1   0   
$EndComp
Text GLabel 5850 1400 3    47   Input ~ 0
MISO
$Comp
L CONN_01X01 P5
U 1 1 54180DD0
P 6050 1100
F 0 "P5" H 6050 1200 50  0000 C CNN
F 1 "SCK" V 6150 1100 50  0000 C CNN
F 2 "" H 6050 1100 60  0000 C CNN
F 3 "" H 6050 1100 60  0000 C CNN
	1    6050 1100
	0    -1   -1   0   
$EndComp
Text GLabel 6050 1400 3    47   Input ~ 0
SCK
$Comp
L CP2 C13
U 1 1 54182035
P 1400 1350
F 0 "C13" H 1400 1450 40  0000 L CNN
F 1 "10µF" H 1406 1265 40  0000 L CNN
F 2 "" H 1438 1200 30  0000 C CNN
F 3 "" H 1400 1350 60  0000 C CNN
	1    1400 1350
	1    0    0    -1  
$EndComp
$Comp
L BI_LED D?
U 1 1 5418302A
P 8700 5900
F 0 "D?" H 9000 6000 50  0000 C CNN
F 1 "BI_LED" H 9050 5800 50  0000 C CNN
F 2 "" H 8700 5900 60  0000 C CNN
F 3 "" H 8700 5900 60  0000 C CNN
	1    8700 5900
	1    0    0    -1  
$EndComp
$Comp
L CODING_SWITCH SW4
U 1 1 541830EB
P 9400 1200
F 0 "SW4" H 9500 1550 60  0000 C CNN
F 1 "Hour × 10" H 9400 851 60  0000 C CNN
F 2 "" H 9400 1200 60  0000 C CNN
F 3 "" H 9400 1200 60  0000 C CNN
	1    9400 1200
	-1   0    0    1   
$EndComp
$Comp
L CODING_SWITCH SW3
U 1 1 541850B4
P 9400 2100
F 0 "SW3" H 9500 2450 60  0000 C CNN
F 1 "Hour × 1" H 9400 1751 60  0000 C CNN
F 2 "" H 9400 2100 60  0000 C CNN
F 3 "" H 9400 2100 60  0000 C CNN
	1    9400 2100
	-1   0    0    1   
$EndComp
$Comp
L CODING_SWITCH SW2
U 1 1 541850FC
P 9400 3000
F 0 "SW2" H 9500 3350 60  0000 C CNN
F 1 "Minute × 10" H 9400 2651 60  0000 C CNN
F 2 "" H 9400 3000 60  0000 C CNN
F 3 "" H 9400 3000 60  0000 C CNN
	1    9400 3000
	-1   0    0    1   
$EndComp
$Comp
L CODING_SWITCH SW1
U 1 1 54185149
P 9400 3900
F 0 "SW1" H 9500 4250 60  0000 C CNN
F 1 "Minute × 1" H 9400 3551 60  0000 C CNN
F 2 "" H 9400 3900 60  0000 C CNN
F 3 "" H 9400 3900 60  0000 C CNN
	1    9400 3900
	-1   0    0    1   
$EndComp
Text GLabel 7650 4050 0    47   Input ~ 0
PD0
Text GLabel 7650 3900 0    47   Input ~ 0
PD1
Text GLabel 7650 3750 0    47   Input ~ 0
PD2
Text GLabel 7650 3600 0    47   Input ~ 0
PD3
Text GLabel 7650 1450 0    47   Input ~ 0
PD7
Text GLabel 7650 2350 0    47   Input ~ 0
PD6
Text GLabel 7650 3250 0    47   Input ~ 0
PD5
Text GLabel 7650 4150 0    47   Input ~ 0
PD4
$Comp
L DIODE D25
U 1 1 54186D23
P 8400 900
F 0 "D25" H 8400 800 40  0000 L BNN
F 1 "1N4148" H 8400 800 40  0001 C CNN
F 2 "" H 8400 900 60  0000 C CNN
F 3 "" H 8400 900 60  0000 C CNN
	1    8400 900 
	-1   0    0    1   
$EndComp
$Comp
L DIODE D24
U 1 1 54188891
P 8400 1050
F 0 "D24" H 8400 950 40  0000 L BNN
F 1 "1N4148" H 8400 950 40  0001 C CNN
F 2 "" H 8400 1050 60  0000 C CNN
F 3 "" H 8400 1050 60  0000 C CNN
	1    8400 1050
	-1   0    0    1   
$EndComp
$Comp
L DIODE D23
U 1 1 541888BF
P 8400 1200
F 0 "D23" H 8400 1100 40  0000 L BNN
F 1 "1N4148" H 8400 1100 40  0001 C CNN
F 2 "" H 8400 1200 60  0000 C CNN
F 3 "" H 8400 1200 60  0000 C CNN
	1    8400 1200
	-1   0    0    1   
$EndComp
$Comp
L DIODE D22
U 1 1 541888EE
P 8400 1350
F 0 "D22" H 8400 1250 40  0000 L BNN
F 1 "1N4148" H 8400 1250 40  0001 C CNN
F 2 "" H 8400 1350 60  0000 C CNN
F 3 "" H 8400 1350 60  0000 C CNN
	1    8400 1350
	-1   0    0    1   
$EndComp
$Comp
L DIODE D21
U 1 1 5418A030
P 8400 1800
F 0 "D21" H 8400 1700 40  0000 L BNN
F 1 "1N4148" H 8400 1700 40  0001 C CNN
F 2 "" H 8400 1800 60  0000 C CNN
F 3 "" H 8400 1800 60  0000 C CNN
	1    8400 1800
	-1   0    0    1   
$EndComp
$Comp
L DIODE D20
U 1 1 5418A036
P 8400 1950
F 0 "D20" H 8400 1850 40  0000 L BNN
F 1 "1N4148" H 8400 1850 40  0001 C CNN
F 2 "" H 8400 1950 60  0000 C CNN
F 3 "" H 8400 1950 60  0000 C CNN
	1    8400 1950
	-1   0    0    1   
$EndComp
$Comp
L DIODE D19
U 1 1 5418A03C
P 8400 2100
F 0 "D19" H 8400 2000 40  0000 L BNN
F 1 "1N4148" H 8400 2000 40  0001 C CNN
F 2 "" H 8400 2100 60  0000 C CNN
F 3 "" H 8400 2100 60  0000 C CNN
	1    8400 2100
	-1   0    0    1   
$EndComp
$Comp
L DIODE D18
U 1 1 5418A042
P 8400 2250
F 0 "D18" H 8400 2150 40  0000 L BNN
F 1 "1N4148" H 8400 2150 40  0001 C CNN
F 2 "" H 8400 2250 60  0000 C CNN
F 3 "" H 8400 2250 60  0000 C CNN
	1    8400 2250
	-1   0    0    1   
$EndComp
$Comp
L DIODE D17
U 1 1 5418A7C0
P 8400 2700
F 0 "D17" H 8400 2600 40  0000 L BNN
F 1 "1N4148" H 8400 2600 40  0001 C CNN
F 2 "" H 8400 2700 60  0000 C CNN
F 3 "" H 8400 2700 60  0000 C CNN
	1    8400 2700
	-1   0    0    1   
$EndComp
$Comp
L DIODE D16
U 1 1 5418A7C6
P 8400 2850
F 0 "D16" H 8400 2750 40  0000 L BNN
F 1 "1N4148" H 8400 2750 40  0001 C CNN
F 2 "" H 8400 2850 60  0000 C CNN
F 3 "" H 8400 2850 60  0000 C CNN
	1    8400 2850
	-1   0    0    1   
$EndComp
$Comp
L DIODE D15
U 1 1 5418A7CC
P 8400 3000
F 0 "D15" H 8400 2900 40  0000 L BNN
F 1 "1N4148" H 8400 2900 40  0001 C CNN
F 2 "" H 8400 3000 60  0000 C CNN
F 3 "" H 8400 3000 60  0000 C CNN
	1    8400 3000
	-1   0    0    1   
$EndComp
$Comp
L DIODE D14
U 1 1 5418A7D2
P 8400 3150
F 0 "D14" H 8400 3050 40  0000 L BNN
F 1 "1N4148" H 8400 3050 40  0001 C CNN
F 2 "" H 8400 3150 60  0000 C CNN
F 3 "" H 8400 3150 60  0000 C CNN
	1    8400 3150
	-1   0    0    1   
$EndComp
$Comp
L DIODE D13
U 1 1 5418AE20
P 8400 3600
F 0 "D13" H 8400 3500 40  0000 L BNN
F 1 "1N4148" H 8400 3500 40  0001 C CNN
F 2 "" H 8400 3600 60  0000 C CNN
F 3 "" H 8400 3600 60  0000 C CNN
	1    8400 3600
	-1   0    0    1   
$EndComp
$Comp
L DIODE D12
U 1 1 5418AE26
P 8400 3750
F 0 "D12" H 8400 3650 40  0000 L BNN
F 1 "1N4148" H 8400 3650 40  0001 C CNN
F 2 "" H 8400 3750 60  0000 C CNN
F 3 "" H 8400 3750 60  0000 C CNN
	1    8400 3750
	-1   0    0    1   
$EndComp
$Comp
L DIODE D11
U 1 1 5418AE2C
P 8400 3900
F 0 "D11" H 8400 3800 40  0000 L BNN
F 1 "1N4148" H 8400 3800 40  0001 C CNN
F 2 "" H 8400 3900 60  0000 C CNN
F 3 "" H 8400 3900 60  0000 C CNN
	1    8400 3900
	-1   0    0    1   
$EndComp
$Comp
L DIODE D10
U 1 1 5418AE32
P 8400 4050
F 0 "D10" H 8400 3950 40  0000 L BNN
F 1 "1N4148" H 8400 3950 40  0001 C CNN
F 2 "" H 8400 4050 60  0000 C CNN
F 3 "" H 8400 4050 60  0000 C CNN
	1    8400 4050
	-1   0    0    1   
$EndComp
Wire Wire Line
	1700 1600 1800 1600
Wire Wire Line
	1700 1000 1700 1600
Wire Wire Line
	950  1000 4950 1000
Wire Wire Line
	1800 1400 1700 1400
Connection ~ 1700 1400
Wire Wire Line
	1800 1300 1700 1300
Connection ~ 1700 1300
Wire Wire Line
	3700 2650 5100 2650
Wire Wire Line
	4550 1700 4550 1000
Connection ~ 4550 1000
Wire Wire Line
	4750 1700 4750 1000
Connection ~ 4750 1000
Wire Wire Line
	4550 2200 4550 2550
Connection ~ 4550 2550
Wire Wire Line
	4750 2650 4750 2200
Wire Wire Line
	1700 1900 1800 1900
Wire Wire Line
	1700 2450 1700 2300
Wire Wire Line
	3700 2750 4950 2750
Wire Wire Line
	4950 2200 4950 2850
Wire Wire Line
	4950 1000 4950 1700
Wire Wire Line
	4950 3450 4950 3650
Wire Wire Line
	1800 3400 1700 3400
Wire Wire Line
	1700 3400 1700 4000
Wire Wire Line
	1800 3500 1700 3500
Connection ~ 1700 3500
Wire Wire Line
	1800 3600 1700 3600
Connection ~ 1700 3600
Connection ~ 4950 2750
Wire Wire Line
	3700 1800 4050 1800
Wire Wire Line
	950  1150 950  1000
Connection ~ 1700 1000
Wire Wire Line
	1150 1150 1150 1000
Connection ~ 1150 1000
Wire Wire Line
	1400 1150 1400 1000
Connection ~ 1400 1000
Wire Wire Line
	950  1550 950  1700
Wire Wire Line
	950  1700 1400 1700
Wire Wire Line
	1400 1700 1400 1550
Wire Wire Line
	1150 1550 1150 1850
Connection ~ 1150 1700
Wire Wire Line
	4050 1150 4300 1150
Wire Wire Line
	3700 1600 3750 1600
Wire Wire Line
	3700 1700 3750 1700
Wire Wire Line
	4050 2400 4150 2400
Wire Wire Line
	3700 1300 3750 1300
Wire Wire Line
	3700 1400 3750 1400
Wire Wire Line
	3700 1500 3750 1500
Wire Wire Line
	3700 2550 5100 2550
Connection ~ 4750 2650
Wire Wire Line
	4050 1650 4050 2300
Wire Wire Line
	3700 2900 3750 2900
Wire Wire Line
	3700 3000 3750 3000
Wire Wire Line
	3700 3100 3750 3100
Wire Wire Line
	3700 3200 3750 3200
Wire Wire Line
	3700 3300 3750 3300
Wire Wire Line
	3700 3400 3750 3400
Wire Wire Line
	3700 3500 3750 3500
Wire Wire Line
	3700 3600 3750 3600
Wire Wire Line
	4050 2750 4050 2400
Connection ~ 4050 2750
Wire Wire Line
	4050 2300 4150 2300
Wire Wire Line
	4450 1950 4450 2250
Wire Wire Line
	4400 1950 4450 1950
Wire Wire Line
	3700 1900 4150 1900
Wire Wire Line
	4150 1900 4150 1750
Wire Wire Line
	4150 1750 4300 1750
Wire Wire Line
	3700 2000 4150 2000
Wire Wire Line
	4150 2000 4150 2150
Wire Wire Line
	4150 2150 4300 2150
Wire Wire Line
	3700 2150 3750 2150
Wire Wire Line
	3700 2250 3750 2250
Wire Wire Line
	3700 2350 3750 2350
Wire Wire Line
	3700 2450 3750 2450
Connection ~ 4050 1800
Wire Wire Line
	4300 1550 4300 1650
Wire Wire Line
	5450 1400 5450 1300
Wire Wire Line
	5650 1400 5650 1300
Wire Wire Line
	5850 1400 5850 1300
Wire Wire Line
	6050 1400 6050 1300
Wire Wire Line
	5250 1300 5250 1400
Wire Wire Line
	5250 1400 4950 1400
Connection ~ 4950 1400
Wire Wire Line
	7650 4150 8800 4150
Wire Wire Line
	8600 900  8700 900 
Wire Wire Line
	8700 900  8700 950 
Wire Wire Line
	8700 950  8800 950 
Wire Wire Line
	8600 1050 8800 1050
Wire Wire Line
	8600 1200 8700 1200
Wire Wire Line
	8700 1200 8700 1150
Wire Wire Line
	8700 1150 8800 1150
Wire Wire Line
	8600 1800 8700 1800
Wire Wire Line
	8700 1800 8700 1850
Wire Wire Line
	8700 1850 8800 1850
Wire Wire Line
	8600 1950 8800 1950
Wire Wire Line
	8600 1350 8700 1350
Wire Wire Line
	8700 1350 8700 1250
Wire Wire Line
	8700 1250 8800 1250
Wire Wire Line
	7650 1450 8800 1450
Wire Wire Line
	8600 2100 8700 2100
Wire Wire Line
	8700 2100 8700 2050
Wire Wire Line
	8700 2050 8800 2050
Wire Wire Line
	8600 2250 8700 2250
Wire Wire Line
	8700 2250 8700 2150
Wire Wire Line
	8700 2150 8800 2150
Wire Wire Line
	8600 2700 8700 2700
Wire Wire Line
	8700 2700 8700 2750
Wire Wire Line
	8700 2750 8800 2750
Wire Wire Line
	8600 2850 8800 2850
Wire Wire Line
	8600 3000 8700 3000
Wire Wire Line
	8700 3000 8700 2950
Wire Wire Line
	8700 2950 8800 2950
Wire Wire Line
	8600 3150 8700 3150
Wire Wire Line
	8700 3150 8700 3050
Wire Wire Line
	8700 3050 8800 3050
Wire Wire Line
	7650 3250 8800 3250
Wire Wire Line
	8600 3600 8700 3600
Wire Wire Line
	8700 3600 8700 3650
Wire Wire Line
	8700 3650 8800 3650
Wire Wire Line
	8600 3750 8800 3750
Wire Wire Line
	8600 3900 8700 3900
Wire Wire Line
	8700 3900 8700 3850
Wire Wire Line
	8700 3850 8800 3850
Wire Wire Line
	8600 4050 8700 4050
Wire Wire Line
	8700 4050 8700 3950
Wire Wire Line
	8700 3950 8800 3950
Wire Wire Line
	7650 3750 8200 3750
Wire Wire Line
	7650 3600 8200 3600
Wire Wire Line
	7650 3900 8200 3900
Wire Wire Line
	7650 4050 8200 4050
Wire Wire Line
	7750 900  7750 3600
Wire Wire Line
	7750 900  8200 900 
Connection ~ 7750 3600
Wire Wire Line
	7850 1050 7850 3750
Wire Wire Line
	7850 1050 8200 1050
Connection ~ 7850 3750
Wire Wire Line
	7950 1200 7950 3900
Wire Wire Line
	7950 1200 8200 1200
Connection ~ 7950 3900
Wire Wire Line
	8050 1350 8050 4050
Wire Wire Line
	8050 1350 8200 1350
Connection ~ 8050 4050
Wire Wire Line
	7650 2350 8800 2350
Wire Wire Line
	8200 1800 7750 1800
Connection ~ 7750 1800
Wire Wire Line
	8200 1950 7850 1950
Connection ~ 7850 1950
Wire Wire Line
	8200 2100 7950 2100
Connection ~ 7950 2100
Wire Wire Line
	8200 2250 8050 2250
Connection ~ 8050 2250
Wire Wire Line
	8200 2700 7750 2700
Connection ~ 7750 2700
Wire Wire Line
	8200 2850 7850 2850
Connection ~ 7850 2850
Wire Wire Line
	8200 3000 7950 3000
Connection ~ 7950 3000
Wire Wire Line
	8200 3150 8050 3150
Connection ~ 8050 3150
Text Notes 6100 4050 2    60   ~ 0
Arduino Pro Mini 328 - 5V/16MHz (SparkFun)
Wire Notes Line
	750  800  6250 800 
Wire Notes Line
	6250 800  6250 4200
Wire Notes Line
	6250 4200 750  4200
Wire Notes Line
	750  4200 750  800 
Wire Notes Line
	7300 700  9900 700 
Wire Notes Line
	9900 700  9900 4700
Wire Notes Line
	9900 4700 7300 4700
Wire Notes Line
	7300 4700 7300 700 
Text Notes 9700 4550 2    60   ~ 0
adjustment of the wake-up time 
$EndSCHEMATC
