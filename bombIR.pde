
//-----------------------------------------------------------------------------------------
/*
 * bombIR
 * ---------------------------------------------------------------------------
 * Graffiti Research Lab Germany
 * http://www.graffitiresearchlab.de
 * ----------------------------------------------------------------------------
 * License:
 * Licensed according to the 
 * Attribution-Non-Commercial-Repurcussions 3.0 Unported (CC BY-NC 3.0)
 * as per http://www.graffitiresearchlab.fr/?portfolio=attribution-noncommercial-repercussions-3-0-unported-cc-by-nc-3-0
 * 
 * ----------------------------------------------------------------------------
 * Credits
 * _______
 * 
 * Programming:  
 *   Jesse Scott
 *   Hauke Altmann
 * 
 * Libraries:
 *  OscP5
 *  ControlP5
 *  GLGraphics
 *  GML4U
 *  ToxiLibs
 *  SimpleOpenNI
 * ----------------------------------------------------------------------------
 */
//-----------------------------------------------------------------------------------------

/*
TO DO
  
*/

// IMPORTS
//-----------------------------------------------------------------------------------------

import controlP5.*;

import oscP5.*;
import netP5.*;

import gml4u.brushes.*;
import gml4u.drawing.GmlBrushManager;
import gml4u.events.GmlEvent;
import gml4u.events.GmlParsingEvent;
import gml4u.model.GmlBrush;
import gml4u.model.GmlConstants;
import gml4u.model.GmlStroke;
import gml4u.model.Gml;
import gml4u.recording.GmlRecorder;
import gml4u.utils.GmlParser;
import gml4u.utils.GmlSaver;
import toxi.geom.Vec3D;
  
// DECLARATIONS
//-----------------------------------------------------------------------------------------  
ControlP5 cp5;  
OscP5 oscP5;
    
GmlRecorder recorder;
GmlParser parser;
GmlSaver saver;
GmlBrushManager brushManager;

PGraphics pg;
PGraphics pg2;
PGraphics cp;

//secondApplet s;
//PFrame f;

// GLOBAL VARIABLES
//-----------------------------------------------------------------------------------------

float brushR = 255;
float brushG = 255;
float brushB = 255; 
float brushA = 255;
int brushMode = 1;
int brushSize = 15;

boolean saveScreen = false;
boolean dripsIO = false;
boolean clicked = false;
int saveCount = 0;

Drop [] drips;
int numDrips = 0;

PImage logo, license;
float scale;
int UseOpenGL, UseSecondScreen;
int NumScreens;
int FirstScreenWidth, FirstScreenHeight, FirstScreenOffset; 
int SecondScreenWidth, SecondScreenHeight, SecondScreenOffset;
int ThirdScreenWidth, ThirdScreenHeight, ThirdScreenOffset;
float diam;
float currFrame = 0;
float elapsedFrame;
boolean drawOSC = false;
boolean colorOSC = true;

float recX, recY;
float drawX, drawY, drawXp, drawYp;
int saveMSG = 0;
int clearMSG = 0;

int menuHeight = 100;
int cpSize = int(menuHeight * 0.8);
int picker;

