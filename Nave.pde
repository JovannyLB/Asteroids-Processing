boolean[] teclas;                                                        // Array que guarda of valor das teclas apertadas

class nave{
  PVector aceleracaoNave, velocidadeNave, posicaoNave;                   // Vetores de aceleração, velocidade e posição são usados no movimento da nave
  PShape formaNave;                                                      // PShape é usado para criar o formato da nave
  float direcaoNave;                                                     // Guarda a rotação da nave
  int ultimoTiroNave;                                                    // Guarda o tempo e millis em que o ultimo tiro foi atirado
  int delayTempoNave;                                                    // Guarda o delay entre os tiros atirados
  boolean refazerBG;
  
  
  // O construtor principal da classe nave. Coloca os valores default nas variaveis e cria o formato da nave
  nave(){
    aceleracaoNave = new PVector();
    velocidadeNave = new PVector();
    posicaoNave = new PVector(width / 2, height / 2);
    direcaoNave = 0;
    refazerBG = false;
    ultimoTiroNave = 0;
    delayTempoNave = 300;
    teclas = new boolean[5];
    formaNave = createShape();                                            // A nave é criada com o centro em 0, 0 e é extremamente pequena
    formaNave.beginShape();                                               // Criar ela em 0, 0 garante que o ponto de rotação é no centro
    formaNave.fill(255);                                                  // Criar ela pequena da mais controle sobre escalar a nave
    formaNave.strokeWeight(1);
    formaNave.vertex(0, -4);
    formaNave.vertex(2, 0);
    formaNave.vertex(2, 2);
    formaNave.vertex(0, 1);
    formaNave.vertex(-2, 2);
    formaNave.vertex(-2, 0);
    formaNave.vertex(0, -4);
    formaNave.endShape();
  }
  
  
  // Manuseia o draw da nave primeiro atualizando a fisica, então zerando para 0, 0 sem rotação ou escala
  // A nave então é rodada baseada na variavel de rotação, e a é "desenhada" na posição guardade no vetor posicaoNave com sua escala apropriada
  void drawNave(){
    updateNave();
    formaNave.resetMatrix();
    formaNave.rotate(radians(direcaoNave));
    shape(formaNave, posicaoNave.x, posicaoNave.y, 10, 10);
  }
  
  
  // Termina o loop de Draw e mostra uma mensagem simples dizendo que o jogador perdeu
  void destruirNave(){
    fill(150);
    textAlign(CENTER, CENTER);
    textSize(72);
    noLoop();
    text("Você perdeu!", width / 2, height / 2);
  }
  
  
  // Adiciona aceleração se a tecla W esteja apertada basiada na direção. Atualiza a rotação baseada nos botões e adiciona velocidade arrastada
  // Também manuseia o envolvimento de tela
  void updateNave(){
    aceleracaoNave.x = 0;
    aceleracaoNave.y = 0;
    if(teclas[0]){
      aceleracaoNave.x = 0.5 * cos(radians(direcaoNave) - PI / 2);
      aceleracaoNave.y = 0.5 * sin(radians(direcaoNave) - PI / 2);
    }
    if(teclas[1] && !teclas[2]){
      direcaoNave -= 5;
    }
    if(teclas[2] && !teclas[1]){
      direcaoNave += 5;
    }
    velocidadeNave.add(aceleracaoNave);
    posicaoNave.add(velocidadeNave);
    velocidadeNave.mult(.95);
    posicaoNave.x %= width;
    if(posicaoNave.x < -10){
      refazerBG = true;
      posicaoNave.x = width; //<>//
    }
    if((posicaoNave.x + 5) > width){
      refazerBG = true;
      posicaoNave.x = width;
    }
    posicaoNave.y %= height;
    if(posicaoNave.y < -10){
      refazerBG = true;
      posicaoNave.y = height; //<>//
    }
    if((posicaoNave.y + 5) > height){
      refazerBG = true;
      posicaoNave.y = height;
    }
    if(teclas[4]){
      if(millis() - ultimoTiroNave > delayTempoNave){
        ultimoTiroNave = millis();        
        PVector testeP = new PVector(posicaoNave.x, posicaoNave.y);
        PVector vel  = new PVector(0, -10);
        rotate2D(vel, radians(direcaoNave));
        balas.add(new Bala(testeP, vel));
      }
      
    }
    
  }
  
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == UP)     teclas[0]  = true;
    if(keyCode == LEFT)   teclas[1]  = true;
    if(keyCode == RIGHT)  teclas[2]  = true;
    if(keyCode == DOWN)   teclas[3]  = true;
  }
  else{
    if(key == 'w') teclas[0] = true;
    if(key == 'a') teclas[1] = true;
    if(key == 'd') teclas[2] = true;
    if(key == 's') teclas[3] = true;
    if(key == ' ') teclas[4] = true;
  }
}

void keyReleased(){
  if(key == CODED){
    if(keyCode == UP)     teclas[0] = false;
    if(keyCode == LEFT)   teclas[1] = false;
    if(keyCode == RIGHT)  teclas[2] = false;
    if(keyCode == DOWN)   teclas[3] = false;
  }
  else{
    if(key == 'w') teclas[0] = false;
    if(key == 'a') teclas[1] = false;
    if(key == 'd') teclas[2] = false;
    if(key == 's') teclas[3] = false;
    if(key == ' ') teclas[4] = false;
  }
}
