


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
        who <= 2'b00;
        
        
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
            
            
            
            
          if(ctrl== `DW_2) begin
            if(count==`COUNT_2_MIN)
                begin
                  count<=`COUNT_1_MAX;
                end
              else begin
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
            end else begin
                who <= `LOSER_WON;
            end
            winner_count <= 4'h0;
            loser_count <= 4'h0;
        end else begin
            gameover <= 1'b0;
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
    int  Testcases[2] ; 
  
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
  
  
  initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
   end
  initial begin
    $display("TestCase#              Status");
    rst = 1'b1;
    ctrl = 2'b01;
    init = 1'b0;
    init_val = 8'h0;
  
        
        #10 rst = 1'b0;
        #10 ctrl = 2'b01;
        
        //Test Case #1
        // if you set it to increase by 2 the loser wins
        //
        #600
        ctrl = 2'b00;
         if (who== `LOSER_WON) begin
          Testcases[0] = `Test_Success;
          end
        else begin
          Testcases[0] = `Test_Failed;
        end
        #2400
        if (who== `WINNER_WON) begin
          Testcases[1] = `Test_Success;
          end
        else begin
          Testcases[1] = `Test_Failed;
          
          end
          
          
          
          
            $display("TestCase#               Status");
        foreach (Testcases[i]) begin
          if(Testcases[i])begin
            $display("%0d                       Sucess", i);
          end
        else begin
          $display("%0d                         Failed", i);
        end
      
        
    
end
        
        
        
        

    
  
    
  end
  /* always @(posedge clk) begin
        $display("count = %d, winner = %d, loser = %d, gameover = %d, who = %d", count, winner, loser, gameover, who);
    end */
  
  
endmodule 
        
  



