`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2023 08:17:36 PM
// Design Name: 
// Module Name: seq_det
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


module seq_det(clk,din,reset,dout);

        
        parameter IDLE = 2'b00,
                  STATE1 = 2'b01,
                  STATE2 = 2'b10,
                  STATE3 = 2'b11;
                  
        input clk,din,reset;
        output dout;
        
        reg [1:0] present_state, nxt_state;
        
        always@(posedge clk)
        begin
            if(reset)
            present_state <= IDLE;
            else
            present_state <= nxt_state;  
        end
        
        always@(present_state or din)
        begin
            case(present_state) 
            IDLE : if(din == 1)
                   nxt_state <= STATE1;
                   else
                   nxt_state <= IDLE;
            STATE1 : if(din == 0)
                   nxt_state <= STATE2;
                   else
                   nxt_state <= STATE1;
            STATE2 : if(din == 1)
                   nxt_state <= STATE3;
                   else
                   nxt_state <= IDLE;
            STATE3 : if(din == 1)
                   nxt_state <= STATE1;
                   else
                   nxt_state <= STATE2;  
            
            default : nxt_state <= IDLE;
            endcase
        end
        
        assign dout = (present_state == STATE3);
        
endmodule
