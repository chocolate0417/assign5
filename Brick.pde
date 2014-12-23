class Brick{
  private int x, y;
  private boolean alive = true;
  //-1 for red min, 0 for regular white, 1 for green max paddle size
  int type = 0; 
  
  Brick(int xPos, int yPos){
    x = xPos;
    y = yPos;
  }
  
  Brick(int xPos, int yPos, int type){
    x = xPos;
    y = yPos;
    type = type;
  }
  
  int getXPos(){
   return x; 
  }
  
  int getYPos(){
   return y; 
  }
  
  boolean status(){
   return alive; 
  }
  
  void hit(){
   alive = false; 
  }
  
  void update(){
   if(alive){
     if (type == 0)
       fill(white);
     else if (type < 0)
       fill(red);
     else
       fill(blue);
     
     rect(x, y, sq - sp, sq - sp, 2);
   }
  }
}
