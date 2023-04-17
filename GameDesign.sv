// Code your design here



////////////////////////
//S
//E
//D
//R
//A
//...//////////////////
//R
//U
//L
//E
//Z
////////////////////////

/////////////////////////////
`include "clock.sv"

///////////////////////// ///
`define LOSER_WON    2'b01 //
`define WINNER_WON   2'b10 // 
`define UP_1         2'b00 //
`define UP_2         2'b01 //
`define DW_1         2'b10 //
`define DW_2         2'b11 //
`define COUNT_1_MIN  3'h0  //
`define COUNT_1_MAX  3'h7  //
`define COUNT_2_MIN  3'h1  //
`define COUNT_2_MAX  3'h6  //
`define WIN_SCORE    4'hF  //
`define Test_Success 1     //
`define Test_Failed  0     //
/////////////////////////////



module MMC_Game(
   input logic clk,
   input logic rst,
   input logic [1:0] ctrl,
   input logic init,
   input logic [2:0] init_val,
   output logic [2:0] count,
   output logic winner,
   output logic loser,
   output logic gameover,
  output logic [1:0] who
);
  
///////////////////////////
//
logic GameStart ;
//
//////////////////////////  


///////////////////////////
// To Store Local
// WINNER AND LOSER
//      STATS        ///// 

logic [3:0] winner_count;
logic [3:0] loser_count ;
/////////////////////////
  
  
///////////////////////////
// Initialize with zero ///
//                     ///
  initial begin
    winner_count = 0;
    loser_count = 0;
    GameStart = 0;
    
  end
/////////////////////////
  
  
 ///////////////////////////////////////
 // Counter  Block              	 //
 /////////////////////////////////////
