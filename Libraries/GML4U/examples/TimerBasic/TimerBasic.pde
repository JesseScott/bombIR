/**
* GML4U library
* Author Jerome Saint-Clair
* http://saint-clair.net
*
* This example shows how to use a timer to draw GML 
* based on the GML's time information 
*
*/

import org.apache.log4j.PropertyConfigurator;

import gml4u.brushes.*;
import gml4u.drawing.*;
import gml4u.utils.*;
import gml4u.utils.Timer;
import gml4u.model.*;

Gml gml;
GmlBrushManager brushManager = new GmlBrushManager(this);
Timer timer = new Timer();

int timeMax = 30;

void setup() {
  size(600, 400, P3D);
  PropertyConfigurator.configure(sketchPath+"/log4j.properties");
   
  gml = GmlParsingHelper.getGml(sketchPath+"/sample.gml.xml", false);
  
  GmlUtils.timeBox(gml, timeMax, true);
  timer.start();
}

void draw() {
  background(0);
    timer.tick();
    brushManager.draw(gml, 600, timer.getTime());
}