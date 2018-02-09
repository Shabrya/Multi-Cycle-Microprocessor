module dmem(input clk,we,
input [5:0]addr,
input [7:0]d,
output[7:0] rd);

reg [7:0] RAM [63:0];//creat an array that ia 64 by 8

initial 
begin
$readmemh("memfile.dat",RAM);  
end

	
	always @(posedge clk)
		if(we)//WRITE
			RAM[addr] <= d; 
	
	assign rd = RAM[addr];	
		
endmodule