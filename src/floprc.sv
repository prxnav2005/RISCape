module floprc #(parameter WIDTH = 8) (input logic clk, reset, clear, input logic [WIDTH-1:0] d, output logic [WIDTH-1:0] q);
  
  always_ff @(posedge clk or posedge reset)
    begin
      if(reset)
        q <= 0;
      else if(clear)
        q <= 0;
      else 
        q <= d;
    end
endmodule