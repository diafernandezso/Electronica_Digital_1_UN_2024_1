`timescale 10ns / 10ns
module testbench;
	
	
		
reg clk = 0;
  always #1 clk = !clk;
wire clk_o =0;
  

   initial
  begin
    
    #1000 $finish(); // [stop(), $finish()]
  end


initial
  begin
    $dumpfile("top.vcd");
    $dumpvars(0, testbench);
  end

endmodule
