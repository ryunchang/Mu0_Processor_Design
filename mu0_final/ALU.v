module ALU(A, B, ALUfs, rst_n, ALUout);

input[3:0] ALUfs;
input [15:0] A, B;
input rst_n;

output reg [15:0] ALUout;

always@(*)
 if(rst_n)
 case (ALUfs)
  0 : ALUout <= 0;
  1 : ALUout <= A+B;
  2 : ALUout <= A-B;
  3 : ALUout <= B;
  4 : ALUout <= B+1;
  5 : ALUout <= A+1;
  6 : ALUout <= A-1; //added code
  7 : ALUout <= A*B; //added code
  8 : ALUout <= A>>1; //added code
  default : ALUout <= 0;
 endcase

 else ALUout <= 0;
endmodule
	