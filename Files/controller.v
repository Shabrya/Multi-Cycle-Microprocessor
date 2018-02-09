module controller(input clk,reset,
			     input [7:0] instr,
				  input [7:0] A,
				  output MemWr,
				  output [1:0] JMPmux,Shiftsel,Asel,
				  output IRload,MRload,PCload,MemInst,Aload,RFwr,OutEn,
				  output [2:0] ALUsel
				  );

reg [5:0] present;
reg [5:0] next;
reg [16:0] bits;


initial
begin
next <= 6'd0;
present <= 6'd0;
bits <= 17'd0;
end			  	
					
localparam FETCH = 6'd0,
		   DECODE = 6'd1,
			NOP = 6'd2,
		   LDA = 6'd3,
		   STA = 6'd4,
		   LDM = 6'd5,
		   STM = 6'd6,
		   LDI = 6'd7,
		   AND = 6'd8,
		   OR = 6'd9,
		   ADD = 6'd10,
		   SUB = 6'd11,
		   NOT = 6'd12,
		   INC = 6'd13,
		   DEC = 6'd14,
		   SHFL = 6'd15,
		   SHFR = 6'd16,
		   ROTR = 6'd17,
		   IN = 6'd18,
		   OUT = 6'd19,
		   HALT = 6'd20,
		   JMP = 6'd21,
		   JMPR = 6'd22,
		   JZ = 6'd23,
		   JZR = 6'd24,
		   JNZ = 6'd25,
		   JNZR = 6'd26,
		   JP = 6'd27,
		   JPR = 6'd28,
		   LDMC2 = 6'd29,
		   STMC2 = 6'd30;
		   
           
always@(next)
	begin
		if(reset)
			present = 6'd0;
		else
			present = next;
	end			

