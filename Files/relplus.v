module relplus(input[5:0] a,b,
output[5:0] OUT);

assign OUT =  a + {3'b000,b[2:0]};

endmodule 