/*
	Title: MIPS Single-Cycle Control Unit
	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
	
	Input Port
		1. opcode: ��J�����O�N���A�ڦ����͹���������T��
	Input Port
		1. RegDst: ����RFMUX
		2. ALUSrc: ����ALUMUX
		3. MemtoReg: ����WRMUX
		4. RegWrite: ����Ȧs���O�_�i�g�J
		5. MemRead:  ����O����O�_�iŪ�X
		6. MemWrite: ����O����O�_�i�g�J
		7. Branch: �PALU��X��zero�T����AND�B�ⱱ��PCMUX
		8. ALUOp: ��X��ALU Control
*/
module control_single( opcode, funct, RegDst, ALUSrc, MemtoReg, RegWrite, 
		       MemRead, MemWrite, Branch, Jump, ALUOp, WBmux);
    input[5:0] opcode;
    input[5:0] funct;
    output RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, WBmux;
    output[1:0] ALUOp;
    reg RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, WBmux;
    reg[1:0] ALUOp;

    parameter R_FORMAT = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ = 6'd4;
    parameter BNE = 6'd5;
    parameter J = 6'd2;
    parameter ORI = 6'd13;

    always @( opcode ) begin
        case ( opcode )
          R_FORMAT : // r-format
          begin
			if ( funct == 6'b011011 ) begin // div
				RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b10; WBmux = 1'b0;
			end
			else begin
				RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b10; WBmux = 1'b0;
			end
          end

          LW :	// lw
          begin
				RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b1; RegWrite = 1'b1; MemRead = 1'b1; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; WBmux = 1'b0;
				
          end

          SW :	// sw
          begin
				RegDst = 1'bx; ALUSrc = 1'b1; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b1; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; WBmux = 1'b0;
          end

          BEQ : // beq
          begin
				RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b0; ALUOp = 2'b01; WBmux = 1'b0;
          end


          BNE :	// bne
          begin
				RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b0; ALUOp = 2'b01; WBmux = 1'b0;
          end


          J :	// j
          begin
				RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b1; ALUOp = 2'b01; WBmux = 1'b0;
          end
	

          ORI :	// ori
          begin
				RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0;
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; WBmux = 1'b0;
				
          end

          default
          begin
				$display("control_single unimplemented opcode %d", opcode);
				RegDst=1'bx; ALUSrc=1'bx; MemtoReg=1'bx; RegWrite=1'bx; MemRead=1'bx; 
				MemWrite=1'bx; Branch=1'bx; Jump = 1'bx; ALUOp = 2'bxx; WBmux = 1'bx;
          end

        endcase
    end
endmodule

