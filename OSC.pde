
//-----------------------------------------------------------------------------------------

public void oscEvent(OscMessage msg) {
  
  if(msg.checkAddrPattern("/Width") && msg.checkTypetag("f")) {
    float bS = map(msg.get(0).floatValue(), 0.1, 1.0, 1, 50);  
    brushSize = int(bS);
    //println("Got New Width... " + brushSize);
  }
  else if(msg.checkAddrPattern("/Red") && msg.checkTypetag("f")) {
    if(colorOSC == true) {
      float nR = map(msg.get(0).floatValue(), 0.1, 1.0, 1, 255);  
      brushR = int(nR);
      //println("Got New Red... " + brushR);
    }
  }
  else if(msg.checkAddrPattern("/Green") && msg.checkTypetag("f")) {
    if(colorOSC == true) {
      float nG = map(msg.get(0).floatValue(), 0.1, 1.0, 1, 255);  
      brushG = int(nG);
      //println("Got New Green... " + brushG);
    }
  }
  else if(msg.checkAddrPattern("/Blue") && msg.checkTypetag("f")) {
    if(colorOSC == true) {
      float nB = map(msg.get(0).floatValue(), 0.1, 1.0, 1, 255);  
      brushB = int(nB);
      //println("Got New Blue... " + brushB);
    }
  }
  else if(msg.checkAddrPattern("/saveMSG") && msg.checkTypetag("i")) {
    //println("Got Save Msg");
    saveMSG = msg.get(0).intValue();
    if(saveMSG == 1) {
      saveScreen = true;   
      saveMSG = 0;
    }
  }
  else if(msg.checkAddrPattern("/clearMSG") && msg.checkTypetag("i")) {
    //println("Got Clear Msg");
    clearMSG = msg.get(0).intValue();
    if(clearMSG == 1) {
      eraseAll();
      clearMSG = 0;
    }
  }
  else if(msg.checkAddrPattern("/xy") && msg.checkTypetag("ff")) {
    drawOSC = true;
    recX = msg.get(0).floatValue();
    recY = msg.get(1).floatValue();
    //println("Drawing from phone " + recX + " " + recY);
  }
  
  // CCV
  else if(msg.checkAddrPattern("/tuio/2Dcur")) {
    println("### received an osc message from CCV... ");
    println(" with the ADDRESS PATTERN " + msg.addrPattern());
    println(" & the TYPETAG " + msg.typetag());
    
    if(msg.checkTypetag("si")) {
      println("### received an osc message from SI... ");
      String firstValue   = msg.get(0).stringValue();  
      int    secondValue  = msg.get(1).intValue();
      drawOSC = true;
      //recX                = msg.get(2).floatValue();
      //recY                = msg.get(3).floatValue();
      println(" values: \t" + firstValue+ "\t " + secondValue);
      return;
    }  
  }  

 
} //--

//-----------------------------------------------------------------------------------------

