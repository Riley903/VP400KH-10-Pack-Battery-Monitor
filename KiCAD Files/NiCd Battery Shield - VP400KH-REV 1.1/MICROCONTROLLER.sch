EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A 11000 8500
encoding utf-8
Sheet 3 4
Title "MICROCONTROLLER"
Date "2021-06-24"
Rev "1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 4600 4600 0    50   Input ~ 0
SDA
Text GLabel 4600 4700 0    50   Input ~ 0
SCL
Text Label 4600 2000 0    50   ~ 0
5V
Text GLabel 4600 2800 0    50   Input ~ 0
DATA
Text GLabel 6000 1600 2    50   Input ~ 0
A0
Text GLabel 6000 1700 2    50   Input ~ 0
A1
Text GLabel 6000 1800 2    50   Input ~ 0
A2
Text GLabel 6000 1900 2    50   Input ~ 0
A3
Text GLabel 6000 2000 2    50   Input ~ 0
A4
Text GLabel 6000 2100 2    50   Input ~ 0
A5
Text GLabel 6000 2200 2    50   Input ~ 0
A6
Text GLabel 6000 2300 2    50   Input ~ 0
A7
Text GLabel 6000 2400 2    50   Input ~ 0
A8
Text GLabel 6000 2500 2    50   Input ~ 0
A9
Wire Wire Line
	6000 1600 5900 1600
Wire Wire Line
	5900 1700 6000 1700
Wire Wire Line
	6000 1800 5900 1800
Wire Wire Line
	5900 1900 6000 1900
Wire Wire Line
	6000 2000 5900 2000
Wire Wire Line
	5900 2100 6000 2100
Wire Wire Line
	6000 2200 5900 2200
Wire Wire Line
	5900 2300 6000 2300
Wire Wire Line
	6000 2400 5900 2400
Wire Wire Line
	5900 2500 6000 2500
Text GLabel 3600 2000 0    50   Input ~ 0
5V
Text GLabel 3600 2100 0    50   Input ~ 0
5V
Text GLabel 4600 2200 0    50   Input ~ 0
3V3
Text GLabel 4600 2300 0    50   Input ~ 0
3V3
Wire Wire Line
	4700 2200 4600 2200
Wire Wire Line
	4600 2300 4700 2300
$Comp
L power:GND #PWR?
U 1 1 607C35CD
P 4600 1800
AR Path="/607C35CD" Ref="#PWR?"  Part="1" 
AR Path="/607B886A/607C35CD" Ref="#PWR?"  Part="1" 
AR Path="/60829CC7/607C35CD" Ref="#PWR03"  Part="1" 
F 0 "#PWR03" H 4600 1550 50  0001 C CNN
F 1 "GND" V 4600 1600 50  0000 C CNN
F 2 "" H 4600 1800 50  0001 C CNN
F 3 "" H 4600 1800 50  0001 C CNN
	1    4600 1800
	0    1    1    0   
$EndComp
Wire Wire Line
	4600 1800 4700 1800
$Comp
L power:GND #PWR?
U 1 1 607C35D4
P 4600 1900
AR Path="/607C35D4" Ref="#PWR?"  Part="1" 
AR Path="/607B886A/607C35D4" Ref="#PWR?"  Part="1" 
AR Path="/60829CC7/607C35D4" Ref="#PWR04"  Part="1" 
F 0 "#PWR04" H 4600 1650 50  0001 C CNN
F 1 "GND" V 4600 1700 50  0000 C CNN
F 2 "" H 4600 1900 50  0001 C CNN
F 3 "" H 4600 1900 50  0001 C CNN
	1    4600 1900
	0    1    1    0   
$EndComp
Wire Wire Line
	4700 1900 4600 1900
Text GLabel 6000 5000 2    50   Input ~ 0
MISO
Text GLabel 6000 5100 2    50   Input ~ 0
MOSI
Text GLabel 6000 5200 2    50   Input ~ 0
SCK
Text GLabel 6000 5300 2    50   Input ~ 0
CS
Wire Wire Line
	6000 5000 5900 5000
Wire Wire Line
	5900 5100 6000 5100
Wire Wire Line
	6000 5200 5900 5200
