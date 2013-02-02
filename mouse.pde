
  //-----------------------------------------------------------------------------------------
  
  void mousePressed() {
    clicked = true;
    
    // Start recording if not already
    GmlBrush brush = new GmlBrush();
    brush.set(GmlBrush.UNIQUE_STYLE_ID, MeshDemo.ID);
    recorder.beginStroke(0, saveCount, brush);

    // Frame Counter
    frameCount = 0;
    currFrame = frameCount;

  }
  
  void mouseDragged () {
    clicked = true;
    
    // Set UI safe zone
    if(mouseY < height - menuHeight) {  
      
      // Frame Counter
      elapsedFrame = frameCount - currFrame;
      float eF = elapsedFrame / 100;
      String eff = nf(eF, 1, 2);
    
      // Add points to GML stroke
      Vec3D v = new Vec3D((float) mouseX/width, (float) mouseY/height, 0);
      recorder.addPoint(0, v, float(eff));
    }
  }
  
  void mouseReleased() {
    clicked = false;
    
    // End current GML stroke
    recorder.endStroke(0);
  }
  
  //-----------------------------------------------------------------------------------------
