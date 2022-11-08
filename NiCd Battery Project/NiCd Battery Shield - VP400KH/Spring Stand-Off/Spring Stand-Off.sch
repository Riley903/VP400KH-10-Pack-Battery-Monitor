EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A 11000 8500
encoding utf-8
Sheet 1 1
Title ""
Date "2021-06-08"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_01x01 J1
U 1 1 60BFE7EF
P 6200 3000
F 0 "J1" H 6280 3042 50  0000 L CNN
F 1 "KEYSTONE 240" H 6280 2951 50  0000 L CNN
F 2 "NiCd Battery Tester:KEYSTONE_240" H 6200 3000 50  0001 C CNN
F 3 "~" H 6200 3000 50  0001 C CNN
	1    6200 3000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 60BFEFCC
P 5500 2700
F 0 "H2" H 5600 2749 50  0000 L CNN
F 1 "M3" H 5600 2658 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm_Pad_Via" H 5500 2700 50  0001 C CNN
F 3 "~" H 5500 2700 50  0001 C CNN
	1    5500 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 2800 5500 3000
Wire Wire Line
	5500 3000 6000 3000
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 60BFFBBF
P 5200 2700
F 0 "H1" H 5300 2749 50  0000 L CNN
F 1 "M3" H 5300 2658 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm_Pad_Via" H 5200 2700 50  0001 C CNN
F 3 "~" H 5200 2700 50  0001 C CNN
	1    5200 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 2800 5200 3000
Wire Wire Line
	5200 3000 5500 3000
Connection ~ 5500 3000
$EndSCHEMATC