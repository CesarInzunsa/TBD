/*
PRACTICA 11
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 30/11/21
DESCRIPCION: Crear un trigger que guarde la fecha y número de filas afectadas por cada delete en la tabla de myAuthors
*/

--PONER EN USO LA BD
USE pubs;

--Crea una la BD PUBS y Crear DOS tablas:
SELECT * INTO myAuthors from authors;

--CREAR LA TABLA DE miRecord
CREATE TABLE miRecord
(
	miFecha datetime,
	miRegistros int,
	usuario varchar(35)
);

--Crear un trigger que guarde la fecha y número de filas afectadas por cada delete:
CREATE TRIGGER trg_d_myauthors ON myAuthors FOR delete AS
BEGIN
	INSERT INTO miRecord
	VALUES (getdate(), @@rowcount, user_name())
	RETURN
END

--Ejecutar un delete y ver la tabla myRecords:
DELETE FROM myAuthors WHERE state = 'KS';
SELECT * FROM miRecord;

--Ejecutar un delete que no afecta filas y ver la tabla miRecords:
DELETE FROM myAuthors WHERE 1 = 2
SELECT * FROM miRecord;