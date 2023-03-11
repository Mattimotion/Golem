#include <Funken.h>
#include <Servo.h>
#define LED 2

// Funken library
// Download the Funken library here: https://github.com/astefas/Funken/tree/master/bin
// Install with Sketch > Include Library > Add .ZIP Library
Funken fnk;

boolean ledon = false;

Servo armServo;
Servo turntableServo;

void setup() {
  fnk.begin(9600, 0, 0); // higher baudrate for better performance
  fnk.listenTo("SERVOS", servocontrol); // however you want to name your callback
  fnk.listenTo("LED", ledcontrol);
  

  pinMode(LED, OUTPUT);
 

  armServo.attach(5);
  armServo.write(0);

  turntableServo.attach(7);
  turntableServo.write(0);

 
}

void loop() {

  fnk.hark();
  if(ledon) {
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }

  
}
 
void servocontrol(char *c) {

  // get first argument
  char *token = fnk.getToken(c); // is needed for library to work properly, but can be ignored

  // read servo value from serial port
  int servoValueTurn = atoi(fnk.getArgument(c));
  int servoValueArms = atoi(fnk.getArgument(c));
  turntableServo.write(servoValueTurn);
  armServo.write(servoValueArms);

}

void ledcontrol(char *c) {
  char *token = fnk.getToken(c);
  boolean ledOnCommand = atoi(fnk.getArgument(c));
  ledon = ledOnCommand;
}



    

 
