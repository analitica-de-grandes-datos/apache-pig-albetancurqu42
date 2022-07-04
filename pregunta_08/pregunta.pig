/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

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
data_transform = FOREACH data GENERATE flatten(col2) as item_col2, flatten(col3) as item_col3;
data_tuples = FOREACH data_transform GENERATE (item_col2, item_col3) as tuple_i;
groupby = GROUP data_tuples BY tuple_i;
data_final = FOREACH groupby GENERATE group, COUNT(data_tuples);
STORE data_final INTO 'output' USING PigStorage(',');
