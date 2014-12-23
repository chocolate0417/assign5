
public int sW = 360;
public int sH = 570; 
public int rows = 5;
public int cols = 10;

private static int yOff = 15;
private static int xOff = 15;

//This should not be public, but rather in brick class! 
public int sq = (sW - xOff)/cols; 
public int sp = 10;

public int padW = 40;
public int padH = 5;
public int padOff = 40;
public int abPPos = 0;

//This should be in the ball class. Exposed by a get. 
public int diameter = 7;

public int score = 0;
public int lives = 3; 
public int level = 1; 
public int brickCount = rows * cols; 
public boolean gameBegin = false;

color red = #E64040;
color white = #FFFFFF;
color blue = #6666FF;


Paddle paddleOne = new Paddle();
Brick[] bricks = new Brick[rows * cols];
Ball ballOne = new Ball();

void setup() {
  size(sW, sH);
  background(0);
 
  for (int i = 0; i < cols; i++){
     for (int j = 0; j < rows; j++){
        bricks[i * rows + j] = new Brick(xOff + (i * sq), yOff + (j * sq));
     } 
  }
}

void keyPressed() {
 score = 0;
 lives = 3; 
 level = 1; 
 brickCount = rows * cols; 
 gameBegin = false;
 
 setup(); 
}

void mouseClicked(){
  if (!gameBegin){
     gameBegin = true;
     ballOne.startGame();
   }
 }
 
 
void gameOver(){  
  background(0);
  textSize(32);
  fill(red);
  textAlign(CENTER);
  text("Game Over", sW/2, sH/2);
  textSize(18);
  text("Score: " + score, sW/2, sH/2 + 40); 
  textSize(18);
  text("Press Enter to Restart", sW/2, sH/2 + 80); 
} 

void gameWin(){
  background(0);
  textSize(32);
  fill(blue);
  textAlign(CENTER);
  text("Win!", sW/2, sH/2);
  textSize(18);
  text("Score: " + score, sW/2, sH/2 + 40); 
  textSize(18);
  text("Press Enter to Restart", sW/2, sH/2 + 80); 
}

void draw() {
  background(0);
  
  ballOne.update();
  paddleOne.update();

  for (int i = 0; i < cols; i++){
     for (int j = 0; j < rows; j++){
      bricks[i * rows + j].update();
     } 
  }
  
  textSize(13);
  fill(red);
  text("Lives:", xOff, sH - padOff/3);
  
  for (int i = 0; i < lives; i++){
       fill(red);
       ellipse(xOff * i + 60, sH - padOff/2 + 2, 7, 7);
       
  }
  
  //Arbitrary offset 75.  Should find a way to know how large the text is.  
  textSize(13);
  fill(blue);
  text("Score: " + score , sW - xOff - 75, sH - padOff/3);
  
    
  int ballX = ballOne.getXPos();
  int ballY = ballOne.getYPos();
  int paddleX = paddleOne.getPos();
    
  //game over? 
  if (lives == 0){
   //Here we should have a gameOver method we call.  
    gameOver();
  }
  
  //game win?
  if (brickCount == 0){
   gameWin(); 
  }
  
  //TODO: Fix.  There is an error on the edges of screens. 
  //Ball hit wall 
  if (ballX <= diameter/2 || ballX >= sW - diameter/2){
    ballOne.horizontal();  
  }
  
  //Ball hit ceiling
  if (ballY < diameter/2){
    ballOne.vertical(); 
  }
  
  //Ball hit paddle
  
  if (ballY == sH - padOff - diameter/2 && (ballX + diameter/2 >= paddleX - padW/2 && ballX - diameter/2 <= paddleX + padW/2)){
    abPPos = ballX - paddleX;
    ballOne.paddle();    
  } 
  
  //Ball lost
  if (ballY > sH - padOff + diameter/2){
    gameBegin = false;
    ballOne.reset();
    lives -= 1;
  }
  
  //Sorry this is slow.  Probably should be implemented differently. 
  //TODO: FIX.  Does not properly hit blocks.   
 
  
  for (int i = 0; i < rows * cols; i++){
     if (bricks[i].status()){
       
       int brickY = bricks[i].getYPos();
       int brickX = bricks[i].getXPos();
       int side = sq - sp;
       
       //hits the tops or bottoms 
       if ((ballX - diameter/2 <= brickX + side && ballX + diameter/2 >= brickX) && 
               (ballY <= brickY + side && ballY >= brickY)){
                 println("ow");
                 ballOne.vertical();              
                 bricks[i].hit();
                 score += 10;
                 brickCount -= 1;
           }         
       
       //hits the sides 
       //TODO: FIX. shouldn't use elif because it's unfair, but using an if 
       //we don't update and we need to check status again.   
       else if ((ballY - diameter/2 <= brickY + side && ballY + diameter/2 >= brickY) && 
           (ballX <= brickX + side && ballX >= brickX)){
              println("hit");
              ballOne.horizontal();   
              bricks[i].hit();
              score += 10;
              brickCount -= 1;
           }   
  
           

     }  
    
  }
  
}

