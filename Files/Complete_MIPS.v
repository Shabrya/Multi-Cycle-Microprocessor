module Complete_MIPS(input clk, reset,
input [7:0] IN,
output [7:0] writedata,
output memWr,output[7:0] OUT,output [7:0] data,
output [5:0] addr,output Aload);

wire [5:0] address;
wire [7:0] readdata;

assign data = readdata;
assign addr = address;

my_cpu PROCESSOR(clk,reset,address,memWr,writedata,readdata,IN,OUT,Aload);

dmem dmem(clk,memWr,address,writedata,readdata);

endmodule 