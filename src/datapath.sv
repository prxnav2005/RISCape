module datapath(input logic clk, reset, StallF, StallD, FlushD, FlushE, PCSrcE, ALUSrcAE, ALUSrcBE, MemWriteM, RegWriteW, input  logic [31:0]  InstrF, ReadDataM,  input logic [2:0] ImmSrcD, ALUControlE, input logic [1:0] ForwardAE, ForwardBE, ResultSrcW, output logic [31:0] PCF, WriteDataM, ALUResultM, output logic [6:0] opD,  output logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW, output logic [2:0] funct3D, output logic funct7b5D, ZeroE);
  
  logic [31:0] PCNextF, PCPlus4F, InstrD, PCD, PCPlus4D, RD1D, RD2D, ImmExtD, RD1E, RD2E, PCE, ImmExtE, SrcAE, SrcBE, SrcAEforward, ALUResultE, WriteDataE, PCPlus4E, PCTargetE, PCPlus4M, ALUResultW, ReadDataW, PCPlus4W, ResultW;

  logic [4:0] RdD;
  
  // === Pipeline: Fetch
  mux2 #(32) pcmux(PCPlus4F, PCTargetE, PCSrcE, PCNextF);
  flopenr #(32) pcreg(clk, reset, ~StallF, PCNextF, PCF);
  adder pcadd(PCF, 32'h4, PCPlus4F);
  
  // === Pipeline: Decode
  flopenrc #(96) regD(clk, reset, FlushD, ~StallD, {InstrF, PCF, PCPlus4F}, {InstrD, PCD, PCPlus4D});
  
  assign opD = InstrD[6:0];
  assign funct3D = InstrD[14:12];
  assign funct7b5D = InstrD[30];
  assign Rs1D = InstrD[19:15];
  assign Rs2D = InstrD[24:20];
  assign RdD = InstrD[11:7];
  
  regfile rf(clk, RegWriteW, Rs1D, Rs2D, RdW, ResultW, RD1D, RD2D);
  extend ext(InstrD[31:7], ImmSrcD, ImmExtD);

  // === Pipeline: Execute
  floprc #(175) regE(clk, reset, FlushE, {RD1D, RD2D, PCD, Rs1D, Rs2D, RdD, ImmExtD, PCPlus4D}, {RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E});
  
  mux3 #(32) faemux(RD1E, ResultW, ALUResultM, ForwardAE, SrcAEforward);
  mux2 #(32) srcamux(SrcAEforward, 32'b0, ALUSrcAE, SrcAE); // lui
  mux3 #(32) fbemux(RD2E, ResultW, ALUResultM, ForwardBE, WriteDataE);
  mux2 #(32) srcbmux(WriteDataE, ImmExtE, ALUSrcBE, SrcBE);
  
  alu alu(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE);
  adder branchadd(ImmExtE, PCE, PCTargetE);
  
  // === Pipeline: Memory
  flopr #(101) regM(clk, reset, {ALUResultE, WriteDataE, RdE, PCPlus4E}, {ALUResultM, WriteDataM, RdM, PCPlus4M});
  
  // === Pipeline: Writeback
  flopr #(101) regW(clk, reset, {ALUResultM, ReadDataM, RdM, PCPlus4M}, {ALUResultW, ReadDataW, RdW, PCPlus4W});
  
  mux3 #(32) resultmux(ALUResultW, ReadDataW, PCPlus4W, ResultSrcW, ResultW);
  
endmodule