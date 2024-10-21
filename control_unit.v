`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2024 18:24:22
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [4:0] opFn,
    output reg [2:0] ALUfn,   // output should be reg since it's assigned in an always block
    output reg RegDst,
    output reg MemWrite,
    output reg RegWrite,
    output reg MemRead,
    output reg ALUsrc,
    output reg br, 
    output reg nia,
    output reg MemtoReg
    );
    
    
    always @(*) begin
    ALUfn = 3'b000;
    RegDst = 1'b0;
    MemWrite = 1'b0;
    RegWrite = 1'b0;
    MemRead = 1'b0;
    ALUsrc = 1'b0;
    br = 1'b0;
    nia = 1'b0;
    MemtoReg = 1'b0;

    case (opFn)
    /*ADD*/  5'b00000: begin 
        MemtoReg <= 1'b1; RegDst <= 1'b1; MemWrite <= 1'b0; ALUfn <= 3'b000; 
        RegWrite <= 1'b1; MemRead <= 1'b0; ALUsrc <= 1'b0; br <= 1'b0; nia <= 1'b1; 
    end
    /*SUB*/  5'b00001: begin 
        MemtoReg <= 1'b1; RegDst <= 1'b1; MemWrite <= 1'b0; ALUfn <= 3'b001; 
        RegWrite <= 1'b1; MemRead <= 1'b0; ALUsrc <= 1'b0; br <= 1'b0; nia <= 1'b1; 
    end
    /*AND*/  5'b00010: begin 
        MemtoReg <= 1'b1; RegDst <= 1'b1; MemWrite <= 1'b0; ALUfn <= 3'b010; 
        RegWrite <= 1'b1; MemRead <= 1'b0; ALUsrc <= 1'b0; br <= 1'b0; nia <= 1'b1; 
    end
    /*OR*/   5'b00011: begin 
        MemtoReg <= 1'b1; RegDst <= 1'b1; MemWrite <= 1'b0; ALUfn <= 3'b011; 
        RegWrite <= 1'b1; MemRead <= 1'b0; ALUsrc <= 1'b0; br <= 1'b0; nia <= 1'b1; 
    end
    /*ADDI*/ 5'b001xx: begin 
        MemtoReg <= 1'b1; RegDst <= 1'b0; MemWrite <= 1'b0; ALUfn <= 3'b100; 
        RegWrite <= 1'b1; MemRead <= 1'b0; ALUsrc <= 1'b1; br <= 1'b0; nia <= 1'b1; 
    end
    /*LW*/   5'b010xx: begin 
        MemtoReg <= 1'b0; RegDst <= 1'b0; MemWrite <= 1'b0; ALUfn <= 3'b101; 
        RegWrite <= 1'b1; MemRead <= 1'b1; ALUsrc <= 1'b1; br <= 1'b0; nia <= 1'b1; 
    end
    /*SW*/   5'b011xx: begin 
        MemtoReg <= 1'bx; RegDst <= 1'b0; MemWrite <= 1'b1; ALUfn <= 3'b110; 
        RegWrite <= 1'b0; MemRead <= 1'b0; ALUsrc <= 1'b1; br <= 1'b0; nia <= 1'b1; 
    end
    /*BEQ*/  5'b100xx: begin 
        MemtoReg <= 1'bx; RegDst <= 1'bx; MemWrite <= 1'b0; ALUfn <= 3'b111; 
        RegWrite <= 1'b0; MemRead <= 1'b0; ALUsrc <= 1'b0; br <= 1'b1; nia <= 1'b0; 
    end
    /*J*/    5'b101xx: begin 
        MemtoReg <= 1'bx; RegDst <= 1'bx; MemWrite <= 1'b0; ALUfn <= 3'bxxx; 
        RegWrite <= 1'b0; MemRead <= 1'b0; ALUsrc <= 1'bx; br <= 1'b0; nia <= 1'b0; 
    end
    default: begin 
        MemtoReg <= 1'bx; RegDst <= 1'bx; MemWrite <= 1'b0; ALUfn <= 3'bxxx; 
        RegWrite <= 1'b0; MemRead <= 1'b0; ALUsrc <= 1'bx; br <= 1'b0; nia <= 1'bx;
    end
endcase

    end
endmodule