Wire Wire Line
	5900 5300 6000 5300
Wire Wire Line
	4600 4600 4700 4600
Wire Wire Line
	4700 4700 4600 4700
Wire Wire Line
	4600 2800 4700 2800
Text GLabel 4600 2400 0    50   Input ~ 0
AREF
Wire Wire Line
	4600 2400 4700 2400
$Comp
L Device:R R?
U 1 1 607E607F
P 9500 5500
AR Path="/607E607F" Ref="R?"  Part="1" 
AR Path="/607B886A/607E607F" Ref="R?"  Part="1" 
AR Path="/60829CC7/607E607F" Ref="R42"  Part="1" 
F 0 "R42" V 9600 5550 50  0000 R BNN
F 1 "100K" V 9500 5500 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 9430 5500 50  0001 C CNN
F 3 "~" H 9500 5500 50  0001 C CNN
F 4 "C17900" H 9500 5500 50  0001 C CNN "LCSC"
	1    9500 5500
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R?
U 1 1 607E6085
P 9000 5500
AR Path="/607E6085" Ref="R?"  Part="1" 
AR Path="/607B886A/607E6085" Ref="R?"  Part="1" 
AR Path="/60829CC7/607E6085" Ref="R41"  Part="1" 
F 0 "R41" V 9100 5550 50  0000 R BNN
F 1 "150K" V 9000 5500 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 8930 5500 50  0001 C CNN
F 3 "~" H 9000 5500 50  0001 C CNN
F 4 "C17916" H 9000 5500 50  0001 C CNN "LCSC"
	1    9000 5500
	0    -1   -1   0   
$EndComp
Text GLabel 8750 5500 0    50   Input ~ 0
5V
$Comp
L power:GND #PWR?
U 1 1 607E60BA
P 9750 5500
AR Path="/607E60BA" Ref="#PWR?"  Part="1" 
AR Path="/607B886A/607E60BA" Ref="#PWR?"  Part="1" 
AR Path="/60829CC7/607E60BA" Ref="#PWR06"  Part="1" 
F 0 "#PWR06" H 9750 5250 50  0001 C CNN
F 1 "GND" V 9755 5327 50  0000 C CNN
F 2 "" H 9750 5500 50  0001 C CNN
F 3 "" H 9750 5500 50  0001 C CNN
	1    9750 5500
	0    -1   1    0   
$EndComp
Text GLabel 8750 5650 0    50   Input ~ 0
AREF
Wire Wire Line
	8750 5500 8850 5500
Wire Wire Line
	9150 5500 9250 5500
Wire Wire Line
	9650 5500 9750 5500
Wire Wire Line
	8750 5650 9250 5650
Wire Wire Line
	9250 5650 9250 5500
Connection ~ 9250 5500
Wire Wire Line
	9250 5500 9350 5500
$Comp
L NiCd-Battery-Tester-PCB-Rev-3-rescue:MEGA_2560_PRO_MINI-NiCd_Battery_Tester U4
U 1 1 608879FA
P 5300 3500
F 0 "U4" H 5300 5625 50  0000 C CNN
F 1 "MEGA_2560_PRO_MINI-NiCd_Battery_Tester" H 5300 5534 50  0000 C CNN
F 2 "NiCd Battery Tester:MEGA 2560 PRO MINI_NO_MOUNTS" H 5650 650 50  0001 C CNN
F 3 "" H 5650 650 50  0001 C CNN
	1    5300 3500
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP21
U 1 1 607AF268
P 3850 2000
F 0 "TP21" H 3900 2150 50  0000 L CNN
F 1 "5V" H 3900 2050 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D4.0mm_Drill2.0mm" H 4050 2000 50  0001 C CNN
F 3 "~" H 4050 2000 50  0001 C CNN
	1    3850 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 2000 4700 2000
Wire Wire Line
	3850 2000 3600 2000
Connection ~ 3850 2000
Wire Wire Line
	3600 2100 4700 2100
Text GLabel 4600 3000 0    50   Input ~ 0
CHARGE_CONTROL_SIGNAL
Wire Wire Line
	4700 3000 4600 3000
Text GLabel 4600 4400 0    50   Input ~ 0
STATUS_CHECK
Wire Wire Line
	4600 4400 4700 4400
