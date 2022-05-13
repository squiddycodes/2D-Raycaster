/*Derek Guidorizzi
I wanted to make a raycaster for fun to see if i could do smth cool
Try not to die, use the mouse and navigate to the purple goal!!!
Press v to reveal the map, use the mouse to control the player
*/

float px = 600;//init x and y of player
float py = 600;
int pcolor = 3;
int mapscale = 48;//must change size too
ArrayList<Node> Nodes = new ArrayList<Node>();
float prevX = -1;
float prevY = -1;
float flashlightangle = 315;
int flashlightwidth = 20;
float raysize = 250;
boolean won = false;

//MAIN EVENT FUNCTIONS

void setup(){
  size(1200, 1200);//                                             SIZE
  initMap();
}

void draw(){
  drawBackground();
  //drawRays();
  if(!playerCollides()){
    px = mouseX;
    py = mouseY;
  }else{
    //game over
  }
  drawPlayer();
  drawFlashlight();
  /*ellipse(px + 250, py, 5,5);
  ellipse(px - 250, py, 5,5);
  ellipse(px, py + 250, 5,5);
  ellipse(px, py - 250, 5,5);*/
  //stroke(0);
  //line(px,py,px - abs(cos(radians(225 + 180))) * 100, py + abs(sin(radians(225 + 180))) * 100); test line at 225 degrees
  drawNodes();
}

void keyPressed() {
  if (keyPressed) {
    if(key == '.') {
      pcolor++;
      if(pcolor == 8)
        pcolor = 1;
    }else if(key == ',') {
      pcolor--;
      if(pcolor == 0)
        pcolor = 7;
    }else if(key == 'v'){
      for(Node n : Nodes){
        if(!n.permvisible){
          n.permvisible = true;
          n.visible = true;
        }else
          n.permvisible = false;
      }
    }
  }
}

//END MAIN EVENT FUNCTIONS


//RAYCAST LENGTH DETECTION FUNCTION


float getCastLength(float x, float y, float angle){
  float collides = raysize;//start with default raysize
  Node node = new Node(69,69,69);//sample node for conditional

  for(int ray = mapscale; ray <= raysize && collides == raysize; ray+=1){//iterate through ray with increasing magnitude; runs until hits node or gets to raysize
    if(angle < 90){
      for(Node n : Nodes){//get closest collision node
        if(n.x >= px - raysize && n.x <= px + raysize && n.y >= py - raysize && n.y <= py + raysize){//only do for nodes in a box around the player (REDUCES LAG HOPEFULLY)
          if(n.collides(px + abs(sin(radians(90 - angle)) * ray), py - abs(cos(radians(90 - angle)) * ray))){
            collides = ray;//new raylength at new collision, to be narrowed down below
            node = n;//node it hits
            n.visible = true;
          }
        }
      }
    }else if(angle < 180){
      for(Node n : Nodes){//get closest collision node
        if(n.x >= px - raysize && n.x <= px + raysize && n.y >= py - raysize && n.y <= py + raysize){//only do for nodes in a box around the player (REDUCES LAG HOPEFULLY)
          if(n.collides(px - abs(sin(radians(angle + 90)) * ray), py - abs(cos(radians(angle + 90)) * ray))){
            collides = ray;//new raylength at new collision, to be narrowed down below
            node = n;//node it hits
            n.visible = true;
          }
        }
      }
    }else if(angle < 270){
      for(Node n : Nodes){//get closest collision node
        if(n.x >= px - raysize && n.x <= px + raysize && n.y >= py - raysize && n.y - raysize <= py + raysize){//only do for nodes in a box around the player (REDUCES LAG HOPEFULLY)
          if(n.collides(px - abs(cos(radians(180 + angle)) * ray), py + abs(sin(radians(180 + angle)) * ray))){
            collides = ray;//new raylength at new collision, to be narrowed down below
            node = n;//node it hits
            n.visible = true;
          }
        }
      }
    }else{//360
      for(Node n : Nodes){//get closest collision node
        if(n.x >= px - raysize && n.x <= px + raysize && n.y >= py - raysize && n.y <= py + raysize){//only do for nodes in a box around the player (REDUCES LAG HOPEFULLY)
          if(n.collides(px + abs(cos(radians(360 - angle)) * ray), py + abs(sin(radians(360 - angle)) * ray))){
            collides = ray;//new raylength at new collision, to be narrowed down below
            node = n;//node it hits
            n.visible = true;
          }
        }
      }
    }
  }
  
  if(collides != raysize){//if collides with a node
    boolean stillcollides = false;
    for(float raylen = collides; raylen > 0 && stillcollides; raylen--){//run until doesn't collide anymore
      if(angle < 90){
        if(!node.collides(px + abs(sin(radians(90 - angle)) * raylen), py - abs(cos(radians(90 - angle)) * raylen))){
          collides = raylen;
        }
      }else if(angle < 180){
        if(!node.collides(px - abs(sin(radians(angle + 90)) * raylen), py - abs(cos(radians(angle + 90)) * raylen))){
          collides = raylen;
        }
      }else if(angle < 270){
        if(!node.collides(px - abs(cos(radians(180 + angle)) * raylen), py + abs(sin(radians(180 + angle)) * raylen))){
          collides = raylen;
        }
      }else{//360
        if(!node.collides(px + abs(cos(radians(360 - angle)) * raylen), py + abs(sin(radians(360 - angle)) * raylen))){
          collides = raylen;
        }
      }
    }
  }
  return collides;
}

