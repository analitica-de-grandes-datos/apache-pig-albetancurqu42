/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

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
data_transform = FOREACH data GENERATE ToString(date, 'MM');

STORE data_transform INTO 'output' USING PigStorage(',');
