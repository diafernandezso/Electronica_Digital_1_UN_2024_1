module sensor (
input clk,
input echo_pin,
output reg [SIZE-1:0] echo_counter, 	// declaracion del echo counter a partir de LIM 
output reg trig_pin

);
parameter lim_entre_medidas = 24'd12500000; // limite de 250ms para contar (12.500.000 x T, T = 20ns)
parameter lim_trigger = 24'd500; // limite de 10us para disparar trigger (500.000 x T, T = 20ns)

parameter SIZE = $clog2(lim_entre_medidas);  //tamaño del arreglo

reg [SIZE-1:0] counter_1 ; 	// declaracion del counter 1 a partir de LIM 
reg [SIZE-1:0] counter_2 ; 	// declaracion del counter 2 a partir de LIM 
reg [SIZE-1:0] counter_3 ; 	// declaracion del counter 3 a partir de LIM 

initial
begin
    counter_1 = 'd0;
    counter_2 = 'd0;
    counter_3 = 'd0;
end

 always@(posedge clk)
 begin
		if (echo_pin)
			begin
				counter_1 <= counter_1 + 1;		
			end else begin
				echo_counter <= counter_1;
				counter_1 <= 'd0;
			end
		if (counter_2 == lim_entre_medidas)
			begin
				counter_2 <= 'd0;
				trig_pin <= 'b1;				
			end else begin
				counter_2 <= counter_2 + 1;
			end
		if (counter_3 == lim_trigger)
			begin
				trig_pin <= 'b0;
				counter_3 <= 'b0;
			end else begin
				counter_3 <= counter_3 + 1;
			end
		
 end

endmodule
