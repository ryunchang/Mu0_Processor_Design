module memory_extended (STP_flag, clk, addr, data, MEMrq, RnW, min, max, out); 

 input clk, MEMrq, RnW, STP_flag;
 input [11:0] addr;
 inout [15:0] data;

 input [15:0] min, max;
 output reg [15:0] out;
 reg [15:0] mem [31:0];

 parameter [3:0] LDA = 4'b0000;
 parameter [3:0] STO = 4'b0001;
 parameter [3:0] ADD = 4'b0010;
 parameter [3:0] SUB = 4'b0011;
 parameter [3:0] JMP = 4'b0100;
 parameter [3:0] JGE = 4'b0101;
 parameter [3:0] JNE = 4'b0110;
 parameter [3:0] STP = 4'b0111;
 parameter [3:0] INC = 4'b1000; //added code
 parameter [3:0] DEC = 4'b1001; //added code
 parameter [3:0] MUL = 4'b1010; //added code
 parameter [3:0] SHR = 4'b1011; //added code


 parameter [11:0] S = 12'd27;
 parameter [11:0] sum = 12'd28;
 parameter [11:0] i = 12'd29;
 parameter [11:0] N = 12'd30;
 parameter [11:0] v1 = 12'd31;
 parameter [11:0] loop1 = 12'd7;


assign data = (MEMrq & RnW) ? mem[addr] : 16'hz; // read
always @(posedge clk) begin // write
 if (MEMrq & !RnW) mem[addr] <= data;
 if(STP_flag == 1) out <= mem[29];
end

initial begin

	mem[0] = {JMP, 12'd1}; // jump to mem[1]
	mem[1] = {LDA, S};
	mem[2] = {STO, sum}; 
	mem[3] = {STO, i}; 
	mem[4] = {SUB, N}; 
	mem[5] = {JNE, loop1}; 
	mem[6] = {STP, 12'd0}; 
	
	//loop1
	mem[7] = {LDA, i};
	mem[8] = {ADD, v1};
	mem[9] = {STO, i};
	mem[10] = {ADD, sum};
	mem[11] = {STO, sum};
	mem[12] = {LDA, i};
	mem[13] = {SUB, N};
	mem[14] = {JNE, loop1}; 
	mem[15] = {STP, 12'd0}; 
	
	mem[27] = 16'd9; // S = 9
	mem[28] = 16'd0; // sum = 0
	mem[29] = 16'd0; // i
	mem[30] = 16'd6; // N = 6
	mem[31] = 16'd1; // v1 = 1 
end	

always @(min, max) begin
 sigma(min, max);
end

task sigma(input [15:0] min, input [15:0] max);
begin
 mem[0] = {LDA, 12'd30};
 mem[1] = {DEC, 12'd30}; 
 mem[2] = {MUL, 12'd30}; 
 mem[3] = {SHR, 12'd30};
 mem[4] = {STO, 12'd30};
 mem[5] = {LDA, 12'd31}; 
 mem[6] = {INC, 12'd31};
 mem[7] = {MUL, 12'd31};
 mem[8] = {SHR, 12'd31};
 mem[9] = {SUB, 12'd30};
 mem[10] = {STO, 12'd29};
 mem[11] = {STP, 12'd0};
	
 mem[29] = 16'd0; // sum
 mem[30] = min; //min
 mem[31] = max; //max
end
endtask
endmodule

















