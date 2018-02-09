module shifter(a,sel,out);
	input [7:0] a;
	input [1:0] sel;
	output reg [7:0] out;
	
	initial
		begin
		out = 0;
		end
	
	always@(*)
	begin
		case(sel)
		2'b00:out = a;
		2'b01:out = a << 1;
		2'b10:out = a >> 1;
		2'b11:out = {a[0],a[7:1]};
		default: out = a;
	endcase
	end
		
endmodule 