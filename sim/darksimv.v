//`timescale 1ns / 1ps
`include "/home/fana/main/riscv1/rtl/conf.vh"
`include "/home/fana/main/riscv1/rtl/socriscv32.v"

// clock and reset logic

`define BOARD_CK 100000000

module darksimv;

    reg CLK = 0;
    reg RES = 1;
    //reg [31:0] iROM_DATA,iRAM_DATA;

    // initial while(1) #(500e6/`BOARD_CK) CLK = !CLK; // clock generator w/ freq defined by config.vh

    integer i, a;
    
    initial
    begin
`ifdef __ICARUS__
        $dumpfile("darksocv.vcd");
        $dumpvars();
        // iROM_DATA = 32'h0;
	    // iRAM_DATA = 32'h0;
    `ifdef __REGDUMP__
        for(i=0;i!=`RLEN;i=i+1)
        begin
            $dumpvars(0,soc0.core0.REGS[i]);
        end
    `endif
`endif

        $display("reset---- (startup)");
        // #1000    RES = 0;
        for (a = 0; a <200; a = a+1 ) begin
			if(a ==10)
            begin
                RES = 0;
            end
            CLK=0;
			#1;
			CLK=1;	
			#1;	
		end

    end

    wire TX;
    wire RX = 1;

    socriscv32 soc0
    (
        .iCLK(CLK),
        .iRST(|RES),
        .UART_RXD(RX),
        .UART_TXD(TX)
    );

endmodule
