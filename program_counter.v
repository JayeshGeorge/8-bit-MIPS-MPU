`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2024 23:10:57
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input br,nia,
    input [7:0] imm,
    output [7:0]pc
);
    reg [7:0] pc;
always @(*)
begin 
    if(~br & ~nia)
        pc<=imm;
    else if (~br & nia)
        pc<=pc + 1 ;
    else if(br & nia)
        pc<=pc+imm;
    else 
        pc=8'b00000000;
    end
    
    assign y=pc;
        
endmodule
