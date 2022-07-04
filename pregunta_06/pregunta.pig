/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

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
data_transform = FOREACH data GENERATE flatten(col3) as key; 

groupby = GROUP data_transform BY key;

counter = FOREACH groupby GENERATE group, COUNT(data_transform);
STORE counter INTO 'output' USING PigStorage(',');