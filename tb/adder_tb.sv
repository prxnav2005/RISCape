module adder_tb;

  logic [31:0] a, b, y;

  adder dut(.a(a), .b(b), .y(y));

  initial begin
    a = 32'h00000000; b = 32'h00000001; #10;
    a = 32'hFFFFFFFF; b = 32'h00000001; #10;
    a = 32'h12345678; b = 32'h87654321; #10;
    a = 32'h7FFFFFFF; b = 32'h00000001; #10;
    a = 32'h80000000; b = 32'h80000000; #10;
    $finish;
  end

endmodule