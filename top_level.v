`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2024 02:41:53
// Design Name: 
// Module Name: top_level
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_level(
    input clk, BR, NIA, reset,   // Added `reset` input
    output [15:0] instr
);
    // Wires for Program Counter and Instruction Memory
    wire [7:0] pc_out;
    wire [2:0] opcode;
    wire [1:0] fn;
    wire [7:0] imm;   
    
    // Control Unit Outputs
    wire [2:0] ALUfn;
    wire RegDst, MemWrite, RegWrite, MemRead_MemWrite, ALUsrc, Br, NIA, MemtoReg;

    // Register File Wires
    wire [2:0] rs1, rs2, rd;  // 3-bit register addresses
    wire [7:0] write_data, read_data1, read_data2;  // 8-bit register data

    // Instantiate Program Counter (PC)
    program_counter PC (
        .br(BR),
        .nia(NIA),
        .imm(imm),
        .pc(pc_out)
    );
    
    // Instantiate Instruction Memory (IM)
    instruction_memory IM (
        .addr(pc_out),        // Connect PC output to Instruction Memory address
        .clk(clk),
        .read_en(1'b1),       // Always read in this example
        .instr(instr),         // Fetched instruction
        .op(opcode)
    );
    wire opcode_fn;
    // Instantiate Decoder (DC)
    decoder DC (
        .instruction(instr),  // Pass instruction to decoder
        .opcode(opcode),      // Opcode decoded from instruction
        .opcode_function(opcode_fn),
        .fn(fn),              // Function code (fn) extracted
        .immediate(imm),
        .is_rtype(),  // Decoder outputs
        .is_itype(),
        .is_jtype()
    );
         //immediate instruction value
        wire  imm;
        assign imm = {{1{instr[12]}}, instr[12:6]} ;
    
   
    // Instantiate Control Unit (CU)
    control_unit CU (
        .opFn(opcode_fn),
        .ALUfn(ALUfn),
        .RegDst(RegDst),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .ALUsrc(ALUsrc),
        .br(BR),
        .nia(NIA),
        .MemtoReg(MemtoReg)
    );
      
    // Register Address Assignment
    assign rs1 = instr[7:5];   // Source register 1 (from instruction)
    assign rs2 = instr[4:2];   // Source register 2 (from instruction)
    //REGISTER DESTINATION MUX 2:1
    
    assign rd = (RegDst) ? instr[10:8] : instr[7:5];  // Destination register based on RegDst
    
    assign write_data = 8'b00000001;  // Example data to write to register

    // Instantiate Register File (RF)
    reg_file RF (
        .clk(clk), 
        .reset(reset),           // Added `reset` signal
        .reg_write(RegWrite),    // Write enable signal from control unit
        .rs1(rs1),               // Register source 1 (from instruction)
        .rs2(rs2),               // Register source 2 (from instruction)
        .rd(rd),                 // Register destination (based on RegDst)
        .write_data(write_data), // Data to write to the destination register
        .read_data1(read_data1), // Data from source register 1
        .read_data2(read_data2)  // Data from source register 2
    );
   //ALU SOURCE MUX 
   // for immediate type instruction ALUsrc :1 
   //for register type instruction ALUsrc: 0
    wire ALU_src;
    assign ALU_src = (ALUsrc) ? imm : read_data2;
    
    wire [7:0] alu_result;
    wire z_flag;
    
    ALU alu(
        .clk(clk),
        .reset(reset),
        .ALU_src1(read_data1),
        .ALU_src2(ALU_src),
        .ALU_fn(ALUfn),
        .result(alu_result),
        .zero_flag(z_flag),
        .pc(BR)
        );
 endmodule