always@(posedge clk)
begin
		//next = present;
	
		if(reset)
			begin
			next = FETCH;
		end 
		else 
			begin
			
			case(present)
			
				FETCH:
					begin					
						bits = 17'b10001000000000000;
						next = DECODE;
					end
		
				DECODE:
				begin
						bits = 17'd0;
					if(instr == 8'b0000_0000)
						next = NOP;
					else if(instr[7:4] == 4'b0001)
						next = LDA;
					else if(instr[7:4] == 4'b0010)
						next = STA;
					else if(instr[7:4] == 4'b0011)
						next = LDM;
					else if(instr[7:4] == 4'b0100)
						next = STM;
					else if(instr[7:4] == 4'b0101)
						next = LDI;
					else if(instr[7:4] == 4'b1010)
						next = AND;
					else if(instr[7:4] == 4'b1011)
						next = OR;
					else if(instr[7:4] == 4'b1100)
						next = ADD;
					else if(instr[7:4] == 4'b1101)
						next = SUB;
					else if(instr == 8'b1110_0000)
						next = NOT;
					else if(instr == 8'b1110_0001)
						next = INC;
					else if(instr == 8'b1110_0010)
						next = DEC;
					else if(instr == 8'b1110_0011)
						next = SHFL;
					else if(instr == 8'b1110_0100)
						next = SHFR;
					else if(instr == 8'b1110_0101)
						next = ROTR;
					else if(instr == 8'b1111_0000)
						next = IN;
					else if(instr == 8'b1111_0001)
						next = OUT;
					else if(instr == 8'b1111_0010)
						next = HALT;
					else if(instr[7:4] == 4'b0110)
					begin
						if(instr[3:0] == 4'd0)
							next = JMP;
						else
							next = JMPR;
					end
					else if(instr[7:4] == 4'b0111)
					begin
						if(instr[3:0] == 4'd0)
							next = JZ;
						else
							next = JZR;
					end
					else if(instr[7:4] == 4'b1000)
					begin
						if(instr[3:0] == 4'd0)
							next = JNZ;
						else 
							next = JNZR;
					end					
					else if(instr[7:4] == 4'b1001)
					begin
						if(instr[3:0]== 4'd0)	
							next = JP;
						else	
							next = JPR;
					end
					else 
						next = FETCH;
					
				end
				NOP:
					begin
						bits = 17'b00000000000000000;
						next = FETCH;
					end
				LDA:
					begin
						bits = 17'b00000000110000000;
						next = FETCH;
					end
				STA:
					begin
						bits = 17'b00000000001000000;
						next = FETCH;
					end
				LDM:
					begin
						bits = 17'b01001000000000000;
						next = LDMC2;
					end
				STM:
					begin 
						bits = 17'b01001000000000000;
						next = STMC2;
					end
				LDI:
					begin
						bits = 17'b00001001110000000;
						next = FETCH;
					end
				AND:
					begin
						bits = 17'b00000000010001000;
						next = FETCH;
					end
				OR:
					begin
						bits = 17'b00000000010010000;
						next = FETCH;
					end
				ADD:
					begin
						bits = 17'b00000000010100000;
						next = FETCH;
					end
				SUB:
					begin
						bits = 17'b00000000010101000;
						next = FETCH;
					end
				NOT:
					begin
						bits = 17'b00000000010011000;
						next = FETCH;
					end
				INC:
					begin
						bits = 17'b00000000010110000;
						next = FETCH;
					end
				DEC:
					begin
						bits = 17'b00000000010111000;
						next = FETCH;
					end
				SHFL:
					begin
						bits = 17'b00000000010000010;
						next = FETCH;
					end
				SHFR:
					begin
						bits = 17'b00000000010000100;
						next = FETCH;
					end
				ROTR:
					begin
						bits = 17'b00000000010000110;
						next = FETCH;
					end
				IN:
					begin
						bits = 17'b00000001010000000;
						next = FETCH;
					end
				OUT:
					begin
						bits = 17'b00000000000000001;
						next = FETCH;
					end
				HALT:
					begin
						bits = 17'd0;
						next = HALT;
					end
				LDMC2:
					begin
						bits = 17'b00000101110000000;
						next = FETCH;
					end
				STMC2:
					begin
						bits = 17'b00000110000000000;
						next = FETCH;
					end
				JMP:
					begin
						bits = 17'b00011000000000000;
						next = FETCH;
					end
				JMPR:
					begin
						if(instr[3:0] == 4'd0)
							bits = 17'd0;
						else
						begin
							if(instr[3] == 1'd0)//pos
								bits = 17'b00111000000000000;
							else//neg
								bits = 17'b00101000000000000;
						end
					
					next = FETCH;
					end
				JZ:
					begin
						if(A == 8'b0)
							bits = 17'b00011000000000000;
						else //zero != 0 so PC+1
							bits = 17'b00001000000000000;
							
						next = FETCH;
					end
				JZR:
					begin
						if(A == 8'b0 && instr[3:0]!= 4'd0)
							begin
								if(instr[3] == 1'd0)//pos
									bits = 17'b00111000000000000;
								else//neg
									bits = 17'b00101000000000000;
							end
						else//zero!=0 or smmm == 0 thus NOP
							bits =17'd0;
							
						next = FETCH;
					end
				JNZ:
					begin
						if(A != 8'b0)
							bits = 17'b00011000000000000;
						else
							bits = 17'b00001000000000000;
							
						next = FETCH;
					end
				JNZR:
					begin
						if(A!=8'b0 && instr[3:0] != 4'd0)
							begin
								if(instr[3] == 1'd0)//pos
									bits = 17'b00111000000000000;
								else//neg
									bits = 17'b00101000000000000;
							end
						else //the top instruction was false
							bits = 17'd0;
						
						next = FETCH;
					end
				JP:
					begin
						if(A[7] == 1'd0 && A !=8'd0 )//A is positive
							bits = 17'b00011000000000000;
						else // A is neg 
							bits = 17'b00011000000000000;
						next = FETCH;
					end
				JPR:
					begin
						if(A[7] == 1'd0 && instr[3:0] != 4'd0)
							begin
								if(instr[3] == 1'd0)//pos
									bits = 17'b00111000000000000;
								else//neg
									bits = 17'b00101000000000000;
							end
						else //the top instruction was false
							bits = 17'd0;
							
					next = FETCH;
					end
			endcase
		end
end
		   
assign IRload = bits[16];
assign MRload = bits[15];
assign JMPmux = bits[14:13];
assign PCload = bits[12];
assign MemInst = bits[11];
assign MemWr = bits[10];
assign Asel = bits[9:8];
assign Aload = bits [7];
assign RFwr = bits [6];
assign ALUsel = bits [5:3];
assign Shiftsel = bits [2:1];
assign OutEn = bits[0];	

endmodule 