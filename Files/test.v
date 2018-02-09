module test;

	reg clk;
	reg reset;
	reg [7:0] IN;
	wire [7:0] Accumulator;
	wire MemWr;
	wire [7:0] OUT;
	wire [7:0] instr;
	wire [5:0] address;
	wire Aload;
	
// instantiate device to be tested	
Complete_MIPS U0(clk,reset,IN,Accumulator,MemWr,OUT,instr,address,Aload);
	
// initialize test
initial
begin
reset <= 1; # 22; reset <= 0;
IN <= 8'd8;
end

always
begin
clk <= 1;
 # 10; 
 clk <= 0;
 # 10; // clock duration
end
			
//check results
always@(negedge clk)
begin
if(address == 6'd29)begin
$display("Test Finished");
$stop; 
end
end
	
endmodule