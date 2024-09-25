**PROTOTIPO DE ESTACIONAMIENTO ASISTIDO**
=====================
Este prototipo consiste en la utilizacion de un sensor de distancia hcsr04, leds , buzzer y la FPGA para desarrollar un sistema de deteccion de proximidad. Los modulos utilizados se describen a continuación:



**Módulo de Sensor**
=====================

### Descripción

El módulo sensor mide el tiempo que tarda en recibir una señal de eco después de enviar una señal de disparo desde un sensor ultrasónico. El módulo utiliza tres contadores para medir los intervalos de tiempo y generar la señal de disparo.

### Entradas

* `clk`: Señal de reloj
* `echo_pin`: Señal de eco del sensor ultrasónico

### Salidas

* `echo_counter`: Un registro que almacena el tiempo que tarda en recibir la señal de eco (en ciclos de reloj)
* `trig_pin`: Un registro que genera la señal de disparo para el sensor ultrasónico

### Parámetros

* `lim_entre_medidas`: El tiempo máximo permitido para recibir la señal de eco (250ms, o 12.500.000 ciclos de reloj)
* `lim_trigger`: El tiempo mínimo requerido para que la señal de disparo esté en alto (10us, o 500.000 ciclos de reloj)
* `SIZE`: El tamaño de los contadores, calculado como el techo del logaritmo base 2 de `lim_entre_medidas`

### Registros Internos

* `counter_1`: Un contador que incrementa cuando la señal de eco está en alto
* `counter_2`: Un contador que incrementa cada ciclo de reloj y se resetea cuando alcanza `lim_entre_medidas`
* `counter_3`: Un contador que incrementa cada ciclo de reloj y se resetea cuando alcanza `lim_trigger`

### Operación

El módulo opera de la siguiente manera:

1. Cuando la señal de eco está en alto, `counter_1` incrementa cada ciclo de reloj. Esto permite medir el tiempo que tarda en recibir la señal de eco.
2. Cuando la señal de eco se vuelve baja, `echo_counter` se asigna el valor de `counter_1`, y `counter_1` se resetea a 0. Esto permite almacenar el tiempo que tarda en recibir la señal de eco en `echo_counter`.
3. `counter_2` incrementa cada ciclo de reloj y se resetea cuando alcanza `lim_entre_medidas`. Cuando se resetea, la señal de disparo se establece en alto. Esto permite generar una señal de disparo cada vez que se alcanza el límite de tiempo entre mediciones.
4. `counter_3` incrementa cada ciclo de reloj y se resetea cuando alcanza `lim_trigger`. Cuando se resetea, la señal de disparo se establece en bajo. Esto permite mantener la señal de disparo en alto durante un tiempo determinado.

El módulo utiliza tres contadores para medir los intervalos de tiempo y generar la señal de disparo. `counter_1` mide el tiempo que tarda en recibir la señal de eco, `counter_2` mide el tiempo entre mediciones, y `counter_3` mide el tiempo que la señal de disparo está en alto.

**Módulo leds**
================

### Descripción

El módulo leds  que evalúa un valor de 24 bits y activa uno, dos o tres LEDs según el rango en el que se encuentre el valor.

### Entradas

* `value`: Valor de 24 bits a evaluar

### Salidas

* `leds`: Salida de 3 bits que controla los 3 LEDs

### Parámetros

* `RANGE1`: Rango 1 (0-23750)
* `RANGE2`: Rango 2 (23751-95000)
* `RANGE3`: Rango 3 (95001-12500000)

### Operación

El módulo opera de la siguiente manera:

* La entrada `value` se evalúa en tiempo real utilizando un bloque `always`.
* Se utiliza un bloque `case` para evaluar el rango en el que se encuentra el valor `value`.
* Según el rango, se activan uno, dos o tres LEDs:
	+ Si el valor se encuentra en el rango 1, solo se activa el primer LED (`leds = 3'b001`).
	+ Si el valor se encuentra en el rango 2, se activan el primer y segundo LEDs (`leds = 3'b011`).
	+ Si el valor se encuentra en el rango 3, se activan todos los LEDs (`leds = 3'b111`).
	+ Si el valor se encuentra fuera de los rangos definidos, todos los LEDs se apagan (`leds = 3'b000`).

**Módulo buzzer**
================

### Descripción


Este módulo tiene una entrada value de 24 bits que se evalúa en tiempo real. Según el rango en el que se encuentre el valor, se configura la frecuencia del buzzer utilizando un contador counter. La frecuencia se ajusta cambiando el valor de counter en cada rango.

En el rango 1, la frecuencia es alta (1000 Hz), en el rango 2 es media (500 Hz) y en el rango 3 es baja (200 Hz). Cuando el valor se encuentra fuera de los rangos definidos, el buzzer se apaga.

El contador counter se decrementa en cada ciclo de reloj y cuando llega a 0, se invierte el estado del buzzer (buzzer <= ~buzzer). Esto genera un sonido continuo con la frecuencia configurada para cada rango.


**Módulo top**
================

### Descripción

Este módulo instancia y gestiona los aneriores para el correcto funcionamiento del prototipo en la fpga  


### Nota: La simulacion no pudo desarrollarse ya que los limites de los contadores son de un orden superior a los 20-bit, por esta razon cada simulacion toma mucho tiempo .
