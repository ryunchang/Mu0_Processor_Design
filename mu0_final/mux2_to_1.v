module mux2_to_1(data0, data1, sel, out);

input [15:0] data0, data1;
input sel;

output reg [15:0] out;

always @(*)
 if(sel) out <= data1;
 else out <= data0;

endmodule
