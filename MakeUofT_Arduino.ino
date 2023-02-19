char sendData[3];
const int TouchPin=2;
const int ledPin=3;
long sound = 0;
int count = 0;
int avg = 0;

 
void setup() {
  pinMode(TouchPin, INPUT);
  pinMode(ledPin,OUTPUT);
  Serial.begin(9600);
  delay(1000);
}
 
void loop() {
  int touchSensorValue = digitalRead(TouchPin);
  
  int lightValue = analogRead(A3);
  //Touch Sensor
  if(touchSensorValue==1)
  {
    digitalWrite(ledPin,HIGH);
    sendData[0] = 't'; //Touchdown
  }
  else
  {
    digitalWrite(ledPin,LOW); //No Touchdown
    sendData[0] = 'f';
  }
  
  //Store Light Value
  if (lightValue > 500){
    sendData[1] =  'b'; 
  }  
  else {
    sendData[1] =  'd';   
  }

  //LOUD 
  while (count < 32){
    for(int i=0; i<32; i++) {
      sound = analogRead(A0);
      avg += sound;
    }
    count++;  
  }
  count = 0;

  if ((avg/32) > 8000){
    sendData[2] = 'l';
  }
  else {
    sendData[2] = 'q'; 
  }
  avg = 0;

  for(int i = 0; i < sizeof(sendData); i++){
    Serial.print(sendData[i]);
    delay(1000);
  }
  

}
 
