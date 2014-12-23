class Paddle{
  
  int w = padW; 
  int h = padH;
  int x = sW/2;
  int y = sH - padOff;
  
  Paddle() {  
  }
  
  //limit to screen size
  void update(){
    rect(x, y, w, h);
    x = (mouseX > sW - w) ? sW - w : mouseX;
  }
  
  //used to later get abPPos
  int getPos(){
    return x + w/2; 
  }
  
}

