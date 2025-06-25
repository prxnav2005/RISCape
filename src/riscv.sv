module riscv(input logic clk, reset, input logic [31:0] InstrF, ReadDataM, output logic [31:0] PCF, ALUResultM, WriteDataM, output logic MemWriteM);
  
  logic [6:0] opD;
  logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
  logic [2:0] funct3D, ImmSrcD, ALUControlE;
  logic [1:0] ResultSrcW, ForwardAE, ForwardBE;
  logic funct7b5D, ZeroE, PCSrcE, ALUSrcAE, ALUSrcBE, ResultSrcEb0, RegWriteM, RegWriteW, StallF, StallD, FlushD, FlushE;
  
  controller c(clk, reset, opD, funct3D, funct7b5D, ImmSrcD, FlushE, ZeroE, PCSrcE, ALUControlE, ALUSrcAE, ALUSrcBE, ResultSrcEb0, MemWriteM, RegWriteM, RegWriteW, ResultSrcW);
  
  datapath dp(clk, reset, StallF, PCF, InstrF, opD, funct3D, funct7b5D, StallD, FlushD, ImmSrcD, FlushE, ForwardAE, ForwardBE, PCSrcE, ALUControlE, ALUSrcAE, ALUSrcBE, ZeroE, MemWriteM, WriteDataM, ALUResultM, ReadDataM, RegWriteW, ResultSrcW, Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW);
  
  hazard hu(Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW, PCSrcE, ResultSrcEb0, RegWriteM, RegWriteW, ForwardAE, ForwardBE, StallF, StallD, FlushD, FlushE);
  
endmodule