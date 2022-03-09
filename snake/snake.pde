int w, startX, startY, appleX, appleY, score, rectX, rectY, sizeX, sizeY, highscore, timer;
int [][] snake = new int[2][2];
int speedX, speedY;
PImage apple;
boolean eating, gameOver, gameStarted;

//initalize starting variables
void setup(){
 size(868, 868);
  w= 48;
  startX = 50; startY = 434;
  frameRate(80);
  speedX = w;
  speedY = 0;
  apple = loadImage("pics/apple.png");
  imageMode(CENTER);
  eating = true;
  gameOver = true;
  gameStarted = false;
  score = 0;
  highscore = -1;
  rectX = 334; rectY =500; sizeX= 200; sizeY = 100;
  timer = 8;
  snake[0][0] = startX + w; snake[0][1] = startY; snake[1][0] = startX; snake[1][1] = startY;
}

//snake movements on keypress
void keyPressed(){
  if(keyPressed){
    if(keyCode == RIGHT){
      if(speedX == 0){
        speedX = w; speedY = 0;
      }
    }
    else if(keyCode == LEFT){
      if(speedX == 0){
       speedX = -w; speedY = 0;
      }
    }
    else if(keyCode == UP){
      if(speedY == 0){
       speedX = 0; speedY = -w; 
      }
    }
    else if(keyCode == DOWN){
      if(speedY == 0){
       speedX = 0; speedY = w;
      }
    }
    
    
  }
}

void draw(){
 background(0);
 //is the game active?
 if(!gameOver){
   fill(255,0,0);
   textSize(24);
   textAlign(LEFT);
   text("Score: " + score, 5, 30);     //display score
   stroke(0);
   for(int i = 50; i < 800; i += w){    //game board
     for(int j = 50; j < 800; j+=w){
       if((i - 50) % (w*2) == 0){
         if((j-50) % (w*2) == 0){
         fill(66,176,56);
         }
       else{
         fill(75,227,61);
       }
       }
       else{
        if((j-50) % (w*2) == 0){
           fill(75,227,61);
         }
       else{
        fill(66,176,56);
       }
         
         
       }
       rect(i, j, w,w);
       
     }
   }
   
   if(eating){              //if eating apple, generate new location
     boolean conflict = true;
     while(conflict){
      conflict = false; 
      appleX = int(random(1,16));
      appleY = int(random(1,16));
      for(int i = 0; i < snake.length; i++){
       if(snake[i][0]/48 == appleX && snake[i][1]/48 == appleY){  //make sure apple isn't generated on the snake
        conflict = true; 
       }
      }
     }

     eating = false;
   }
   image(apple, appleX*48 -w/2+50, appleY*48 - w/2+50, 40,40);
   fill(0,0,255);
   stroke(0,0,145);;
   for(int i = 0; i < snake.length; i++){  //draw the snake
     rect(snake[i][0], snake[i][1], w,w);
   }
  
  
   fill(0);
   //draw snake eyes based on direction
   if(speedX > 0){
     ellipse(snake[0][0] + 2*w/3, snake[0][1] + w/3, 10,10);
     ellipse(snake[0][0] + 2*w/3, snake[0][1] + 2*w/3, 10,10);
   }
   else if(speedX < 0){
    ellipse(snake[0][0] + w/3, snake[0][1] + w/3, 10,10);
    ellipse(snake[0][0] + w/3, snake[0][1] + 2*w/3, 10,10); 
   }
   else if(speedY < 0){
    ellipse(snake[0][0] + 2*w/3, snake[0][1] + w/3, 10,10);
    ellipse(snake[0][0] + w/3, snake[0][1] + w/3, 10,10); 
   }
   else if(speedY > 0){
    ellipse(snake[0][0] + w/3, snake[0][1] + 2*w/3, 10,10);
    ellipse(snake[0][0] + 2*w/3, snake[0][1] + 2*w/3, 10,10); 
   }
   
   //timer is used to keep a high frame rate while keeping a moderate snake speed
   if(timer !=0){
    timer--; 
   }
   else{
   
   for(int i = snake.length -1; i >= 0; i--){         //update snake
       if(i ==0){
         if(speedX !=0){
           snake[i][0] = snake[i][0] + speedX;
         }
        else{
          snake[i][1] = snake[i][1] + speedY;
        }
       }
       else{
         snake[i][0] = snake[i-1][0];
         snake[i][1] = snake[i-1][1];
       }
      
     
  
   }
   
   if(snake[0][0]/48 == appleX && snake[0][1]/48== appleY){      //is snake eating? if so append size using temporary 2D array copy
    eating = true;
    score++;
    int [][] snakeCopy = new int [snake.length + 1][2];
    for(int i = 0; i < snake.length; i++){
     snakeCopy[i][0] = snake[i][0]; snakeCopy[i][1] = snake[i][1]; 
    }
    snakeCopy[snakeCopy.length - 1][0] = -999;
    snakeCopy[snakeCopy.length - 1][0] = -999;
    snake = snakeCopy;
   }
   
   if(snake[0][0] > 770|| snake[0][1] > 770 || snake[0][0] < 50 || snake[0][1] < 50){  //checking if snake is out of bounds
     gameOver = true;
   }
   
   for(int i = 1; i < snake.length; i++){
    
    if(snake[0][0] == snake[i][0] && snake[0][1] == snake[i][1]){ //checking if snake hits itself
     gameOver = true; 
    }
     
   }
   timer = 8;
   if(highscore == -1){
    highscore = 0; 
   }
   }
  }
  else{
   
    fill(255,0,0);
    textSize(72);
    textAlign(CENTER);
    
    //display game over page
    if(highscore != -1){
      if(score > highscore){
       highscore = score; 
      }
      text("GAME OVER",width/2, height/3);
      textSize(48);
      text("Your score is " + score,width/2, height/3 + 50);
      textSize(30);
      text("Current highscore: " + highscore,width/2, height/2);
      if(overRect(rectX, rectY, sizeX, sizeY)){
       stroke(140,11,1);
       fill(140,11,1);
      }
      else{
        stroke(255,0,0);
      }
      rect(rectX, rectY, sizeX, sizeY);
      fill(0);
      textSize(48);
      text("REPLAY", width/2,565);
    }
    
    //display start page
    else{
      text("Welcome to Snake!", width/2, height/2);
       if(overRect(rectX, rectY, sizeX, sizeY)){
       stroke(140,11,1);
       fill(140,11,1);
      }
      else{
        stroke(255,0,0);
      }
      rect(rectX, rectY, sizeX, sizeY);
      fill(0);
      textSize(48);
      text("PLAY", width/2,565);
      
    }
  }
    
  }

//is the mouse over the replay/play button?
boolean overRect(int x, int y, int w, int h)  {
  if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
    return true;
  } else {
    return false;
  }
}

//did the user click the replay/play button? if so, start game
void mousePressed(){
 if(overRect(rectX, rectY, sizeX, sizeY) == true && gameOver== true && gameStarted){
   gameOver = false;
   startX = 50; startY = 434;
   speedX = w; 
   speedY = 0;
   int [][] snakeCopy = new int [2][2];
   snakeCopy[0][0] = startX + w; snakeCopy[0][1] = startY; snakeCopy[1][0] = startX; snakeCopy[1][1] = startY;
   snake = snakeCopy;
   score = 0;
   eating = true;
}
 else if(overRect(rectX, rectY, sizeX, sizeY) == true && gameOver== true && !gameStarted){
  gameStarted = true;
  gameOver = false;
 }
 }
