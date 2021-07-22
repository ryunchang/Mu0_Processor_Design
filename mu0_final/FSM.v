module FSM (rst_n, clk, opcode, ACCz, ACC15, Asel, Bsel, ACCce, PCce, IRce, ACCoe, ALUfs, MEMrq, RnW, STP_flag);
 input rst_n, clk, ACCz, ACC15;
 input [3:0] opcode;
 output Asel, Bsel, ACCce, PCce, IRce, ACCoe, MEMrq, RnW;
 output[3:0] ALUfs;
 output reg STP_flag;
 reg exft;
 reg [12:0] outs;

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

always @(opcode or rst_n or exft or ACCz or ACC15) begin
 if (!rst_n) outs = {1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 4'bxxxx, 1'b1, 1'b1, 1'b0};
 else begin
	case (opcode)
	LDA: begin STP_flag = 0;
		if (!exft) outs = {1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0011, 1'b1, 1'b1, 1'b1};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	STO: begin STP_flag = 0;
		if (!exft) outs = {1'b1, 1'bx, 1'b0, 1'b0, 1'b0, 1'b1, 4'bxxxx, 1'b1, 1'b0, 1'b1};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	ADD: begin STP_flag = 0;
		if (!exft) outs = {1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0001, 1'b1, 1'b1, 1'b1};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	SUB: begin STP_flag = 0;
		if (!exft) outs = {1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0010, 1'b1, 1'b1, 1'b1};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	JMP: begin STP_flag = 0;
		outs = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	JGE: begin STP_flag = 0;
		if (!ACC15)outs = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	JNE: begin STP_flag = 0;
		if (!ACCz) outs = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	STP: begin outs = {1'b1, 1'bx, 1'b0, 1'b0, 1'b0, 1'b0, 4'bxxxx, 1'b0, 1'b1, 1'b0};
		STP_flag = 1; end
	INC: begin STP_flag = 0;
		if (!exft) outs = {1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0101, 1'b1, 1'b1, 1'b1};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	DEC: begin STP_flag = 0;
		if (!exft) outs = {1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0110, 1'b1, 1'b1, 1'b1};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	MUL: begin STP_flag = 0;
		if (!exft) outs = {1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b0111, 1'b1, 1'b1, 1'b1};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end //complete
	SHR: begin STP_flag = 0;
		if (!exft) outs = {1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 4'b1000, 1'b1, 1'b1, 1'b1};
		else outs = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 4'b0100, 1'b1, 1'b1, 1'b0}; end
	default: outs = {1'bx,1'bx,1'bx,1'bx,1'bx,1'bx,4'bxxxx,1'bx,1'bx,1'bx};
 endcase

 end //else end
end //always end
assign Asel = outs[12];
assign Bsel = outs[11];
assign ACCce = outs[10];
assign PCce = outs[9];
assign IRce = outs[8];
assign ACCoe = outs[7];
assign ALUfs = outs[6:3];
assign MEMrq = outs[2];
assign RnW = outs[1];
assign nextexft = outs[0];

always @(posedge clk or negedge rst_n)begin
 if (!rst_n) exft <= 1'b1;
 else exft <= nextexft;
end
endmodule

