
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
 *   Raphael de Courville
 * 
 * Libraries:
 *  keystone
 * ----------------------------------------------------------------------------
 */
//-----------------------------------------------------------------------------------------

/*
TO DO 
- use opencv for capturing the wall
- get aspect ratio of wallscreen for match the painting area
- saving of keystone configurations not working (yet)
  
*/

// IMPORTS
//-----------------------------------------------------------------------------------------
import deadpixel.keystone.*;


  
// DECLARATIONS
//-----------------------------------------------------------------------------------------  
Keystone ks;
CornerPinSurface surface;
PGraphics wallscreen, paintscreen, paintbackground;
PImage bg;

// GLOBAL VARIABLES
//-----------------------------------------------------------------------------------------



//-----------------------------------------------------------------------------------------
  
  void setup() {
        //P3D or OPENGL seems to only work with one window (https://forum.processing.org/topic/opengl-rendering-multiple-windows-frames), 
        //so we make it big enough to span over all three output devices (Laptop, rp screen projector, wall projector)
  		//size(3072, 768, P3D);
        //for testing with one screen
        size(1024, 256, P3D);
        //create painting screen
        paintscreen = createGraphics(340,256,P3D);
        //create background for painting screen
        paintbackground = createGraphics(340,256,P2D);
        bg = loadImage("background.jpg");
        //setup wall screen
		setupKeystone();
    
  } // end SETUP
  
  //-----------------------------------------------------------------------------------------
  
  void draw() {
   	PVector surfaceMouse = surface.getTransformedMouse();
        //draw background for painting screen
        paintbackground.beginDraw();
        paintbackground.image(bg,0,0);
        paintbackground.endDraw();
	
		//draw painting screen
        paintscreen.beginDraw();
        paintscreen.background(255,255,255,0);
        
        //example "painting"
        paintscreen.stroke(0,255,50);
        paintscreen.line(paintscreen.width*0.5, paintscreen.height*0.5, mouseX, mouseY);
        paintscreen.endDraw();
        
		//draw wall screen
        wallscreen.beginDraw();
        wallscreen.background(0);
        wallscreen.image(paintscreen,0,0); 
        wallscreen.endDraw();

		background(0);
        //draw background image
        image(paintbackground,0,0);
        //draw painting area
        image(paintscreen,0,0);
        //render the wall screen
		surface.render(wallscreen);
    
  } // end DRAW
  
  void keyPressed() {
  	switch(key) {
  		case 'c':
		    // enter/leave calibration mode, where surfaces can be warped 
		    // and moved
		    ks.toggleCalibration();
		    break;

  		case 'l':
		    // loads the saved layout
		    ks.load();
		    break;

		case 's':
			// saves the layout
		    ks.save();
		    break;
         }
  }
  
//-----------------------------------------------------------------------------------------

