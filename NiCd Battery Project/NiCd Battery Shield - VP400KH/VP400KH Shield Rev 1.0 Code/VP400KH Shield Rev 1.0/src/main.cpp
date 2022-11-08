/*
 * The program is for an arduino MEGA2560 based NiCd battery monitor and data logger
 * 
 * 
 */


// Include libraries needed for the project
#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <SPI.h>
#include <SD.h>
#include <Adafruit_NeoPixel.h>

File batfile;

// Initialize the LCD display
LiquidCrystal_I2C disp(0x27,20,4);

float GetVoltage(int AnalogInput, float comp);
void SetLEDs ();

// Initialize all the analog ports to be used, BV denotes "Battery Voltage"
// int since the Arduino analog inputs are 10-bit ADCs (1023)
int BV1 = A0;
int BV2 = A1;
int BV3 = A2;
int BV4 = A3;
int BV5 = A4;
int BV6 = A5;
int BV7 = A6;
int BV8 = A7;
int BV9 = A8;
int BV10 = A9;

// Store analog sensors in an array for simplicity with a temp array that may be used for calculations.
int CellVoltages[10] = {BV1, BV2, BV3, BV4, BV5, BV6, BV7, BV8, BV9, BV10};
float tempCellVoltages[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uint32_t CellStat[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

// These values are to compensate for the non-matching resistors used for the difference amplifier ((Vx+ - Vx-) /ACTUAL VOLTAGE)
float compensation[10] = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0};


// Initialize any digital pins to be used, RelayCont denotes a relay control signal.

int RelayCont = 4;                    // Relay Control

// Initialize any temporary or global values to be used
float temp = 0;                 // Global placeholder
const int numReadings = 10;     // Number of readings for the analog input average function
float analogRef = 2.56;         // Analog reference voltage. This value is set in "SETUP" and is selectable. See Arduino "AREF" documentation
float BatteryVolt = 0;          // Total battery voltage for a 10 cell pack
int Timer = 0;                  // Charge and Discharge Timer
int TimeToggle = 0;             // Timer Toggle
int oldTime = 0;                // placeholder for time
bool ChargeState;               // Placeholder for the charging state
bool LoadState;                 // Placeholder for the loading state

// NeoPixel Strip 
#define LED_PIN 2
#define LED_COUNT 10
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

// Setup, runs once.
void setup() {
  
  // Initialize the LCD
  disp.init();
  disp.setBacklight(LOW);

  // Set the Analog Reference Voltage 
  analogReference(INTERNAL2V56);

  // Set up timer
  cli();      // Disable interrrupts

  TCCR4A = 0;   // Set entire TCCR1A register to 0
  TCCR4B = 0;   // Set entire TCCR1B register to 0
  TCNT4 = 0;    // Initialize counter value to 0
  // set compare match register for 1hz increments
  OCR4A = 15624/1;  // (16*10^6) / (1*1024) - 1 (must be <65536)
  // turn on CTC mode
  TCCR4B |= (1 << WGM12);
  // Set CS12 and CS10 bits for 1024 prescaler
  TCCR4B |= (1 << CS12) | (1 << CS10);
  // enable timer compare interrupt
  TIMSK4 |= (1 << OCIE4A);

  sei();      // Enable Interrupts

  // Begin serial communication
  Serial.begin(9600);

  if (!SD.begin()){
    Serial.println("SD Card initialization failed");
    disp.setBacklight(HIGH);
    disp.setCursor(0,0), disp.print("SD CARD FAIL");
    // while(1);
  }

  batfile = SD.open("Battery.txt", FILE_WRITE);
  if(batfile){
    Serial.println("SD Card file successfully opened");
    batfile.println("BATTERY TEST VOLTAGES AND CURRENT");
    batfile.println("TIMER\tBATTERY\tCURRENT\tBAT1\tBAT2\tBAT3\tBAT4\tBAT5\tBAT6\tBAT7\tBAT8\tBAT9\tBAT10");
  }else{
    Serial.println("SD Card file opening error");
  }
  batfile.close();

  pinMode(RelayCont, OUTPUT);
  digitalWrite(RelayCont, LOW);
  Serial.print("Clock\t"),Serial.print("Total\t"), Serial.print("BAT1\t"), Serial.print("BAT2\t"), Serial.print("BAT3\t"), Serial.print("BAT4\t"), Serial.print("BAT5\t"),
               Serial.print("BAT6\t"), Serial.print("BAT7\t"), Serial.print("BAT8\t"), Serial.print("BAT9\t"), Serial.println("BAT10\t");

  // Neopixel Strip
  strip.begin();           // INITIALIZE NeoPixel strip object (REQUIRED)
  strip.show();            // Turn OFF all pixels ASAP
  strip.setBrightness(50); // Set BRIGHTNESS to about 1/5 (max = 255)
}

// Main loop.
void loop() {

  // Evaluate Total Battery Pack Voltage
  BatteryVolt = 0;
  for (int k = 0; k < 10; k = k + 1) {
    BatteryVolt = BatteryVolt + tempCellVoltages[k];
  }

  /* Check and set charging state
      - Check for undervoltage condition (cells are discharged or low charge)
        - Enable charge relay
        - Disable load relay (unless loading state active) 
      - Check for overvoltage condition (cells are charged too high)
        - Disable charge relay
      - Check for "Negative-Delta-Voltage" (cells are charged too high and too quickly)
        - Disable charge relay
  */

  /* Check and set loading state
      - 


  */

  // Check for 1Hz datalog
  if(TimeToggle != oldTime){
    oldTime = TimeToggle;

    Serial.print(Timer),Serial.print("\t");
    
    // Print the values to the serial monitor. This will change to a SD card storage device.
    batfile = SD.open("Battery.txt", FILE_WRITE);
    Serial.print(BatteryVolt), Serial.print("\t");
    batfile.print(Timer), batfile.print("\t");
    batfile.print(BatteryVolt), batfile.print("\t");
    batfile.print("curr"), batfile.print("\t");
    for (int j = 0; j < 10; j = j + 1) {
      temp = tempCellVoltages[j];
      Serial.print(temp), Serial.print("\t");
      batfile.print(temp), batfile.print("\t");
    }
    Serial.println("");
    batfile.println("");
    batfile.close();
    
    // Print the Values to the LCD Display
    disp.setCursor(0,0), disp.print("B"), disp.setCursor(1,0),disp.print(BatteryVolt);
    disp.setCursor(7,0), disp.print("C"), disp.setCursor(8,0),disp.print("curr");
    disp.setCursor(13,0), disp.print("10:"), disp.setCursor(16,0), disp.print(tempCellVoltages[9]);
    disp.setCursor(0,1), disp.print("9:"), disp.setCursor(2,1), disp.print(tempCellVoltages[8]);
    disp.setCursor(7,1), disp.print("8:"), disp.setCursor(9,1), disp.print(tempCellVoltages[7]);
    disp.setCursor(14,1), disp.print("7:"), disp.setCursor(16,1), disp.print(tempCellVoltages[6]);
    disp.setCursor(0,2), disp.print("6:"), disp.setCursor(2,2), disp.print(tempCellVoltages[5]);
    disp.setCursor(7,2), disp.print("5:"), disp.setCursor(9,2), disp.print(tempCellVoltages[4]);
    disp.setCursor(14,2), disp.print("4:"), disp.setCursor(16,2), disp.print(tempCellVoltages[3]);
    disp.setCursor(0,3), disp.print("3:"), disp.setCursor(2,3), disp.print(tempCellVoltages[2]);
    disp.setCursor(7,3), disp.print("2:"), disp.setCursor(9,3), disp.print(tempCellVoltages[1]);
    disp.setCursor(14,3), disp.print("1:"), disp.setCursor(16,3), disp.print(tempCellVoltages[0]);

    SetLEDs();

    // Delay since it is not required to measure the cell voltages at very high rates. Play with this number to suit requirements.
    Timer = Timer+1;
  }

}// End main loop

// 1 Hz Timer to record the data to the SD card and the serial bus
ISR(TIMER4_COMPA_vect){
 TimeToggle++;
}

// Function to update the RGB LED indicators of cell voltage
void SetLEDs (){

  // Read the voltages at each analog input and store into a temporary array.
  for (int i = 0; i < 10; i = i + 1) {
    tempCellVoltages[i] = GetVoltage(CellVoltages[i], compensation[i]);
    if(tempCellVoltages[i] < 1.0){
      CellStat[i] = strip.Color(255,   0,   0); // Red
    }else if(tempCellVoltages[i] >= 1.0 && tempCellVoltages[i] < 1.2){
      CellStat[1] = strip.Color(200,   255,   0);; // Yellow
    }else if(tempCellVoltages[i] >= 1.2 && tempCellVoltages[i] < 1.6){
      CellStat[i] = strip.Color(0, 255,   0); // Green
    }else if(tempCellVoltages[i] >= 1.6){
      CellStat[i] = strip.Color(255, 0,   255); // Purple
    }
  }

  for(uint8_t i =0; i<strip.numPixels(); i++){
    strip.setPixelColor(i,CellStat[i]);
    delay(1);
  }
  strip.show();
  
}


// Function to read the analog input of the requested pin. It then converts this analog reading to a voltage.
float GetVoltage(int AnalogInput, float comp) {

  // Temporary variables for calculations and placeholders
  int tot = 0;
  int values[numReadings];
  for (int j = 0; j < numReadings; j = j + 1) {
    values[j] = 0;
  }
  int index = 0;
  float avg = 0;

  // Summing function. Takes the past "numReadings" amount of readings and sums them to be averaged.
  for (int i = 0; i < numReadings; i = i + 1) {
    tot = tot - values[index];
    values[index] = analogRead(AnalogInput);
    values[index] = values[index] / comp;
    tot = tot + values[index];
    index = index + 1;
    delay(1); // Delay for analog reading stability
  }

  // Average the total and calculate the voltage.
  avg = tot / numReadings;
  avg = avg * analogRef;
  avg = avg / 1023;

  return avg;
}
