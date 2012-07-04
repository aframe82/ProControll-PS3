// This program is almost working
// The mapping of the PS3 controller works successfully,
// however when the data is sent to arduino, the serial.read
// function returns incorrect numbers

import procontroll.*;
import processing.serial.*;
import java.io.*;

Serial myPort;

ControllIO control;
ControllDevice device;
ControllSlider sliderX;
ControllSlider sliderY;

void setup(){
  size(255,255);
  
  myPort = new Serial(this, Serial.list()[1], 19200);
  
  control = ControllIO.getInstance(this);
  
  device = control.getDevice("PLAYSTATION(R)3 Controller");
  device.printSticks();
  device.printSliders();
  device.printButtons();
  device.setTolerance(0.1f);
  
  sliderX = device.getSlider("x");
  sliderY = device.getSlider("rz");
  sliderY.setMultiplier(100);
  sliderX.setMultiplier(100);
}

void draw(){
  background(255);

  float x = sliderX.getValue();// + width/2;
  int leftStick = int(map(x, -100, 100, 10, 99));
  //println(leftStick);
  
  float y = sliderY.getValue();// + height/2;
  int rightStick = int(map(y, -100, 100, 10, 99));
  //println(rightStick);
  
  String output = str(leftStick) + str(rightStick);
  
  int Output = int(output);
  
  println(output);
  //myPort.clear();
  myPort.write(output);
}
