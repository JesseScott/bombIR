
//-----------------------------------------------------------------------------------------

 void brushModes() {
    
    // Current Colour
    pg.stroke(brushR, brushG, brushB, brushA);
    pg.fill(brushR, brushG, brushB, brushA);
    pg.strokeWeight(brushSize);
    pg.strokeJoin(ROUND);
    
    if(mouseY < height-menuHeight && pmouseY < height-menuHeight) {
      // BRUSH MODES
      if(brushMode == 1) { // Circle Brush
        pg.ellipse(mouseX, mouseY, brushSize, brushSize);
      }
      
      if (brushMode == 2) { // FWD SLASH
        pg.line(pmouseX + brushSize, pmouseY - brushSize, mouseX - brushSize, mouseY + brushSize);
      }
      
      if (brushMode == 3) { // SIMPLE LINE
        if(pmouseY < height-menuHeight) {
          pg.line(mouseX, mouseY, pmouseX, pmouseY);
        }
      }
      
      if (brushMode == 4) { // OPEN
        
      }
      
      if (brushMode == 5) { // FAT CAP
                            // from http://www.openprocessing.org/visuals/?visualID=19923
                            // by USER http://www.openprocessing.org/portal/?userID=9333
        diam = abs(mouseY - height/2) * .125;
        pg.strokeWeight(diam);
        //pg.ellipse(mouseX, mouseY, diam, diam);
        pg.line(mouseX, mouseY, pmouseX, pmouseY);    
      }    
      
      if (brushMode == 6) { // GHETTO PAINT
                            // from http://www.openprocessing.org/visuals/?visualID=2369
                            // by USER http://www.openprocessing.org/portal/?userID=1641
        for(int i = 0; i < 15; i++) {
          float theta = random(0, 4 * PI);
          int radius = int(random(0, 30));
          int x = int(mouseX) + int(cos(theta)*radius);
          int y = int(mouseY) + int(sin(theta)*radius);
          pg.ellipse(x,y,0.5,0.5);
        }
      }  
    }
  }
  
  //-----------------------------------------------------------------------------------------
  

