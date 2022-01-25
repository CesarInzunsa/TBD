--PRACTICA 6
--MATERIA: TALLER DE BASE DE DATOS
--TEMA: SQL Procedural
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 25/11/2021
--DESCRIPCION: PRACTICAR LA CREACION DE PROCEDIMIENTOS ALMACENADOS CON LA BD DE NORTHWIND.

--PONER EN USO LA BD
USE Northwind;

--6. NORTHWIND - PROCEDIMIENTO ALMACENADO QUE REPORTA EL N�MERO DE PRODUCTOS DE UNA DETERMINADA CATEGOR�A,
--   MOSTRANDO EL LISTADO Y DESPU�S LA CANTIDAD DE ESA CATEGOR�A DE PRODUCTOS ESTO CON PAR�METRO DE OUTPUT

--CREAR EL PROCEDIMIENTO ALMACENADO
CREATE PROC sp_productos_categoria(@CATEGORIA INT, @NUM_CATEGORIA INT OUTPUT) AS
BEGIN
	SELECT * FROM Products WHERE CategoryID = @CATEGORIA;
	SET @NUM_CATEGORIA = (SELECT COUNT(*) FROM Products WHERE CategoryID = @CATEGORIA);
	RETURN
END

--DECLARAR UNA VARIABLE QUE NOS AYUDARA A IMPRIMIR EL NUMERO DE PRODUCTOS DE ESA CATEGORIA
DECLARE @RESULTADO INT;
--EJECUTAR EL PROCEDIMIENTO ALMACENADO
EXEC sp_productos_categoria 1, @RESULTADO OUTPUT;
--MOSTRAR EL NUMERO DE PRODUCTOS DE LA CATEGORIA UTILIZANDO LA VARIABLE @RESULTADO
SELECT @RESULTADO AS [TOTAL DE PRODUCTOS EN CATEGORIA];