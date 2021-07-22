module ACC_reg (clk, ACCce, ALUout, ACC, ACC15, ACCz);

input clk, ACCce;
input [15:0] ALUout;

output ACC15, ACCz;
output reg [15:0] ACC;

assign ACC15 = ACC[15];
assign ACCz = ACC[0];

always @(posedge clk)
  if (ACCce) ACC <= ALUout[15:0];

endmodule

