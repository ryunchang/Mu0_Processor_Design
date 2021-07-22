module mu0_tb;
 reg rst_n, clk;
 wire [11:0] addr;
 wire [15:0] data;

 reg [15:0] min, max;
 wire [15:0] out;

mu0 dut(.rst_n(rst_n), .clk(clk), .addr(addr), .data(data), .MEMrq(MEMrq), .RnW(RnW), .STP_flag(STP_flag));
//memory_extended meme(.STP_flag(STP_flag), .clk(clk), .addr(addr), .data(data), .MEMrq(MEMrq), .RnW(RnW), .min(min), .max(max), .out(out));
memory mem(.STP_flag(STP_flag), .clk(clk), .addr(addr), .data(data), .MEMrq(MEMrq), .RnW(RnW), .min(min), .max(max), .out(out));


initial begin 
 clk = 0;
end

always #5 clk = !clk;

initial begin
	rst_n = 0;
	#35
	rst_n = 1;
	
	#100 min = 1; max= 10; rst_n =0;
	#10 rst_n = 1;
end


endmodule

