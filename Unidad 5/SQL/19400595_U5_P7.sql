--PRACTICA 7
--MATERIA: TALLER DE BASE DE DATOS
--TEMA: SQL Procedural
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 25/11/2021
--DESCRIPCION: PRACTICAR LA CREACION DE PROCEDIMIENTOS ALMACENADOS.

--7. PROCEDIMIENTO ALMACENADO QUE RECIBE UNA LETRA SI LA LETRA ES UNA VOCAL RETORNA UN 1 SINO RETORNA UN 2,
--   DICHO PROCEDIMIENTO DEBE SER MANDADO LLAMAR DE OTRO PROCEDIMIENTO QUE IMPRIMIRÁ EL RESULTADO.

--CREAR EL PROCEDIMIENTO ALMACENADO QUE NOS AYUDARA A DETERMINAR SI ES VOCAL O CONSONANTE
ALTER PROC sp_es_vocal (@LETRA CHAR(1)) AS
BEGIN
	IF @LETRA LIKE '[AEIOU]%'
	BEGIN
		RETURN 1
	END
	RETURN 2
END

--CREAR EL PROCEDIMIENTO ALMACENADO QUE LLAMARA AL PROCEDIMIENTO ALMACENADO ANTERIOR Y MOSTRARA POR PANTALLA EL RESULTADO
CREATE PROC sp_imprimir_es_vocal (@LETRA CHAR(1)) AS
BEGIN
	DECLARE @VALOR_RETORNO INT;
	EXEC @VALOR_RETORNO = sp_es_vocal @LETRA;
	IF @VALOR_RETORNO = 1
	BEGIN
		PRINT 'ES VOCAL';
	END
	ELSE
	BEGIN
		PRINT 'ES CONSONANTE';
	END
END

--EJECUTAR EL PROCEDIMIENTO ALMACENADO
EXEC sp_imprimir_es_vocal 'C';