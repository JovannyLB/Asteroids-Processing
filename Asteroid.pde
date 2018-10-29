class Asteroid{
  PVector posicaoAsteroid, posAst, dirAst;
  PShape formaAsteroid;
  int astSize, startPos;
  float yAsteroid, xAsteroid, velocity, tamanhoAst, rAst;
  
  Asteroid(int astSize, PVector _pos){
    dirAst = new PVector (50,50);
    formaAsteroid = createShape();
    formaAsteroid.beginShape();
    formaAsteroid.fill(0);
    formaAsteroid.strokeWeight(1.5);
    formaAsteroid.stroke(255);
    formaAsteroid.vertex(0,-5);
    formaAsteroid.vertex(3,-4);
    formaAsteroid.vertex(4,-4);
    formaAsteroid.vertex(5,-2);
    formaAsteroid.vertex(4,1);
    formaAsteroid.vertex(2,2);
    formaAsteroid.vertex(1,2);
    formaAsteroid.vertex(0,2.5);
    formaAsteroid.vertex(-2,2);
    formaAsteroid.vertex(-2,1);
    formaAsteroid.vertex(-3,0);
    formaAsteroid.vertex(-3,-2);
    formaAsteroid.vertex(-2,-4);
    formaAsteroid.vertex(-1,-4);
    formaAsteroid.vertex(0,-5);
    formaAsteroid.endShape();
    this.astSize = astSize;
    
    if (astSize == 1){
      xAsteroid = 25;
      yAsteroid = 15;
      rAst = 20;
      velocity = 1;
    }else if(astSize == 2){
      xAsteroid = 33.32;
      yAsteroid = 20;
      rAst = 26.5;
      velocity = 0.65;
    }else if(astSize == 3){
      xAsteroid = 50; 
      yAsteroid = 30;
      rAst = 40;
      velocity = 0.3;
    }
    //dando o ponto inicial do asteroid
    try{
      if (_pos == null){
        startPos = (int)random(1,5); //<>//
        if (startPos == 1 || startPos == 2){
          if(startPos == 1){                  //ocasiao 1 (direita)
            posicaoAsteroid = new PVector(width-1,random(1,height-1));
            dirAst.x = -velocity;
            dirAst.y = random(-velocity, velocity);
          }
          else{                               //ocasiao 2 (esquerda)
            posicaoAsteroid = new PVector(1,random(1,height-1));
            dirAst.x = velocity;
            dirAst.y = random(-velocity, velocity);
          }
        }
        else{
          if(startPos == 3){                  //ocasiao 3 (abaixo)
            posicaoAsteroid = new PVector(random(1,width), height-1);
            dirAst.y = -velocity;
            dirAst.x = random(-velocity, velocity);
          }
          else{                               //ocasiao 4 (acima)
            posicaoAsteroid = new PVector(random(1,width-1), 1);
            dirAst.y = velocity;
            dirAst.x = random(-velocity, velocity);
          }
        }
      }
      else{
        posicaoAsteroid = _pos;
        dirAst = new PVector((random(-velocity,velocity)),((random(-velocity,velocity))));
      }
    }catch(Exception ex){}
  }
  void drawAsteroid(){
    updateAsteroid();
    shape(formaAsteroid, posicaoAsteroid.x, posicaoAsteroid.y, xAsteroid,yAsteroid);
  }
  void updateAsteroid(){
    posicaoAsteroid.add(dirAst);
    
    posicaoAsteroid.x %= width;
    if(posicaoAsteroid.x < -10){
      posicaoAsteroid.x = width;
    }
    posicaoAsteroid.y %= height;
    if(posicaoAsteroid.y < -10){
      posicaoAsteroid.y = height;
    }
  }
}
/*
void timerAsteroid(float timer, float segundos){
  if(timer+(segundos*1000) < millis()){
    asteroids.add(new Asteroid((int)random(1,4), null));
    asteroids.get(asteroids.size()-1).drawAsteroid();
    timer = millis();
    print(asteroids.size()+"\n");
  }
}
*/
