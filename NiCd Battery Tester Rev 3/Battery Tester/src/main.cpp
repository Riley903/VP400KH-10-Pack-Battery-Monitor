
//  The program is for an arduino MEGA2560 based NiCd battery monitor and data logger
  
/* To DO  
 - Put the recording data in the ISR
 - Simplify the fuck out of this shit code
 - Get the current measurement working
 - Implement the cell status monitor
 - Possibly get a better display over I2C with more pixels
 - Implement the buzzer
 -
*/

// Include libraries needed for the project
#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <SPI.h>
#include <SD.h>
#include <Adafruit_ADS1X15.h>


File batfile;

// Initialize the LCD display
LiquidCrystal_I2C disp(0x27,20,4);

//
Adafruit_ADS1115 ads1115;	// Construct an ads1115 


// The prescaler value and timer count determine the timer frequency and, consequently, its interrupt rate.
// For a 16MHz clock and a desired 1 second interrupt rate, we can use:
// Prescaler = 256 and Timer count = 62500
// Timer frequency = 16MHz / 256 = 62500Hz, so a count to 62500 will give us 1 second.
#define TIMER_PRESCALER 256
#define TIMER_COUNT     62500

float GetVoltage(int AnalogInput, float comp);
void CellStatus (float CellVoltage, float CellHistory, int CellState, int g);
void I2C_Scanner();

// Initialize all the analog ports to be used, BV denotes Battery Voltage
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

// Shunt measurement on analog pin A10
int SHUNT = A10;

