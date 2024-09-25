module buzzer_control (
    input [23:0] value, // valor a evaluar (24 bits)
    output reg buzzer // salida para el buzzer
);

parameter RANGE1 = 24'd0; // rango 1 (0-23750)
parameter RANGE2 = 24'd23751; // rango 2 (23751-95000)
parameter RANGE3 = 24'd95001; // rango 3 (95001-12500000)

parameter FREQ1 = 24'd1000; // frecuencia para rango 1 (alta)
parameter FREQ2 = 24'd500; // frecuencia para rango 2 (media)
parameter FREQ3 = 24'd200; // frecuencia para rango 3 (baja)

reg [23:0] counter; // contador para generar la frecuencia

always @(value) begin
    case (value)
        RANGE1: begin
            counter <= FREQ1;
            buzzer <= ~buzzer;
        end
        RANGE2: begin
            counter <= FREQ2;
            buzzer <= ~buzzer;
        end
        RANGE3: begin
            counter <= FREQ3;
            buzzer <= ~buzzer;
        end
        default: begin
            counter <= 0;
            buzzer <= 0;
        end
    endcase
end

always @(counter) begin
    if (counter == 0) begin
        buzzer <= ~buzzer;
        counter <= FREQ1;
    end else begin
        counter <= counter - 1;
    end
end

endmodule