Wire Wire Line
	9000 3900 8900 3900
Wire Wire Line
	8900 3800 9000 3800
Wire Wire Line
	9000 3700 8900 3700
Wire Wire Line
	8900 3600 9000 3600
Wire Wire Line
	9000 3500 8900 3500
Wire Wire Line
	8900 3400 9000 3400
$Comp
L power:GND #PWR?
U 1 1 60C9F7DF
P 8900 3400
AR Path="/60C9F7DF" Ref="#PWR?"  Part="1" 
AR Path="/607CEECB/60C9F7DF" Ref="#PWR?"  Part="1" 
AR Path="/6086926A/60C9F7DF" Ref="#PWR?"  Part="1" 
AR Path="/60829CC7/60C9F7DF" Ref="#PWR012"  Part="1" 
F 0 "#PWR012" H 8900 3150 50  0001 C CNN
F 1 "GND" V 8900 3200 50  0000 C CNN
F 2 "" H 8900 3400 50  0001 C CNN
F 3 "" H 8900 3400 50  0001 C CNN
	1    8900 3400
	0    1    1    0   
$EndComp
Text GLabel 8900 3500 0    50   Input ~ 0
5V
Text GLabel 8900 3900 0    50   Input ~ 0
CS
Text GLabel 8900 3800 0    50   Input ~ 0
SCK
Text GLabel 8900 3700 0    50   Input ~ 0
MOSI
Text GLabel 8900 3600 0    50   Input ~ 0
MISO
Wire Wire Line
	8900 2750 9000 2750
Wire Wire Line
	9000 2850 8900 2850
Wire Wire Line
	8900 2950 9000 2950
Wire Wire Line
	9000 3050 8900 3050
Text GLabel 8900 3050 0    50   Input ~ 0
SCL
Text GLabel 8900 2950 0    50   Input ~ 0
SDA
$Comp
L power:GND #PWR?
U 1 1 60C9F7F0
P 8900 2750
AR Path="/60C9F7F0" Ref="#PWR?"  Part="1" 
AR Path="/607CEECB/60C9F7F0" Ref="#PWR?"  Part="1" 
AR Path="/6086926A/60C9F7F0" Ref="#PWR?"  Part="1" 
AR Path="/60829CC7/60C9F7F0" Ref="#PWR011"  Part="1" 
F 0 "#PWR011" H 8900 2500 50  0001 C CNN
F 1 "GND" V 8905 2622 50  0000 R CNN
F 2 "" H 8900 2750 50  0001 C CNN
F 3 "" H 8900 2750 50  0001 C CNN
	1    8900 2750
	0    1    1    0   
$EndComp
Text GLabel 8900 2850 0    50   Input ~ 0
5V
$Comp
L Connector_Generic:Conn_01x04 J?
U 1 1 60C9F7F7
P 9200 2850
AR Path="/60C9F7F7" Ref="J?"  Part="1" 
AR Path="/607CEECB/60C9F7F7" Ref="J?"  Part="1" 
AR Path="/6086926A/60C9F7F7" Ref="J?"  Part="1" 
AR Path="/60829CC7/60C9F7F7" Ref="J14"  Part="1" 
F 0 "J14" H 9280 2842 50  0000 L CNN
F 1 "LCD" H 9280 2751 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 9200 2850 50  0001 C CNN
F 3 "~" H 9200 2850 50  0001 C CNN
	1    9200 2850
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x06 J?
U 1 1 60C9F7FD
P 9200 3600
AR Path="/60C9F7FD" Ref="J?"  Part="1" 
AR Path="/607CEECB/60C9F7FD" Ref="J?"  Part="1" 
AR Path="/6086926A/60C9F7FD" Ref="J?"  Part="1" 
AR Path="/60829CC7/60C9F7FD" Ref="J15"  Part="1" 
F 0 "J15" H 9150 3900 50  0000 L CNN
F 1 "SD CARD" V 9300 3400 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 9200 3600 50  0001 C CNN
F 3 "~" H 9200 3600 50  0001 C CNN
	1    9200 3600
	1    0    0    -1  
$EndComp
$EndSCHEMATC