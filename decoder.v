`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2024 12:35:59
// Design Name: 
// Module Name: decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Decoder for custom 8-bit RISC architecture. 
//              It decodes the instruction and identifies R-type, I-type, or J-type.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module decoder(
    input [15:0] instruction,      // 16-bit instruction input
    input [2:0] opcode,       // 3-bit opcode output
    output reg [4:0] opcode_function,
    output reg [1:0] fn,           // 2-bit function field for R-type instructions
    output reg is_rtype,           // Flag for R-type instruction
    output reg is_itype,           // Flag for I-type instruction
    output reg is_jtype,            // Flag for J-type instruction
    output reg [7:0] immediate
);

    always @(*) begin
        //fetch the immediate instruction
        immediate= {{1{instruction[12]}},instruction[12:6]};

        // Extract function field (bits 12:11) for R-type instructions
        fn = instruction[12:11];
        opcode_function = instruction [15:10];

        // Identify instruction type based on opcode
        case (opcode)
            3'b000: begin
                is_rtype = 1'b1;  // R-type instruction
                is_itype = 1'b0;
                is_jtype = 1'b0;     
            end
            // I-type instructions (grouped together)
            3'b001, 3'b010, 3'b011, 3'b100: begin
                is_rtype = 1'b0;
                is_itype = 1'b1;  // I-type instruction
                is_jtype = 1'b0;
            end
            3'b101: begin
                is_rtype = 1'b0;
                is_itype = 1'b0;
                is_jtype = 1'b1;  // J-type instruction
            end
            default: begin
                is_rtype = 1'b0;
                is_itype = 1'b0;
                is_jtype = 1'b0;  // Unknown or unsupported instruction
            end
        endcase
    end
endmodule
