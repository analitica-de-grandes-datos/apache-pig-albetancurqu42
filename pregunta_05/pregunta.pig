/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (
letter:chararray, 
col2:BAG{A:tuple(B:chararray)}, 
col3:map[]
    );
data_transform = FOREACH data GENERATE flatten(col2) as letter; 
groupby = GROUP data_transform BY letter;

counter = FOREACH groupby GENERATE group, COUNT(data_transform);
STORE counter INTO 'output' USING PigStorage(',');
