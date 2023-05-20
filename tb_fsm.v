`include "serial_adder_fsm.v"

module Serial_Adder_Moore_tb ();

  reg a, b;
  reg reset;
  reg clk;
  wire sum;
  wire [1:0] nst;
  wire [1:0] cst;
  
  Serial_Adder_Moore gl(
    .a(a),
    .b(b),
    .reset(reset),
    .clk(clk),
    .sum(sum),
    .cst(cst),
    .nst(nst)
  );
  initial begin
    reset = 1; a = 0;b = 0;
    
    #10 reset = 0;a = 0;b = 0;
    
    #10 a = 0; b = 1;
    
    #10 a = 1; b = 0;
    
    #10 a = 1;b = 1;
    
    #10 a = 0;b = 1;
    
    #10 a = 1;b = 0;
    
    #10 a = 1;b = 1;
    
    #10 a = 1;b = 1;
    
    #10 a = 0;b = 0;
    
    #10 a = 0;b = 0;
    
    #10 a = 0;b = 1;
    
    #10 a = 1;b = 0;
    
    #10 a = 1;b = 1;
    
    #10 a = 1;b = 1;
    
    #10 a = 0;b = 0;
    
    #10 a = 1;b = 0;
    
    #10 a = 0;b = 1;
    
    #10 a = 1;b = 1;
   
    
    //#10 d = 1'bz;
    #30 $finish;
    
  end
  
  initial clk = 1;
  always #5 clk = ~clk;
  
  //initial #600 $finish;
  
endmodule

