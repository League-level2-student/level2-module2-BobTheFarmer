//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
  int x;
  int y;

// Add a constructor with parameters to initialize each variable.
  Segment(int x, int y) {
    this.x = x*10;
    this.y = y*10;
  }
}




//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
   ArrayList<Segment> tail = new ArrayList<Segment>();
   Segment head;
   int foodX;
   int foodY;
   
   int snakeDirection = UP;
   int foodEaten = 0;
   
   int switchSnakeColorCooldown = 0;
   int snakeR;
   int snakeG;
   int snakeB;

//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  size(1800, 800);
  head = new Segment(0, 0);
  frameRate(20);
  dropFood();
  
  
}

void dropFood() {
  //Set the food in a new random location
    foodX = (int)random(180);
    foodY = (int)random(80);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0);
  move();
  drawSnake();
  drawFood();
  eat();
  print("Snake Cords: " + head.x + ", " + head.y + ". Food Eaten: " + foodEaten + ". foodCords : " + foodX + ", " + foodY + "\n");
}

void drawFood() {
  //Draw the food
    fill(#F50C0C);
    square(foodX*10, foodY*10, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
    //Head
      switchSnakeColorCooldown--;
      if(switchSnakeColorCooldown<1) { 
       switchSnakeColorCooldown = 5;
       snakeR = (int)random(255);
       snakeG = (int)random(255);
       snakeB = (int)random(255);
      
     
      }
      fill(snakeR, snakeG, snakeB);
      square(head.x*10, head.y*10, 10); 
      manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for(int i = 0; i<tail.size(); i++) {
   square(tail.get(i).x*10, tail.get(i).y*10, 10);
  }
   
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
    checkTailCollision();
    drawTail();
    tail.add(new Segment(head.x, head.y));
    tail.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(int i = 0; i<tail.size(); i++) {
   
  if(tail.get(i).x == head.x){
    if(tail.get(i).y == head.y) {
      foodEaten=0;
     tail.clear();
    }
   
  }
}
}




//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
    switch(keyCode) {
      case UP: 
        snakeDirection=UP;
        break;
       case DOWN: 
        snakeDirection=DOWN;
        break;
       case LEFT: 
        snakeDirection=LEFT;
        break;
       case RIGHT: 
        snakeDirection=RIGHT;
        break;
    }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
      
    
  switch(snakeDirection) {
  case UP:
    // move head up here 
      head.y--;
    break;
  case DOWN:
    // move head down here 
    head.y++;
    break;
  case LEFT:
     head.x--;
    break;
  case RIGHT:
    head.x++; 
    break;
  }
  checkBoundaries();
  
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
   if(head.x<0) {
     head.x=180;
   }
   
   if(head.x>180) {
      head.x=0;
   }
   
   if(head.y<0) {
      head.y=80;
   }
   
   if(head.y>80) {
      head.y=0;
      
   }
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
    if(head.y == foodY && head.x == foodX) {
      dropFood();
      foodEaten++;
      tail.add(new Segment(head.x, head.y));
    }
}
