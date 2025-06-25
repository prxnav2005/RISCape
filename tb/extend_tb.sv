module extend_tb;
  logic [31:7] instr;
  logic [31:0] immext;
  logic [2:0] immsrc;
  
  extend dut(.instr(instr), .immsrc(immsrc), .immext(immext));
  
  initial
    begin
      instr = 25'h000123; immsrc = 3'b000;
      #1 $display("I-type immext = %h", immext);
      
      instr = {7'b0000010, 5'b00001}; immsrc = 3'b001;
      #1 $display("S-type immext = %h", immext);
      
      instr = 25'b1_000000_00001_0001_0; immsrc = 3'b010;
      #1 $display("B-type immext = %h", immext);
      
      instr = 25'b1_00000000_1_0000000000; immsrc = 3'b011;
      #1 $display("J-type immext = %h", immext);
      
      instr = 25'hABCDE; immsrc = 3'b100;
      #1 $display("U-type immext = %h", immext);
      
      $finish;
      
    end
endmodule