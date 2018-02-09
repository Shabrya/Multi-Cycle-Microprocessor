module output_reg(d,load,clk,reset,q);

input [7:0]d;
input load,clk,reset;
output reg [7:0]q;

flopr #(8) OUTREG(clk,reset,load,d,q);

endmodule