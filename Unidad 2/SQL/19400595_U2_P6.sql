/*
PRACTICA 6
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
FECHA: 18/10/21
DESCRIPCION: UTILIZAR ALIAS DE CAMPOS, ALIAS DE TABLAS, INNER JOIN, SUB CONSULTAS Y VISTAS EN LA BD DE SUPERHEROES
*/

--PONER EN USO LA BD
USE SUPERHERORES;

--B) ACTUALIZAR LA EDAD DE LOS HEROES CUYO NOMBRE O APODO EMPIECE CON UNA CONSONANTE A o
--Y PONERLE EL MISMO UNIVERSO (USTED ELIJALO)
UPDATE HEROES
SET
HER_EDAD = 41,
HER_UNIVERSO = 'MARVEL'
WHERE
NOT HER_NOMBRE LIKE '[AEIOU]%' OR NOT HER_ALIAS LIKE '[AEIOU]%';

--C) MOSTRAR CUANTOS REGISTROS TIENE CADA TABLA
SELECT HEROES, HEROESvsVILLANOS, [LUGARES DEFENSA], PODERES, [PODERES DE HEROES], [PODERES DE VILLANOS], TRAJES, VILLANOS
FROM
(SELECT COUNT(*) AS 'HEROES' FROM HEROES H) AS HEROES,
(SELECT COUNT(*) AS 'HEROESvsVILLANOS' FROM HEROESvsVILLANOS) AS HEROESvsVILLANOS,
(SELECT COUNT(*) AS 'LUGARES DEFENSA' FROM LUGARES_DEFENSA) AS LUGARES_DEFENSA,
(SELECT COUNT(*) AS 'PODERES' FROM PODERES) AS PODERES,
(SELECT COUNT(*) AS 'PODERES DE HEROES' FROM PODERES_HEROES) AS PODERES_HEROES,
(SELECT COUNT(*) AS 'PODERES DE VILLANOS' FROM PODERES_VILLANOS) AS PODERES_VILLANOS,
(SELECT COUNT(*) AS 'TRAJES' FROM TRAJES) AS TRAJES,
(SELECT COUNT(*) AS 'VILLANOS' FROM VILLANOS) AS VILLANOS;

--D) MOSTRAR LA SIGUIENTE INFORMACION
SELECT H.HER_ALIAS AS 'ALIAS', L.LUG_NOMBRE AS 'LUGAR QUE DEFIENDE', HER_ESTRELLAS AS 'ESTRELLAS', HER_EDAD 'EDAD'
FROM HEROES H
INNER JOIN LUGARES_DEFENSA L ON (H.LUG_ID = L.LUG_ID);

--E) MOSTRAR LA SIGUIENTE INFORMACION
SELECT V.VIL_ALIAS AS 'VILLANO (APODO)', PO.POD_NOMBRE AS 'NOMBRE PODER', H.HER_NOMBRE AS 'HEROE QUE ENFRENTA'
FROM VILLANOS V
INNER JOIN PODERES_VILLANOS PV ON (V.VIL_ID = PV.VIL_ID)
INNER JOIN PODERES PO ON (PV.POD_ID = PO.POD_ID)
INNER JOIN HEROESvsVILLANOS HV ON (V.VIL_ID = HV.VIL_ID)
INNER JOIN HEROES H ON (H.HER_ID = HV.HER_ID);

--F) MOSTRAR LOS APODOS SUPERHEROES QUE TENGAN MAS DE UN ENEMIGO
SELECT H.HER_ALIAS
FROM HEROES H
INNER JOIN HEROESvsVILLANOS HV ON (H.HER_ID = HV.HER_ID)
GROUP BY H.HER_ALIAS
HAVING COUNT (HV.HER_ID)>1;

--I) INSERTE LOS SIGUIENTES SUPERHEROES, USTED INVENTE LOS DATOS ADICIONALES:
--PATITO FEO, OSITO BIMBO, PITUFO AMIGO, PEPITO GRILLO.
--ESTOS SON LOS APODOS COMPLETE PARA INSERTARLOS.
INSERT INTO HEROES VALUES
('ROBERT', 'PATITO FEO',34,31,5,'EL HECHICERO, CON SUS PODERES, SUS GRANDES PODERES',56,'MARVEL'),
('MARIO', 'OSITO BIMBO',22,32,2,'UN OSO QUE PUEDE VIAJA EN EL TIEMPO',57,'DC'),
('FRANCIS', 'PITUFO FEO',36,33,3,'CON UNA GRAN MAGIA PARA ESCONDER COSAS',58,'DC'),
('CRI', 'PEPITO GRILLO',44,34,4,'SALTA CON GRAN FUERZA Y VENCE A SUS ENEMIGOS',59,'MARVEL');


INSERT INTO LUGARES_DEFENSA VALUES
('DISTRITO 9'),
('CIUDAD Z'),
('PITUFO LANDIA'),
('PINOCHO CITY');

SELECT * FROM TRAJES;
INSERT INTO TRAJES VALUES
(56,'AZUL CON AMARILLO','DIAMANTE','SIN FOTO'),
(57,'ROJO CON NEGRO','PLUMAS TRICOLOR','SIN FOTO'),
(58,'AZUL BRILLANTE','TELA MAGICA','SIN FOTO'),
(59,'VERDE CON NEGRO','MADERA','SIN FOTO');

