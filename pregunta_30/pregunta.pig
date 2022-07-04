/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

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
data_transform = FOREACH data GENERATE
ToString(date,'yyyy-MM-dd'),
LOWER(ToString(date, 'dd')),
ToString(date, 'd'),
LOWER(ToString(date, 'E')),
LOWER(ToString(date, 'EEEE'))
;

data_transform = FOREACH data_transform GENERATE $0, $1, $2,
 REPLACE($3,'mon', 'lun'), REPLACE($4,'monday', 'lunes');
data_transform = FOREACH data_transform GENERATE $0, $1, $2,
 REPLACE($3,'tue', 'mar'), REPLACE($4,'tuesday', 'martes');
data_transform = FOREACH data_transform GENERATE $0, $1, $2,
 REPLACE($3,'wed', 'mie'), REPLACE($4,'wednesday', 'miercoles');
data_transform = FOREACH data_transform GENERATE $0, $1, $2,
 REPLACE($3,'thu', 'jue'), REPLACE($4,'thursday', 'jueves');
data_transform = FOREACH data_transform GENERATE $0, $1, $2,
 REPLACE($3,'fri', 'vie'), REPLACE($4,'friday', 'viernes');
data_transform = FOREACH data_transform GENERATE $0, $1, $2,
 REPLACE($3,'sat', 'sab'), REPLACE($4,'saturday', 'sabado');
data_transform = FOREACH data_transform GENERATE $0, $1, $2,
 REPLACE($3,'sun', 'dom'), REPLACE($4,'sunday', 'domingo');


STORE data_transform INTO 'output' USING PigStorage(',');
