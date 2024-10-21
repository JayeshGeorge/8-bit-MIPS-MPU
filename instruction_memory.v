`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2024 02:32:07
// Design Name: 
// Module Name: instruction_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Instruction memory for custom 8-bit RISC architecture.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module instruction_memory(
    input [7:0] addr,          // 8-bit address for memory (256 instructions)
    input clk,                 // Clock signal
    input read_en,             // Read enable signal
    output reg [15:0] instr,   // 16-bit instruction output
    output reg [2:0] op        // 3-bit opcode output
);

    // Memory declaration (256x16-bit)
    reg [15:0] memory [0:255];

    // Initialize memory with instructions
    initial begin 
        memory[0] = 16'b0000000000000000;   // ADD  (opcode = 000)
        memory[1] = 16'b0000100000000001;   // SUB  (opcode = 000)
        memory[2] = 16'b0001000000000010;   // AND  (opcode = 000)
        memory[3] = 16'b0001100000000011;   // OR   (opcode = 000)
        memory[4] = 16'b0010000000000100;   // ADDI (opcode = 001)
        memory[5] = 16'b0100000000000100;   // LW   (opcode = 010)
        memory[6] = 16'b0110000000000100;   // SW   (opcode = 011)
        memory[7] = 16'b1000000000000100;   // BEQ  (opcode = 100)
        memory[8] = 16'b1010000000000100;   // J    (opcode = 101)
    end

    // Memory read logic
    always @ (posedge clk) begin
        if (read_en) begin
            instr <= memory[addr];         // Fetch instruction from memory
            op <= instr[15:13];            // Extract opcode from instruction
        end
    end

endmodule
