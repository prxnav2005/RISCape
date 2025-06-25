module controller(input logic clk, reset, funct7b5D, FlushE, ZeroE, input logic [2:0] funct3D, input logic [6:0] opD, output logic [2:0]  ImmSrcD, ALUControlE, output logic [1:0] ResultSrcW, output logic PCSrcE, ALUSrcAE, ALUSrcBE, ResultSrcEb0, MemWriteM, RegWriteM, RegWriteW); 
  
  logic [2:0] ALUControlD;
  logic [1:0] ALUOpD, ResultSrcD, ResultSrcE, ResultSrcM;
  logic RegWriteD, RegWriteE, MemWriteD, MemWriteE, JumpD, JumpE, BranchD, BranchE, ALUSrcAD, ALUSrcBD;
  
  maindec md(opD[5], funct3D, funct7b5D, ALUOpD, ALUControlD);
  floprc #(11) controlregE(clk, reset, FlushE, {RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcAD, ALUSrcBD}, {RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcAE, ALUSrcBE});
  
  assign PCSrcE = (BranchE & ZeroE) | JumpE;
  assign ResultSrcEb0 = ResultSrcE[0];
  
  flopr #(4) controlregM(clk, reset, {RegWriteE, ResultSrcE, MemWriteE}, {RegWriteM, ResultSrcM, MemWriteM}); 
  
  flopr #(3) controlregW(clk, reset, {RegWriteM, ResultSrcM}, {RegWriteW, ResultSrcW});
  
endmodule