PImage image;


void setup() {
   size(1600, 900, P3D); 
   
   background(153);
   
   image = loadImage("image.jpg");
   
   rotateX(PI / 6);
   
   // camera(70.0, 35.0, 120.0, 50.0, 50.0, 0.0, 0.0, 1.0, 0.0);
}

void draw() {
   rotateX(PI / 5);
   image(image, 300, 0);
}
