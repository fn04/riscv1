
module instruction_type_i
	#(
		parameter OPCODE_I1 = 7'h13,
		parameter OPCODE_I2 = 7'h03,
		parameter OPCODE_I3 = 7'h67
	)
	(
	input				iCLK,
	input	 [31:0]	iIR,
	
	output [4:0] 	oRD,
	output [4:0] 	oRS1,
	output [31:0]	oREG_IN,
	input	 [31:0]	iREG_OUT1, //
	
	output			oRAM_CE,
	//output 			oRAM_RD,
	output [31:0]	oRAM_ADDR,
	input	 [31:0]	iRAM_DATA, //masukan data ram dari ram mux
	
	input  [31:0]  iPC,
	output [31:0]  oPCBR
	
	);
	
	wire [6:0]  opcode;
	wire [2:0]  func3;
	wire [11:0] imm12;
	wire [31:0] alu_in1,alu_in2,alu_out_i1,alu_out_i2,alu_out_i3,ram_address,ram_data;
	wire [7:0] 	ram_data_byte;
	wire [15:0] ram_data_half;
	
	// decode instruction
	assign opcode 	= iIR[6:0];
	assign oRD 		= iIR[11:7];
	assign func3 	= iIR[14:12];
	assign oRS1 	= iIR[19:15];
	assign imm12 	= iIR[31:20];
	
	assign alu_in1 = iREG_OUT1;
	assign alu_in2 = imm12;
	
	// instruction i1
	assign alu_out_i1 = 	(func3=={3'h0}) ?   alu_in1 + alu_in2 :												// add immediate
								(func3=={3'h4}) ?   alu_in1 ^ alu_in2 :												// xor immediate
								(func3=={3'h6}) ?   alu_in1 | alu_in2 : 											// or immediate
								(func3=={3'h7}) ?   alu_in1 & alu_in2 :												// and immediate
								(func3=={3'h1}) ?   alu_in1 << alu_in2[4:0] :										// shift left logical immediate
								(func3=={3'h5}) & (alu_in2[11:5]==7'h00) ?  alu_in1 >> alu_in2[4:0] :		// shift right logical immediate
								(func3=={3'h5}) & (alu_in2[11:5]==7'h20) ?  alu_in1 >>> alu_in2[4:0] :	// shift right arithmetic immediate
								(func3=={3'h2}) ?   $signed(alu_in1) < $signed(alu_in2[4:0]) ? 1 : 0  :	// set less than immediate (signed)
								(func3=={3'h3}) ?   alu_in1 < alu_in2[4:0] ? 1 : 0 :							// set less than immediate (unsigned)
								32'h0 ;
	
	// instruction i2
	assign oRAM_CE = 1;
	//assign oRAM_RD = 1;
	assign oRAM_WR = 0;
	assign ram_address = alu_in1 + alu_in2;
	assign oRAM_ADDR = ram_address;
	assign ram_data = iRAM_DATA;
	
	assign ram_data_byte = 	(ram_address[1:0] == 2'b00) ? ram_data[7:0]:
									(ram_address[1:0] == 2'b01) ? ram_data[15:8]:
									(ram_address[1:0] == 2'b10) ? ram_data[23:16]:
									(ram_address[1:0] == 2'b11) ? ram_data[31:24]: 8'h00;
									
	assign ram_data_half = 	(ram_address[1] == 1'b0) ? ram_data[15:0]:
									(ram_address[1] == 1'b1) ? ram_data[31:16]: 16'h0000;
									
	assign alu_out_i2 = (func3=={3'h0}) ?   $signed(ram_data_byte) :	// Load Byte
						  (func3=={3'h1}) ?   $signed(ram_data_half):	// Load Half
						  (func3=={3'h2}) ?   ram_data : 					// Load Word
						  (func3=={3'h4}) ?   ram_data_byte :				// Load Byte (Unsigned)
						  (func3=={3'h5}) ?   ram_data_half:				// Load Half (Unsigned)
						  32'h0 ;

	// instruction i3
	assign alu_out_i3 = iPC + 4;
	assign oPCBR =		iREG_OUT1 + imm12;
	assign oREG_IN = 	(opcode==OPCODE_I1) ? alu_out_i1:
							(opcode==OPCODE_I2) ? alu_out_i2:
							(opcode==OPCODE_I3) ? alu_out_i3:
							32'h0;
						
	// always @(posedge iCLK)
	// begin
	// 	$display("opcode = 0x%x", opcode);
	// 	$display("imm12 = 0x%x, iREG_OUT1 = 0x%x", imm12, iREG_OUT1);
	// end

endmodule