always @(posedge clk or posedge rst) begin
      if(rst) begin
        count <= 4'h0;
        winner <= 1'b0;
        loser <= 1'b0;
        gameover <= 1'b0;
        who<= 2'b00;
        
        
        
         end else begin
         
        if (init) begin
            count <= init_val;
        end else begin
           
            
          if(ctrl== `UP_1) begin
          if(count== `COUNT_1_MAX)
                begin
                  count<=`COUNT_1_MIN;
                end
              else begin
                count<=count+1;
              end
            end
            
            
          if(ctrl== `UP_2) begin
            if(count== `COUNT_2_MAX)
                begin
                  count<=`COUNT_1_MIN;
                end
            else if(count == `COUNT_1_MAX)
                begin
                  count <= `COUNT_1_MIN+1;
                end
              else begin
                  count<=count+2;
              end
                  count<=count+2;
            end
            
            
            
            
            
          if(ctrl== `DW_1) begin
            if(count==`COUNT_1_MIN)
                begin
                  count<=`COUNT_1_MAX;
                end
              else begin
                count<=count-1;
              end
            end
            
            
            
            
          if(ctrl== `DW_2) 
          begin
            if(count==`COUNT_2_MIN)
                begin
                  count<=`COUNT_1_MAX;
                end
            else if(count == `COUNT_1_MIN)
                begin
                  count<= `COUNT_1_MAX -1;
                end
              else 
                begin
                  count<=count-2;
                end
            end
            
            
            
            
        end
        
        
        
        
    end
end
  
 ////////////////////////////////////
 // End of the counter  block     //
 ///////////////////////////////////
 //_________________________________________________________________
  
  
 ///////////////////////////////////
 //  Round Decision block        //
 /////////////////////////////////
 always @(posedge clk or posedge rst) begin
    if (rst) begin
        winner <= 1'b0;
        loser <= 1'b0;
    end else begin
        if (count == 3'h0) begin
            loser <= 1'b1;
            winner <= 1'b0;
        end 
        else if(count == 3'h7) begin
            winner <= 1'b1;
            loser  <= 1'b0;
        end
        else begin
            winner <= 1'b0;
          	loser  <= 1'b0;
        end
    end
end
 ///////////////////////////////
 // End of Round Decision    //
 /////////////////////////////
 //____________________________________________________________
 
 
 //////////////////////////////
 //   STATS INCREMENT BLOCK  //
 /////////////////////////////
  
 always @(posedge clk or posedge rst) begin
    if (rst) begin
        winner_count <= 8'h00;
        loser_count <= 8'h00;
    end else begin
        if (winner) begin
            winner_count <= winner_count + 1;
        end
        if (loser) begin
            loser_count <= loser_count + 1;
        end
    end
end
  
/////////////////////////////////
//   END OF STATS INCREMENT   //
///////////////////////////////
//_______________________________________________
  
  
//////////////////////////////
// WINNER DETECTION BLOCK   //
//////////////////////////////

  


always @(posedge clk or posedge rst) begin
    if (rst) begin
        gameover <= 1'b0;
    end else begin
      if (winner_count == `WIN_SCORE || loser_count == `WIN_SCORE) begin
            gameover <= 1'b1;
                  if (winner_count == `WIN_SCORE) begin
                      who <= `WINNER_WON;
                  end 
                  else begin
                      who <= `LOSER_WON;
                  end
            winner_count <= 4'h0;
            loser_count <= 4'h0;
            count<=0;
        end 
        else begin
            gameover <= 1'b0;
            who<=0;
        end
    end
end
///////////////////////////////////
// END OF WINNER DETECTION  //////
/////////////////////////////////
//______________________________________________
  
  
 
        
endmodule       


// Code your testbench here
// or browse Examples
module MMTB_Final;
  	logic clk;
    logic rst;
    logic [1:0] ctrl;
    logic init;
  	logic [2:0] init_val;
  	logic [2:0] count;
    logic winner;
    logic loser;
    logic gameover;
    logic [1:0] who;
    int  Testcases[15] ; 
  
   MMC_Game uut (
        .clk(clk),
        .rst(rst),
        .ctrl(ctrl),
        .init(init),
        .init_val(init_val),
        .count(count),
        .winner(winner),
        .loser(loser),
        .gameover(gameover),
        .who(who)
    );
  
  CLK CL0(clk);


  initial begin
    $display("TestCase#              Status");
    rst = 1'b1;
    ctrl = 2'b01;
    init = 1'b0;
    init_val = 3'h7;  // problem stuck at init val if init = 1;
    // problem does't handle if the counter value is 7 and the ctrl is counter + 2
  
        
        #10 rst = 1'b0;
       
        
        //Test Case #1 (Count up 2)
        // if you set it to increase by 2 the loser wins
        //
        #590
        ctrl = 2'b00;
         if (who== `LOSER_WON) begin
          Testcases[0] = `Test_Success;
          end
        else begin
          Testcases[0] = `Test_Failed;
        end
        
        
      //Test Case #2
      // Check Loser functionality but by incrementing by 1 (count up 1)
      // At the end the loser will have 15 points and winner will have 14 points
      // so Loser wins
        
        #1150
        
         if (who== `LOSER_WON) begin
          Testcases[1] = `Test_Success;
          end
        else begin
          Testcases[1] = `Test_Failed;
        end
        
        //Test case #3
        // Put initial value 7 
        // then keep increasing and decreasing 6-7-6-7
        
        init = 1'b1;
        #10
        init = 1'b0;
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
         #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
         #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
         #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        #10
        ctrl=2'b10;
        #10
        ctrl=2'b00;
        
        #25
        
        ////////////
       //Test Case 3
       /////////////
       
         if (who== `WINNER_WON) begin
          Testcases[2] = `Test_Success;
          end
        else begin
          Testcases[2] = `Test_Failed;
        end
        
        
        
        ///////////////////////
        //
        ctrl = 2'b01;
        init = 1'b1;
        #10
        init = 1'b0;
        
        
        
        #550
        ////////////
       //Test Case 4
       /////////////
       
         if (who== `WINNER_WON) begin
          Testcases[3] = `Test_Success;
          end
        else begin
          Testcases[3] = `Test_Failed;
        end
        
        
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
         ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
         ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
         #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        #10
        ctrl = 2'b00;
        #10
        ctrl = 2'b01;
        
        #445
        
        //////////////
       //Test Case 5
       /////////////
       
         if (who== `WINNER_WON) begin
          Testcases[4] = `Test_Success;
          end
        else begin
          Testcases[4] = `Test_Failed;
        end
        
        ///////////////
        //Test Case  6
        ///////////////
        
         
        
        #50
        rst = 1'b1;
         
        #10
        if (count== 0) begin
          Testcases[5] = `Test_Success;
          end
        else begin
          Testcases[5] = `Test_Failed;
        end
        
rst= 1'b0;
        
ctrl = 2'b10;
        #1150
        //////////////
       //Test Case 7 Decrement by 1
       /////////////
       
         if (who== `LOSER_WON) begin
          Testcases[6] = `Test_Success;
          end
        else begin
          Testcases[6] = `Test_Failed;
        end
        
        /////////////////
        //Test case 8 Decrement by 2
        //
        
ctrl = 2'b11;
       
#588
       
if (who== `LOSER_WON) begin
          Testcases[7] = `Test_Success;
          end
        else begin
          Testcases[7] = `Test_Failed;
        end
        
        
       
      
  
          
          
          
          
            $display("TestCase#                           	Status");
        foreach (Testcases[i]) begin
          if(Testcases[i])begin
            $display("%2d                                    Success", i+1);
          end
        else begin
          $display("%2d                                    Failed", i+1);
        end
      
        
    
end
        
        
        
        

    
  
    
  end
  /* always @(posedge clk) begin
        $display("count = %d, winner = %d, loser = %d, gameover = %d, who = %d", count, winner, loser, gameover, who);
    end */
  
  
endmodule 
        
  

