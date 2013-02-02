/*

//-----------------------------------------------------------------------------------------
// FRAME

public class PFrame extends Frame {
    public PFrame() {
        setBounds(SecondScreenOffset, 0, SecondScreenWidth, SecondScreenHeight);
        s = new secondApplet();
        add(s);
        removeNotify(); 
        setUndecorated(false);   
        setResizable(false);
        addNotify(); 
        setLocation(320, 0);
        s.init();
        //show();
        setVisible(true);
    }
}

//-----------------------------------------
// INIT

public void init() {
  frame.removeNotify(); 
  frame.setUndecorated(false);   
  frame.setResizable(false);
  frame.addNotify(); 
  super.init();
}


//-----------------------------------------
// 2ND SCREEN

public class secondApplet extends PApplet {
  
    public void setup() {
      size(SecondScreenWidth, SecondScreenHeight);
      background(0);

    }
 
    synchronized public void draw() {
      if(pg2 != null) {
        // Copy
        pg2.beginDraw();
          pg2.copy(pg, 0, 0, pg.width, pg.height, 0, 0, pg2.width, pg2.height);
        pg2.endDraw();
        image(pg2, 0, 0);
      }
    }
}

//-----------------------------------------------------------------------------------------

*/
