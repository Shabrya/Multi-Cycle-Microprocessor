module alu (a,b,sel, out);
    input [7:0] a,b;
    input [2:0] sel; 
    output reg [7:0] out;
  
  initial
  begin
  out = 0;
  end
  
    always @ (*) 
    begin 
        case(sel) 
         3'b000: out = a; 
			3'b001: out = a & b; 	
         3'b010: out = a | b;  
			3'b011: out = ~a;    
         3'b100: out = a + b;
			3'b101: out = a - b;
			3'b110: out = a + 8'd1;
			3'b111: out = a - 8'd1;
			default: out = a;  
        endcase
    end
endmodule