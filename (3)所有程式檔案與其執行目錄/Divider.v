`timescale 1ns/1ns
module Divider( clk, dataA, dataB, Signal, dataOut, reset );
input clk ;
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input Signal ;			// �T����6bit
output [63:0] dataOut ;

reg [63:0] temp ;
reg [63:0] dataO ;
reg [31:0] tempA ;
reg [31:0] tempB ;
reg [6:0] counter ;
reg [63:0] REM ;

parameter DIVU = 6'b011011;
parameter OUT = 1'b0 ;



always@( posedge clk or reset )
begin
        if ( reset ) begin
			temp = 32'b0 ;
			counter = 0 ;
		end

        else if ( Signal ) begin 
		// ��F�o��

			counter = 7'd0 ;
		
				tempA[31:0] = dataA ;
				tempB[31:0] = dataB ;
				temp = { 32'd0, tempA } ;  // �Q����
		end 
		
		counter = counter + 7'd1 ;
		/*�[�F�o�q*/
		if ( counter == 6'd33 ) 
		begin
				temp[63:32] = temp[63:32] >> 1 ;		// �����l�ƥk�� 1bit
				temp[63:32] = tempA % tempB ;
				temp[31:0]= tempA / tempB ;
				counter = 6'd0 ;						// counter ���]
				dataO = temp ;						// �]�wdataOut
		end	
		/***********/
		
		temp = temp << 1 ;	// ������1
		if ( counter < 33 )
		begin

			// �ˬd��bit���Q���� > ����
			temp[63:32] = temp[63:32] - tempA ;

			if ( temp[63:32] >= 0 )
				temp[31:31] = 1 ;
			else
			begin
				temp[63:32] = temp[63:32] + tempA ;
				temp[31:31] = 0 ;

			end


			temp = temp << 1 ;
		end

		else 
			counter = 0 ;
	
		
	/*	
  		else
		begin
			 temp[63:32] = tempA % tempB ;
			 temp[31:0]= tempA / tempB ;
			 #330 ;
		end


	*/



end

assign dataOut = dataO ;

endmodule