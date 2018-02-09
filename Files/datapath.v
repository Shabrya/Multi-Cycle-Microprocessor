module datapath(input clk,reset,
				input [7:0] readdata,
				input IRload,
				input [1:0] Jmpmuxsel,
				input PCload,
				input MemInst,
				input MRload,
				input [1:0] Asel,
				input Aload,
				input RFwr,
				input [2:0] ALUsel,
				input [1:0] Shiftsel,
				input outen,
				input [7:0] IN,
				output [7:0] accout,
				output [7:0]OUT,
				output [7:0] INSTR,
				output [5:0] address//being inputed to the RAM
				);				
		
wire [7:0] result,rfout;
//result hold the result from the SHIFTREG
wire [7:0] aluout;
wire [7:0] amux_out;//ACC mux out
//accout hold the output of the accumlator
wire [5:0] MAout;
wire [5:0] PCout,pos_sign,neg_sign,PCplusone;
wire [5:0] JMPmuxOut; 



				
//PC logic
flopr #(8) IR (clk,reset,IRload,readdata,INSTR);
flopr #(6) MA (clk,reset,MRload,readdata[5:0],MAout);
flopr #(6) PC(clk,reset,PCload,JMPmuxOut,PCout);
relplus pos(PCout,INSTR[5:0],pos_sign);
relminus min(PCout,INSTR[5:0],neg_sign);
pcplus pcplusone(PCout,PCplusone);
jump_mux #(6) JMPmux(PCplusone,readdata[5:0],neg_sign,pos_sign,Jmpmuxsel,JMPmuxOut);
mux2 #(6) MemMux(PCout,MAout,MemInst,address);
			

//accumlator logic 
acc_mux #(8) accmux4(result,rfout,IN,readdata,Asel,amux_out);
flopr #(8) accumlator(clk,reset,Aload,amux_out,accout);
regfile RF(accout,INSTR[2:0],RFwr,clk,rfout);
alu ALU(accout,rfout,ALUsel,aluout);
shifter shiftReg(aluout,Shiftsel,result);
flopr #(8) OUTREG(clk,reset,outen,accout,OUT);

endmodule