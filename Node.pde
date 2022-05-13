class Node{
  int x;
  int y;
  int type;
  boolean visible = false;
  boolean permvisible = false;
  
  public Node(int x, int y, int type){
    this.x = x;
    this.y = y;
    this.type = type;
  }
  
  void Draw(){
    if(visible){
      switch(type){
        case 1:
          fill(40);
        break;
        case 2:
          fill(20, 130, 15);
        break;
        case 3:
          fill(40, 35, 150);
        break;
        case 4:
          fill(140, 20, 25);
        break;
        case 5:
          fill(random(0,256), random(0,256), random(0,256));
        break;
      }
      if(won)
        fill(random(0,256), random(0,256), random(0,256));
      rect(x,y,mapscale,mapscale);
      if(visible && !permvisible)
        visible = false;
    }//only draw if visible
  }
  
  boolean collides(float x, float y){
    if(x >= this.x &&y >= this.y && x <= this.x + mapscale && y <= this.y + mapscale)
      return true;
    else
      return false;
  }
  
}
