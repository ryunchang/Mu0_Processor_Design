module PC_reg (clk, rst_n, PCce, ALUout, PC); 

input clk, rst_n, PCce;
input [15:0] ALUout;

output reg [15:0] PC;

always @(posedge clk)
 if(!rst_n) PC <= 16'b0000_0000_0000_0000;
 else if (PCce) PC <= ALUout[15:0];

endmodule

