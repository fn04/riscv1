
module register_file (
	input					iCLK,
	input					iRST,
	input  [4:0]		iRD,
	input  [4:0]		iRS1,
	input  [4:0]		iRS2,
	output [31:0]		oREG_OUT1,
	output [31:0]		oREG_OUT2,
	input  [31:0]		iREG_IN	
);

integer i; 
reg [31:0] regfile [0:31];

assign oREG_OUT1 = regfile[iRS1];
assign oREG_OUT2 = regfile[iRS2];

initial begin
	for (i = 1; i <32; i = i +1 )
		begin
			regfile[i] = 0;
		end
	regfile[0] = 0;
end

always @(posedge iCLK or negedge iRST)
	begin
		if (iRST==0)
			for (i = 0; i <32; i = i + 1 )
			begin
				regfile[i] = iREG_IN;
			end
		else
			begin
				regfile[iRD] = iREG_IN;
				regfile[0] = 0;
				$display("#REGISTERS:");
				// $display("#oREG_OUT1:%d, #oREG_OUT2:%d", oREG_OUT1, oREG_OUT2);
				//$display("iRS1: 0x%x, iRS2: 0x%x", iRS1, iRS2);
				//$display("rs1=0x%x, irs2=0x%x, ireg1=0x%x, ireg2=0x%x \n",iRS1, iRS2, oREG_OUT1, oREG_OUT2);
				for (i = 0; i <32; i = i + 8 )
					$display("#REG [%0d]: [0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x]",i,regfile[i+0],regfile[i+1],regfile[i+2],regfile[i+3],regfile[i+4],regfile[i+5],regfile[i+6],regfile[i+7]);
				//	$display("#REGISTERS: {\"x%0d\":0x%x - \"x%0d\":0x%x - \"x%0d\":0x%x - \"x%0d\":0x%x - \"x%0d\":0x%x - \"x%0d\":0x%x - \"x%0d\":0x%x - \"x%0d\":0x%x}",i,regfile[i+0],i+1,regfile[i+1],i+2,regfile[i+2],i+3,regfile[i+3],i+4,regfile[i+4],i+5,regfile[i+5],i+6,regfile[i+6],i+7,regfile[i+7]);
				//	$display("#3: {\"x%02d\":0x%x - \"x%02d\":0x%x - \"x%02d\":0x%x - \"x%02d\":0x%x - \"x%02d\":0x%x - \"x%02d\":0x%x - \"x%02d\":0x%x - \"x%02d\":0x%x}",i,regfile[i+0],i+1,regfile[i+1],i+2,regfile[i+2],i+3,regfile[i+3],i+4,regfile[i+4],i+5,regfile[i+5],i+6,regfile[i+6],i+7,regfile[i+7]);
				//	$monitor("#3: \"x%02d\":0x%x",i,regfile[i]);
			
	end
	end
endmodule


