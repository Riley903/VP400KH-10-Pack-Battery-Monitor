EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A 11000 8500
encoding utf-8
Sheet 4 4
Title "NiCd Battery Tester"
Date "2021-04-01"
Rev "2A"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_01x02 J?
U 1 1 607DB33F
P 2300 1450
AR Path="/607DB33F" Ref="J?"  Part="1" 
AR Path="/607CEECB/607DB33F" Ref="J3"  Part="1" 
F 0 "J3" H 2450 1450 50  0000 C CNN
F 1 "9V" H 2450 1350 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_CUI_PJ-102AH_Horizontal" H 2300 1450 50  0001 C CNN
F 3 "~" H 2300 1450 50  0001 C CNN
	1    2300 1450
	-1   0    0    -1  
$EndComp
$Comp
L Device:CP C?
U 1 1 607DB345
P 3050 1600
AR Path="/607DB345" Ref="C?"  Part="1" 
AR Path="/607CEECB/607DB345" Ref="C8"  Part="1" 
F 0 "C8" H 3100 1700 50  0000 L CNN
F 1 "1uF" H 3100 1500 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 3088 1450 50  0001 C CNN
F 3 "~" H 3050 1600 50  0001 C CNN
	1    3050 1600
	1    0    0    -1  
$EndComp
Text Label 2950 1450 0    50   ~ 0
9V_POWER_FUSED
Text Label 2600 1750 0    50   ~ 0
GND
$Comp
L power:GND #PWR?
U 1 1 607DB34D
P 2600 1800
AR Path="/607DB34D" Ref="#PWR?"  Part="1" 
AR Path="/607CEECB/607DB34D" Ref="#PWR0113"  Part="1" 
F 0 "#PWR0113" H 2600 1550 50  0001 C CNN
F 1 "GND" H 2605 1627 50  0000 C CNN
F 2 "" H 2600 1800 50  0001 C CNN
F 3 "" H 2600 1800 50  0001 C CNN
	1    2600 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 1550 2600 1550
Wire Wire Line
	2600 1550 2600 1750
Wire Wire Line
	3050 1750 2600 1750
Connection ~ 2600 1750
Wire Wire Line
	2600 1750 2600 1800
Connection ~ 3050 1450
Text GLabel 3650 1450 2    50   Input ~ 0
9VDC_BUS
Wire Wire Line
	3050 1450 3650 1450
$Comp
L Device:Fuse_Small F?
U 1 1 607DB35B
P 2800 1450
AR Path="/607DB35B" Ref="F?"  Part="1" 
AR Path="/607CEECB/607DB35B" Ref="F12"  Part="1" 
F 0 "F12" H 2800 1550 50  0000 C CNN
F 1 "3A" H 2800 1350 50  0000 C CNN
F 2 "NiCd Battery Tester:1206_FUSE" H 2800 1450 50  0001 C CNN
F 3 "~" H 2800 1450 50  0001 C CNN
	1    2800 1450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2500 1450 2700 1450
Wire Wire Line
	2900 1450 3050 1450
Text GLabel 5100 2300 0    50   Input ~ 0
5V
$Comp
L Device:LED_Small D?
U 1 1 607E1CB8
P 5300 1800
AR Path="/607E1CB8" Ref="D?"  Part="1" 
AR Path="/607CEECB/607E1CB8" Ref="D2"  Part="1" 
F 0 "D2" H 5150 1850 50  0000 L CNN
F 1 "9V GREEN" H 5300 1700 50  0000 C CNN
F 2 "LED_THT:LED_D5.0mm" V 5300 1800 50  0001 C CNN
F 3 "~" V 5300 1800 50  0001 C CNN
	1    5300 1800
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 607E1CBE
P 5650 1800
AR Path="/607E1CBE" Ref="R?"  Part="1" 
AR Path="/607CEECB/607E1CBE" Ref="R50"  Part="1" 
F 0 "R50" V 5750 1800 50  0000 C CNN
F 1 "620R" V 5650 1800 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 5580 1800 50  0001 C CNN
F 3 "~" H 5650 1800 50  0001 C CNN
F 4 "C17972" H 5650 1800 50  0001 C CNN "LCSC"
	1    5650 1800
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED_Small D?
U 1 1 607E1CC4
P 5300 2300
AR Path="/607E1CC4" Ref="D?"  Part="1" 
AR Path="/607CEECB/607E1CC4" Ref="D4"  Part="1" 
F 0 "D4" H 5150 2350 50  0000 L CNN
F 1 "5V GREEN" H 5300 2200 50  0000 C CNN
F 2 "LED_THT:LED_D5.0mm" V 5300 2300 50  0001 C CNN
F 3 "~" V 5300 2300 50  0001 C CNN
	1    5300 2300
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 607E1CCA
P 5650 2300
AR Path="/607E1CCA" Ref="R?"  Part="1" 
AR Path="/607CEECB/607E1CCA" Ref="R51"  Part="1" 
F 0 "R51" V 5550 2300 50  0000 C CNN
F 1 "620R" V 5650 2300 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 5580 2300 50  0001 C CNN
F 3 "~" H 5650 2300 50  0001 C CNN
F 4 "C17972" H 5650 2300 50  0001 C CNN "LCSC"
	1    5650 2300
	0    1    1    0   
