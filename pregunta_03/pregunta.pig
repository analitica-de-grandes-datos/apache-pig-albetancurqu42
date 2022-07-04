/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (letter:chararray, date:chararray, number:int);

number_tmp = FOREACH data GENERATE number as nn;
order_list = ORDER number_tmp BY nn ASC;
firts_elements = LIMIT order_list 5;

STORE firts_elements INTO 'output' USING PigStorage(',');