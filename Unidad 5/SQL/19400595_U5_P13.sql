/*
PRACTICA 13
AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
NO. CONTROL: 19400595
FECHA: 01/12/21
DESCRIPCION: CREA UN DISPARADOR QUE FUNCIONE PARA LAS 2 OPERACIONES (INSERT Y UPDATE)
SOBRE LA TABLA  VILLANOS DE LA BD DE SUPERHEROES, Y AGREGA UN CAMPO EN DICHA TABLA LLAMADA USUARIO LOGEADO 
Y POR MEDIO DEL TRIGGER ACTUALICE ESE CAMPO PONIENDO EL USUARIO QUE SE LOGGEO AL SERVIDOR Y POR ENDE HIZO
LA ACTUALIZACION. PARA HACER LA ACTUALIZACION  CREAREMOS UN SP QUE LE PASEMOS LOS PARAMETROS Y LO REALICE
*/

--PONER EN USO LA BD
USE SUPERHERORES;

--ALTERAR LA TABLA DE VILLANOS Y AGREGAR EL CAMPO DE USUARIO
ALTER TABLE VILLANOS
ADD USUARIO NVARCHAR(40);

--CREAR EL PROCEDIMIENTO ALMACENADO
CREATE PROC sp_villanos_logeado (@ID INT, @USUARIO_LOG NVARCHAR(40)) AS
BEGIN
	UPDATE VILLANOS
	SET USUARIO = @USUARIO_LOG
	WHERE VIL_ID = @ID;
END

--CREAR EL TRIGGER PARA LA TABLA DE VILLANOS
CREATE TRIGGER tr_villanos_logeado ON VILLANOS FOR INSERT, UPDATE AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ID INT = (SELECT VIL_ID FROM inserted), @USUARIO_LOG NVARCHAR(30) = SYSTEM_USER;
	EXECUTE sp_villanos_logeado @ID, @USUARIO_LOG;
END

--COMPROBAR QUE FUNCIONA EL TRIGGER Y EL PROC ALMACENADO
UPDATE VILLANOS
SET VIL_NOMBRE = 'GENE KHAN'
WHERE VIL_ID = 2;
SELECT * FROM VILLANOS;