      // Generated Typography modelled with Conway's 
      // Game of Life Algorithm 
      // Idea from "Type+Code" book 
      
      //Global Variables 
      PFont myFont;
      int cellsize = 20; 
      int cols; 
      int rows; 
      int [][] oldBoard; 
      int [][] newBoard; 
      
      void setup(){
        size (5000,700); 
        smooth(); 
        frameRate(1);
        
        // font setup
        myFont = createFont ("Broadway", 48);
        textFont(myFont, 5); 
      
        initSettings(); 
        initBoard();
      }
      
      
      void initSettings(){
        cols = width/cellsize; 
        rows = height/cellsize; 
        oldBoard = new int [cols][rows];
        newBoard = new int [cols][rows];
        
        colorMode(RGB, 255, 255, 255, 5); 
        background(255); 
      }
      
      // initializes board, with a random number of 
      // alive cells (based on 0 or 1 value)
      void initBoard(){
        background(0);
        for (int i =0; i<cols; i++){
           for (int j = 0; j<rows; j++){
             if (int(random(2)) == 0){
               oldBoard[i][j]= 1;
             } else {
               oldBoard[i][j] = 0; 
             }
           }
        }
      }
      
     
      
      // Use Conway's life algorithm to set up word positions
      void findNeighbors(){
        for (int x = 0; x<cols; x++){
          for (int y = 0; y<rows; y++){
            int neighbors = 0; // keeps track of # of neighbors to current cell
    
            // check all neighbors
            // modulo operator used to ensure neighbor wrap around        
            
            //top row
            if (oldBoard[(x+cols-1) % cols][(y+rows-5)%rows] == 1) neighbors++;     
            if (oldBoard[x][(y+rows-5)%rows] == 1) neighbors++;              
            if (oldBoard[(x+1) % cols][(y+rows-5)%rows] == 1) neighbors++;
          
            // middle row
            if (oldBoard[(x+cols-1) % cols][y] == 1) neighbors++;
            if (oldBoard[(x+1) % cols][y] == 1) neighbors++;
          
            // bottom row
            if (oldBoard[(x+cols-1) % cols][(y+10)%rows] == 1) neighbors++;
            if (oldBoard[x][(y+10)%rows] == 1) neighbors++;
            if (oldBoard[(x+1) % cols][(y+10)%rows] == 1) neighbors++;
     
            // generate new board with rules of life
            if ((oldBoard[x][y] ==1)&&(neighbors <1)) newBoard[x][y] = 1; //one neighbor
            else if ((oldBoard[x][y] ==1)&&(neighbors >1)) newBoard[x][y] = 10; //overpopulation
            else if ((oldBoard[x][y] ==0)&&(neighbors ==2)) newBoard[x][y] = 3; //reproduce
            else newBoard[x][y] = oldBoard[x][y]; //stability     
            
          }
        }
      }
    
      // populates the board with text based on the newly generated board (after one simulation is run)  
      void populate(){
       for (int i =0; i<cols; i++){
         for (int j = 0; j<rows; j++){
           if ((newBoard[i][j] == 1)){
             fill(255); 
             stroke(0.1); 
             fill (14,227,99,2); 
             
             for (int a = 0; a<25; a++){
               textSize(i); 
             }
             text("life", i*cellsize, j*cellsize); 
           }
         }
       } 
      
      }
      
       // swap old and new boards, store old as temp to be reused
      void swapAndSave(){
       
       int [][] temp = oldBoard; 
       oldBoard = newBoard; 
       newBoard = temp; 
       saveFrame();
      }
      
      // draws the typography with the life algorithm
      void draw(){
        background (255,255,255); // black background
        findNeighbors(); 
        populate(); 
        swapAndSave(); 
      } 
       
         // clears and resets board when the mouse is clicked
      void mouseClicked(){
        initBoard(); 
      }
