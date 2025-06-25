module alu_tb;
  logic [31:0] a, b, result;
  logic [2:0] alucontrol;
  logic zero;
  
  alu ALU(.a(a), .b(b), .alucontrol(.alucontrol), .result(result), .zero(zero));
  
  initial
    begin
      $display("Starting ALU test...");
      
      a = 32'd10; b = 32'd15; alucontrol = 3'b000;
      #1 $display("ADD: %0d + %0d = %0d | zero = %b", a, b, result, zero);
      
      a = 32'd20; b = 32'd5; alucontrol = 3'b001;
      #1 $display("SUB: %0d - %0d = %0d | zero = %b", a, b, result, zero);
      
      a = 32'hFF00FF00; b = 32'h0F0F0F0F; alucontrol = 3'b010;
      #1 $display("AND: %h & %h = %h | zero = %b", a, b, result, zero);
      
      a = 32'h0000FFFF; b = 32'hFFFF0000; alucontrol = 3'b011;
      #1 $display("OR: %h | %h = %h | zero = %b", a, b, result, zero);
      
      a = 32'h12345678; b = 32'h87654321; alucontrol = 3'b100;
      #1 $display("XOR: %h ^ %h = %h | zero = %b", a, b, result, zero);
      
      a = 32'd5; b = 32'd10; alucontrol = 3'b101;
      #1 $display("SLT: %0d < %0d = %0d | zero = %b", a, b, result, zero);
      
      a = 32'd42; b = 32'd42; alucontrol = 3'b001;
      #1 $display("SUB (zero): %0d - %0d = %0d | zero = %b", a, b, result, zero);
      
      $display("ALU test completed.");
      $finish;
      
    end
endmodule