  //-----------------------------------------------------------------------------------------
  
  void style() {
    
    if(mouseY < height-menuHeight) {
      brushModes();
      
      //println(mouseX - pmouseX);
      if(mouseX - pmouseX < 4 && mouseX - pmouseX > -4) {
        //println("DRIP");
        drip(); 
      } 
      
    }
    
  } 
  
 //-----------------------------------------------------------------------------------------
 
 
