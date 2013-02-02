
 //-----------------------------------------------------------------------------------------
 // CP5 
  
 // COLOR + SIZE
 
 void WIDTH(int BrushSize) {
    brushSize = (BrushSize);
  }
  
 void BRUSH_A(int BrushA) {
    brushA = (BrushA);
  } 
 
 // STYLES
 
 void CR(boolean theFlag) {
  if(theFlag == true) {
    brushMode = 1;
  }
 } 

 void FW(boolean theFlag) {
  if(theFlag == true) {
    brushMode = 2;
  }
 } 

 void LN(boolean theFlag) {
  if(theFlag == true) {
    brushMode = 3;
  }
 }

 void FC(boolean theFlag) {
  if(theFlag == true) {
    brushMode = 5;
  }
 }
 
void SP(boolean theFlag) {
  if(theFlag == true) {
    brushMode = 6;
  }
 }

 // CLEAR
 void CLEAR(boolean theFlag) {
  if(theFlag == true) {
    eraseAll();
  }
 }  
 
 // SAVE
  
 void SAVE(boolean theFlag) {
  if(theFlag == true) {
    saveScreen = true;
  }
 } 
 
 // DRIPS
 
 void DRIPS(boolean theFlag) {
    if(theFlag == true) {
      dripsIO = true;
    } else if (theFlag == false) {
      dripsIO = false;
    }
 }
  

