#include <Javino.h>         // https://javino.chon.group/
#include <LiquidCrystal.h>  // https://www.arduino.cc/reference/en/libraries/liquidcrystal/

// When using a physical arduino boar with the LCD Keypad Shield, uncomment the following:
  #define PinLCDCtrl01 4
  #define PinLCDCtrl02 5
  #define PinLCDCtrl03 6
  #define PinLCDCtrl04 7
  #define PinLCDRS     8
  #define PinLCDEN     9
  #define PinLCDLight  10


// When using a simulated arduino with the SimulIDE, uncomment the following:
/*
 #define PinLCDCtrl01 5
 #define PinLCDCtrl02 4
 #define PinLCDCtrl03 3
 #define PinLCDCtrl04 2
 #define PinLCDRS     11
 #define PinLCDEN     10
 #define PinLCDLight  12
*/
Javino javino;
LiquidCrystal lcd(PinLCDRS, PinLCDEN, PinLCDCtrl01, PinLCDCtrl02, PinLCDCtrl03, PinLCDCtrl04);
void(* softReset) (void) = 0;
unsigned long lastClick = 0;
unsigned long startCounter  = 0;
unsigned long rightNow = 0;
unsigned long randNumber = 0;
unsigned long duration=60000;

String strBtnPressed = "";
int counter=0;
boolean running=false;


void serialEvent(){
  javino.readSerial();
}

void setup() {
  pinMode(PinLCDLight, OUTPUT);
  digitalWrite(PinLCDLight, HIGH);
  lcd.begin(16, 2);
  writeInLCD("Press any key","(A0)");
  javino.perceive(getExogenousPerceptions);
   javino.act["startBench"]  = startBench;
  javino.start(9600);
}
 
void loop() {
 readLCDKeyboard();
 javino.run();
}



void getExogenousPerceptions(){
	if(running){
    lastClick = millis()-startCounter;
		if(lastClick<duration){
			counter++;
			writeInLCD(String(duration-lastClick));
      javino.addPercept("number("+String(counter)+")");
		}else{
			running=false;
      writeInLCD("PPM="+String(counter));
      javino.addPercept("result("+String(counter)+")");
      javino.sendPercepts();
      delay(5000);
      softReset();
		}
	}
}

void startBench(){
  running=true;
  counter=0;
  writeInLCD("Starting...");
  startCounter = millis();
}

void readLCDKeyboard(){ 
  strBtnPressed = getBtnPressed();
  if((strBtnPressed != "none" ) & (millis()>(lastClick+500))){
      lastClick = millis();
      if(strBtnPressed == "yes"){
		    startBench();
	   }     
  }
}



String getBtnPressed(){
//    int input = analogRead(A0);
    if(analogRead(A0) < 750) return "yes";
    else return "none"; 
}

void writeInLCD(String L1, String L2){
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print(L1);
    lcd.setCursor(0,1);
    lcd.print(L2);
  }

void writeInLCD(String L1){
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print(L1);
  }
