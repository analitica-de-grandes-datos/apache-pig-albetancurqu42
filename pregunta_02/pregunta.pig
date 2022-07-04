/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (letter:chararray, date:chararray, number:int);

order_list = GROUP data BY lleter ASC, number ASC;

STORE order_list INTO 'output' USING PigStorage(',');
