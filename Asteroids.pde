// Essa é a classe main, onde o jogo é "produzido"
nave jogador;
GameManager manager;
PImage bg;
int lives;
int points;
int astNum = 15;
PVector pos, posAst;
float timer = 0;

IntList valorAlturaBG = new IntList();
IntList valorLarguraBG = new IntList();

ArrayList<Asteroid> brilhos = new ArrayList<Asteroid>();
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Bala> balas = new ArrayList<Bala>();

class GameManager{

  GameManager(){                                                         // Construtor para instanciação de variaveis
    posAst = new PVector();
    jogador = new nave();  //jogador
    for( int i=1; i<astNum; i++ ) {  //asteroids
      brilhos.add(new Asteroid(1,pos));
      asteroids.add(new Asteroid((int)random(1,4), pos));
    }
  }
  
  void drawGame(){                                                       // Roda umas vez por frame, chama o update e manuseia o "desenho"
    fill(0, 50);                                                         // Desenha por cima da imagem com opacidade para dar o efeito de rastro
    rect(0, 0, width, height);
    fill(255);           
    for(int i = 0; i<astNum; i++){
      try{
        brilhos.get(i).drawAsteroid();                   //Faz o BG piscar
        brilhos.get(i).formaAsteroid.beginShape();
        brilhos.get(i).formaAsteroid.stroke(0);
        brilhos.get(i).formaAsteroid.endShape();
        brilhos.get(i).drawAsteroid();
      }catch(Exception e){}
    }                                        // Chama o draw da nave
    jogador.drawNave();
    for(int i = 0; i<asteroids.size(); i++){
      try{
        
        asteroids.get(i).drawAsteroid();
        
        if (jogador.hits(asteroids.get(i).posicaoAsteroid, asteroids.get(i).rAst)){        //Se jogador bate em asteroid
          lives--;
          asteroids.remove(i);
        }
        
      }
      catch(Exception e){}
    }
    for(int j = 0; j < balas.size(); j++){
      //bullets.get(i).edges();
      if(balas.get(j).update()){
        balas.remove(j);
        j--;
      }
      if(j < 0){
       break; 
      }
      balas.get(j).render();
      for (int i = 0; i < asteroids.size(); i++){
        try{
          if (balas.get(j).hits(asteroids.get(i).posicaoAsteroid, asteroids.get(i).rAst)){  //Se bala bate em asteroid
            if(asteroids.get(i).astSize == 1){
              points += 10;  
              asteroids.remove(i);
              balas.remove(j);
            }else if(asteroids.get(i).astSize == 2){
              posAst.x = (asteroids.get(i).posicaoAsteroid.x);
              posAst.y = (asteroids.get(i).posicaoAsteroid.y);
              points += 15;
              balas.remove(j);
              asteroids.remove(i);
              asteroids.add(new Asteroid(1, posAst));
              asteroids.get(asteroids.size()+1).drawAsteroid();
              asteroids.add(new Asteroid(1, posAst));
              asteroids.get(asteroids.size()+1).drawAsteroid();
            }else if(asteroids.get(i).astSize == 3){
              posAst.x = (asteroids.get(i).posicaoAsteroid.x);
              posAst.y = (asteroids.get(i).posicaoAsteroid.y);
              points += 20;
              balas.remove(j);
              asteroids.remove(i);
              asteroids.add(new Asteroid(2, posAst));
              asteroids.get(asteroids.size()+1).drawAsteroid();
              asteroids.add(new Asteroid(2, posAst));
              asteroids.get(asteroids.size()+1).drawAsteroid();
            } //<>//
            posAst.x = 0;
            posAst.y = 0;
          }
        }
        catch(Exception e){}
      }
      /*if(balas.get(i).checkCollision(asteroids)){
        balas.remove(i);
        i--;
      }*/
    }
  }
  
  void drawBG(int quantidadeEstrela){
    noStroke();                                                            //  Edição noStroke() !!!!! //
    if(valorAlturaBG.size() < quantidadeEstrela && valorLarguraBG.size() < quantidadeEstrela){
      for(int i = 0; i < quantidadeEstrela; i++){
        valorAlturaBG.append((int) random(0, height));
      }
      for(int i = 0; i < quantidadeEstrela; i++){
        valorLarguraBG.append((int) random(0, width));
      } 
    }
    if(valorAlturaBG.size() > 0 && valorLarguraBG.size() > 0){
      for(int i = 0; i < quantidadeEstrela; i++){
        ellipse(valorLarguraBG.get(i), valorAlturaBG.get(i), 5, 5);
      }
    }
  }
}

void settings(){
  size(900, 600);
}

void setup(){ 
  lives = 3;
  points = 0;
  manager = new GameManager();
}

void draw(){
  if(lives > 0){
    manager.drawBG(100);
    if(jogador.refazerBG == true){
      valorAlturaBG.clear();
      valorLarguraBG.clear();
      jogador.refazerBG = false;
    }
    manager.drawGame();
    text("PONTOS: " + points,700,50);
    text("VIDAS: " + lives,50,50);
    if(timer+(5*1000) < millis()){
      asteroids.add(new Asteroid((int)random(1,4), null));
      asteroids.get(asteroids.size()-1).drawAsteroid();
      timer = millis();
      print(asteroids.size()+"\n");
    }
  }
  if(lives == 0){
    jogador.destruirNave();
  }
  
}



float heading2D(PVector pvect){
  return (float)(Math.atan2(pvect.y, pvect.x));  
}
void rotate2D(PVector v, float theta) {
  float xTemp = v.x;
  v.x = v.x*cos(theta) - v.y*sin(theta);
  v.y = xTemp*sin(theta) + v.y*cos(theta);
}
