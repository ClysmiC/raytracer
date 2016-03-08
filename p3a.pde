// p3a: Ray Tracer
// author: Andrew Smith

// This is the starter code for the CS 3451 Ray Tracing project.
// The most important part of this code is the interpreter, which will
// help you parse the scene description (.cli) files.

// A global variable for holding current active file name.
// By default, the program reads in i0.cli, which draws a rectangle.

import java.util.ArrayList;
import java.util.List;

private String gCurrentFile = new String("i0.cli");
private List<Sphere> spheres;
private List<Light> lights;

private float fov;
private int backgroundColor;

void setup() {
  size(500, 500);  
  noStroke();
  colorMode(RGB, 1.0);
  background(0, 0, 0);
  
  spheres = new ArrayList();
  lights = new ArrayList();
  
  interpreter();
}

void reset_scene() {
  //reset global scene variables
}

void keyPressed() {
  reset_scene();
  switch(key) {
    case '1':  gCurrentFile = new String("i1.cli"); interpreter(); break;
    case '2':  gCurrentFile = new String("i2.cli"); interpreter(); break;
    case '3':  gCurrentFile = new String("i3.cli"); interpreter(); break;
    case '4':  gCurrentFile = new String("i4.cli"); interpreter(); break;
    case '5':  gCurrentFile = new String("i5.cli"); interpreter(); break;
    case '6':  gCurrentFile = new String("i6.cli"); interpreter(); break;
    case '7':  gCurrentFile = new String("i7.cli"); interpreter(); break;
    case '8':  gCurrentFile = new String("i8.cli"); interpreter(); break;
    case '9':  gCurrentFile = new String("i9.cli"); interpreter(); break;
  }
}

float get_float(String str) { return float(str); }

// this routine helps parse the text in a scene description file
void interpreter()
{
  println("Parsing '" + gCurrentFile + "'");
  String str[] = loadStrings(gCurrentFile);
  if (str == null) println("Error! Failed to read the file.");
  
  backgroundColor = color(0, 0, 0);
  
  for (int i=0; i<str.length; i++)
  {
    String[] token = splitTokens(str[i], " "); // Get a line and parse tokens.
    if (token.length == 0) continue; // Skip blank line.
    
    if (token[0].equals("fov"))
    {
      fov = get_float(token[1]);
    }
    else if (token[0].equals("background"))
    {
      float r = get_float(token[1]);
      float g = get_float(token[2]);
      float b = get_float(token[3]);
      
      backgroundColor = color(r, g, b);
    }
    else if (token[0].equals("light"))
    {
      float x =get_float(token[1]);
      float y =get_float(token[2]);
      float z =get_float(token[3]);
      float r =get_float(token[4]);
      float g =get_float(token[5]);
      float b =get_float(token[6]);
      
      lights.add(new Light(new PVector(x, y, z), r, g, b));
    }
    else if (token[0].equals("surface"))
    {
      float Cdr =get_float(token[1]);
      float Cdg =get_float(token[2]);
      float Cdb =get_float(token[3]);
      float Car =get_float(token[4]);
      float Cag =get_float(token[5]);
      float Cab =get_float(token[6]);
      float Csr =get_float(token[7]);
      float Csg =get_float(token[8]);
      float Csb =get_float(token[9]);
      float P =get_float(token[10]);
      float K =get_float(token[11]);
    }    
    else if (token[0].equals("sphere"))
    {
      float r =get_float(token[1]);
      float x =get_float(token[2]);
      float y =get_float(token[3]);
      float z =get_float(token[4]);
      
      spheres.add(new Sphere(new PVector(x, y, z), r));
    }
    else if (token[0].equals("begin"))
    {

    }
    else if (token[0].equals("vertex"))
    {
      float x =get_float(token[1]);
      float y =get_float(token[2]);
      float z =get_float(token[3]);
    }
    else if (token[0].equals("end"))
    {

    }
    else if (token[0].equals("rect"))
    {
                                          // this command demonstrates how the parser works
      float x =get_float(token[1]);       // and is not really part of the ray tracer
      float y =get_float(token[2]);
      float w =get_float(token[3]);
      float h =get_float(token[4]);
      fill (255, 255, 255);  // make the fill color white
      rect (x, y, w, h);     // draw a rectangle on the screne
    }
    else if (token[0].equals("write"))
    {
      draw_scene();   // this is where you actually perform the ray tracing
      println("Saving image to '" + token[1]+"'");
      save(token[1]); // this saves your ray traced scene to a PNG file
    }
  }
}

// This is where you should put your code for creating
// eye rays and tracing them.
void draw_scene() {
  clear();
  background(backgroundColor);
  
  float fovRad = (float)Math.toRadians(fov);
  
  float l = (float)Math.tan(fovRad/2f) * -1;
  float r = -l;
  
  //since aspect ratio is 1:1, we don't have to re-do this calculation
  float t = r;
  float b = l;
  
  for(int y = 0; y < height; y++)
  {
    for(int x = 0; x < width; x++)
    {
      float xRange = r - l;
      float yRange = t - b;
      
      float rayX = x + xRange * (x / xRange);
      float rayY = y + yRange * (y / yRange);
      float rayZ = -1;
      
      Ray ray = new Ray(new PVector(rayX, rayY, rayZ)); //constructor handles normalization
      Hit hit = ray.castRay(spheres);
      
      if(hit != null)
      {
        //set the pixel color
        fill (0, 0, 0);     // you should put the correct pixel color here
        rect (x, y, 1, 1);  // make a tiny rectangle to fill the pixel 
      }
    }
  }
}

void draw() {
  // nothing should be placed here for this project
}