$EndComp
Text GLabel 5100 1800 0    50   Input ~ 0
9VDC_BUS
Wire Wire Line
	5200 1800 5100 1800
Wire Wire Line
	5100 2300 5200 2300
Wire Wire Line
	5400 2300 5500 2300
Wire Wire Line
	5400 1800 5500 1800
$Comp
L power:GND #PWR?
U 1 1 607E1CD5
P 5900 2300
AR Path="/607E1CD5" Ref="#PWR?"  Part="1" 
AR Path="/607CEECB/607E1CD5" Ref="#PWR0114"  Part="1" 
F 0 "#PWR0114" H 5900 2050 50  0001 C CNN
F 1 "GND" V 5905 2127 50  0000 C CNN
F 2 "" H 5900 2300 50  0001 C CNN
F 3 "" H 5900 2300 50  0001 C CNN
	1    5900 2300
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 607E1CDB
P 5900 1800
AR Path="/607E1CDB" Ref="#PWR?"  Part="1" 
AR Path="/607CEECB/607E1CDB" Ref="#PWR0115"  Part="1" 
F 0 "#PWR0115" H 5900 1550 50  0001 C CNN
F 1 "GND" V 5905 1627 50  0000 C CNN
F 2 "" H 5900 1800 50  0001 C CNN
F 3 "" H 5900 1800 50  0001 C CNN
	1    5900 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5900 1800 5800 1800
Wire Wire Line
	5800 2300 5900 2300
Text GLabel 7900 1600 0    50   Input ~ 0
DATA
Wire Wire Line
	7950 1600 7900 1600
Wire Wire Line
	8450 3700 8350 3700
Wire Wire Line
	8350 3600 8450 3600
Wire Wire Line
	8450 3500 8350 3500
Wire Wire Line
	8350 3400 8450 3400
Wire Wire Line
	8450 3300 8350 3300
Wire Wire Line
	8350 3200 8450 3200
$Comp
L power:GND #PWR?
U 1 1 607EAE3A
P 8350 3300
AR Path="/607EAE3A" Ref="#PWR?"  Part="1" 
AR Path="/607CEECB/607EAE3A" Ref="#PWR0116"  Part="1" 
F 0 "#PWR0116" H 8350 3050 50  0001 C CNN
F 1 "GND" V 8350 3100 50  0000 C CNN
F 2 "" H 8350 3300 50  0001 C CNN
F 3 "" H 8350 3300 50  0001 C CNN
	1    8350 3300
	0    1    1    0   
$EndComp
Text GLabel 8350 3200 0    50   Input ~ 0
5V
Text GLabel 8350 3700 0    50   Input ~ 0
CS
Text GLabel 8350 3600 0    50   Input ~ 0
SCK
Text GLabel 8350 3500 0    50   Input ~ 0
MOSI
Text GLabel 8350 3400 0    50   Input ~ 0
MISO
Wire Wire Line
	8150 1700 8450 1700
Wire Wire Line
	8250 1600 8450 1600
Wire Wire Line
	8150 1500 8450 1500
$Comp
L Device:R R?
U 1 1 607EAE48
P 8100 1600
AR Path="/607EAE48" Ref="R?"  Part="1" 
AR Path="/607CEECB/607EAE48" Ref="R52"  Part="1" 
F 0 "R52" V 8150 1400 50  0000 C CNN
F 1 "470R" V 8100 1600 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 8030 1600 50  0001 C CNN
F 3 "~" H 8100 1600 50  0001 C CNN
F 4 "C17936" H 8100 1600 50  0001 C CNN "LCSC"
	1    8100 1600
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 607EAE4E
P 8150 1700
AR Path="/607EAE4E" Ref="#PWR?"  Part="1" 
AR Path="/607CEECB/607EAE4E" Ref="#PWR0117"  Part="1" 
F 0 "#PWR0117" H 8150 1450 50  0001 C CNN
F 1 "GND" V 8155 1572 50  0000 R CNN
F 2 "" H 8150 1700 50  0001 C CNN
F 3 "" H 8150 1700 50  0001 C CNN
	1    8150 1700
	0    1    1    0   
