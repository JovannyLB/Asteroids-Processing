// Essa é a classe main, onde o jogo é "produzido"
nave jogador;
GameManager manager;
PImage bg;
int lives;
int points;

IntList valorAlturaBG = new IntList();
IntList valorLarguraBG = new IntList();

ArrayList<Bala> balas = new ArrayList<Bala>();

class GameManager{

  GameManager(){                                                         // Construtor para instanciação de variavei
    jogador = new nave();
  }
  
  void drawGame(){                                                       // Roda umas vez por frame, chama o update e manuseia o "desenho"
    fill(0, 35);                                                         // Desenha por cima da imagem com opacidade para dar o efeito de rastro
    rect(0, 0, width, height);
    fill(255);
    jogador.drawNave();                                                  // Chama o draw da nave
    for(int i = 0; i < balas.size(); i++){
      //bullets.get(i).edges();
      if(balas.get(i).update()){
        balas.remove(i);
      i--;
    }
    if(i < 0){
       break; 
    }
      balas.get(i).render();
      //if(bullets.get(i).checkCollision(asteroids)){
      //  bullets.remove(i);
      //  i--;
      //} 
    }
  }
  
  void drawBG(int quantidadeEstrela){
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
    manager.drawGame();
    text("PONTOS: " + points,700,50);
    text("VIDAS: " + lives,50,50);
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