//END RAYCAST LENGTH DETECTION FUNCTION


//DRAW FUNCTIONS
void drawFlashlight(){
  //print("px, py = (" + px + ", " + py + ")\nprevX, prevY = (" + prevX + ", " + prevY + ")\n\n\n");
  float xdifference = round((px - prevX)*15.)/15.;
  float ydifference = round((py - prevY)*15.)/15.;
  if(prevX != px && prevY != py){
    if(xdifference > 0 && ydifference < 0){//first quadrent
      flashlightangle = 90+degrees((atan((px - prevX)/(py - prevY))));
    }else if(xdifference < 0 && ydifference < 0){//second quadrent
      flashlightangle = 90+degrees((atan((px - prevX)/(py - prevY))));
    }else if(xdifference < 0 && ydifference > 0){//third quadrent
      flashlightangle = 270+degrees((atan((px - prevX)/(py - prevY))));
    }else{//fourth quadrent
      flashlightangle = 270+degrees((atan((px - prevX)/(py - prevY))));
    }
  }
  
  strokeWeight(1);
  for(float i = (int)flashlightangle - flashlightwidth; i < flashlightangle + flashlightwidth; i+=1){
    if(i < 90){
      line(px,py, px + abs(sin(radians(90 - i)) * getCastLength(px + abs(sin(radians(90 - i)) * raysize), py - abs(cos(radians(90 - i)) * raysize), i)), py - abs(cos(radians(90 - i)) * getCastLength(px + abs(sin(radians(90 - i)) * raysize), py - abs(cos(radians(90 - i)) * raysize), i)));
    }else if(i < 180){
      line(px,py, px - abs(sin(radians(i + 90)) * getCastLength(px - abs(sin(radians(i + 90)) * raysize), py - abs(cos(radians(i + 90)) * raysize), i)), py - abs(cos(radians(i + 90)) * getCastLength(px - abs(sin(radians(i + 90)) * raysize), py - abs(cos(radians(i + 90)) * raysize), i)));
    }else if(i < 270){
      line(px,py, px - abs(cos(radians(180 + i)) * getCastLength(px - abs(cos(radians(180 + i)) * raysize), py + abs(sin(radians(180 + i)) * raysize), i)), py + abs(sin(radians(180 + i)) * getCastLength(px - abs(cos(radians(180 + i)) * raysize), py + abs(sin(radians(180 + i)) * raysize), i)));
    }else{
      line(px,py, px + abs(cos(radians(360 - i)) * getCastLength(px + abs(cos(radians(360 - i)) * raysize), py + abs(sin(radians(360 - i)) * raysize), i)), py + abs(sin(radians(360 - i)) * getCastLength(px + abs(cos(radians(360 - i)) * raysize), py + abs(sin(radians(360 - i)) * raysize), i)));
    }
  }
  strokeWeight(0);//delete if v1 wins
  prevX = px;//reset values
  prevY = py;
  stroke(0);
}

