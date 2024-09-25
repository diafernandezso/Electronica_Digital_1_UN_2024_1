module top(
input clk,
input echo_pin,
//output reg [SIZE-1:0] echo_counter, 	// declaracion del echo counter a partir de LIM 
output  trig_pin,
output  [2:0] leds
);

wire  [23:0] echo_counter;

sensor hcsr04 (
.clk(clk),
.echo_pin(echo_pin),
.echo_counter(echo_counter),
.trig_pin(trig_pin)
);

leds led (
.value(echo_counter),
.leds(leds)
);

endmodule
