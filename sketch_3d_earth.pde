/*
Plotting of Data on 3D Globe using processing_3.3 
*/

//There may be memory issue while running code so first change preferences and set maximum memory to 2048 or higher

import java.util.ArrayList;            //Creates Arraylist for making insertion  and deletion eassy
import java.util.Locale;    

import peasy.*;                         //Peasy cam Library for rotaion of globe 

import processing.core.PApplet;
import processing.core.PShape;         //for creating objects

import processing.opengl.PGraphics3D;  //for creating graphics

int b=0;
int h=0;

PShader blur;

int amp2=0;
float noise1=0;
float noise2=0;

Table table;
Table main;                          //  Contains main database 
Table america;                       //  Contains data of all American States

String[] name1=new String[4000];     //  for loading names of Countries
String[] state1=new String[4000];    //  for loading names of American States
float[] lat1=new float[4000];        //  Contains latitude of Countries
float[] lon1=new float[4000];        //  Contains longitude of Countries
float[] lat2=new float[4000];        //  Contains latitude of American States
float[] lon2=new float[4000];        //  Contains latitude of Countries
float[] lat3=new float[4000];        //  Contains latitude(of total data)
float[] lon3=new float[4000];        //  Contains longitude(of total data)

int count3=0;                        //  Counter

PImage backdrop;                     //  Loads background image

int[] count2=new int[2500];          //  Second counter

int x=0;                             //  Variables for color Code
int i=0;
int t=0;
int amp=0;                           //  Amplitude  

PeasyCam cam;                        //  Creates peasy cam object 

float rad1=0;                        //  Radians for longitude and latitude
                    

int[] count1=new int[180];

PShape sun;                          //  Shape of Globe
PImage suntex;                       //  Surface

int[] totd4=new int[250];

PVector[] vecs = new PVector[1000];
 
void setup() 
{
  size(1024,900, P3D);
  int q=0;
  smooth(8);                               //  Smoothness of pixels
  
  cam = new PeasyCam(this, 6000);          //  Intialize peasy camera
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(50000);
  
  suntex = loadImage("712130main_8246931247_e60f3c09fb_o.jpg");         //  Surface of globe
  
  table = loadTable("Air.csv", "header");                                 //  LOADS data
  main=loadTable("LocationFilteredAirplane_Crashes_and_Fatalities_Since_1908 .csv","header");
  america=loadTable("Statae_LLocation_LongLAt.csv","header");
  
  noStroke();
  fill(255);
  sphereDetail(40);                                         //  Details of sphere

  sun = createShape(SPHERE, 1500);                          //  Creates sphere
  sun.setTexture(suntex);  


  for (int j=0; j<1000; j++) 
  {
     vecs[j] = new PVector(0,0,0);                          //  Adding vectors
  }
    
    
  println(table.getRowCount() + " total rows in table");         // prints the database
  println(main.getRowCount() + " total rows in table");
  println(america.getRowCount() + " total rows in table");
  
  for (TableRow row : table.rows()) 
  {
    t=0;
    x++;
    
   /*loads the data in the array variables*/
   
   float lon = row.getFloat("Longitude");
   float lat = row.getFloat("Latitude");
   int totd2 = row.getInt("Total Death");
   String name = row.getString("Name");
   
  /*
  Sorting the database
  Arranging data in corresponding variables
  counting and deleting the duplicate countries
  */
    for(i=0;i<=q;i++)
    {
      if(name.equals(name1[i])== true)
      { 
        t=1;
        count1[i]++;
        count2[i]+=totd2;
      }  
    }
  
    if(t==0)
    {
      count1[q]++;
    
      lon1[q]=lon;
      lat1[q]=lat;
    
      name1[q]=name;
      count2[q]+=totd2;
      q++;
    } 
    t=0;
  }
   
  for(int i=0;i<=5000;i++)
  {
    b=b+count1[i];
    
    if(name1[i]== null)
    {
      break;
    }
    
    println(i+1 + " " + name1[i] +" " + lon1[i]+" " +lat1[i] + "    " +count2[i] +"  "   );
  }
  
  for (TableRow row : america.rows())
  {
    String statesamer = row.getString("State");             //Adding American states in the data
    float lon4 = row.getFloat("Longitude");                 //Adding longitude 
    float lat4 = row.getFloat("Latitude");                  //Adding latitude
    state1[h]=statesamer;
    lon2[h]=lon4;
    lat2[h]=lat4;
    h++;
  }
  
  for (TableRow row : main.rows())
  {
    String state2 = row.getString("Location - Split 2");
    int totd3 = row.getInt("Total Death");
    
    for(int u=0;u<=50;u++)
    {
      
      if(state2.equals(state1[u])== true)
      {
        totd4[u]=totd4[u]+totd3;
      }
    }
  }
  
  for(int u=0;u<=50;u++)
  {
    println(u+176 + " " + state1[u] +" " + lon2[u]+" " +lat2[u] + "    " +totd4[u] +"  "  );
  }
  
 int p=0;
 
  for(int r=176;r<=230;r++)
  {
    name1[r]=state1[p];
    lon1[r]=lon2[p];
    lat1[r]=lat2[p];
    count2[r]=totd4[p];
    p++;
  }
  
  for(int r=0;r<=226;r++)
  {
    println(r+1 + " " + name1[r] +" " + lon1[r]+" " +lat1[r] + "    " +count2[r] +"  "   );
  }
  
  int f=0;;
  for(int r=0;r<=226;r++)
  {
    if(count2[r]>=6500 )
    {
      f++;
      println(f);
    }
  }
  frameCount=100;
}





void draw() 
{
  randomSeed(0);                  //  Makes the random variables fix corresponding to the first loop value 
  delay(30);
  background(0);                 
  stroke(255,0,0);
  strokeWeight(20);
  hint(DISABLE_DEPTH_MASK);
  hint(ENABLE_DEPTH_MASK);
  pushMatrix();                        //  Translates the matrix
  shape(sun);                          //  Loads the Sun
  popMatrix();
  
  for (int i=1; i<230;i++) 
  {
    amp=count2[i];
    stroke(255,0,255);
    
    if(amp<=500)
    {
      stroke(34,34,255);
    }
    
    strokeWeight(2);
    
    if(amp>=6500)                   //  Plotting 9/11 
    { 
      stroke(255,0,0);
      strokeWeight(4);
    }                             //  Plotting data using lines by its latitude and longitude
    
    line((2000+amp/10)*cos(radians(lat1[i]))*sin(radians(lon1[i]-90)),-(2000+amp/10)*sin(radians(lat1[i])),(2000+amp/10)*cos(radians(lat1[i]))*cos(radians(lon1[i]-90)),0,0,0);
    
    x=1;
  }
}