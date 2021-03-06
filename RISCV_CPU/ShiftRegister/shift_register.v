`include "DFlipFlop/d_flip_flop.v"
`include "Multiplexer/multiplexer_4to1.v"

module shift_register(I, bit, S, clk, Q);
    parameter n = 32;
    input [n-1:0] I;
    input [1:0] S;
	input clk, bit;
	output [n-1:0] Q;
	wire [n-1:0] D;
	
	genvar i;
	generate for (i = 0; i < n ; i=i+1) begin 
			wire [3:0] W;
			assign W[0] = Q[i];
			assign W[1] = (i == 0 ? bit : Q[i-1]);
			assign W[2] = (i == n-1 ? bit : Q[i+1]);
			assign W[3] = I[i];
			Mux4to1 M (W, S, D[i]);
			d_flip_flop dff (D[i], clk, Q[i]);
		end
	endgenerate
endmodule