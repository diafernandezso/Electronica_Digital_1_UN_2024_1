module leds (
    input [23:0] value, // valor a evaluar (24 bits)
    output reg [2:0] leds // salida para los 3 LEDs
);

parameter RANGE1 = 24'd0; // rango 1 (0-1250000)
parameter RANGE2 = 24'd23750; // rango 2 (1250001-2500000)
parameter RANGE3 = 24'd95000; // rango 3 (2500001-12500000)

always @(value) begin
    case (value)
        RANGE1: leds = 3'b001; // primer rango, solo el primer LED
        RANGE2: leds = 3'b011; // segundo rango, primer y segundo LEDs
        RANGE3: leds = 3'b111; // tercer rango, todos los LEDs
        default: leds = 3'b000; // valor fuera de rango, todos los LEDs apagados
    endcase
end

endmodule
