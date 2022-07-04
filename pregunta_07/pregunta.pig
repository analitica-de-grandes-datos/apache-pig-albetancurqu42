/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (
key:chararray,
col2:BAG{A:tuple(B:chararray)},
col3:map[]
);
data_transform = FOREACH data GENERATE key, COUNT(col2.B) as item_col2, SIZE(col3) as item_col3;

orderby = ORDER data_transform BY key ASC, item_col2 ASC, item_col3 ASC;
STORE orderby INTO 'output' USING PigStorage(',');