// Store analog sensors in an array for simplicity with a temp array that may be used for calculations.
int CellVoltages[10] = {BV1, BV2, BV3, BV4, BV5, BV6, BV7, BV8, BV9, BV10};
float tempCellVoltages[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float cellVoltageHistory[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

// These values are to compensate for the non-matching resistors used for the difference amplifier ((Vx+ - Vx-) ACTUAL VOLTAGE)
float compensation[10] = {1.0236,0.9932,1.01,0.9945,1.023,0.997,0.998,1.001,1.002,0.996};
float ShuntComp = 1;

// Initialize any digital pins to be used, RelayCont denotes a relay control signal.
// Cell Indication LED digital pinouts
int C1 = 13;
int C2 = 12;
int C3 = 11;
int C4 = 10;
int C5 = 9;
int C6 = 8;
int C7 = 7;
int C8 = 6;
int C9 = 5;
int C10 = 4;
int CellIndications[10] = {C1, C2, C3, C4, C5, C6, C7, C8, C9, C10};
int CellStates[10] = {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW};
int RelayCont = 30;                   
int displayBacklightEnable = 19;      // LCD Display Brightness Toggle
int buzzer = 3;                       // Buzzer
const byte buzzerToggle = 18;         // Buzzer toggle interrupt button

// Initialize any temporary or global values to be used
float temp = 0;                 // Global placeholder
float pwr = 0;                  // Value placeholder for the power input. Not relevant when AREF  Power voltage.
const int numReadings = 10;     // Number of readings for the analog input average function
float analogRef = 2.56;         // Analog reference voltage. This value is set in SETUP and is selectable. See Arduino AREF documentation
float OverVoltage = 1.65;       // Charging battery over voltage value, select best value based on battery behaviour or datasheet
float BatteryVolt = 0;          // Total battery voltage for a 10 cell pack
int counter = 0;                // Counter for battery history
int cell = 0;                   // placeholder for each cell
int Timer = 0;                  // Charge and Discharge Timer
float dischargeVolt = 1;        // Minimum discharge voltage per cell
float current = 0;              // Current measurment placeholder
int backlightEnable = HIGH;     // LCD Backlight variable
int buzzerButton = HIGH;        // Buzzer toggle button placeholder
int16_t adc0;                   // Placeholder for ADC0 channel of the ads1115 analog to digial converter
bool record = false;            // placeholder for recording event    



// Setup, runs once.
void setup() {
  
  // Initialize the LCD
  disp.init();
  disp.setBacklight(HIGH);

  // Set the Analog Reference Voltage 
  analogReference(INTERNAL2V56);

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

  // Initialize Timer1
  noInterrupts();           // Disable all interrupts
  TCCR1A = 0;               // Set entire TCCR1A register to 0
  TCCR1B = 0;               // Same for TCCR1B 
  TCNT1  = 0;               // Initialize counter value to 0
  // Set compare match register for 1hz increments
  OCR1A = TIMER_COUNT - 1;  // = (16*10^6) / (1*256) - 1 (must be <65536)
  // Turn on CTC mode (Clear Timer on Compare Match)
  TCCR1B |= (1 << WGM12);
  // Set CS12 and CS10 bits for 256 prescaler
  TCCR1B |= (1 << CS12);
  // Enable timer compare interrupt
  TIMSK1 |= (1 << OCIE1A);

  interrupts();             // Enable all interrupts


  // Initialize the pin modes for the LED Cell indications
  for (int i = 0; i < 10; i = i + 1) {
    pinMode(CellIndications[i], OUTPUT);
    digitalWrite(CellIndications[i], LOW);
  }

  // initialize the ads1115
  ads1115.begin(0x48);  // Initialize ads1115 at address 0x49
  ads1115.setGain(GAIN_TWOTHIRDS);  // 2/3x gain +/- 6.144V  (Voltage = ADS1115_Reported_Value/32767 *6.144)
  
  pinMode(displayBacklightEnable, INPUT);
  pinMode(RelayCont, OUTPUT);
  digitalWrite(RelayCont, LOW);
  pinMode(buzzer, OUTPUT);
  Serial.print("Clock\t"),Serial.print("Total\t"), Serial.print("BAT1\t"), Serial.print("BAT2\t"), Serial.print("BAT3\t"), Serial.print("BAT4\t"), Serial.print("BAT5\t"),
               Serial.print("BAT6\t"), Serial.print("BAT7\t"), Serial.print("BAT8\t"), Serial.print("BAT9\t"), Serial.println("BAT10\t");
}

// Main loop.
void loop() {

  // I2C_Scanner();

  // Read the voltages at each analog input and store into a temporary array.
  for (int i = 0; i < 10; i = i + 1) {
    tempCellVoltages[i] = GetVoltage(CellVoltages[i], compensation[i]);

    // Stored the values of each cell into an array that is captured every 10 seconds
    if (counter == 10) {
      for (int h = 0; h < 10; h = h + 1) {
        cellVoltageHistory[h] = tempCellVoltages[h];
      }
      counter = 0;
    }
  }

  /* 
  for(int i = 0; i < 10; i = i+1){
    CellStatus(tempCellVoltages[i],cellVoltageHistory[i], CellStates[i], i);  
    Serial.print(CellStates[i]);
    Serial.print("\n");
  }
  */

  // Current Measurement
  /* 
  - Assuming we have an ACS712-30A with a reading characteristic of 66 mv/A that is centered at 2.5V.
  - Assuming we have the ADS1115 16-bit analog reader set to single ended mode and 6.144V gain
  - For Max negative current ADS1115 would output (0.5V / 6.144V) * 32768 = 2773
  - For no current: The ACS712-30A would output 2.5V and the ADS1115 would output (2.5/6.144)*32768 = 13333
  - For Max positive current ADS1115 would output (4.5V / 6.144V) * 32768 = 24000
  - Thus to map the ADS1115 output to a current value:
    2773 = -30A
    13333 = 0A
    24000 = +30A
  For a rate of 353.78 units per Ampere from -30A to +30A
  */
 
  adc0 = ads1115.readADC_SingleEnded(0);
  // Serial.print("AIN0: ");
  // Serial.println(adc0);



  // Evaluate Total Battery Pack Voltage
  BatteryVolt = 0;
  for (int k = 0; k < 10; k = k + 1) {
    BatteryVolt = BatteryVolt + tempCellVoltages[k];
  }

  // 

  if(record == true){
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
    Serial.println();
    batfile.println();
    batfile.close();

    // backlightEnable = digitalRead(displayBacklightEnable);
    // if (backlightEnable == HIGH){
    //  disp.setBacklight(HIGH);
    // }else disp.setBacklight(LOW);
    
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

    // Delay since it is not required to measure the cell voltages at very high rates. Play with this number to suit requirements.
    Timer = Timer+1;
    record = false;
    counter = counter + 1;
  }
  
} // End main loop



ISR(TIMER1_COMPA_vect) { // This ISR will run every 1 second
  // Your code here to execute every second
  // This code should be quick and not use delay() or other blocking functions
  // Serial.println("Hello, Welcome to the ISR, Should appear every 1 second");
  // Serial.println();
  record = true;
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

  // Summing function. Takes the past numReadings amount of readings and sums them to be averaged.
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

// Function to determine the status of each cell. Checks for Over-voltage, Undervoltage, and Negative-Detla Voltage
void CellStatus (float CellVoltage, float CellHistory, int CellState, int g){

    // Check for Negative Delta Voltage
    // The value for the voltage drop when charging needs to be determined through experimentation
    if (CellVoltage == CellHistory - 0.05) {                     // Change value here for voltage drop value. 0.01 = 10mV
      digitalWrite(RelayCont, HIGH);                            // turn OFF charging circuit
      CellStates[g] = HIGH;
      cell = CellIndications[g];
      digitalWrite(cell, HIGH);                                 // Turn on LED indication for the cell
    } // NDV

    // Check for individual cell over-voltage
    if (CellVoltage == OverVoltage) {
      digitalWrite(RelayCont, HIGH);                            // turn OFF charging circuit
      CellStates[g] = HIGH;
      cell = CellIndications[g];
      digitalWrite(cell, HIGH);                                 // Turn on LED indication for the cell
    } // OVERVOLTAGE
    
    // Check for individual cell discharge voltage
    if (CellVoltage == dischargeVolt ) {
      digitalWrite(RelayCont, HIGH);                            // turn OFF charging circuit
      CellStates[g] = HIGH;
      cell = CellIndications[g];
      digitalWrite(cell, HIGH);                                 // Turn on LED indication for the cell
    } // UNDERVOLTAGE
    
    // Serial.print(Cell Status);

} // CellStatus

// scan the I2C bus for devices and report the address.
void I2C_Scanner(){
  
  byte error, address;
  int nDevices;

  Serial.println("Scanning...");

  nDevices = 0;
  for(address = 1; address < 127; address++ )
  {
    Wire.beginTransmission(address);
    error = Wire.endTransmission();

    if (error == 0)
    {
      Serial.print("I2C device found at address 0x");
      if (address < 16)
        Serial.print("0");

      Serial.print(address,HEX);
      Serial.println("  !");

      nDevices++;
    }
    else if (error==4)
    {
      Serial.print("Unknown error at address 0x");
      if (address < 16)
        Serial.print("0");

      Serial.println(address,HEX);
    }
  }

  if (nDevices == 0)
    Serial.println("No I2C devices found");
  else
    Serial.println("done");
}
