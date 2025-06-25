module dmem_tb;
  
  logic clk, we;
  logic [31:0] a, wd, rd;
  
  dmem dut(.clk(clk), .we(we), .a(a), .wd(wd), .rd(rd));
  
  always
    #5 clk = ~clk;
  
  initial
    begin
      clk = 0;
      we = 0;
      a = 32'd0;
      wd = 32'd0;
      
      #10;
      
      we = 1;
      a = 32'd4;
      wd = 32'hABCD1234;
      
      #10;
      we = 0;
      #10;
      
      a = 32'd4;
      #1 $display("Read value: %h (expected ABCD1234)", rd);
      
      $finish;
    end
endmodule