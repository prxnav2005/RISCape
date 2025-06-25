module testbench();
  logic clk, reset, MemWrite;
  logic [31:0] WriteData, DataAdr;
  
  top DUT(clk, reset, WriteData, DataAdr, MemWrite);
  
  initial
    begin
      reset <= 1;
      #20;
      reset <= 0;
    end
  
  always
    begin
      clk <= 1;
      #10;
      clk <= 0;
      #10;
    end
  
  always @(negedge clk)
    begin
      if(MemWrite)
        begin
          if(DataAdr === 132 & WriteData === 32'hABCDE02E)
            begin
              $display("Simulation succeeded");
              $stop;
            end
        end
    end
endmodule