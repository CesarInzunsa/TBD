/*
PRACTICA 12
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 30/11/21
DESCRIPCION: CREA UN TRIGGER QUE CADA QUE SE ACTUALICE LOS DATOS DE UN HEROE GUARDE EN OTRA TABLA EL REGISTRO ANTERIOR
Y EL REGISTRO NUEVO CON TRES DATOS ADICIONALES LA FECHA DE LA ACTUALIZACION Y EL USUARIO QUE LOGGEO AL
SQLSERVER PARA REALIZAR DICHA ACTUALIZACIÓN, SI ES EL REGISTRO NUEVO O VIEJO.
*/

--PONER EN USO LA BD
USE SUPERHERORES;

--CREAR EL TRIGGER
CREATE TRIGGER tr_heroes_bitacora ON HEROES FOR UPDATE AS
BEGIN
	SET NOCOUNT ON

	DECLARE @id INT, @nombre VARCHAR(60), @alias VARCHAR(30), @edad SMALLINT, @lug_id INT;
	DECLARE @estrellas TINYINT, @descripcion VARCHAR(200), @tra_id SMALLINT, @universo VARCHAR(8);

	IF NOT EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'U' AND NAME = 'BITACORA')
		CREATE TABLE BITACORA(
		REGISTRO VARCHAR(5),
		HER_ID INT,
		HER_NOMBRE VARCHAR(60),
		HER_ALIAS VARCHAR (30),
		HER_EDAD SMALLINT,
		LUG_ID INT,
		HER_ESTRELLAS TINYINT,
		HER_DESCRIPCION VARCHAR(200),
		TRA_ID SMALLINT,
		HER_UNIVERSO VARCHAR(8),
		FECHA DATE,
		SESION VARCHAR(100)
		);
	ELSE
	--VIEJO
	SELECT @id = HER_ID, @nombre = HER_NOMBRE, @alias = HER_ALIAS, @edad = HER_EDAD, @lug_id = LUG_ID, @estrellas = HER_ESTRELLAS,
		   @descripcion = HER_DESCRIPCION, @tra_id = TRA_ID, @universo = HER_UNIVERSO
	FROM deleted;

INSERT INTO BITACORA
VALUES ('VIEJO', @id, @nombre, @alias, @edad, @lug_id, @estrellas, @descripcion, @tra_id, @universo, GETDATE(), SYSTEM_USER);


	--NUEVO
	SELECT @id = HER_ID, @nombre = HER_NOMBRE, @alias = HER_ALIAS, @edad = HER_EDAD, @lug_id = LUG_ID, @estrellas = HER_ESTRELLAS,
		   @descripcion = HER_DESCRIPCION, @tra_id = TRA_ID, @universo = HER_UNIVERSO
	FROM inserted;

INSERT INTO BITACORA
VALUES ('NUEVO', @id, @nombre, @alias, @edad, @lug_id, @estrellas, @descripcion, @tra_id, @universo, GETDATE(), SYSTEM_USER);

END

--COMPROBAR QUE FUNCIONA EL TRIGGER
UPDATE HEROES
SET HER_UNIVERSO = 'DC'
WHERE HER_ID = 1;
SELECT * FROM BITACORA;