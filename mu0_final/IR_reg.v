module IR_reg (clk, IRce, data, IR); //irce?? ir=data

input clk, IRce; 
input [15:0] data;
output reg [15:0] IR;

always @(posedge clk)
 if (IRce) IR <= data[15:0];
endmodule
