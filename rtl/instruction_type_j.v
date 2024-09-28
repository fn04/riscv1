
module instruction_type_j(
	input				iCLK,
	input	 [31:0]	iIR,
	input  [31:0]  iPC,
	output [4:0] 	oRD,
	output [31:0]	oREG_IN,
	output [31:0]  oPCBR,
	input 			status
	);
	
	reg buffer1, buffer2;

	wire [6:0]  opcode;
	wire signed [31:0] imm20;
	wire [31:0] alu_out;

	// decode instruction
	assign opcode 	= iIR[6:0];
	assign oRD 		= iIR[11:7];

	assign imm20 	= {{12{iIR[31]}},iIR[19:12], iIR[20], iIR[30:25],iIR[24:21],1'b0};
	
	assign alu_out = iPC + 4;
	assign oREG_IN = alu_out;

	//assign oPCBR = imm20;
	assign oPCBR = (buffer1==1) ? imm20 + 8 : imm20;
	// aku tambah 4 lagi karena branch perlu eksekusi jal selama 1 clock (4)
	
	always @(posedge iCLK)
	begin
		//if(iIR[6:0]==7'h13)
		buffer1 <= status;
		buffer2 <= buffer1;
		$display("INSRUCTION TYPE J -> oPCBR: 0x%x, imm20: 0x%x, status: 0x%x, buffer1: 0x%x",oPCBR, imm20, status, buffer1);
	end
	
endmodule

