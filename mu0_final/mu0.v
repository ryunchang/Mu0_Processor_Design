module mu0 (rst_n, clk, addr, data, MEMrq, RnW, STP_flag);
 input rst_n, clk;
 input [15:0] data;
 output[11:0] addr;
 output MEMrq, RnW;
 output STP_flag;
 wire [15:0] ALUout, IR, PC, B, ACC;
 wire [3:0] ALUfs;

PC_reg PC_reg(.clk(clk), .rst_n(rst_n), .PCce(PCce), .ALUout(ALUout), .PC(PC));
IR_reg IR_reg(.clk(clk), .IRce(IRce), .data(data), .IR(IR));
mux2_to_1 muxA(.data0({4'b0000, PC}), .data1({4'b0000, IR[11:0]}), .sel(Asel), .out(addr));
mux2_to_1 muxB(.data0({4'b0000, addr}), .data1(data), .sel(Bsel), .out(B));
ACC_reg ACC_reg(.clk(clk), .ACCce(ACCce), .ALUout(ALUout), .ACC(ACC), .ACC15(ACC15), .ACCz(ACCz));
tri16bit tri16(.in(ACC), .oe(ACCoe), .out(data));
sync_rst sync_rst(.rst_n(rst_n), .clk(clk), .sreset(sreset));
ALU ALU(.rst_n(rst_n), .A(ACC), .B(B), .ALUfs(ALUfs), .ALUout(ALUout));
FSM FSM(.rst_n(sreset), .clk(clk), .opcode(IR[15:12]), .ACCz(ACCz), .ACC15(ACC15), 
	.Asel(Asel), .Bsel(Bsel), .ACCce(ACCce), .PCce(PCce), .IRce(IRce),
	.ACCoe(ACCoe), .ALUfs(ALUfs), .MEMrq(MEMrq), .RnW(RnW), .STP_flag(STP_flag));


endmodule

module tri16bit (in, oe, out);
 input oe;
 input [15:0] in;
 output [15:0] out;
 assign out = oe ? in : 16'hz;
endmodule

module sync_rst (rst_n, clk, sreset);
 input rst_n, clk;
 output sreset;
 reg sreset, sreset1;

always @(posedge clk)
 {sreset, sreset1} <= {sreset1, rst_n};
endmodule


