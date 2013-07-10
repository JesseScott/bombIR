
//-----------------------------------------------------------------------------------------
// MENU + GUI CONTROL

int saveCount = 0;

 void CLEAR(boolean theFlag) {
  if(theFlag == true) {
    
    paintscreen.beginDraw();
    paintscreen.clear();
    paintscreen.image(paintbackground,0,0);
    paintscreen.endDraw();
    
    wallscreen.beginDraw();
    wallscreen.clear();
    wallscreen.endDraw();
  }
 }

 // SAVE
 void SAVE(boolean theFlag) {
  if(theFlag == true) {
     saveCount ++;
     // save image w/o gui
     wallscreen.save("exports/Save_" + saveCount + ".jpg");
  }
 } 

 //adjust brush size
 void WIDTH(int brushSize) {
    sprayManagerLeft.setWeight(brushSize);
    sprayManagerRight.setWeight(brushSize);
 } 
 
 
 // Set the position of the cropping area corners
 
 void cropScale(float cs) {      // defined in settings.properties
     float w = firstWindowWidth; // defined in settings.properties
     float h = windowHeight;
     corner.tlX = int( w / 2.0 * cs );
     corner.tlY = int( h / 2.0 * cs );
     corner.trX = int( w - ( w  / 2.0 * cs ) );
     corner.trY = int( h / 2.0 * cs );
     corner.brX = int( w - ( w  / 2.0 * cs ) );
     corner.brY = int( h - ( h  / 2.0 * cs ) );
     corner.blX = int( w / 2.0 * cs );
     corner.blY = int( h - ( h  / 2.0 * cs ) );
 }

 // Show Blob
 void showBlob() {
   if(calibrateCamera) {
     showBlob =! showBlob;
   }
   if(!calibrateCamera) {
     showBlob =! showBlob;
     background(0);
     drawPaintBg();
   }   
 }
 
 // Show Cam
 void showCam() {
   if(calibrateCamera) {
     showCam =! showCam;
   }
   if(!calibrateCamera) {
     showCam =! showCam;
     background(0);
     drawPaintBg();
   }   
 }
 
 // Save Calibration
 void saveCalib() {
   if(calibrateCamera) {
     background(0);
     calibrateCamera = false; 
     showCam = false;
     showBlob = false;
     drawPaintBg();
     calibMenu.hide();
     noCursor();
   }
 }
 
 void keyPressed() {
   switch(key) {
     case 'r': 
       // clear the paint screen (left)
       sprayManagerLeft.reset(paintscreen, bg); 
       // clear the wall screen (right)
       sprayManagerRight.reset(wallscreen, color(0));
     break;
     case 'm': 
       if(!calibrateCamera) {   
         toggleMenu();
         drawPaintBg();
       }
     break;
     case 'b':
       toggleBlobControl();
       if(calibrateCamera) {   
         background(0);
       }
       else {
         drawPaintBg();
       }
     break;     
   }
 }
   
 //show or hide the menu
 void toggleMenu(){
   if(menu.isVisible()){
     noCursor();
     menu.hide();
     background(0);
   }
   else {
     menu.show();
     cursor(CROSS);
   }
 }
 
 //show or hide blob control
 void toggleBlobControl(){
   if(calibMenu.isVisible()){
     capturePrev.hide();
     calibMenu.hide();
     background(0);
     noCursor();
   }
   else {
     capturePrev.show();
     calibMenu.show();

     cursor(CROSS);
   }
 }
