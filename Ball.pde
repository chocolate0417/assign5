//We are on a grid where (0,0) is the top left corner

class Ball{
  int d = diameter;
  int x = mouseX + padW/2;
  int y = sH - padOff - padH;
  int xSpeed = 0;
  int ySpeed = 0;
  
  Ball(){
  }
  
  Ball(int xS, int yS){
   //why is the speed the same as the size?
    xSpeed = xS;
    ySpeed = yS;
  }
 
 int getXPos(){
   return x;
 }
 
 int getYPos(){
   return y;
 }
 
 void update() {
   fill(white);
   ellipse(x, y, d, d); 

   if (gameBegin){
     x += xSpeed;
     y += ySpeed;
   } else {
     y = sH - padOff - d/2;
     x = (mouseX > sW - padW) ? sW - padW/2 : mouseX + padW/2;
   }   
 }
  
 //This may be somewhat bad practice because the ball shouldn't need know these cases! 
 
 //Hit wall or sides of brick 
 void horizontal() {
  //Keep going in same y, opposite x
  xSpeed *= -1;
 } 
 
 //Hit ceiling or tops and bottoms of brick 
 void vertical(){
  ySpeed *= -1; 
 }
 
 void paddle() {
   //abPPos is the position of the ball relative to middle of paddle (negative on left)
   //change Y in opposite direction
   //change X depending on position of paddle 

  ySpeed *= -1; 
  xSpeed = abPPos/3;
 }
 
 void startGame(){
  ySpeed = -4;
  xSpeed = round(random(-5, 5));
 }
 
 void reset(){
  //lost ball! 
  int xSpeed = 0;
  int ySpeed = 0;
 } 
}
