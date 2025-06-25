module aludec(input logic opb5, funct7b5, input logic [1:0] ALUOp, input logic [2:0] funct3, output logic [2:0] ALUControl);
  
  logic RtypeSub;
  assign RtypeSub = funct7b5 & opb5;
  
  always_comb
    case (ALUOp)
      2'b00: ALUControl = 3'b000;
      2'b01: ALUControl = 3'b001;
      default: case (funct3)
        3'b000: ALUControl = RtypeSub ? 3'b001 : 3'b000;
        3'b010: ALUControl = 3'b101;
        3'b100: ALUControl = 3'b100;
        3'b110: ALUControl = 3'b011;
        3'b111: ALUControl = 3'b010;
        default: ALUControl = 3'bxxx;
      endcase
    endcase
  
endmodule