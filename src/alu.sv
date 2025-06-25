module alu(input logic [31:0] a, b, input logic [2:0] alucontrol, output logic [31:0] result, output logic zero);
  
  logic [31:0] condinvb, sum;
  logic v, isAddSub;
  
  assign condinvb = alucontrol[0] ? ~b : b;
  assign sum = a + condinvb + alucontrol[0];
  assign isAddSub = ~alucontrol[2] & ~alucontrol[1] | ~alucontrol[1] &  alucontrol[0];
  
  always_comb
    begin
      case(alucontrol)
        3'b000: result = sum;
        3'b001: result = sum;
        3'b010: result = a & b;
        3'b011: result = a | b;
        3'b100: result = a ^ b;
        3'b101: result = sum[31] ^ v;
        default: result = 32'bx;
      endcase
      
      assign zero = (result == 32'b0);
      assign v = ~(alucontrol[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & isAddSub;
    end
endmodule