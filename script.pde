// @rutherfordcraze made this
// You can use, modify, and redistribute it

// Edit these:
int width = 100; // How many characters wide the image should be
String src = "skull.png"; // PNG or JPG, must be square unless you're ok with it being distorted
String[] characters = {" ", "·", "+", "x", "◊", "G", "M"}; // Darker ones towards the end
boolean inverted = false; // Invert colours

// Don't edit these:
PImage img;
String op = "";


// Set up canvas
void settings() {
  size(width, width);
}

// Load and process the image
void setup() {
  img = loadImage(src);
  img.filter(GRAY);
  if(inverted) img.filter(INVERT);
  img.filter(POSTERIZE, characters.length);
  
  // Only run the thing once
  noLoop();
}

void draw() {
  background(0);
  image(img, 0, 0, width, width);

  // Set up the pixels[] array, containing a colour value for each pixel on the canvas 
  loadPixels();
  
  // Get a division number
  int rdiv = int(256 / characters.length);
  
  // Iterate through each pixel (this takes a while if it's a big image)
  for(int i = 0, l = pixels.length; i < l; i ++) {
    // Grab the red-channel value
    int r = int(red(pixels[i]));
    
    // Unless it's zero, divide it by the rdiv number to get a value between 0 and characters.length
    if(r != 0) r = r / rdiv;
    
    // Clamp it if it's out of range
    if(r >= characters.length) r = characters.length - 1;
    
    // Add the pixel's corresponding character to the output string
    op += characters[r];
  }
  
  // Set up output array
  String[] output = new String[width];
  
  // Put the output string into the output array, separated into lines
  for(int i = 0; i < width; i ++) {
    int cursor = width * i;
    output[i] = op.substring(cursor, cursor + width);
  }
  
  // Save the output array, one line at a time, into the output textfile
  saveStrings("output.txt", output);
}