--O) MOSTRAR LOS HEROES CON CADA UNO DE LOS PODERES QUE TENGA, SIEMPRE Y CUANDO LOS HEROES TENGAN UNA EDAD
--MENOR O IGUAL QUE 50 O SEA NULL SU EDAD, Y QUE SU ID PODER SEA ENTRE 5 Y 25.
--MOSTRANDO LA SIGUIENTE INFORMACION: APODO, NOMBRE DEL LUGAR QUE DEFIENDE, EDAD E ID DEL HEROE.
SELECT H.HER_ALIAS AS 'APODO', L.LUG_NOMBRE AS 'NOMBRE DEL LUGAR QUE DEFIENDE', H.HER_EDAD AS 'EDAD', H.HER_ID AS 'ID DEL HEROE'
FROM HEROES H
INNER JOIN LUGARES_DEFENSA L ON (H.LUG_ID = L.LUG_ID)
INNER JOIN PODERES_HEROES PH ON (H.HER_ID = PH.HER_ID)
WHERE (H.HER_EDAD<=50 OR H.HER_EDAD IS NULL) AND (PH.POD_ID BETWEEN 5 AND 25);

--J) MOSTRAR LOS VILLANOS QUE TIENEN ENTRE 2 Y 4 PODERES, VISUALIZAR LOS APODOS Y CANTIDAD DE PODERES.
SELECT V.VIL_ALIAS, COUNT(PV.VIL_ID) AS 'CANTIDAD DE PODERES'
FROM VILLANOS V
INNER JOIN PODERES_VILLANOS PV ON (V.VIL_ID = PV.VIL_ID)
GROUP BY V.VIL_ALIAS
HAVING COUNT(PV.VIL_ID) BETWEEN 2 AND 4;

--K) MOSTRAR CADA PODER QUE TIENE CADA SUPERHEROE QUE DEFIENDE CIUDAD GOTICA, NEW YORK, SMALLVILLE.
SELECT H.HER_ALIAS, P.POD_NOMBRE
FROM HEROES H
INNER JOIN PODERES_HEROES PH ON (H.HER_ID = PH.HER_ID)
INNER JOIN PODERES P ON (P.POD_ID = PH.POD_ID)
INNER JOIN LUGARES_DEFENSA LD ON (H.LUG_ID = LD.LUG_ID)
WHERE LD.LUG_NOMBRE IN ('CIUDAD GOTICA','NEW YORK','SMALLVILLE');

--L) BORRAR TODOS LOS HEROES QUE NO TENGAN ENEMIGOS Y QUE NO TENGAN PODERES ASIGNADOS.
DELETE FROM HEROES
WHERE ((SELECT COUNT(*) FROM HEROESvsVILLANOS WHERE HEROES.HER_ID = HEROESvsVILLANOS.HER_ID) = 0 OR (SELECT COUNT(*) FROM HEROESvsVILLANOS WHERE HEROES.HER_ID = HEROESvsVILLANOS.HER_ID) IS NULL)
AND   ((SELECT COUNT(*) FROM PODERES_HEROES WHERE HEROES.HER_ID=PODERES_HEROES.HER_ID) = 0 OR (SELECT COUNT(*) FROM PODERES_HEROES WHERE HEROES.HER_ID=PODERES_HEROES.HER_ID) IS NULL);

--M) CREAR UNA VISTA CON LA SIGUIENTE INFORMACION: APODO HEROE,NOMBRE HEROE,CANT. PODERES,CANT. ENEMIGOS
CREATE VIEW VISTA AS
(SELECT H.HER_ALIAS AS 'APODO', H.HER_NOMBRE AS 'NOMBRE',
(SELECT COUNT(*) FROM PODERES_HEROES PH WHERE PH.HER_ID = H.HER_ID) AS 'CANTIDAD DE PODERES',
(SELECT COUNT(*) FROM HEROESvsVILLANOS HV WHERE HV.HER_ID = H.HER_ID) AS 'CANTIDAD DE ENEMIGOS'
FROM HEROES H);


--N) MOSTRAR LOS SUPERHEROES QUE DEFIENDA UN LUGAR QUE EMPIECE CON UNA VOCAL
SELECT *
FROM HEROES H
INNER JOIN LUGARES_DEFENSA LD ON (LD.LUG_ID = H.LUG_ID)
WHERE LD.LUG_NOMBRE LIKE '[AEIOU]%';

--O) ACTUALICE EDAD y DE ESTRELLAS DE LOS HEROES TENGAN ENTRE 3 Y 4 PODERES Y SU CANTIDAD DE
--ENEMIGOS SEA MAYOR A 3 (UTILICE LA VISTA ANTERIORMENTE CREADA).
UPDATE HEROES
SET
HEROES.HER_EDAD = 20,
HEROES.HER_ESTRELLAS = 5
WHERE HEROES.HER_ALIAS IN (SELECT APODO FROM VISTA WHERE VISTA.[CANTIDAD DE PODERES] BETWEEN 3 AND 4)
AND HEROES.HER_ALIAS IN (SELECT VISTA.APODO FROM VISTA WHERE VISTA.[CANTIDAD DE ENEMIGOS]>3);

--P)CREAR UNA VISTA QUE CONTENGA EL PROMEDIO DE ESTRELLAS POR UNIVERSO
-- Y LA SUMA DE LAS ESTRELLAS ACUMULADAS DE LOS HEROES QUE PERTENECEN
-- A ESE UNIVERSO
CREATE VIEW V_ESTRELLAS AS(
SELECT HER_UNIVERSO AS UNIVERSO, AVG(HER_ESTRELLAS) AS PROM_ESTRELLAS, COUNT(HER_ESTRELLAS) AS SUM_ESTRELLAS
FROM HEROES
GROUP BY HER_UNIVERSO);