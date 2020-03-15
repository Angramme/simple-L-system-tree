
long seed;
PFont mono;

void setup(){
  size(740, 580);
  
  seed = (long)random(0, 50000);
  
  mono = createFont("junegull.ttf", 20);
}

void draw(){
  translate(width/2, height);
  rotate(PI);
  
  background(250, 260, 255);
  
  randomSeed(seed);
  
  stroke(181, 101, 85, 100);
  strokeWeight(5);
  
  line(0,0,0,50);
  float growth = .5+.5*sin(millis()*.001);
  
  part( (int)lerp(1,9,growth) , 0, 50, 
    80, .8, 
    PI/2, PI/8, PI/24, 
    -.1, 
    .4, PI/20,
    (growth*8)%1);
  
  rotate(PI);
  textFont(mono);
  text("Made by Angramme fall 2019", -width/2+5, -5);
  fill(252, 38, 77);
}

void part(int n_left, 
  float x, float y, 
  float R, float r_scale,
  float m_ang, float s_ang, float tilt, 
  float skew, 
  float r_rand, float a_rand,
  float growth){
    
  n_left--;
    
  if(n_left==0)R *= growth; 
   
  //branches polar coords
  float b1a = m_ang+s_ang+tilt +random(-a_rand, a_rand);
  float b1r = R*(1+skew)*random(1-r_rand, 1+r_rand);
  float b2a = m_ang-s_ang+tilt +random(-a_rand, a_rand);
  float b2r = R*(1-skew)*random(1-r_rand, 1+r_rand);
  
  //branches cartesian coords
  float b1x = x+cos(b1a)*b1r;
  float b1y = y+sin(b1a)*b1r;
  float b2x = x+cos(b2a)*b2r;
  float b2y = y+sin(b2a)*b2r;
    
  //draw branches
  line(x, y, b1x, b1y);
  line(x, y, b2x, b2y);
  
  //recursion
  if(n_left > 0){
    float seed1 = random(0, 10000);
    float seed2 = random(0, 10000);
    
    randomSeed((long)seed1);
    part(n_left, b1x, b1y, 
      R*r_scale*(1+skew), r_scale, 
      m_ang+s_ang+tilt, s_ang, tilt,
      skew, 
      r_rand, a_rand,
      growth);
    
    randomSeed((long)seed2);
    part(n_left, b2x, b2y, 
      R*r_scale*(1-skew), r_scale, 
      m_ang-s_ang+tilt, s_ang, tilt,
      skew,
      r_rand, a_rand,
      growth);
  }
  
  //leaves
  if(n_left==0){
    leaves(b1x, b1y, 1);
    leaves(b2x, b2y, 1);
    leaves(x, y, 1);
  }else if(n_left<2){
    leaves(x, y, 1);
  }else if(n_left==2){
    leaves(x, y, 1-growth);
  }
  
}

void leaves(float x, float y, float alpha){
  pushStyle();
  noFill();
  stroke(252, 38, 77, alpha*255);
  circle(x, y, 10);
  popStyle();
}
