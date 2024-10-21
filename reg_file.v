`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 23:36:48
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input clk, reset,reg_write,
    input [2:0] rs1,        //rs1 = Ra
    input [2:0] rs2,        //rs2 = Rb
    input [2:0] rd,
    input [7:0] write_data,
    output [7:0] read_data1,
    output [7:0] read_data2
    );
    
    reg [7:0] Registers[7:0];
    integer k;
    always @ (posedge clk or posedge reset) begin
    if(reset)
        begin
            for( k=0;k<=7;k=k+1) begin
                Registers[k]<=8'b00000000;
            end
        end
   else if(reg_write) begin
    Registers[rd] <= write_data;
   end
   end
 
 assign read_data1 = Registers[rs1]; //Source Register
 assign read_data2 = Registers[rs2];    //Destination Register
 
endmodule