void drawBackground(){
  fill(100, 75, 30);
  if(Nodes.get(0).permvisible == false)
    fill(0);
  if(won)
    fill(random(0,256), random(0,256), random(0,256));
  rect(-5,-5,1210,1210);
}

void drawPlayer(){
  switch(pcolor){
    case 1:
      fill(255,0,0);
      stroke(255,0,0);
    break;
    case 2:
      fill(255,127,0);
      stroke(255,127,0);
    break;
    case 3:
      fill(255,255,0);
      stroke(255,255,0);
    break;
    case 4:
      fill(0,255,0);
      stroke(0,255,0);
    break;
    case 5:
      fill(0,0,255);
      stroke(0,0,255);
    break;
    case 6:
      fill(75,0,130);
      stroke(75,0,130);
    break;
    case 7:
      fill(143,0,255);
      stroke(143,0,255);
    break;
  }
  if(won)
    fill(random(0,256), random(0,256), random(0,256));
  if(won)
    stroke(random(0,256), random(0,256), random(0,256));
  ellipse(px, py, 10, 10);
}

void drawRays(){
  switch(pcolor){
    case 1:
      stroke(255,0,0);
    break;
    case 2:
      stroke(255,127,0);
    break;
    case 3:
      stroke(255,255,0);
    break;
    case 4:
      stroke(0,255,0);
    break;
    case 5:
      stroke(0,0,255);
    break;
    case 6:
      stroke(75,0,130);
    break;
    case 7:
      stroke(143,0,255);
    break;
  }
  if(won)
    stroke(random(0,256), random(0,256), random(0,256));
  int raysize = 100;
  for(int i = 0; i < 360; i+=1){
      line(px,py,px + (cos(i) * raysize), py - (sin(i) * raysize));
  }
}
void drawNodes(){
  stroke(0);
  if(won){
    stroke(random(0,256), random(0,256), random(0,256));
    strokeWeight(4);
  }
  for(Node n : Nodes)
    n.Draw();
}

//END DRAW FUNCTIONS

boolean playerCollides(){//if player collides with walls, end game
  boolean collides = false;
  for(int i = 0; i < map.length; i++){
    for(int x = 0; x < map[i].length; x++){
      if(map[i][x] != 0 && map[i][x] != 5){
        if(mouseX > x * mapscale && mouseX < x * mapscale + mapscale && mouseY > i * mapscale && mouseY < i * mapscale + mapscale)
          collides = true;
      }else if(map[i][x] == 5){
        if(mouseX > x * mapscale && mouseX < x * mapscale + mapscale && mouseY > i * mapscale && mouseY < i * mapscale + mapscale)
          //randomize all colors
          won = true;
      }
    }
  }
  return collides;
}

//MAP AND NODE INIT

int[][] map = //25 x 25 - mapscale divisions
  {{0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,3,0,3,0,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,3,0,0,0,3,0,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,3,0,3,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,3,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,4,4,4,4,4,4,0,0,4,0,0,0,0,0,0,0,1},
  {1,4,0,4,4,4,4,4,4,0,0,4,0,0,0,0,4,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,1},
  {1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};
void initMap(){
  for(int y = 0; y < map.length; y++){
    for(int x = 0; x < map[y].length; x++){
      if(map[y][x] != 0)
        Nodes.add(new Node(x * mapscale, y * mapscale, map[y][x]));
    }
  }
}
