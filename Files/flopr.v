module flopr # (parameter WIDTH = 8)
(input clk, reset,load,
input [WIDTH-1:0] d,
output [WIDTH-1:0] q);

reg [WIDTH-1:0] data;


assign q = data;
	

always @ (posedge clk)
begin
if(reset)
	data <= 0;
else if(load)
	data <= d;
	
end



endmodule 