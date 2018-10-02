
class Bala{
  PVector position, veloc;
  float bulletX;
  float bulletY;
  int radius = 5;
  int counter = 0;
  int timeout = 100;
  PImage img = loadImage("LazerBullet.png");
  
  public Bala(PVector pos, PVector vel){
    position = pos;
    veloc = vel;
  }
  
  public boolean update(){
    counter++;
    if(counter >= timeout){
      return true;
    }
    position.add(veloc);
    return false; 
  }
  void render(){
    pushMatrix();
    translate(position.x, position.y);
    rotate(heading2D(veloc)+PI/2);
    image(img, 0, 0, radius, radius*5); 
    popMatrix();
  }
}