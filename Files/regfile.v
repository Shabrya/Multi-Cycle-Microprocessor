module regfile(input[7:0] D,input[2:0] address ,input we,clock,
output [7:0] out);
 


//instantiate an array of size 8 and which can hold word of length 8 bits
reg [7:0] register [7:0];

//If we wish to write into the register file
always@(posedge clock)
begin
	if(we)
	begin
		register[address] <= D; 
	end
end

//outputs at every clock cycle
assign out = register[address];
 
endmodule 