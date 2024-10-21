`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2024 23:25:36
// Design Name: 
// Module Name: ALU
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

module ALU(
    input clk,reset,
    input [7:0] ALU_src1,     // First ALU operand (register)
    input [7:0] ALU_src2,     // Second ALU operand (register or immediate)
    input [2:0] ALU_fn,       // ALU function select signal     
    output reg [7:0] result,  // ALU result output
    output reg zero_flag,     // Zero flag output
    output reg [7:0] pc     // PC used for jump instruction
);

    
    reg [7:0] dm [255:0];  // Data Memory
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 8'b00000000;  // Reset PC to 0 on reset
        else if (ALU_fn == 3'b111) begin  // Handle BEQ (Branch if Equal)
            if (ALU_src1 == ALU_src2)
                pc <= pc + ALU_src2;      // Branch to PC + immediate if equal
            else
                pc <= pc + 1;             // Increment PC by 1 if not equal
        end
    end
    
    always @ (*) begin
        case (ALU_fn)
            3'b000: result = ALU_src1 + ALU_src2;          // ADD
            3'b001: result = ALU_src1 - ALU_src2;          // SUB
            3'b010: result = ALU_src1 & ALU_src2;          // AND
            3'b011: result = ALU_src1 | ALU_src2;          // OR
            3'b100: result = ALU_src1 + ALU_src2;          // ADDI
            3'b101: result = dm[ALU_src1 + ALU_src2];      // Load Word (LW)
            3'b110: dm[ALU_src1 + ALU_src2] = ALU_src2;    // Store Word (SW)
            default: result = 8'b00000000;                 // Default result to zero
        endcase

        // Set the zero flag based on the result
        zero_flag = (result == 8'b00000000) ? 1'b1 : 1'b0;
    end

endmodule
