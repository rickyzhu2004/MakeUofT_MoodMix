import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.serial.*;
import java.util.Random;

Serial myPort;
Minim minim;
AudioPlayer player;
int input_array[] = new int[3];
int size = 3;
int val;
boolean played = false;
boolean skip = false;
int random_index;
final String[] upbeat = {"Upbeat 1.mp3", "Upbeat 3.mp3", "Upbeat 4.mp3", "Upbeat 5.mp3", "Upbeat 6.mp3", "Upbeat 7.mp3", "Upbeat 8.mp3", "Upbeat 9.mp3", "Upbeat 10.mp3"};
final String[] chill = {"Chill 1.mp3", "Chill 2.mp3", "Chill 3.mp3", "Chill 4.mp3", "Chill 5.mp3", "Chill 6.mp3", "Chill 7.mp3", "Chill 8.mp3", "Chill 9.mp3", "Chill 10.mp3", "Chill 11.mp3", "Chill 12.mp3", "Chill 13.mp3"};
Random random = new Random();
int send;
long startTime;
long endTime;
long time = 0;

 
void setup()
{
  // In the next line, you'll need to change this based on your USB port name
  myPort = new Serial(this, "COM6", 9600);
  minim = new Minim(this);
  // Put in the name of your sound file below, and make sure it is in the same directory
  //player = minim.loadFile("music\\Upbeat_2(1).mp3");
  //delay(1000);
}
 
void draw() {
  for (int i = 0; i < size; i++){
    val = myPort.read();
    if (val > 0){
      input_array[i] = val;
      /*
      System.out.println(input_array[0]);
      System.out.println(input_array[1]);
      System.out.println(input_array[2]);
      */
    }
    delay(1000);
  }
  if (input_array[1] == 98) {
    random_index = random.nextInt(upbeat.length);
    player = minim.loadFile("music\\" + upbeat[random_index]);
    player.play();
    played = true;
  }
  else if (input_array[1] == 100) {
    random_index = random.nextInt(chill.length);
    player = minim.loadFile("music\\" + chill[random_index]);
    player.play();
    played = true;
  }
  if (input_array[2] == 113) {
    player.setGain(-10);
  }
  else if (input_array[2] == 108) {
    player.setGain(10);
  }
  /*
  if (input_array[0] == 116) { //true aka button is clicked
    played = false;
  }
  */
  if (played == true){
     startTime = System.currentTimeMillis();
     do {
      val = myPort.read();
      if (val > 0){
        for (int i = 0; i < size; i++){
        input_array[i] = val;
        //System.out.println(input_array[0]);
        //System.out.println(input_array[1]);
        //System.out.println(input_array[2]);
        }
       }
       //time++;
       endTime = System.currentTimeMillis();
       if (input_array[0] == 116){
         //System.out.println("HELLO");
         player.close();
         break;
       }
       System.out.println(endTime-startTime);
     } while ((endTime - startTime) < 120000 && input_array[0] != 116);
     played = false;
  }
}
