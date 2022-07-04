/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.csv' USING PigStorage(',') AS (
key:int,
name:chararray,
surname:chararray,
date:chararray,
color:chararray,
number:int
);

data = FOREACH data GENERATE ToDate(date, 'yyyy-MM-dd') AS  date;
data_transform = FOREACH data GENERATE ToString(date,'yyyy') as year;

groupby = GROUP data_transform BY year;
counter = FOREACH groupby GENERATE group, COUNT($1);
STORE counter INTO 'output' USING PigStorage(',');
