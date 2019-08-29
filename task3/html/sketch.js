// a shader variable
let theShader;
let slider;
let size;
let vLabel;

function preload(){
  // load the shader
  theShader = loadShader('shader.vert', 'shader.frag');
}

function setup() {
  vLabel = createP('Vericies');
  slider = createSlider(2, 99, 2, 1);
  createP("Size");
  size = createSlider(0,1,0.5,0);
  // shaders require WEBGL mode to work
  createCanvas(windowWidth, windowHeight, WEBGL);
  noStroke();
}

function draw() {  
  // shader() sets the active shader with our shader
  shader(theShader);
  
  theShader.setUniform("u_resolution", [width, height]);
  theShader.setUniform("u_time", millis() / 1000.0);
  theShader.setUniform("u_mouse", [mouseX, map(mouseY, 0, height, height, 0)]);
  theShader.setUniform("N", slider.value());
  theShader.setUniform("Size", size.value());
  vLabel.html(slider.value());
  
  // rect gives us some geometry on the screen
  rect(0,0,width, height);
}

function windowResized(){
  resizeCanvas(windowWidth, windowHeight);
}