//-----------------------------------------------------------------------------------------
  
  void setup() {
    
    // Parse Settings
    String settings[] =  loadStrings("settings.txt");
    NumScreens         =  int(settings[0]);
    FirstScreenWidth   =  int(settings[1]);
    FirstScreenHeight  =  int(settings[2]);
    SecondScreenOffset =  int(settings[3]);
    SecondScreenWidth  =  int(settings[4]);
    SecondScreenHeight =  int(settings[5]);
    ThirdScreenOffset  =  int(settings[6]);
    ThirdScreenWidth   =  int(settings[7]);
    ThirdScreenHeight  =  int(settings[8]);
    
    for(int i = 0; i < settings.length; i++) {
      println("Settings Line " + i + " is " + settings[i]);  
    }
    
    // Screen stuff
    if(FirstScreenWidth < 800 || FirstScreenHeight < 600) {
      FirstScreenWidth = 800;
      FirstScreenWidth = 600;
    }
    
    size(FirstScreenWidth, FirstScreenHeight + menuHeight, JAVA2D);
    background(0);
    smooth();
    
    //frame.setLocation(0,0);
    //f = new PFrame();
    
    // Canvas
    pg  = createGraphics(FirstScreenWidth,  FirstScreenHeight, JAVA2D);  
    //pg2 = createGraphics(SecondScreenWidth, SecondScreenHeight,   JAVA2D);
    cp = createGraphics(cpSize, cpSize, JAVA2D); 
 
    // Drips
    drips = new Drop[6000];
    
    // OSC
    oscP5 = new OscP5(this, 3333);
    
    // GML
    Vec3D screen = new Vec3D(width, height, 0);
    scale = width;
    float minimumStrokeLength = 0.01f; // Default value when omitted
    float minimumPointsDistance = 0.001f; // Default value when omitted
    recorder = new GmlRecorder(screen, minimumStrokeLength, minimumPointsDistance);
    brushManager = new GmlBrushManager();
    saver = new GmlSaver(500, "", this);
    saver.start();    
    
    // Logo
    logo = loadImage("logo.png");
    
    // CP5
    cp5 = new ControlP5(this);
    cp5.addSlider("WIDTH", 1, 50, 15, 200, height - int(menuHeight * 0.75), menuHeight/4, menuHeight/2);
    cp5.addBang("CR", 250, height - int(menuHeight * 0.75), menuHeight/3, menuHeight/2);
    cp5.addBang("FW", 300, height - int(menuHeight * 0.75), menuHeight/3, menuHeight/2);
    cp5.addBang("LN", 350, height - int(menuHeight * 0.75), menuHeight/3, menuHeight/2);
    cp5.addBang("FC", 400, height - int(menuHeight * 0.75), menuHeight/3, menuHeight/2); 
    cp5.addBang("SP", 450, height - int(menuHeight * 0.75), menuHeight/3, menuHeight/2);
    cp5.addToggle("DRIPS", 500, height - int(menuHeight * 0.75), menuHeight/2, menuHeight/2);
    cp5.addBang(  "CLEAR", 600, height - int(menuHeight * 0.75), menuHeight/2, menuHeight/2);
    cp5.addBang(  "SAVE",  700, height - int(menuHeight * 0.75), menuHeight/2, menuHeight/2);
 
    // Colour Picker
    cp.beginDraw();
      cp.colorMode(HSB, cpSize);
      for (int i = 0; i < cpSize; i++) {
        for (int j = 0; j < cpSize; j++) {
          cp.stroke(i, j, i+j);
          cp.point(i, j);
        }
      }
    cp.endDraw();
    colorMode(RGB);

    
  } // end SETUP
  
  //-----------------------------------------------------------------------------------------
  
  void draw() {
    //int fps = round(frameRate); println("FPS " + fps);
    if(mouseY < height-menuHeight) {
      //noCursor();
    }
    else {
      cursor();
    }
    
    pg.beginDraw();
      pg.smooth();
      // Draw if mouse dragged
      if(clicked == true) {
        style();
      }
      // Draw Drips
      if(dripsIO == true) {
        for(int i = 0; i < numDrips; i++) {
          drips[i].drip();
          drips[i].show();
          drips[i].stopping();
        }
      }
    
      // Save Screen
      if(saveScreen == true) {
        saveCount ++;
        // save image w/o gui
        pg.save("exports/Save_" + saveCount + ".jpg");
        // save GML file
        saver.save(recorder.getGml(), sketchPath +"/exports/GML_" + saveCount + ".xml");
        saveScreen = false;
      }
    pg.endDraw();
    
    // Draw UI
    if(mouseY > height-menuHeight) {
      background(0);
      cp5.show(); 
      if(width > 800) {
        image(logo, 800, height - menuHeight * 1.2, 256, 154);
      }
      
      image(cp, 10, height - cpSize * 1.1);
      if(mouseX > 10 && mouseX < cpSize + 10) {
        if(mousePressed) {
          picker = get(mouseX, mouseY);
          brushR = red(picker);
          brushG = green(picker);
          brushB = blue(picker);
        } 
      }  
      fill(brushR, brushG, brushB);
      rect(cpSize * 1.25, height - cpSize * 1.1, cpSize, cpSize);
    }
    
    else if(mouseY < height-menuHeight) {
     background(0);
     cp5.hide(); 
    }
    cp5.draw(); // gui
    
    // Buffer Image
    image(pg, 0, 0);
    
  } // end DRAW
  
//-----------------------------------------------------------------------------------------

