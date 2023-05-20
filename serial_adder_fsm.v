`timescale 1ns/1ps

module Serial_Adder_Moore (
  a, b, reset, clk, sum, cst, nst
);

input a, b;
input clk;
input reset;

output reg sum;
output reg [1:0] nst; // carry out
output reg [1:0] cst;

initial begin
  cst = 2'b00;
end

// state assignment
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

// synchronous with clock
always @(a or b or posedge clk) begin
  case (cst)
    S0: begin
      sum = a ^ b;
      if ((~a & b) | (a & ~b))
        nst = S1;
      else if (a & b)
        nst = S2;
      else if (~a & ~b)
        nst = cst;
    end
    
    S1: begin
      sum = a ^ b;
      if ((~ a & b) | (a & ~b))
        nst = cst;
      else if (a & b)
        nst = S2;
      else if (~a & ~b)
        nst = S0;
    end
    
    S2: begin
      sum = a~^b;
      if ((~a & b) | (a & ~b))
        nst = cst;
      else if (a & b)
        nst = S3;
      else if (~a & ~b)
        nst = S1;
    end
    
    S3: begin
      sum = a~^b;
      if ((~a & b) | (a & ~b))
        nst = S2;
      else if (a & b)
        nst = cst;
      else if (~a & ~b)
        nst = S1;
    end
    
    default: nst = S0;
  endcase
end

// reset facility
always @(posedge reset or posedge clk) begin
  if (reset) begin
    sum <= 1'b0;
    cst <= S0;
  end
  else begin
    cst <= nst;
  end
end

endmodule