$EndComp
Text GLabel 8150 1500 0    50   Input ~ 0
5V
$Comp
L Connector_Generic:Conn_01x03 J?
U 1 1 607EAE55
P 8650 1600
AR Path="/607EAE55" Ref="J?"  Part="1" 
AR Path="/607CEECB/607EAE55" Ref="J4"  Part="1" 
F 0 "J4" H 8730 1642 50  0000 L CNN
F 1 "NEOPIXEL" H 8730 1551 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 8650 1600 50  0001 C CNN
F 3 "~" H 8650 1600 50  0001 C CNN
	1    8650 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 2000 8450 2000
Wire Wire Line
	8450 2100 8350 2100
Wire Wire Line
	8350 2200 8450 2200
Wire Wire Line
	8450 2300 8350 2300
Text GLabel 8350 2300 0    50   Input ~ 0
SCL
Text GLabel 8350 2200 0    50   Input ~ 0
SDA
$Comp
L power:GND #PWR?
U 1 1 607EAE67
P 8350 2100
AR Path="/607EAE67" Ref="#PWR?"  Part="1" 
AR Path="/607CEECB/607EAE67" Ref="#PWR0118"  Part="1" 
F 0 "#PWR0118" H 8350 1850 50  0001 C CNN
F 1 "GND" V 8355 1972 50  0000 R CNN
F 2 "" H 8350 2100 50  0001 C CNN
F 3 "" H 8350 2100 50  0001 C CNN
	1    8350 2100
	0    1    1    0   
$EndComp
Text GLabel 8350 2000 0    50   Input ~ 0
5V
$Comp
L Connector_Generic:Conn_01x04 J?
U 1 1 607EAE7B
P 8650 2100
AR Path="/607EAE7B" Ref="J?"  Part="1" 
AR Path="/607CEECB/607EAE7B" Ref="J5"  Part="1" 
F 0 "J5" H 8730 2092 50  0000 L CNN
F 1 "LCD" H 8730 2001 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 8650 2100 50  0001 C CNN
F 3 "~" H 8650 2100 50  0001 C CNN
	1    8650 2100
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x06 J?
U 1 1 607EAE81
P 8650 3400
AR Path="/607EAE81" Ref="J?"  Part="1" 
AR Path="/607CEECB/607EAE81" Ref="J6"  Part="1" 
F 0 "J6" H 8600 3700 50  0000 L CNN
F 1 "SD CARD" V 8750 3200 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 8650 3400 50  0001 C CNN
F 3 "~" H 8650 3400 50  0001 C CNN
	1    8650 3400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H?
U 1 1 607EB9BE
P 6450 5750
AR Path="/607EB9BE" Ref="H?"  Part="1" 
AR Path="/607CEECB/607EB9BE" Ref="H1"  Part="1" 
F 0 "H1" H 6550 5796 50  0000 L CNN
F 1 "LCD PLACEHOLDER" H 6550 5705 50  0000 L CNN
F 2 "NiCd Battery Tester:20x4_LCD_BOUNDARY" H 6450 5750 50  0001 C CNN
F 3 "~" H 6450 5750 50  0001 C CNN
	1    6450 5750
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 607A7820
P 6450 6000
F 0 "H2" H 6550 6046 50  0000 L CNN
F 1 "MountingHole" H 6550 5955 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 6450 6000 50  0001 C CNN
F 3 "~" H 6450 6000 50  0001 C CNN
	1    6450 6000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID1
U 1 1 6084BDB9
P 6450 6250
F 0 "FID1" H 6535 6296 50  0000 L CNN
F 1 "Fiducial" H 6535 6205 50  0000 L CNN
F 2 "Fiducial:Fiducial_0.75mm_Mask1.5mm" H 6450 6250 50  0001 C CNN
F 3 "~" H 6450 6250 50  0001 C CNN
	1    6450 6250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID2
U 1 1 6084C468
P 6450 6450
F 0 "FID2" H 6535 6496 50  0000 L CNN
F 1 "Fiducial" H 6535 6405 50  0000 L CNN
F 2 "Fiducial:Fiducial_0.75mm_Mask1.5mm" H 6450 6450 50  0001 C CNN
F 3 "~" H 6450 6450 50  0001 C CNN
	1    6450 6450
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:Fiducial FID3
U 1 1 6084C659
P 6450 6650
F 0 "FID3" H 6535 6696 50  0000 L CNN
F 1 "Fiducial" H 6535 6605 50  0000 L CNN
F 2 "Fiducial:Fiducial_0.75mm_Mask1.5mm" H 6450 6650 50  0001 C CNN
F 3 "~" H 6450 6650 50  0001 C CNN
	1    6450 6650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
