module hazard_tb;
  logic PCSrcE, ResultSrcEb0, RegWriteM, RegWriteW, StallF, StallD, FlushD, FlushE;
  logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
  logic [1:0] ForwardAE, ForwardBE;
  
  hazard dut(.PCSrcE(PCSrcE), .ResultSrcEb0(ResultSrcEb0), .RegWriteM(RegWriteM), .RegWriteW(RegWriteW), .Rs1D(Rs1D), .Rs2D(Rs2D), .Rs1E(Rs1E), .Rs2E(Rs2E), .RdE(RdE), .RdM(RdM), .RdW(RdW), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE), .StallF(StallF), .StallD(StallD), .FlushD(FlushD), .FlushE(FlushE));
  
  initial
    begin
      Rs1E = 5'd1; RdM = 5'd1; RegWriteM = 1;
      Rs2E = 5'd2; RdW = 5'd2; RegWriteW = 1;
      Rs1D = 5'd3; Rs2D = 5'd4; RdE = 5'd3;
      ResultSrcEb0 = 1; PCSrcE = 1;
      
      #1;
      $display("ForwardAE = %b, ForwardBE = %b", ForwardAE, ForwardBE);
      $display("StallF = %b, FlushE = %b", StallF, FlushE);
      
      $finish;
    end
endmodule