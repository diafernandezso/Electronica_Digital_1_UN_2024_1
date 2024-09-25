**Contador de segundos/decimas/centecimas/milesimas de segundo**
=====================================
###Descripcion:

Consiste en la utilizacion de la logica secuencial para desarrollar un cronómetro que cuente en segundos/decimas/centecimas/milesimas de segundo al mando de un selector.
Para esto se utilizan modulo divisor de frecuencia, siete segmentos, conversor binario-decimal y un gestor de frecuuencias. En cuanto a hardware se utiliza la FPGA que incluye los 7-segmentos y los switches para seleccionar la frecuencia deseada. 



**Módulo divisor de frecuencia**
=====================================

### Descripción

El módulo de división de frecuencia es un circuito digital que divide la frecuencia del cristal oscilatorio de 50 MHz en cuatro frecuencias diferentes: 1 Hz, 10 Hz, 100 Hz y 1000 Hz. El módulo utiliza cuatro contadores para dividir la frecuencia de entrada y generar las salidas correspondientes.

### Entradas

* `clk`: Clock de entrada de 50 MHz
* `rst`: Botón de reset

### Salidas

* `fdiv_1`: Clock de salida de 1 Hz
* `fdiv_2`: Clock de salida de 10 Hz
* `fdiv_3`: Clock de salida de 100 Hz
* `fdiv_4`: Clock de salida de 1000 Hz

### Parámetros

* `LIM_1`: Límite para contar para la frecuencia de 1 Hz (25000000)
* `LIM_2`: Límite para contar para la frecuencia de 10 Hz (2500000)
* `LIM_3`: Límite para contar para la frecuencia de 100 Hz (250000)
* `LIM_4`: Límite para contar para la frecuencia de 1000 Hz (25000)
* `SIZE`: Tamaño de los contadores, calculado como el techo del logaritmo base 2 de `LIM_1`

### Registros Internos

* `counter_1`: Contador para la frecuencia de 1 Hz
* `counter_2`: Contador para la frecuencia de 10 Hz
* `counter_3`: Contador para la frecuencia de 100 Hz
* `counter_4`: Contador para la frecuencia de 1000 Hz

### Operación

El módulo opera de la siguiente manera:

* Cada contador (`counter_1` a `counter_4`) se incrementa en cada ciclo de reloj (`clk`).
* Cuando un contador alcanza su límite correspondiente (`LIM_1` a `LIM_4`), se resetea el contador y se invierte la salida correspondiente (`fdiv_1` a `fdiv_4`).
* La frecuencia de salida se ajusta cambiando el valor del límite para contar en cada contador.

**Módulo tiempos**
=====================

### Descripción

El módulo de tiempos es un contador que cuenta el número de segundos, décimas, centésimas o milésimas transcurridos dependiendo del clock de entrada (`clk`). El módulo también tiene una entrada de reset (`rst`) que permite reiniciar el contador a 0.

### Entradas

* `clk`: Clock de entrada
* `rst`: Botón de reset

### Salidas

* `counter_1`: Contador de salida que indica el número de segundos, décimas, centésimas o milésimas transcurridos

### Parámetros

* `LIM_1`: Límite para contar (9999)
* `SIZE`: Tamaño en bits del contador, calculado como el techo del logaritmo base 2 de `LIM_1`

### Operación

El módulo opera de la siguiente manera:

* Cuando se pulsa el botón de reset (`rst`), el contador se reinicia a 0.
* Cuando el contador alcanza el límite (`LIM_1`), se reinicia a 0.
* En cada ciclo de reloj (`clk`), el contador se incrementa en 1 si no se ha alcanzado el límite o se ha pulsado el botón de reset.

**Módulo de Conversión Binario a BCD**
=====================================

### Descripción

El módulo de conversión binario a BCD (Binary Coded Decimal) es un circuito digital que convierte un valor binario de 14 bits (`bitIn`) en cuatro salidas BCD (unidades, decenas, centenas y miles) que representan el valor decimal correspondiente.

### Entradas

* `bitIn`: Valor binario de 14 bits que se va a convertir a BCD

### Salidas

* `bcdunits`: Salida de las unidades (0-9)
* `bcdtens`: Salida de las decenas (0-9)
* `bcdcents`: Salida de las centenas (0-9)
* `bcdmils`: Salida de los miles (0-9)

### Operación

El módulo opera de la siguiente manera:

* La salida `bcdmils` se calcula dividiendo el valor de entrada `bitIn` entre 1000.
* La salida `bcdcents` se calcula tomando el resto de la división de `bitIn` entre 1000 y dividiéndolo entre 100.
* La salida `bcdtens` se calcula tomando el cociente de la división de `bitIn` entre 10 y tomando el resto de la división entre 10.
* La salida `bcdunits` se calcula tomando el resto de la división de `bitIn` entre 10.

**Módulo de Conversión BCD a 7 Segmentos**
=====================================

### Descripción

El módulo de conversión BCD a 7 segmentos es un circuito digital que convierte un valor BCD (Binary Coded Decimal) de 4 bits en una señal de 7 bits que representa el patrón de segmentos para un display de 7 segmentos.

### Entradas

* `BCD`: Valor BCD de 4 bits que se va a convertir a una señal de 7 segmentos

### Salidas

* `SSeg`: Señal de 7 bits que representa el patrón de segmentos para un display de 7 segmentos

### Operación

El módulo opera de la siguiente manera:

* La señal `SSeg` se calcula utilizando un bloque `case` que evalúa el valor de entrada `BCD`.
* Para cada valor de `BCD`, se asigna un patrón de segmentos correspondiente a la señal `SSeg`.
* El patrón de segmentos se representa utilizando una notación de 7 bits, donde cada bit corresponde a un segmento del display (a, b, c, d, e, f, g).
* Si el valor de entrada `BCD` no se encuentra en la lista de casos, se asigna un valor predeterminado a la señal `SSeg`.

### Funcionamiento 
https://youtube.com/shorts/Y1Nse2T1J-o?feature=shared

### Nota: La simulacion no pudo desarrollarse ya que los limites de los contadores son de un orden superior a los 20-bit, por esta razon cada simulacion toma mucho tiempo .
